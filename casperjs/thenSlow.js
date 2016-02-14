#!/usr/bin/env casperjs
/*
Test then and slow servers.

Observed outcome:

  slow
  fast

So the first request does wait for the response,
and only then is the second request made.

Of course, there are things it might not wait for:

- JavaScript to run. An infinite loop would never finish running.
- other to be loaded
*/
var casper = require('casper').create();
var host = 'http://localhost:1337'
casper.start();
casper.thenOpen(host + '/slow', function() {
  this.echo(this.getHTML());
});
casper.thenOpen(host + '/fast', function() {
  this.echo(this.getHTML());
});
casper.run();
