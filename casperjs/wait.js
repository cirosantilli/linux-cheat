#!/usr/bin/env casperjs
/* Pause execution for N milliseconds. */
var casper = require('casper').create();
casper.start();
casper.then(function(){this.echo('before');});
casper.wait(3000);
casper.then(function(){this.echo('after');});
casper.run();
