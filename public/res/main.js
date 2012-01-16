!function(l10n) {

$.domReady(function init() {
  'use strict';
  var c, clist, path = window.location.pathname;

  c = $('#comments');

  if (c) {
    c.append('<h2>'+l10n.comments+'</h2><div id="clist"></div>');
    clist = $('#clist');

    path = path.replace(/\/\//, '/');

    // get comment form template
    request('GET', '/res/comment-form.'+l10n.lang+'.tpl',
        function onComplete(status, result) {
      'use strict';
      if (status === 200) {
        $('#comments').append(result);

        var message = $('#cf-message'),
            author = $('#cf-author'),
            email = $('#cf-email'),
            website = $('#cf-website'),
            nospam = $('#cf-nospam'),
            doc = $('#cp-doc'),
            stage = $('#cp-stage');

        // get comments json
        request('GET', '/comments?res='+path, function onComplete(status, result) {
          'use strict';
          if (status === 200) {
            var comments;
            try {
              comments = JSON.parse(result);
              addComments(clist, comments);
            } catch(e) {}
          }
        });

        doc.on('click', function () {
          window.open('/res/markdown.'+l10n.lang+'.html', 'Markdown', 'width=450,height=600');
        });
        doc.attr('href', 'javascript:void()');

        // markdown preview
        message.on('keyup', function(e) {
          stage.html(marked(message.val(), { ignoreHtml: true }));
        });

        // bin validation
        message.on('click', validateFields);
        message.on('keyup', validateFields);
        author.on('click', validateFields);
        author.on('keyup', validateFields);
        email.on('click', validateFields);
        email.on('keyup', validateFields);
        website.on('click', validateFields);
        website.on('keyup', validateFields);
        nospam.on('click', validateFields);
        nospam.on('keyup', validateFields);

        // save button
        $('#cf-save').on('click', function(e) {
          var comment = getComment(document.forms['cf']);

          console.log(comment);
          console.log(encodeComment(comment));

          showStatus('load');

          // post form
          request('POST', '/comments?res='+path, encodeComment(comment),
              function onComplete(status, result) {
            if (status === 200) {
              showStatus('ok', 5);
              clearFields();
              showNewComment(comment);
            } else if (status === 412) {
              showStatus('not ok');
            } else {
              showStatus('error');
            }
          });
        });
      }
    });
  }
});

//get html for a comment
function getCommentHTML(comment, isNew) {
  'use strict';

  if (!comment.edited)
    comment.edited = new Date();

  return '<article class="comment'+(isNew ? ' new' : '')+'">'
      + '<a id="'+comment._id+'" class="bm"></a><header>'
      + (comment.email.hash ? '<figure class="avatar">'
      + '<img src="http://www.gravatar.com/avatar/'
      + comment.email.hash + '.jpg?s=60&d=mm" alt="Avatar"'
      + 'width="60" height="60"></figure>' : '')
      + '<p class="meta">'
      + (comment.website ? '<a href="'+comment.website+'">' : '')
      + comment.author
      + (comment.website ? '</a>' : '')
      + ', '+l10n.dateString($.isodate(comment.edited))
      + (comment._id ? '<a href="#'+comment._id+'" title="permalink">#</a>':'')
      + '</header><section class="matter">'+comment.message
      + '</section></article></li>';
}

// add comments
function addComments(clist, comments) {
  'use strict';
  var i;

  for (i = 0; i < comments.length; i++) {
    clist.append(getCommentHTML(comments[i]));
  }
}

// get comment object out of form
function getComment(form) {
  var el = form.elements,
      comment = {};

  for (var i = 0; i < el.length; i++) {
    comment[el[i].name] = el[i].value;
  }

  return comment;
}

// encode form data
function encodeComment(comment) {
  var enc = encodeURIComponent,
      data = '';

  var i = 0;
  for (var key in comment)
    data += (i++ > 0 ? '&' : '') + enc(key) + '=' + enc(comment[key]);

  return data;
}

// show status
function showStatus(cmd, time) {
  var status = $('#cf-status');

  if (cmd == 'ok')
    status.attr('src', '/res/tick.png');
  else if (cmd == 'not ok')
    status.attr('src', '/res/error.png');
  else if (cmd == 'load')
    status.attr('src', '/res/load.gif');
  else if (cmd == 'error')
    status.attr('src', '/res/exclamation.png');

  status.show();

  if (time)
    window.setTimeout(function hide() {
      status.hide();
    }, time * 1000);
};

function valid(el) {
  el.addClass('valid');
  el.removeClass('invalid');
}

function invalid(el) {
  el.addClass('invalid');
  el.removeClass('valid');
}

function validateFields() {
  var message = $('#cf-message'),
      author = $('#cf-author'),
      email = $('#cf-email'),
      website = $('#cf-website'),
      nospam = $('#cf-nospam');

  if (/./.test(message.val()))
    valid(message);
  else
    invalid(message);

  if (/./.test(author.val()))
    valid(author);
  else
    invalid(author);

  if (email.val() == '' || /^.+@.+$/.test(email.val()))
    valid(email);
  else
    invalid(email);

  if (website.val() == '' || /^((.+:)?\/\/)?.+\...+$/.test(website.val()))
    valid(website)
  else
    invalid(website);

  if (document.getElementById('cf-nospam').checked == true)
    valid(nospam);
  else
    invalid(nospam);
}

function clearFields() {
  $('#cf-message').val('');
  $('#cf-author').val('');
  $('#cf-email').val('');
  $('#cf-website').val('');
  $('#cf-nospam').val('');
}

function showNewComment(comment) {
  $('#clist').append(getCommentHTML(comment, true));
}

}(l10n);
