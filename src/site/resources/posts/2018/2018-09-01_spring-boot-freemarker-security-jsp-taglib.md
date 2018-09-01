---
title: Configuring the Spring Security JSP Taglib with FreeMarker for Spring Boot 2
alias: spring-boot-freemarker-security-jsp-taglib.md

author: Paul Vorbach
created-at: 2018-09-01

tags: [ english, howto, java, maven, spring-boot, spring-security, freemarker ]
locale: en-US

template: post-corristo.ftl

properties:
  highlight: "#13634D"
...

**TL;DR:** _Have a look at my [sample project] for setting up a Spring Boot project with FreeMarker and the JSP taglib
from Spring Security._

[sample project]: https://github.com/pvorb/spring-boot-freemarker-spring-security-jsp-taglib-sample

Currently, I'm working on a project that involves classic Spring WebMVC development using Spring Boot 2, because I want
it to work without any JavaScript. For that project, I chose to use FreeMarker as a template library, as I prefer its
syntax over Thymeleaf. Also one of the things I quite like is that you can, in some way,
[inherit templates](https://nickfun.github.io/posts/2014/freemarker-template-inheritance.html). In my opinion this is
more useful in practice than including the same header and footer snippets for every page individually.

Today I needed my template to render a username, if there was a successful authentication. Since my project is using
Spring Security via the `spring-boot-starter-security` artifact, I looked for a solution that would make using
authentication context information in a FreeMarker template easy. Of course this would be something many people did
before me with that exact combination of tools.

As it turned out, I was wrong and this problem was harder than expected. It took me a while to search through the docs
for various projects and also many questions on Stack Overflow, so I thought I'd share the path to my solution here and
I hope it'll save you some time.

Spring Security doesn't come with a macro library for FreeMarker, but only
[a taglib for JSP](https://docs.spring.io/spring-security/site/docs/5.0.7.RELEASE/reference/html/taglibs.html).
But one of the great things about FreeMarker is that it supports using JSP taglibs.
[This answer on Stack Overflow](https://stackoverflow.com/a/28348350/432354) led me to an easy-looking solution:
To simply include the following line into your template

    <#assign security=JspTaglibs["http://www.springframework.org/security/tags"]/>

and then using the

    <@security.authorize access="isAuthenticated()">

macro.

This left me with the following exception:

    freemarker.ext.jsp.TaglibFactory$TaglibGettingException: No TLD was found for the "http://www.springframework.org/security/tags" JSP taglib URI. (TLD-s are searched according the JSP 2.2 specification. In development- and embedded-servlet-container setups you may also need the "MetaInfTldSources" and "ClasspathTlds" freemarker.ext.servlet.FreemarkerServlet init-params or the similar system properites.)

So I thought the taglib was simply missing from the classpath and I began looking for a dependency that contained the
correct *.tld file. And I was right! The following dependency contained the missing file.

~~~ xml
<dependency>
    <groupId>org.springframework.security</groupId>
    <artifactId>spring-security-taglibs</artifactId>
</dependency>
~~~

After including the dependency I got the following exception:

    freemarker.template.TemplateModelException: Error while looking for TLD file for "http://www.springframework.org/security/tags"; see cause exception.
    […]
    Caused by: freemarker.ext.jsp.TaglibFactory$TaglibGettingException: No TLD was found for the "http://www.springframework.org/security/tags" JSP taglib URI. (TLD-s are searched according the JSP 2.2 specification. In development- and embedded-servlet-container setups you may also need the "MetaInfTldSources" and "ClasspathTlds" freemarker.ext.servlet.FreemarkerServlet init-params or the similar system properites.)

Meh. That "caused by" exception was the exact same one as before. So FreeMarker still couldn't find the taglib?
What next?

I had a look in the classpath, where the file was located. It was located in the
`spring-security-taglibs-5.0.7.RELEASE.jar` file under `/META-INF/security.tld`. But unfortunately, simply changing the
previous assignment to

    <#assign security=JspTaglibs["/META-INF/security.tld"]/>

or

    <#assign security=JspTaglibs["classpath:/META-INF/security.tld"]/>

also didn't work out.

As this didn't lead anywhere, I looked for alternatives solutions. There had been a [request for a native FreeMarker
macro library](https://github.com/spring-projects/spring-security/issues/3275), several years ago. Unfortunately this
didn't get picked up by the Spring Security team and in the end there were only some suggestions on how to use the
`SPRING_SECURITY_CONTEXT` in your own macros.

This was when I thought about giving up and writing my own macros for Spring Security, but eventually I came across
[an answer on Stack Overflow by Andy Wilkinson][wilkinson-answer]:

[wilkinson-answer]: https://stackoverflow.com/a/33758469/432354

> [There's a] possible workaround where you configure FreemarkerConfigurer's tag lib factory with some additional TLDs to be
> loaded from the classpath:
>
>     freeMarkerConfigurer.getTaglibFactory().setClasspathTlds(…);

So I only had to define a list of *.tld files on the classpath? That was worth giving a try. I added the following
code to the constructor of my `@SpringBootApplication` class.

~~~ java
freeMarkerConfigurer.getTaglibFactory().setClasspathTlds(singletonList("/META-INF/security.tld"));
~~~

My template still threw an exception. But wait, the exception had changed!

    freemarker.template.TemplateModelException: Error while loading tag library for URI "http://www.springframework.org/security/tags" from TLD location "classpath:/META-INF/security.tld"; see cause exception.
    […]
    Caused by: freemarker.ext.jsp.TaglibFactory$TldParsingSAXException: Can't load class "org.springframework.security.taglibs.authz.JspAuthorizeTag" for custom tag "authorize".
    […]
    Caused by: java.lang.Exception: Unchecked exception; see cause
    […]
    Caused by: java.lang.NoClassDefFoundError: javax/servlet/jsp/tagext/Tag
    […]
    Caused by: java.lang.ClassNotFoundException: javax.servlet.jsp.tagext.Tag

That was a huge step forward! FreeMarker finally found the `security.tld` file, but now couldn't use it to render the
template because of a missing class.

The only thing I had to do now was including the following dependency in my POM file.
(Users of other servlet containers will have to use an equivalent library for their container.)

~~~ xml
<dependency>
    <groupId>org.apache.tomcat</groupId>
    <artifactId>tomcat-jsp-api</artifactId>
</dependency>
~~~

After that change, the taglib finally worked and I could use it in my templates. The way to use it in your templates is
by including the variant with the full TLD URI:

    <#assign security=JspTaglibs["http://www.springframework.org/security/tags"]/>
    
    <@security.authorize access="isAuthenticated()">
        <@security.authentication property="principal.username"/>
    </@security.authorize>

Since the information is a bit scattered across this article, I compiled a [minimal sample project][sample project]
where you can look up the details on how to get everything up and running.
