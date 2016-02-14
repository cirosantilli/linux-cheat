#!/usr/bin/env casperjs
/*
# exit

  Sets exit status, but does not exit!!!

  https://github.com/n1k0/casperjs/issues/193
*/
var casper = require('casper').create();
switch ('nothing') {
  case 'nothing':
    /*
    This produces exit status 3:
    2 is simply overwritten by the next exit call.
    */
    casper.exit(2)
    casper.exit(3)
  break;
  case 'bypass':
    casper.exit(2)
    /* bypass works here, but in a larger script it failed to skip the next exit once for me. */
    casper.bypass(1)
    casper.exit(3)
  break
  case 'else':
    /*
    This is the most robust solution I've found so far:
    use your program logic to never run exit multiple times.
    */
    if (true) {
      casper.exit(2)
    } else {
      casper.exit(3)
    }
  break
}
