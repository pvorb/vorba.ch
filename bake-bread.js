var bread = require("bread");

// configuration object
var conf = {
	dbinf: { // MongoDB connection
		host: "localhost",
		port: "27017",
		name: "vorb_de",
		collection: "pages"
	},

	directories: {
		input: "pub",    // Look for files in this dir.
		output: "pub",   // Write files to this dir.
		templates: "tpl" // Look for templates in this dir.
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
			title: "Blog",
			pattern: /\/log\/\d{4}\/\d{2}\/[^\/]+/,  // Index files matched by this pattern.
			path: {
				first: "/log/index.html",            // first page of the index
				pattern: "/log/index-{{page}}.html"  // other pages
			},
			template: "index.tpl",    // template
			limit: 8,                 // 8 links per page
			sort: [["date", "desc"]]  // newest first
		},
		// Atom Feed
		{
			title: "Paul Vorbach",
			pattern: /\/log\/\d{4}\/\d{2}\/[^\/]+/,  // Add files matched by this pattern to
			                          // the feed.
			path: "/log/feed.xml",    // feed url
			template: "atom.tpl",     // template
			limit: 10,                // total maximum
			sort: [["date", "desc"]]  // newest first
		}
	],

	properties: {
		siteTitle: "Paul Vorbach",
		author: "Paul Vorbach",
		template: "post.tpl",
		stylesheet: "compact.css"
	}
};

bread(conf);