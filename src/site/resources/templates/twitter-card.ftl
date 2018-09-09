<#macro twitter_card>
    <meta name="twitter:card" content="summary">
    <meta name="twitter:site" content="@pvorb">
    <meta property="og:title" content="${title}">
    <meta property="og:description" content="Read the article on ${site.title}">
<#if teaser?? && url??>
    <meta property="og:image" content="${site.publicUrl}${url}" />
<#else>
    <meta property="og:image" content="https://vorba.ch/res/logo.png" />
</#if>
</#macro>
