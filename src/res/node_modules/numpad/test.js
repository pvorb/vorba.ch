var assert = require('assert');
var numpad = require('./numpad.js');

assert.strictEqual(numpad(5, 3), '005');
assert.strictEqual(numpad(18.1, 5), '00018.1');
assert.strictEqual(numpad(1534, 2), '1534');
assert.strictEqual(numpad(1883.953, 3), '1883.953');

console.log('ok');
