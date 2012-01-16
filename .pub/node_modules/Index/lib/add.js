var Index = require('./Index.js');

// Add new data to the index
Index.prototype.add = function(data, cb) {

  if (typeof data == 'object')

    // If data is an array, save each element of data
    if (data instanceof Array)
      for (var i = 0; i < data.length; i++)
        this.add(data[i], cb);
    // If data is an object, save data
    else {
      if (data.tags)
        // add new tags
        for (var i = 0; i < data.tags.length; i++) {
          this.tags[data.tags[i]] = true;
        }

      var id = data._id;
      delete data._id;

      // save data
      this.collection.update({ _id: id }, { '$set': data },
          { upsert: true, safe: true }, cb);
    }
  // If data is not an object, throw an error
  else
    return cb(new Error('data must be an object or an array of objects'));

};
