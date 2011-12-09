// configuration object
module.exports = {
  dbinf: { // MongoDB connection
    host: "localhost",
    port: "27017",
    name: "vorb_de",
    collection: "pages"
  },

  directories: {
    input: "pub", // Look for files in this dir.
    output: "pub", // Write files to this dir.
    templates: "tpl", // Look for templates in this dir.
    tags: "pub/log/tag" // Write tag files to this dir.
  },

  fileExtensions: { // Replace markdown by html
    "mkd": "html",
    "md": "html",
    "mdown": "html",
    "markdown": "html"
  },

  // Array of indexes that shall be created
  indexes: [
    // Blog Index
    {
      // Index files matched by this pattern.
      pattern: /\/log\/\d{4}\/\d{2}\/[^\/]+/,
      path: {
        first: "/log/index.html", // first page of the index
        pattern: "/log/index-{{page}}.html" // other pages
      },
      template: "index.tpl", // template
      limit: 8, // 8 links per page
      sort: [ [ "date", "desc" ] ], // newest first
      properties: {
        title: "Blog"
      }
    },
    // Atom Feed
    {
      // Add files matched by this pattern to the feed
      pattern: /\/log\/\d{4}\/\d{2}\/[^\/]+/,
      path: "/log/feed.xml", // feed url
      template: "atom.tpl", // template
      limit: 10, // total maximum
      sort: [ [ "date", "desc" ] ], // newest first
      properties: {
        title: "Paul Vorbach",
        id: "http://vorb.de/log/feed.xml"
      }
    }
  ],

  tags: {
    template: "tag.tpl",
    sort: [["date", "desc"]],
    index: {
      path: "index.html",
      template: "tag-index.tpl"
    }
  },

  properties: {
    siteTitle: "Paul Vorbach",
    siteSubtitle: "Web, Entwicklung und so",
    siteAuthor: "Paul Vorbach",
    author: "Paul",
    authorLink: "http://vorb.de/",
    template: "post.tpl",
    stylesheet: "milten.css"
  }
};
