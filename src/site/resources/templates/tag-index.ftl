<#ftl output_format="HTML"/>
<#assign url="/tag"/>
<#include "corristo-base.ftl"/>
<#macro page_title>
    <title>${l10n.translate("meta.tags", .locale)} | ${site.title}</title>
</#macro>
<#macro page_content>
    <header>
        <h1>${l10n.translate("meta.tags", .locale)} </h1>
        <p class="meta">
            ${tags?size} ${l10n.translate("meta.tags", .locale)}
        </p>
    </header>
    <#list tags>
        <section>
            <ul>
                <#items as tag>
                    <li><a href="/tag/${tag}.html">${tag}</a></li>
                </#items>
            </ul>
        </section>
    </#list>
</#macro>
<@page/>
