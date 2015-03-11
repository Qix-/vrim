http = require 'http'
io = require 'socket.io'
pty = require 'pty'
fs = require 'fs'

class VrimServer
  constructor: ->
    # Set up an HTTP server
    @http = http.createServer (req, res) =>
      @onRequest req, res

    @io = io @http
    @io.on 'connection', (sock) =>
      @onConnect sock

    @http.listen 9999

  onRequest: (req, res) ->
    req.url = '/index.html' if req.url is '/'

    fs.readFile 'http' + req.url, (err, data) ->
      if err
        res.writeHead 500
        res.end 'Bad request: ' + err
      else
        res.writeHead 200
        res.end data

  onConnect: (sock) ->
    console.log 'socket opened'


module.exports = VrimServer
