;
function pad(n) { return n<10 ? '0'+n : n; }
var l10n = {
  lang: 'en',
  language: 'en_US',

  comments: 'Comments',
  commentsNotAvailable: 'Comments are temporarily not available.',
  dateString: function (date) {
    return date.getFullYear()+'-'+pad(date.getMonth())+'-'+date.getDate();
  }
};
