#!/usr/bin/env tclsh
package require Tcl 
package require tcltest
::tcltest::configure -testdir \
        [file dirname [file normalize [info script]]]
eval ::tcltest::configure $argv
::tcltest::runAllTests
