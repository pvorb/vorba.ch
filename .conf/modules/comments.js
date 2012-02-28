var Comments = require('Comments');
var mongo = require('mongodb');
var marked = require('marked');
var esc = require('esc');
var ejs = require('ejs');
var fs = require('fs');
var path = require('path');

marked.setOptions({
  pedantic: false,
  gfm: true,
  sanitize: true
});

module.exports = function comments(app, log, conf, globalConf, started) {
  var comments = new Comments(conf);

  var db = null;
  // pingback
  var dbConnector = new mongo.Db(conf.name,
    new mongo.Server(conf.host, conf.port));
  dbConnector.open(function opened(err, dbConnection) {
    if (err)
      return started(err);

    db = dbConnection;
    started();
  });

  function cancel(statusCode, err, resp) {
    console.log(err);
    log.write(err.message+'\n');
    resp.writeHead(statusCode, { 'Content-Type': "plain/text" });
    resp.end();
  }

  app.get('^/log/comments\\?res=', function getComments(req, resp) {
    var res = req.urlParsed.query.res;

    // comments
    comments.getCommentsJSON(res, resp, function(err) {
      if (err)
        return cancel(404, err, resp);

    log.write('Got comments for '+res+'.\n');
    });
  });

  app.post('^/log/comments\\?res=', function postComment(req, resp) {
    var res = req.urlParsed.query.res;

    comments.parseCommentPOST(res, req, function parsed(err, comment) {
      if (err)
        return cancel(400, err, resp);

      // validate comment
      comment = validateComment(comment);

      comments.setCommentJSON(res, comment, resp, function saved(err) {
        if (err)
          return cancel(500, err, resp);

        log.write('Saved comment for '+res+'.\n');
      });
    });
  });

  app.get('^/log/comment-feed\\.xml$', function getCommentFeed(req, resp) {
    // get all comments
    comments.getComments(null, {
          author: true,
          website: true,
          message: true,
          res: true,
        }, { sort: [["created", "desc"]], limit: 10 },
        function (err, cursor) {
      if (err)
        return cancel(404, err, resp);

      cursor.toArray(function (err, comments) {
        if (err)
          return cancel(404, err, resp);

        fs.readFile(path.resolve('.conf/templates/comment-feed.tpl'), 'utf8',
            function (err, tpl) {
          if (err)
            return cancel(500, err, resp);

          var props = {};
          props.esc = esc;
          props.__comments = comments;

          var xml;
          try {
          xml = ejs.render(tpl, { locals: props });
          } catch (err) {
            return cancel(500, err, resp);
          }

          resp.writeHead(200, { 'Content-Type': 'text/xml' });
          resp.end(xml);
        });
      });
    });
  });
};

// comment validation
function validateComment(c) {
  if (typeof c != 'object')
    return false;

  if (c.nospam !== 'on')
    return false;

  if (!/./.test(c.message))
    return false;

  if (!/./.test(c.author))
    return false;

  if (!(c.email == '' || /.+@.+/.test(c.email)))
    return false;

  if (!(c.website == '' || /^((.+:)?\/\/)?.+\...+$/.test(c.website)))
    return false;

  if (c.website != '' && !/\/\//.test(c.website))
    c.website = 'http://' + c.website;

  c.plain = c.message;
  c.message = marked(c.message);
  c.author = esc(c.author);
  delete c.save;
  delete c.nospam;

  return c;
}
