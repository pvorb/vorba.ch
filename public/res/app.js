/**
 * marked - A markdown parser
 * Copyright (c) 2011, Christopher Jeffrey. (MIT Licensed)
 */

;(function() {

/**
 * Options
 */
var opt = {
  ignoreHtml: false
};

/**
 * Block-Level Grammar
 */

var block = {
  newline: /^\n+/,
  code: /^ {4,}[^\n]*(?:\n {4,}[^\n]*|\n)*(?=\n| *$)/,
  hr: /^( *[\-*_]){3,} *\n/,
  heading: /^ *(#{1,6}) *([^\0]+?) *#* *\n+/,
  lheading: /^([^\n]+)\n *(=|-){3,}/,
  blockquote: /^ *>[^\n]*(?:\n *>[^\n]*)*/,
  list: /^( *)([*+-]|\d+\.) [^\0]+?(?:\n{2,}(?! )|\s*$)(?!\1\2|\1\d+\.)/,
  html: /^ *(?:<!--[^\0]*?-->|<(\w+)[^\0]+?<\/\1>|<\w+[^>]*>) *(?:\n{2,}|\s*$)/,
  text: /^[^\n]+/
};

/**
 * Block Lexer
 */

block.lexer = function(str) {
  var tokens = []
    , links = {};

  str = str.replace(/\r\n|\r/g, '\n')
           .replace(/\t/g, '    ');

  str = str.replace(
    /^ {0,3}\[([^\]]+)\]: *([^ ]+)(?: +"([^\n]+)")? *$/gm,
    function(__, id, href, title) {
      links[id] = {
        href: href,
        title: title
      };
      return '';
    }
  );

  tokens.links = links;

  return block.token(str, tokens);
};

block.token = function(str, tokens) {
  var str = str.replace(/^ +$/gm, '')
    , loose
    , cap
    , item
    , space
    , i
    , l;

  while (str) {
    // newline
    if (cap = block.newline.exec(str)) {
      str = str.substring(cap[0].length);
      if (cap[0].length > 1) {
        tokens.push({
          type: 'space'
        });
      }
      continue;
    }

    // code
    if (cap = block.code.exec(str)) {
      str = str.substring(cap[0].length);
      cap = cap[0].replace(/^ {4}/gm, '');
      tokens.push({
        type: 'code',
        text: cap
      });
      continue;
    }

    // heading
    if (cap = block.heading.exec(str)) {
      str = str.substring(cap[0].length);
      tokens.push({
        type: 'heading',
        depth: cap[1].length,
        text: cap[2]
      });
      continue;
    }

    // lheading
    if (cap = block.lheading.exec(str)) {
      str = str.substring(cap[0].length);
      tokens.push({
        type: 'heading',
        depth: cap[2] === '=' ? 1 : 2,
        text: cap[1]
      });
      continue;
    }

    // hr
    if (cap = block.hr.exec(str)) {
      str = str.substring(cap[0].length);
      tokens.push({
        type: 'hr'
      });
      continue;
    }

    // blockquote
    if (cap = block.blockquote.exec(str)) {
      str = str.substring(cap[0].length);
      tokens.push({
        type: 'blockquote_start'
      });
      cap = cap[0].replace(/^ *>/gm, '');
      block.token(cap, tokens);
      tokens.push({
        type: 'blockquote_end'
      });
      continue;
    }

    // list
    if (cap = block.list.exec(str)) {
      str = str.substring(cap[0].length);

      tokens.push({
        type: 'list_start',
        ordered: isFinite(cap[2])
      });

      loose = /\n *\n *(?:[*+-]|\d+\.)/.test(cap[0]);

      // get each top-level item
      cap = cap[0].match(
        /^( *)([*+-]|\d+\.)[^\n]*(?:\n(?!\1(?:\2|\d+\.))[^\n]*)*/gm
      );

      i = 0;
      l = cap.length;

      for (; i < l; i++) {
        // remove the list items sigil
        // so its seen as the next token
        item = cap[i].replace(/^ *([*+-]|\d+\.) */, '');
        // outdent whatever the
        // list item contains, hacky
        space = /\n( +)/.exec(item);
        if (space) {
          space = new RegExp('^' + space[1], 'gm');
          item = item.replace(space, '');
        }
        tokens.push({
          type: loose
            ? 'loose_item_start'
            : 'list_item_start'
        });
        block.token(item, tokens);
        tokens.push({
          type: 'list_item_end'
        });
      }

      tokens.push({
        type: 'list_end'
      });

      continue;
    }

    // html
    if (!opt.ignoreHtml && (cap = block.html.exec(str))) {
      str = str.substring(cap[0].length);
      tokens.push({
        type: 'html',
        text: cap[0]
      });
      continue;
    }

    // text
    if (cap = block.text.exec(str)) {
      str = str.substring(cap[0].length);
      tokens.push({
        type: 'text',
        text: cap[0]
      });
      continue;
    }
  }

  return tokens;
};

/**
 * Inline Processing
 */

var inline = {
  escape: /^\\([\\`*{}\[\]()#+\-.!_])/,
  autolink: /^<([^ >]+(@|:\/)[^ >]+)>/,
  tag: /^<!--[^\0]*?-->|^<\/?\w+[^>]*>/,
  link: /^!?\[((?:\[[^\]]*\]|[^\[\]])*)\]\s*\(([^\)]*)\)/,
  reflink: /^!?\[((?:\[[^\]]*\]|[^\[\]])*)\]\s*\[([^\]]*)\]/,
  nolink: /^!?\[((?:\[[^\]]*\]|[^\[\]])*)\]/,
  strong: /^__([^\0]+?)__(?!_)|^\*\*([^\0]+?)\*\*(?!\*)/,
  em: /^_([^_]+)_|^\*([^*]+)\*/,
  code: /^`([^`]+)`|^``([^\0]+?)``/,
  br: /^ {2,}\n(?!\s*$)/,
  text: /^/
};

// hacky, but performant
inline.text = (function() {
  var body = [];

  (function push(rule) {
    rule = inline[rule].source;
    body.push(rule.replace(/(^|[^\[])\^/g, '$1'));
    return push;
  })
  ('escape')
  ('tag')
  ('nolink')
  ('strong')
  ('em')
  ('code')
  ('br');

  return new
    RegExp('^[^\\0]+?(?=' + body.join('|') + '|$)');
})();

/**
 * Inline Lexer
 */

inline.lexer = function(str) {
  var out = ''
    , links = tokens.links
    , link
    , text
    , href
    , cap;

  while (str) {
    // escape
    if (cap = inline.escape.exec(str)) {
      str = str.substring(cap[0].length);
      out += cap[1];
      continue;
    }

    // autolink
    if (cap = inline.autolink.exec(str)) {
      str = str.substring(cap[0].length);
      if (cap[2] === '@') {
        text = cap[1][6] === ':'
          ? mangle(cap[1].substring(7))
          : mangle(cap[1]);
        href = mangle('mailto:') + text;
      } else {
        text = escape(cap[1]);
        href = text;
      }
      out += '<a href="'
        + href
        + '">'
        + text
        + '</a>';
      continue;
    }

    // tag
    if (!opt.ignoreHtml && (cap = inline.tag.exec(str))) {
      str = str.substring(cap[0].length);
      out += cap[0];
      continue;
    }

    // link
    if (cap = inline.link.exec(str)) {
      str = str.substring(cap[0].length);
      text = /^\s*<?([^\s]*?)>?(?:\s+"([^\n]+)")?\s*$/.exec(cap[2]);
      link = {
        href: text[1],
        title: text[2]
      };
      out += mlink(cap, link);
      continue;
    }

    // reflink, nolink
    if ((cap = inline.reflink.exec(str))
        || (cap = inline.nolink.exec(str))) {
      str = str.substring(cap[0].length);
      link = (cap[2] || cap[1]).replace(/\s+/g, ' ');
      link = links[link];
      if (!link) {
        out += cap[0][0];
        str = cap[0].substring(1) + str;
        continue;
      }
      out += mlink(cap, link);
      continue;
    }

    // strong
    if (cap = inline.strong.exec(str)) {
      str = str.substring(cap[0].length);
      out += '<strong>'
        + inline.lexer(cap[2] || cap[1])
        + '</strong>';
      continue;
    }

    // em
    if (cap = inline.em.exec(str)) {
      str = str.substring(cap[0].length);
      out += '<em>'
        + inline.lexer(cap[2] || cap[1])
        + '</em>';
      continue;
    }

    // code
    if (cap = inline.code.exec(str)) {
      str = str.substring(cap[0].length);
      out += '<code>'
        + escape(cap[2] || cap[1])
        + '</code>';
      continue;
    }

    // br
    if (cap = inline.br.exec(str)) {
      str = str.substring(cap[0].length);
      out += '<br>';
      continue;
    }

    // text
    if (cap = inline.text.exec(str)) {
      str = str.substring(cap[0].length);
      out += escape(cap[0]);
      continue;
    }
  }

  return out;
};

var mlink = function(cap, link) {
  if (cap[0][0] !== '!') {
    return '<a href="'
      + escape(link.href)
      + '"'
      + (link.title
      ? ' title="'
      + escape(link.title)
      + '"'
      : '')
      + '>'
      + inline.lexer(cap[1])
      + '</a>';
  } else {
    return '<img src="'
      + escape(link.href)
      + '" alt="'
      + escape(cap[1])
      + '"'
      + (link.title
      ? ' title="'
      + escape(link.title)
      + '"'
      : '')
      + '>';
  }
};

/**
 * Parsing
 */

var tokens
  , token;

var next = function() {
  return token = tokens.pop();
};

var tok = function() {
  switch (token.type) {
    case 'space': {
      return '';
    }
    case 'hr': {
      return '<hr>';
    }
    case 'heading': {
      return '<h'
        + token.depth
        + '>'
        + inline.lexer(token.text)
        + '</h'
        + token.depth
        + '>';
    }
    case 'code': {
      return '<pre><code>'
        + escape(token.text)
        + '</code></pre>';
    }
    case 'blockquote_start': {
      var body = [];

      while (next().type !== 'blockquote_end') {
        body.push(tok());
      }

      return '<blockquote>'
        + body.join('')
        + '</blockquote>';
    }
    case 'list_start': {
      var type = token.ordered ? 'ol' : 'ul'
        , body = [];

      while (next().type !== 'list_end') {
        body.push(tok());
      }

      return '<'
        + type
        + '>'
        + body.join('')
        + '</'
        + type
        + '>';
    }
    case 'list_item_start': {
      var body = [];

      while (next().type !== 'list_item_end') {
        body.push(token.type === 'text'
          ? text()
          : tok());
      }

      return '<li>'
        + body.join(' ')
        + '</li>';
    }
    case 'loose_item_start': {
      var body = [];

      while (next().type !== 'list_item_end') {
        body.push(tok());
      }

      return '<li>'
        + body.join(' ')
        + '</li>';
    }
    case 'html': {
      return inline.lexer(token.text);
    }
    case 'text': {
      return '<p>'
        + text()
        + '</p>';
    }
  }
};

var text = function() {
  var body = [ token.text ]
    , top;

  while ((top = tokens[tokens.length-1])
         && top.type === 'text') {
    body.push(next().text);
  }

  return inline.lexer(body.join('\n'));
};

var parse = function(src) {
  tokens = src.reverse();

  var out = [];
  while (next()) {
    out.push(tok());
  }

  tokens = null;
  token = null;

  return out.join(' ');
};

/**
 * Helpers
 */

var escape = function(html) {
  return html
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
    .replace(/'/g, '&apos;');
};

var mangle = function(str) {
  var out = ''
    , ch
    , i = 0
    , l = str.length;

  for (; i < l; i++) {
    ch = str.charCodeAt(i);
    if (Math.random() > 0.5) {
      ch = 'x' + ch.toString(16);
    }
    out += '&#' + ch + ';';
  }

  return out;
};

/**
 * Expose
 */

var marked = function(str, options) {
  if (typeof options === 'object')
    for (var key in options)
      opt[key] = options[key];

  return parse(block.lexer(str));
};

marked.parser = parse;
marked.lexer = block.lexer;

if (typeof module !== 'undefined') {
  module.exports = marked;
} else {
  this.marked = marked;
}

}).call(this);
if (typeof XMLHttpRequest == 'undefined')
  XMLHttpRequest = function () {
    try { return new ActiveXObject('Msxml2.XMLHTTP.6.0'); }
      catch (e) {}
    try { return new ActiveXObject('Msxml2.XMLHTTP.3.0'); }
      catch (e) {}
    try { return new ActiveXObject('Microsoft.XMLHTTP'); }
      catch (e) {}
    //Microsoft.XMLHTTP points to Msxml2.XMLHTTP and is redundant
    throw new Error('This browser does not support XMLHttpRequest.');
  };

function request(method, resource, data, callback) {
  'use strict';
  var hr = new XMLHttpRequest();
  
  if (arguments.length == 3) {
    callback = data;
    data = null;
  } else if (!data) {
    data = null;
  }
  
  hr.onreadystatechange = function() {
    if (hr.readyState == 4)
      callback(hr.status, hr.responseText);
  };
  hr.open(method, resource, true);
  if (data) {
    hr.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
  }
  hr.send(data);
  return hr;
}
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