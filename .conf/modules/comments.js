var Comments = require('Comments');
var mongo = require('mongodb');
var marked = require('marked');
var esc = require('esc');

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
  c.message = marked(c.message, { ignoreHtml: true });
  c.author = esc(c.author);
  delete c.save;
  delete c.nospam;

  return c;
}

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

  app.get('^/log/comments', function getComments(req, resp) {
    var res = req.urlParsed.query.res;

    // comments
    comments.getCommentsJSON(res, resp, function(err) {
      if (err)
        return log.write(err.message+'\n');

    log.write('Got comments for '+res+'.\n');
    });
  });

  app.post('^/log/comments', function postComment(req, resp) {
    var res = req.urlParsed.query.res;

    comments.parseCommentPOST(res, req, function parsed(err, comment) {
      if (err)
        return log.write(err.message+'\n');

      console.log(comment);
      // validate comment
      comment = validateComment(comment);
      console.log(comment);

      comments.setCommentJSON(res, comment, resp, function saved(err) {
        if (err)
          return log.write(err.message+'\n');

        log.write('Saved comment for '+res+'.\n');
      });
    });
  });
};
