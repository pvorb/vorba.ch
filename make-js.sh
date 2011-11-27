#!/bin/sh

cd ./pub/res

# ender build jeesh

cat marked.js > app.js
cat xhr.js >> app.js
cat main.js >> app.js

cp ender.min.js app.de.min.js
cat l10n.de.js >> app.de.min.js
uglifyjs app.js >> app.de.min.js

cd ../..

echo "done."
