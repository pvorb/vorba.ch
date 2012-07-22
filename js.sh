#!/bin/sh

cd ./src/res/

ender build jeesh isodate marked MD5 numpad

cat xhr.js > app.js
cat main.js >> app.js

uglifyjs ender.js > app.en.min.js
# cp ender.min.js app.en.min.js
cat l10n.en.js >> app.en.min.js
uglifyjs app.js >> app.en.min.js

uglifyjs ender.js > app.de.min.js
# cp ender.min.js app.de.min.js
cat l10n.de.js >> app.de.min.js
uglifyjs app.js >> app.de.min.js

cp app.en.min.js ../../public/res/comments.en.min.js
cp app.de.min.js ../../public/res/comments.de.min.js

cd ../..

echo "done."
