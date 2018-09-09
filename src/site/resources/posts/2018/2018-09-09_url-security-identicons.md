---
title: Improving URL Security with Identicons
alias: url-security-identicons.md

author: Paul Vorbach
created-at: 2018-09-09

tags: [ english, browser, google-chrome, security, url, user-experience, identicon ]
locale: en-US

template: post-corristo.ftl

properties:
  highlight: "#822288"
...

If you’ve followed the recent discussion about Chrome’s changes to displaying URLs in the address bar, you might want to
directly switch to the [second part of this blog post](#a-new-approach).

## Existing Problems with URLs

With version 69, Google introduced a new feature for Chrome that strips subdomains of URLs in their address bar if
Chrome considers them to be “trivial”. For example, when you enter the URL https://www.google.com, only google.com
will be visible in Chrome’s address bar. The scheme part of the URL will also be hidden, only indicating whether you’re
on HTTPS or not by a “Secure” or “Insecure” badge. But “www” is not the only subdomain that is considered trivial. The
subdomain “m”, which is often used to serve a mobile version of a website, is also hidden. This way,
https://en.m.wikipedia.org becomes en.wikipedia.org.

This change [enraged many people on Hacker News](https://news.ycombinator.com/item?id=17927972) and, while some defended
the decision, many called it an attack to the Domain Name System and standards.

One obvious reason for Google to strip down URLs in the address bar is to reduce horizontal space on mobile devices.
Another reason to change this is to make URL usage more secure for end users. In recent years, many browsers started to
highlight the hostname of URLs in the address bar by displaying the rest of the URL in gray color. Safari even goes a
step further and only displays the root-level domain of a URL in the address bar. All of this was to make it obvious on
which website users are.

In a recent story on Wired titled
[“Google Wants to Kill the URL,”](https://www.wired.com/story/google-wants-to-kill-the-url/) an engineering manager on
the Google Chrome team, Adrienne Porter Felt, is cited as follows:

> “People have a really hard time understanding URLs. They are hard to read, it’s hard to know which part of them is
> supposed to be trusted, and in general I don’t think URLs are working as a good way to convey site identity. So we
> want to move toward a place where web identity is understandable by everyone – they know who they’re talking to when
> they’re using a website and they can reason about whether they can trust them. But this will mean big changes in how
> and when Chrome displays URLs. We want to challenge how URLs should be displayed and question it as we’re figuring out
> the right way to convey identity.”

Personally, I have problems with the mindset of the inexperienced user. Of course there are many that have no idea how
the world wide web and underlying technologies work and they have a right to safely and easily navigate the web without
thinking about URLs. But on the other hand, URLs are an essential pillar of the web and the internet, along with HTTP,
HTML and many other open standards, that are controlled by the [IETF] or [W3C]. Hiding the technical details that drive
the web from its users is making it easier for some that struggle to use technology in general, but it also keeps people
from learning how the web works, because they don’t get in touch with the web’s rough edges. While it might be in
Google’s interest to blur the boundaries of a search on Google and concrete web page, it can’t be good for the
openness of the web if Google expands its position as a gatekeeper. Other of its initiatives, like
[Accelerated Mobile Pages (AMP)](https://www.ampproject.org/) go in a similar direction.

[IETF]: https://ietf.org/
[W3C]: https://www.w3.org/

So let’s come back to one of the good reasons for changing how users experience and interact with URLs: the security
aspect. In order to know if you’re on the website you want to be, you need to know which part of the URL is relevant for
security. And even if you know that the use of HTTPS and the hostname (domain) are relevant, hostnames can be difficult
to tell from each other, since they can contain Unicode characters through the use of Punycode ([RFC 3492]). The problem
here is that there are so many [homoglyphs] in Unicode that look essentially the same as other characters.

[RFC 3492]: https://tools.ietf.org/html/rfc3492.html
[homoglyphs]: https://en.wikipedia.org/wiki/Homoglyph

For instance, a malicious entity could register the domain аⅿаzоn.com, which, depending on the font used to render this
article, can’t be distinguished from amazon.com. This way, users could be tricked into entering their credentials on
the malicious website. This problem isn’t really tackled by highlighting the domain. In fact, browser vendors started to
block requests to websites that use glyphs from different ranges of Unicode.

## A new approach

When I started to think about these problems, I immediately thought of identicons. Identicons are often used by forum or
commenting software to distinguish multiple authors of posts when they didn’t upload an avatar to their account. The
principle behind identicons is simple: calculate a hash of some string of text and render an image with the use of
multiple, pre-defined geometric figures. Add some color and your identicon is ready. Identicons were
[invented by Don Park] in 2007 “as an easy means of visually distinguishing multiple units of information, anything that
can be reduced to bits. It’s not just IPs but also people, places and things.” These are two examples of identicons I
generated using [Don Park’s original implementation][original-impl].

![1](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAIAAAAlC+aJAAAFdklEQVR42p2az2tVVxDHz59UcOe2a8Gd60L/gaLrrtyoi24KLYJgbIpKkGoW5ZGCwRLrz9rGkJC0ic/GhmCJKIIF21o74ZTJZM7M98yZy108knvf/Xxm3r1n5pxbPrj4pbcfnb3w3dOt499cAccsTLfe+9vXa4/XX+yBA+h08OUffXv9xq/rR2bOg2MKoH/0fJeusffnG+AABIieDvjk5iQnQPRv/v6LjqEgAoeC6esGHDyBSl93kARPgOnrBhxKlx47mAKSHifBFFD02KFE6IFDK6DocRJaAZMeOJQgveegBEx6kAQlAOg9hxKnNx2kgEcPkiAFuvSmQxmibx1YANN7SWCBIH3rUEbplUMV6NJ7SagCQ/TKoSTopQMRBOnNJNDpCXrpUB7s7rzPbuTw+Y/3g/RmEpZ+387R143G6XJyceGff9/lzp9dfTx5sjm/uXHs2uVcEigD9CW5q5M5ZW//Hsg50IX5HqDT4xoyCfUeSDhU+oOn0KhDpVeP0aCGTAI/hYYcmP7QOBB3YHpzJI5ocBLkOBB0kPR6JI44SHpQzGENToIaibsOit6ohbCDou/2A/RVi9vTE/NzXhLaWgg4tPR2Neo5tPRdAd5ajZoEsxo1HUx6tx9oHUz6uICpQUnw+gHl4NGjjkw6ePSjAkqDkgA6MnYA9EiAHQB9TkBqXFz5GXw5XRrT7wsQAdjv7DwD//3ip4dzG2tfrS57+2RK4/Q6OGDulzUMMLOyjA8oufhRBfXxZJ52gsBdOZ4ToNPxVegYKhbBMSWHXi9Pnz0BWWMCByzAFwIOJYdOO32mP5oCbYXsOQCBGn7ePYeSQOfwmwJefW86AIH2iqZDSaBz+FsB3J20Dp6ACj9wKKPoMvxKINJbKQdPAFxaOZRRdBl+KRDvDKWDKeCF33QoQ+gq/Cww2teygykQYWCHMoSuwl8Fcl15dWgFuuFXDiWO3oafNhpr0105OdA4nQi/dCinFhfiJ6jw03br2dP0nACZk38u/LRTKUUFVaHLxx3aORj6DeTmBGqVpn5CwfBX9IN7IOjQhp9v4lEHrjGlQCT8Ev3QTRxxMKfA+DEad5AVshTA4W/R9WMUO5jhVwNZxEHV9ywAwu+hG+MAcPBmIFUpgR3a7oQFzPBjdHskNh288JvFnOdg9lZVoA1/BN0tJVoHMAFsltOtg9cZVgEZ/jg6KuakAwi/J6AcQF9Lp3P4R9E71Sg74Pl30FJWB9yV0+kUoBz6/wKgX5482Tz9w/e4p76xtQF6dhqnaazFTf1nD++C77/527TT1OOV/tdv356E48OZu0ufLi1uv36Vix9+1eDsvdt4TgDNC3GNST8D4EBZOnbt8pGZ8zkNIED03TkBV0BVyMCBCOY3N+rnhIYnwPRdhxJc6fcciID+JafRhzRMAUWPHUp8pd90qFOLnIRRjVbApAcOZWilv3XgNTJzLaOroQQAvedQRlf6lQNP7rZJiGhIgS696VASK/3SgQW8JGANFgjStw4lt9LPDnJ6HSTB06gCQ/TKoaRX+quDWmYNLhWzBp2eoJcOZXXvj/RKP43TNNTLv0SSIDVmVpbTcwL1dYny4dVL01cv0yv9aoUmngTaz92/Taen33V49Hz36OyF/Xsg4cA1ZrvEFEwC0fM9kHCo9AdPoSEHWSGbK/XdJFR6+RQacmD6Q+NA0EHV9+YiH04C06txIOgg6fVI3HVouxNTACRB0rcjcddB0Ru1EHAweytvmdVMgqI3ayHg0NLb1ajp4HWG4GUPlYSW3qtGTQeT3u0HlAPoa8FCt0yCSQ/6AeXg0aOOjB1wVw4EOAkePe7I2AHQd141IAcap/FKP37VgJIA6Ls9MTk82N0B9LT/B1X4qlCCm6utAAAAAElFTkSuQmCC)
![2]( data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAIAAAAlC+aJAAAC00lEQVR42sXawU/UQBQG8Pdn+094N549mHjnYDbGixIjJEpARAQF3SzGJYu7BQLdLQzZWGvb+Wam733tZC4ku/D92G7nzbzKHRwX37Y/P3/kmyejJ4sfe0Wxuus68uv58cZj8Ccufx3h3yCdAS79Kr+Z7o7Gb57xDCzAOr17gQO4H3kGCqBMXwJ4BntANX0VQDIYA2rpawCGwRLQTN8EmBvMAK3pWwG2BhuAL70PYGgwAID0AGBlCAPcK8DMxvsg/YPweOv01VPfnH15qzRkkwOcUHClgNPHDOo67aZQ07tBXae9AKv0awDVINT0JYBnEGr6KoBkEGr6GoBhEGr6JsDcINT0rQBbg1DT+wCGBqGmB4C/hkJpEE36YpnnV/NgNQWmC4Hfvvi5Nzvc9M356Y50Tu/k7tMLFlvK4QoqXCuIJn1MuUsClFe+aNIPBah+b0WTfhBA7a4jmvRNgPtS4vJ9dXutATTvmaJJ3wTgo8gOn1gV0HrHF036PgG+9Uo06XsDgNVWNOn7AeBaQTTpewD83nmJawXB6S+O3if9vVRAsP8QrHQE/+8n714MBYisMgVfOUMB4mtkwdf9IICkCl/wt7Z/QOr+RPA9JxVws5gmbQCC/YcEQOsdMxWQOoL9h1iA737fG6DzzlbwatUPQLMvF7zW9gBQnirIn+8fprsj33R76uDRAN4ABN6enRfLXLMvF+X5zPL2Cp/f8z699bUj7PN7avp/R4s8AzX9f4e7JAM1ff14nWGgpm9pcJgbqOnbW0y2Bmp6b5PP0EBNj9qsVgZqegSwMlDTPwBw+Z5NDpSG80+vXUHlm5dnX3H6bLyPE4Yf9qCu07PDTWX/IepxG57BB4jvP8Q+8EQytAKS+g8Jj5wxDE1Aav8h7aE/c0MNEOw/aAHmhiogpv9gALA1lIDI/oMNwNCwBsT3H8wAVgYHSOo/WAJMDPOTj0n9h+a4B7WYzkuOuH4AAAAAAElFTkSuQmCC)

[invented by Don Park]: http://web.archive.org/web/20070206213620/http://www.docuverse.com/blog/donpark/2007/01/18/visual-security-9-block-ip-identification
[original-impl]: https://github.com/donpark/identicon

One valid issue with identicons was identified by Colin Davis, who created the service [Robohash](https://robohash.org/)
four years later and [commented on Hacker News]:

[commented on Hacker News]: https://news.ycombinator.com/item?id=2743444

> “Identicons are a great idea, I really love them.. They're a good solution to a gut-check "Something is wrong here.."
>
> Sort of like a SSH-fingerprint.
>
> The problem I've had with them is that they're generate not all that memorable. Was that triangles pointing left, then
> up, or up then left?
>
> [Robohash] is my attempt at addressing that problem for my own new project [...]”

So my idea was to use identicons or similar for displaying a small and identifying icon next to an URL in the address
bar of browsers in order to easily identify phishing attacks on your most important web services. These would need to be
rendered by the browser directly without any possibility for website owners to change the appearance.

For example, here are the robohash images for amazon.com and its scam version next to it:

[![amazon.com](/2018/robohash-amazon.com.png)](https://robohash.org/amazon.com)
[![аⅿаzоn.com](/2018/robohash-amazon.com-scam.png)](https://robohash.org/аⅿаzоn.com)

Easily distinguishable, right?

Remembering identicons for a small number of websites would be enough to safely navigate the web. If an identicon looked
suspicious, you’d simply not enter your personal information on that website.

To make this work securely across the vast number of domains on the web is a little difficult, though. Depending on the
algorithm used, most types of identicons can only have up to hundreds of millions of combinations. This is certainly not
enough to be applied globally and there also will certainly be images that look very much like others. If two
similar-looking identicons also had similar-lookin domains, this could get really dangerous. So to improve this, we
would need to use state of the art hash algorithms like [SHA-3] and also use all resulting bits to change a feature of
the identicon. In order to make this possible, multiple identicon types could be combined or new variations of existing
types could be created.

[SHA-3]: https://www.nist.gov/publications/sha-3-standard-permutation-based-hash-and-extendable-output-functions?pub_id=919061

I probably should start to develop a browser extension that implements this idea and look how this idea works in
practice. If you think this idea would be worth giving a try, feel free to go ahead and implement something yourself!

What do you think about this idea? Let me know in the comments or on
[Hacker News](https://news.ycombinator.com/item?id=17947467)!
