var fs = require('fs');
var path = require('path');
var ejs = require('ejs');
var clone = require('clone');

var Index = require('./Index.js');
var parseDate = require('./parse-dates.js');

// Write the tag files
Index.prototype.writeTags = function(cb) {

  var inst = this;
  var opt = this.opt;
  var tplDir = path.resolve(opt.confdir, 'templates');
  var tagDir = opt.tags.directory;
  var tagConf = opt.tags;
  var c = this.collection;
  var tags = Object.keys(this.tags);
  var db = this.db;

  // one more because of tag index
  var todo = tags.length + 1;

  // Read tag template
  fs.readFile(path.resolve(tplDir, tagConf.template), 'utf8',
      function(err, tpl) {
    if (err)
      return cb(err);

    // For every tag
    tags.forEach(function(tag) {

      var p = (typeof opt.properties != 'undefined') ?
        clone(opt.properties) : {};
      // Add the title of the tag to the properties
      p.title = tag;

      // Find docs with this tag
      c.find({ tags: tag }).toArray(function(err, docs) {
        if (err)
          return cb(err);

        // Parse dates
        docs = parseDate(docs);

        // Add docs
        p.__docs = docs;

        // Render with ejs
        var tagFile = ejs.render(tpl, { locals: p });

        // New filename
        var tagFilename = path.resolve(opt.root, tagDir, tag + '.html');

        // Write the file
        fs.writeFile(tagFilename, tagFile, function(err) {
          if (err)
            return cb(err);

          console.log('  ' + tagFilename + ' written.');

          if (!--todo) {
            if (typeof cb != 'undefined')
              cb();
            try {
              db.close();
            } catch (e) {}
            return;
          }
        });
      });
    });
  });

  // Read index template
  fs.readFile(path.resolve(tplDir, tagConf.index.template), 'utf8',
      function(err, tpl) {
    if (err)
      return cb(err);

    var p = (typeof opt.properties != 'undefined') ?
        clone(opt.properties) : {};
    p.__tags = tags;

    var indexFile = ejs.render(tpl, { locals: p });
    var indexFilename = path.resolve(opt.root, tagDir, tagConf.index.path);
    fs.writeFile(indexFilename, indexFile, function(err) {
      if (err)
        return cb(err);

      console.log('  ' + indexFilename + ' written.');

      if (!--todo) {
        if (typeof cb != 'undefined')
          cb();
        try {
          db.close();
        } catch (e) {}
        return;
      }
    });
  });
};
