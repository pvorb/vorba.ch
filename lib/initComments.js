var Comments = require('Comments'),
    marked = require('marked'),
    esc = require('esc'),
    md5 = require('MD5');

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

module.exports = function initComments(app) {
  var comments = new Comments({
    host: 'localhost',
    port: 27017,
    name: 'website',
    collection: 'comments'
  });

  app.get('^/comments', function getComments(req, resp) {
    var res = req.urlParsed.query.res;

    comments.getCommentsJSON(res, resp, function(err) {
      if (err) {
        console.log(err);
        return;
      }
    });
  });

  app.post('^/comments', function postComment(req, resp) {
    var res = req.urlParsed.query.res;

    comments.parseCommentPOST(res, req, function parsed(err, comment) {
      if (err) {
        console.log(err);
        return;
      }

      // validate comment
      comment = validateComment(comment);

      comments.setCommentJSON(res, comment, resp, function saved(err) {
        if (err) {
          console.log(err);
          return;
        }

        console.log('comment saved.');
      });
    });
  });
};
