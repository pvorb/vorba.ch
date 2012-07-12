var http = require('http');
var url = require('url');
var exec = require('child_process').exec;
var path = require('path');

// timeout in ms for a single search
var timeout = 10000;
// specify the root directory, where the search will begin
var root = process.cwd();


var server = http.createServer(function (req, resp) {
  // parse the request url
  // the query is everything after the '?'
  // the second param says that the query shall be evaluated
  var query = url.parse(req.url, true).query;

  // ensure both are != null or ''
  if (query && query.s) {
    // replace single with double quotes
    query.s = query.s.replace("'", '"');

    // run the search
    exec("find . -iname '*html' | xargs grep '"+query+"' -isl",
        { timeout: timeout, cwd: root },
        function (err, stdout, stdin) {

      resp.writeHead(200, { 'Content-Type': 'text/html' });

      if (err) {
        resp.end('<p>Error on search</p>');
        console.log(err);
      }

      // split the results
      var results = stdout.split('\n');
      // remove last element (it’s an empty line)
      results.pop();

      resp.write('<h1>Search results</h1>\n<ul>');
      for (var i = 0; i < results.length; i++) {
        resp.write('<li>');
        resp.write(results[i]);
        resp.write('</li>');
      }
      resp.end('</ul>');
    });
  } else {
    resp.writeHead(200, { 'Content-Type': 'text/html' });
    return resp.end('<p>No results</p>');
  }
});

// listen on port 8080
server.listen(8080, function () {
  console.log('Server running at http://localhost:8080/');
});
