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

module.exports = function comments(app, logger, conf, globalConf, started) {
  conf.publicDirectory = path.resolve(conf.publicDirectory);

  var comments = new Comments(conf);

  var db = null;
  var dbConnector = new mongo.Db(conf.name,
    new mongo.Server(conf.host, conf.port));
  dbConnector.open(function opened(err, dbConnection) {
    if (err)
      return started(err);

    db = dbConnection;
    started();
  });

  function cancel(statusCode, err, resp) {
    logger.warn(err.message);
    resp.writeHead(statusCode, { 'Content-Type': "plain/text" });
    resp.end();
  }

  function next(err) {
    if (err)
      logger.warn(err);
  }

  app.on('/log/pingback', function handlePingbacks(req, resp) {
    logger.info('Incoming pingback request.');
    comments.handlePingback(req, resp, next);
  });

  app.get('^/log/comments\\?res=', function getComments(req, resp) {
    var res = req.urlParsed.query.res;

    // comments
    comments.getCommentsJSON(res, resp, function(err) {
      if (err)
        return cancel(404, err, resp);

      logger.info('Got comments for "'+res+'".');
    });

    logger.info('Sending pingbacks for resource "'+res+'".');
    comments.sendPingbacks(res, function (err, pb) {
      if (err)
        return logger.warn('Error while sending pingbacks: '+err.message);

      logger.info('Successully sent pingbacks for resource "'+pb.href+'".');
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

        logger.info('Saved comment for "'+res+'"');
      });
    });
  });

  app.get('^/log/comment-feed\\.xml$', function getCommentFeed(req, resp) {
    // get all comments
    comments.getComments(null, {
      author: true,
      'email.hash': true,
      website: true,
      message: true,
      res: true,
      regular: true
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

  if (!/./.test(c.message) && !c.pingback)
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
