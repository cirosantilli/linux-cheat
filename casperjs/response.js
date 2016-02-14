#!/usr/bin/env casperjs
/*
http://stackoverflow.com/questions/18074093/get-response-status-404-in-casper-js-within-open
http://stackoverflow.com/questions/17914489/how-to-get-casper-js-http-status-code
*/

var utils = require('utils')
var casper = require('casper').create({
  verbose: true,
  logLevel: 'debug'
});
casper.start();
casper.thenOpen('http://stackoverflow.com/questions/237/distributed-source-control-options/', function(response) {
  utils.dump(response);
  utils.dump(this.status(false));
});
casper.run();
