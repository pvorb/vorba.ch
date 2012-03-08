var ejs = require('ejs');
var fs = require('fs');
var path = require('path');
var url = require('url');
var exec = require('child_process').exec;

module.exports = function comments(app, logger, conf, globalConf, started) {
  conf.publicDirectory = path.resolve('public');
  var tpl = '';

  function search(query, resp) {
    query = query.replace("'", '"');
    exec("find . -iname '*.html' | xargs grep '"+query+"' -isl",
        { timeout: 10000, cwd: conf.publicDirectory },
        function (err, stdout, stderr) {
      resp.writeHead(200, { 'Content-Type': 'text/html' });
      if (err) {
        resp.end(ejs.render(tpl, { locals: { query: query } }));
        return logger.warn('Error on search');
      }

      var results = stdout.split('\n');
      results.pop(); // remove last element
      resp.end(ejs.render(tpl, { locals: { query: query, results: results } }));
    });
  }

  app.get('^/search.html', function handlePingbacks(req, resp) {
    var query = url.parse(req.url, true).query;

    if (query && query.s) {
      search(query.s, resp);
    } else {
      resp.writeHead(200, { 'Content-Type': 'text/html' });
      return resp.end(ejs.render(tpl));
    }
  });

  // read
  fs.readFile('.conf/templates/search.tpl', 'utf8', function (err, contents) {
    if (err)
      return started(err);
    tpl = contents;
    started();
  });

};
