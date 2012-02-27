module.exports = function numpad(x, digits) {
  var result = Math.floor(x).toString();

  if (typeof digits == 'undefined')
    digits = 2;

  while (result.length < digits)
    result = '0'+result;

  var dec = x.toString().split('.')[1];
  if (dec)
    return result + '.' + dec;

  return result;
};
