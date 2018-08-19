<#ftl output_format="HTML"/>
<#include "corristo-base.ftl"/>
<#include "twitter-card.ftl"/>
<#macro page_title>
    <title>${title} | ${site.title}</title>
    <#if properties.highlight??>
        <style>
            body { border-top: 5px solid ${properties.highlight} }
            a { color: ${properties.highlight} }
        </style>
    </#if>
    <@twitter_card/>
</#macro>
<#macro page_content>
    <header>
        <h1>${title}</h1>
        <#if teaser??>
            <figure class="teaser">
                <img src="${teaser.imageUrl}"/>
            </figure>
        </#if>
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
            <#if teaser?? && teaser.author??>
                <p>
                    ${l10n.translate("meta.teaser.by", .locale)}
                    <a href="${teaser.url}">${teaser.author}</a>.
                    <#if teaser.license??>
                        ${l10n.translate("meta.teaser.license", .locale)}:
                        <a href="${teaser.license.url}">${teaser.license.name}</a>.
                    </#if>
                </p>
            </#if>
        </#list>
    </footer>
</#macro>
<@page/>
