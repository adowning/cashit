/**
 * Minified by jsDelivr using Terser v5.19.2.
 * Original file: /npm/wurfl@0.3.1/lib/wurfl.js
 *
 * Do NOT use SRI with dynamically generated files! More information: https://www.jsdelivr.com/using-sri-with-dynamic-files
 */
var worker,
  fs = require('fs'),
  path = require('path'),
  expat = require('node-expat'),
  parser = require('./parser'),
  backgrounder = require('backgrounder'),
  wurflFile = path.join(__dirname, '../wurfl.xml'),
  userAgents = {},
  callbacks = { watch: {}, load: {} }
function get(e, r) {
  var o = userAgents[e]
  return r && void 0 !== o && (o = o.deepCopy()), o
}
function getAll() {
  return userAgents
}
function close() {
  worker && worker.terminate()
}
function getWorker() {
  return (
    worker ||
      ((worker = new backgrounder.spawn(path.join(__dirname, './worker.js'))).on(
        'message',
        function (e) {
          var r = e.method,
            o = e.file
          packageDevices(e.devices)
          var n = callbacks[r][o]
          n && n()
        }
      ),
      worker.on('error', function (e) {
        console.error(e)
      })),
    worker
  )
}
function watch(e, r) {
  'function' == typeof e && ((r = e), (e = void 0)),
    'string' == typeof e && (e = { file: e }),
    ((e = e || { file: e }).file = e.file || wurflFile),
    r && (callbacks.watch[file] = r),
    getWorker().send({ method: 'watch', file: e.file, groups: e.groups })
}
function load(e, r) {
  'function' == typeof e && ((r = e), (e = void 0)),
    'string' == typeof e && (e = { file: e }),
    ((e = e || { file: e }).file = e.file || wurflFile),
    r && (callbacks.load[e.file] = r),
    getWorker().send({ method: 'load', file: e.file, groups: e.groups })
}
function loadSync(e) {
  'string' == typeof e && (e = { file: e }), ((e = e || { file: e }).file = e.file || wurflFile)
  var r = fs.readFileSync(e.file)
  packageDevices(parser.parse(r, e.groups))
}
function packageDevices(e) {
  var r = {}
  e.forEach(function (r) {
    e[r.id] = r
  }),
    e.forEach(function (o, n, t) {
      o instanceof Device || (t[n] = createDevice(o, e, r))
    }),
    (userAgents = r)
}
function createDevice(e, r, o) {
  'root' === e.fall_back || r[e.fall_back] instanceof Device || createDevice(r[e.fall_back], r, o)
  var n = e.groups
  delete e.groups
  var t = new Device(e)
  ;(r[t.id] = t), (o[t.user_agent] = t)
  var i = r[e.fall_back]
  if (i)
    for (var a in i) {
      var c = i[a]
      c instanceof Group && (t[a] = c)
    }
  for (var f in n) {
    c = t[f]
    var l = function () {},
      s = (l.prototype = c ? new c.constructor() : new Group())
    ;(s.constructor = l), (s.id = t.id + '.' + f), (t[f] = c = new l())
    var u = n[f]
    for (var p in u) s[p] = u[p]
  }
  return t
}
function Device(e) {
  for (var r in e) e.hasOwnProperty(r) && (this[r] = e[r])
}
function Group() {}
;(Device.prototype.deepCopy = function () {
  var e = {},
    r = this
  for (var o in r) for (var n in ((e[o] = r[o]), r[o])) 'constructor' != n && (e[o][n] = r[o][n])
  return e
}),
  (exports.watch = watch),
  (exports.load = load),
  (exports.loadSync = loadSync),
  (exports.get = get),
  (exports.getAll = getAll),
  (exports.close = close)
//# sourceMappingURL=/sm/e658718a12f2a1622535ad06b29bb8827a3bc31dc940df8e183fcaeea3f8f0e8.map
