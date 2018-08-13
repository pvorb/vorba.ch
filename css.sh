#!/bin/sh

lessc -x src/corristo.less src/site/posts/res/corristo.css
lessc -x src/milten.less src/site/posts/res/milten.css
lessc -x src/diego.less > src/site/posts/res/diego.css
