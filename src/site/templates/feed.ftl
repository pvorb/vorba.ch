<#ftl output_format="XML"/>
<?xml version="1.0" encoding="utf-8"?>
<feed xmlns="http://www.w3.org/2005/Atom" xml:lang="${site.defaultLocale}">
    <title>${site.title}</title>
    <subtitle>${site.subtitle}</subtitle>
    <updated>${pages[0].createdAt}T00:00:00Z</updated>
    <id>${site.properties.feed.id}</id>
    <#if site.author??>
        <author>
            <name>${site.author}</name>
            <#if site.authorUrl??>
                <uri>${site.authorUrl}</uri>
            </#if>
        </author>
    </#if>
    <rights>© ${copyrightYears} ${site.author}</rights>
    <link href="${site.publicUrl}"/>
    <link href="${site.publicUrl}/feed.xml" rel="self"/>
    <#if site.properties?? && site.properties.feed.categories??>
        <#list site.properties.feed.categories as key, category>
            <category term="${category}"/>
        </#list>
    </#if>
    <icon>${site.publicUrl}/favicon.ico</icon>
    <#list pages as page>
        <entry>
            <title>${page.title}</title>
            <link href="${site.publicUrl}${page.url}" rel="alternate"/>
            <id>http://vorba.ch${page.url}</id>
            <updated>${page.createdAt}T00:00:00Z</updated>
            <author>
                <name>${site.author}</name>
            </author>
            <content type="html">
                <#if page.teaserImageUrl??>
                    ${'<p><img src="'+page.teaserImageUrl+'"></p>'}
                </#if>
                ${page.contentHtml}
            </content>
            <#list pageTags as pageId, tags>
                <#if pageId == page.id>
                    <#list tags as tag>
                        <category term="${tag}"/>
                    </#list>
                </#if>
            </#list>
        </entry>
    </#list>
</feed>
