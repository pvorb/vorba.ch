<#ftl output_format="HTML"/>
<#include "corristo-base.ftl"/>
<#macro page_title>
    <title>${site.title}</title>
</#macro>
<#macro page_content>
    <header><p>${site.subtitle?no_esc}</p></header>
    <section>
        <#list groupedPages as year, pages>
            <h2 id="${year}">${year}</h2>
            <ul>
            <#list pages as page>
                <li>${page.createdAt} – <a href="${page.url}">${page.title}</a></li>
            </#list>
            </ul>
        </#list>
    </section>
    <footer class="meta">
        <p>
            <a href="/tag/" class="button">${l10n.translate("meta.tags", .locale)}</a> ·
            <a href="/feed.xml" class="feed button">Article feed</a>
        </p>
    </footer>
</#macro>
<@page/>
