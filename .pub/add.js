;(function () {

var fs = require('fs');
var path = require('path');
var readline = require('readline');

var props = require('props');
var Index = require('Index');
var isodate = require('isodate');
var async = require('async');

var cliPrefix = '> ';
var cdir = __dirname;
var root = path.resolve(cdir, '..');

var ext = {
  html: /\.(html|htm|xhtml)$/,
  markdown: /\.(md|mkd|markdown|text|txt)$/,
  image: /\.(jpe?g|png|gif|bmp|svg|webp)$/
};

module.exports = function (files, opt) {
  // Load configuration file
  var conf = {};
  try {
    conf = JSON.parse(fs.readFileSync(path.resolve(cdir, 'conf.json'),
        'utf8'));
    conf.confdir = cdir;
    conf.properties = JSON.parse(fs.readFileSync(path.resolve(cdir,
        'properties.json'), 'utf8'));
  } catch (err) {
    return console.error('Could not read the configuration files.');
  }

  if (files.length > 1)
    return console.error('pub add only supports one file at once.');

  new Index(conf, function (err, index) {
    if (err)
      return console.error('The connection to MongoDB could not be established.'
        + '\nEnsure that you started MongoDB and configured pub correctly.');

    var f = files.pop();
    // If it's html or a picture, ask for user input
    if (f.match(ext.html) || f.match(ext.image))
      askForInfo(index, f, makeIndexes);
    // If it's markdown, parse file with props
    else if (f.match(ext.markdown)) {
      var info = props(fs.readFileSync(f));
      makeIndexes(index, f, info);
    }
    // Otherwise the file type is not supported
    else
      console.error('This file type is not supported.');
  });
};

function askForInfo(index, file, cb) {
  var info = {};

  var rl =readline.createInterface(process.stdin, process.stdout);
  rl.on('line', function (l) {
    l = l.trim();
    var prop = l.split(':');
    if (prop.length >= 2) {
      var key = prop.shift().trim();
      var value = prop.join(':').trim();

      switch (key) {
        case 'created':
        case 'modified':
          try {
            info[key] = isodate(value);
          } catch (err) {
            if (value == 'now')
              info[key] = new Date();
            else
              console.error('Invalid value');
          }
          break;
       default:
          info[key] = value;
      }
      rl.prompt();
    } else
      if (l == 'save') {
        // Stop listening on user input
        rl.close();
        process.stdin.destroy();

        // show what we've collected
        console.log(info);

        // add file contents
        try {
          info.__content = fs.readFileSync(file, 'utf8');
        } catch (err) {
          console.error('The file \''+file+'\' cannot be read.');
          process.exit(1);
        }

        // callback
        cb(index, file, info);
      } else {
        console.warn('Unknown command');
        rl.prompt();
      }
  });

  console.log('This file type does not contain all necessary information.\n'
    + 'Please provide me some additional information.');
  rl.setPrompt(cliPrefix, cliPrefix.length);
  rl.prompt();
}

var success = '\nDone.';

function makeIndexes(index, file, info) {
  if (!info._id) {
    var dest = file.replace(ext.markdown, '.html').replace(ext.image, '.html');
    info._id = dest.replace(new RegExp('^'+root), '');
  }

  // add file to index
  index.add(info, function (err, result) {
    if (err)
      throw err;
    console.log('Added file \''+file+'\' to the index.');

    // two tasks
    var todo = 2;

    // write index files
    index.writeIndex(function (err) {
      if (err)
        throw err;
      else {
        if (!--todo)
          console.log(success);
      }
    });

    // write tag files
    index.writeTags(function (err) {
      if (err)
        throw err;
      else {
        if (!--todo)
          console.log(success);
      }
    });
  });
}

}).call(this);
