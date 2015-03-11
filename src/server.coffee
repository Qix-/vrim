http = require 'http'
io = require 'socket.io'
pty = require 'pty'
fs = require 'fs'
vrimtty = require './tty'

class VrimServer
  constructor: ->
    # set up an HTTP server
    @http = http.createServer (req, res) =>
      @onRequest req, res

    @io = io @http
    @io.set 'origins', 'http://localhost:9999'
    @io.on 'connection', (sock) =>
      @onConnect sock

    @http.listen 9999

  onRequest: (req, res) ->
    # root?
    req.url = '/index.html' if req.url is '/'

    fs.readFile 'http' + req.url, (err, data) ->
      if err
        res.writeHead 500
        res.end 'Bad request: ' + err
      else
        res.writeHead 200
        res.end data

  onConnect: (sock) ->
    # create a new TTY session
    tty = pty.spawn 'bash', [],
      name: 'xterm-color',
      cols: 80
      rows: 30
      cwd: process.env.HOME
      env: process.env

    tty.on 'data', (data) ->
      sock.emit 'data', data

    sock.on 'keydown', (keyev) ->
      tty.write vrimtty.keyEventToBuffer keyev


module.exports = VrimServer
