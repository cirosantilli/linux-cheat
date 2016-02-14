#!/usr/bin/env casperjs
var casper = require('casper').create();
casper.start();
casper.thenOpen('http://checkip.amazonaws.com/', function() {
  this.echo(this.getHTML());
});
casper.run();
