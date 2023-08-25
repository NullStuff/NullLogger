extends Transport
## A Transport which prints logs to the console.
##
## This Transports does not need to be used as a singleton, but it is recommended to for simplicity.
## This transport only uses godot's built in print() and optionally printerr() settings to print
## logs to the editor's console and your applications stdout and stderr respectivley.


@export_category("Console Transport")
## Wether or not to print error level logs to the standard error instead of standard output.
@export var use_stderr := true


func _push(message: String, level):
    if use_stderr and level == NullLogger.Level.ERROR:
        printerr(message)
    else:
        print(message)