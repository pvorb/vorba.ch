var fs = require('fs');
var path = require('path');
var url = require('url');
var http = require('http');

module.exports = function comments(app, logger, conf, globalConf, started) {
  app.get('^/dev/npm-stat/(\\w+)\\.json$', function handlePingbacks(req, resp) {
    var match;

    if ((match = /\/(\w+)\.json$/.exec(req.url)) !== null) {
      var pkg = match[1];

      http.get('http://isaacs.iriscouch.com/downloads/_design/app/_view/pkg?group_level=3&start_key=["'+pkg+'"]&end_key=["'+pkg+'%22,{}]', function (res) {
        resp.writeHead(200, {'Content-Type': 'application/json'});
        res.pipe(resp);
      }).on('error', function (e) {
        res.writeHead(500, {'Content-Type': 'application/json'});
        res.end('{"error": {"code": 500, "message": "internal server error"}');
      });
    } else {
      resp.writeHead(200, {'Content-Type': 'application/json'});
      res.end('{"error": {"code": 404, "message": "not found"}');
    }
  });

  started();
};
