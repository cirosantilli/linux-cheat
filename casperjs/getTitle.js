#!/usr/bin/env casperjs
var casper = require('casper').create();
casper.start();
casper.thenOpen('./getTitle.html', function() {
  this.echo(this.getTitle());
});
casper.run();
