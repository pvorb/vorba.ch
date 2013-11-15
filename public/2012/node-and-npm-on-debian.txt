title: Recent Node.js and npm versions on Debian 6
created: 2012-02-29
modified: 2012-03-03T11:08:00+0100
tags: [english, nodejs, linux]
teaser: nodejs-npm.png

template: post.en.tpl


Several months ago, it was somehow a little tricky to install Node.js and npm on
Debian systems. Now it has become as easy as it could be with the help of
[APT pinning](http://wiki.debian.org/AptPreferences). (Be careful with APT
pinning, since it may break your system.)

Now you can install the latest stable version (v0.6.x) of Node.js with

    apt-get -t unstable install nodejs

and npm with

    curl http://npmjs.org/install.sh | sh

And that’s it! By the way, it’s a little confusing, that the latest stable
version of Node.js is in the unstable distribution of squeeze. But that’s the
Debian policy.
