<#ftl output_format="HTML"/>
<#assign url="/tag/"+tag+".html"/>
<#include "corristo-base.ftl"/>
<#macro page_title>
    <title>${title} | ${site.title}</title>
</#macro>
<#macro page_content>
    <header>
        <h1>${title}</h1>
        <#if properties.teaser??>
            <figure class="teaser">
                <img src="${properties.teaser.imageUrl}" />
            </figure>
        </#if>
        <p class="meta">
            ${pages?size} ${l10n.translate("meta.posts", .locale)}
        </p>
    </header>
    <#if content??>
        <section>
            ${content?no_esc}
        </section>
    </#if>
    <#list pages>
        <section>
            <ul>
                <#items as page>
                    <li>${page.createdAt} – <a href="${page.url}">${page.title}</a></li>
                </#items>
            </ul>
        </section>
    </#list>
</#macro>
<@page/>
