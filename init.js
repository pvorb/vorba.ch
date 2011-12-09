var Server  = require('api')('http').Server,
    fs      = require('fs'),
    path    = require('path'),

    socket = '/tmp/dynamic.socket';

var app = new Server();

// error method
app.error = function error(code, req, resp) {
  resp.end('404 not found');
};

app.listFiles = function listFiles(dir, files, req, resp) {
  resp.write(dir+"\n");
  for (var i in files)
    resp.write(files[i]+"\n");
  resp.end(++i + " files total\n");
};

// listen on socket
app.listen(socket, function () {
  fs.chmodSync(socket, '777');
  console.log('Server listening on '+socket+'.');
});

// get years or months
app.get('^/log/\\d{4}/(\\d{2}/)?$',
    function getMonth(req, resp) {
  var dir = path.join(__dirname, 'pub', req.urlParsed.pathname);

  path.exists(dir, function (exists) {
    if (exists)
      fs.stat(dir, function (err, stats) {
        if (err || !stats.isDirectory())
          // show 404
          app.error(404, req, resp);
        else
          // read directory
          fs.readdir(dir, function (err, files) {
            app.listFiles(dir, files, req, resp);
          });
      });
    else
      app.error(404, req, resp);
  });
});

require('./lib/initComments')(app);

app.on('regularRequest', function regularReq(req, resp) {
  resp.writeHead(404);
  resp.end();
});
