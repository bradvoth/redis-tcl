redis-tcl
=========

Tcl library for redis access

Installation:

'make install' will install the library into what it detects is your library
location for tcl.  It does this detection through the entirely simple method of
using the tclsh in your path to check the output of 'info library' command.
The method of detection should be expanded in the future to play more nicely
with alternate tcl installations.

Usage:

'package require redis' will get you started.

The 'redis' command creates a redis connection that can then be passed normal
redis commands.  For example, the following creates a redis connection, and
runs the redis time command (it ignores the output however, that part is up to
you!):

set r [redis]
$r time


It is possible to use this client for basic pub/sub operations with redis.  To
subscribe to a channel you must first set a callback through the following:

$r setcallback procname

After the callback is set channels can be subscribed to as:

$r subscribe x y taters

Once a specific connection is set for a subscription it CANNOT be used for
other redis communications.  At this time it is only possible to bulk
unsubscribe from all channels through:

$r unsubscribe
