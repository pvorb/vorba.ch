<#macro page_title>
    <!-- Title goes here -->
</#macro>

<#macro page_content>
    <!-- Content goes here -->
</#macro>

<#macro page>
<!DOCTYPE html>
<html lang="${.lang}">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1"/>
    <link rel="stylesheet" href="/res/corristo.css">
    <@page_title/>
    <link rel="alternate" type="application/atom+xml" href="/feed.xml" title="Article feed"/>
</head>
<body id="top">
    <nav id="nav">
        <ol id="access">
            <li><a href="#top" title="To the top" accesskey="t">↑</a>
            <li><a href="#nav">Navigation</a>
            <li><a href="#content">Content</a>
        </ol>
        <ol id="path">
            <#if url??>
                <#assign
                path=""
                pathSegments=url?substring(1)?split("/")
                />
                <#if pathSegments??>
                    <li><a href="/" title="${site.properties.hostname}"><img src="/favicon.ico" width="16"
                                                                             height="16"/></a></li>
                    <#list pathSegments as pathSegment>
                        <#assign path += "/" + pathSegment/>
                        <#if pathSegment?has_next>
                            <li><a href="${path}/">${pathSegment}</a></li>
                        </#if>
                    </#list>
                <#else>
                    <li><img src="/favicon.ico" width="16"
                             height="16" title="${site.properties.hostname}"/></li>
                </#if>
            <#else>
                <li><img src="/favicon.ico" width="16"
                         height="16" title="${site.properties.hostname}"/></li>
            </#if>
        </ol>
    </nav>
    <main id="content">
        <@page_content/>
    </main>
    <footer id="about">
        <p>© ${copyrightYears} – Paul Vorbach.
            <a href="http://paul.vorba.ch/">${l10n.translate("footer.contact", .locale)}</a>.</p>
    </footer>
</body>
</html>
</#macro>