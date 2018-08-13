<#ftl output_format="HTML"/>
<#include "diego-base.ftl"/>
<#macro page_title>
    <title>${title} | ${site.title}</title>
</#macro>
<#macro page_content>
    <header>
        <h1>${title}</h1>
        <figure class="teaser">
            <img src="${properties.teaser.imageUrl}"/>
        </figure>
        <p class="meta">${l10n.translate("meta.by", .locale)} <span class="author">${author}</span>,
            <span class="created">${createdAt}</span></p>
    </header>
    <section>
        ${content?no_esc}
    </section>
    <footer class="meta">
        <#list tags>
            <p>${l10n.translate("meta.tags", .locale)}:
            <#items as tag>
                <a href="/tag/${tag}.html">${tag}</a>
                <#sep> · </#sep>
            </#items>
            </p>
            <#if properties.teaser.author??>
                <p>
                    ${l10n.translate("meta.teaser.by", .locale)}
                    <a href="${properties.teaser.url}">${properties.teaser.author}</a>.
                    <#if properties.teaser.license??>
                        ${l10n.translate("meta.teaser.license", .locale)}:
                        <a href="${properties.teaser.license.url}">${properties.teaser.license.name}</a>.
                    </#if>
                </p>
            </#if>
        </#list>
    </footer>
</#macro>
<@page/>
