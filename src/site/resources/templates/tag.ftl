<#ftl output_format="HTML"/>
<#assign url="/tag/"+tag+".html"/>
<#include "corristo-base.ftl"/>
<#macro page_title>
    <title>${title} | ${site.title}</title>
</#macro>
<#macro page_content>
    <header>
        <h1>${title}</h1>
        <#if teaser??>
            <figure class="teaser">
                <img src="${teaser.imageUrl}" />
            </figure>
        </#if>
        <p class="meta">
            ${pages?size} ${l10n.translate("meta.posts", .locale)}
        </p>
    </header>
    <section>
        <#if content??>
            ${content?no_esc}
        </#if>
        <#list pages>
            <ul>
                <#items as page>
                    <li>
                        ${page.createdAt} – <a href="${page.url}" hreflang="${page.locale.language}">${page.title}</a>
                    </li>
                </#items>
            </ul>
        </#list>
    </section>
</#macro>
<@page/>
