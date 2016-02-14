#!/usr/bin/env node
/*
Simple server to test slow responses.
Requets to `/slow` are slow, all others are fast.
*/
var http = require('http');
var host = '127.0.0.1'
var port = 1337
http.createServer(function (request, response) {
  response.writeHead(200, {'Content-Type': 'text/plain'});
  var date = (new Date()).toISOString();
  if (request.url === '/slow') {
    setTimeout(function(){
      response.end('slow\n' + date);
    }, 2000);
  } else {
    response.end('fast\n' + date);
  }
}).listen(port, host);
console.log('Server running at: http://' + host + '/' + port + '/');
