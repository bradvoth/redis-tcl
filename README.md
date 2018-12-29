redis-tcl
=========

Tcl library for redis access

[![Build Status](https://travis-ci.org/bradvoth/redis-tcl.svg?branch=master)](https://travis-ci.org/bradvoth/redis-tcl)

Installation:

'make install' will install the library into what it detects is your library
location for tcl.  It does this detection through the entirely simple method of
using the tclsh in your path to check the output of 'info library' command.
The method of detection should be expanded in the future to play more nicely
with alternate tcl installations.

## Usage

'package require redis' will get you started.

The 'redis' command creates a redis connection that can then be passed normal
redis commands.  For example, the following creates a redis connection, and
runs the redis time command (it ignores the output however, that part is up to
you!):

```tcl
    package require redis
    
    set redis [redis $host $port]
    
    $redis time
    $redis set abc 123
    $redis get abc
```

## Defer and Collect

There is chance that you want to send redis commands in pipeline mode, and read
all the result back in a batch.

```tcl
    $redis -defer set abc 123
    $redis -defer -key abc get abc
    
    # use "--" to separate redis command. This make code easy to read.
    
    $redis -defer -- set def 456
    $redis -defer -key def -- get def
    
    set result [$redis collect]

    # Output: 0 OK abc 123 2 OK def 456
```

## PUB/SUB

It is possible to use this client for basic pub/sub operations with redis.  To
subscribe to a channel you must first set a callback and then subscribe as below:

```tcl
    $redis setcallback procname

    $redis subscribe x y taters
```

Once a specific connection is set for a subscription it CANNOT be used for
other redis communications.  At this time it is only possible to bulk
unsubscribe from all channels through:

```tcl
    $redis unsubscribe
```

This will also reset callback to empty. To get the callback before unsubscribe:

```tcl
    set callback [$redis getcallback]
```

An example of callback may looks like:

```tcl
    proc onPublish {channels redis type reply} {
      if {[llength $reply]==1 && $reply>0} {
        # OK subscribe $reply
        return
      }

      lassign $reply kind channel data
      # kind = enum { subscribe unsubscribe message }
    }
 ```
 
 
