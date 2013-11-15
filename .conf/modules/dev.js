var ejs = require('ejs');
var https = require('https');
var fs = require('fs');
var path = require('path');

module.exports = function comments(app, logger, conf, globalConf, started) {
  conf.publicDirectory = path.resolve('public');
  var tpl = '';
  var maxAge = 1000 * 60 * 60 * 6;
  var last = Date.now();
  var cache = '';

  // get a cached version of the repos json document
  function getDocument(maxTries, callback) {
    if (maxTries > 0 && (Date.now() - last) > maxAge) {
      var doc = '';
      https.get('https://api.github.com/users/pvorb/repos', function (resp) {
        if (resp.statusCode == 200) {
          resp.on('data', function (chunk) {
            doc += chunk;
          });

          resp.on('end', function () {
            try {
              cache = JSON.parse(doc);
            } finally {
              callback(cache);
            }
          });

          resp.on('close', function () {
            callback(cache);
          });
        } else {
          callback(maxTries - 1, callback);
        }
      }).on('error', function (e) {
        getDocument(maxTries - 1, callback);
      });
    } else {
      callback(cache);
    }
  }

  app.get('^/dev/(index\.html)?', function onRequest(req, resp) {
    resp.writeHead(200, { 'Content-Type': 'text/html' });
    getDocument(5, function (json) {
      console.log(json);
      //resp.end(ejs.render(tpl, json));
    });
    resp.end('ok');
  });

  // read
  fs.readFile('.conf/templates/search.tpl', 'utf8', function (err, contents) {
    if (err)
      return started(err);
    tpl = contents;
    started();
  });

};
