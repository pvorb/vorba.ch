<#ftl output_format="HTML"/>
<#include "corristo-base.ftl"/>
<#macro page_title>
    <title>${title} | ${site.title}</title>
</#macro>
<#macro page_content>
    <header>
        <h1>${title}</h1>
    </header>
    <section>
        ${content?no_esc}
    </section>
</#macro>
<#macro page_comments>
</#macro>
<@page/>
