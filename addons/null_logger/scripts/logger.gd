class_name Logger extends Node
## A Node which manages logging to a list of transports.
##
## Loggers will run from _init() and are intended to be used as singletons in your project's
## 'autoruns'. This way they can be refrenced "globally" by name by checking the 'enable' box.
## In order to edit the settings, you will need to create a scene tree with at least a Logger node,
## however it is recommended to create a scene tree with only your Logger. You can change the
## "global" name of your Logger by changing it's name in autoruns. To create multiple Loggers with
## different settings, simply create multiple scene trees and add them each to 'autoruns'.


@export_category("Logger")
## The maximum level to log messages. All lower levels will be included.
@export var log_level := NullLogger.Level.INFO
## Wether or not to watch for command line arguments to switch the log level
@export var watch_cmd_args = true
## Transports to push log lines to
@export var transports: Array[Transport]

func _init():
    if watch_cmd_args:
        var args = Array(OS.get_cmdline_args())

        if args.find("-e") != -1:
            log_level = NullLogger.Level.ERROR
        if args.find("-w") != -1:
            log_level = NullLogger.Level.WARNING
        if args.find("-i") != -1:
            log_level = NullLogger.Level.INFO
        if args.find("-v") != -1:
            log_level = NullLogger.Level.VERBOSE
        if args.find("-d") != -1:
            log_level = NullLogger.Level.DEBUG
        if OS.is_stdout_verbose():
            log_level = NullLogger.Level.VERBOSE


## Add the passed Transport to the list of Transports the logger will push to, unless it is already in the list.
func add_transport(transport: Transport):
    if transports.find(transport) == -1:
        transports.append(transport)


## If the transport is recieving pushes from this logger, remove it.
func remove_transport(transport: Transport):
    var i = transports.find(transport)
    if  i != -1:
        transports.pop_at(i)


## Log a message at the level of error
func error(message: String):
    send_log(message, NullLogger.Level.ERROR)


## Log a message at the level of error
func err(message: String):
    error(message)


## Log a message at the level of warning
func warning(message: String):
    send_log(message, NullLogger.Level.WARNING)


## Log a message at the level of warning
func warn(message: String):
    warning(message)


## Log a message at the level of info
func info(message: String):
    send_log(message, NullLogger.Level.INFO)


## Log a message at the level of debug
func debug(message: String):
    send_log(message, NullLogger.Level.DEBUG)


## Log a message at the level of verbose
func verbose(message: String):
    send_log(message, NullLogger.Level.VERBOSE)


## Push a log message to all Transports 
func send_log(message: String, level: NullLogger.Level = NullLogger.Level.INFO):
    if level <= log_level:
        for transport in transports:
            transport.push(message, level)
