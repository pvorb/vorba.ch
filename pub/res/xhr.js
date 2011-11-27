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
