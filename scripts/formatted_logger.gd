class_name FormattedLogger extends Logger
## A Logger which uses a format string for prettier output.
##
## Loggers will run from _init() and are intended to be used as singletons in your project's
## 'autoruns'. This way they can be refrenced "globally" by name by checking the 'enable' box.
## In order to edit the settings, you will need to create a scene tree with at least a Logger node,
## however it is recommended to create a scene tree with only your Logger. You can change the
## "global" name of your Logger by changing it's name in autoruns. To create multiple Loggers with
## different settings, simply create multiple scene trees and add them each to 'autoruns'.

## What style of time to use for the logged timestamp.
enum Time_Mode {
    MSEC, ## Will use the number of milliseconds since the application started.
    USEC, ## Will use the number of microseconds since the application started.
    SYSTEM ## Will use the date and time from the system.
}


@export_category("Formatted Logger")
## Format for each logged message. Formats are available: [br]
##     {timestamp} is replaced by the logged time using the time format. [br]
##     {label} is replaced by the label provided for that message, or the default label. [br]
##     {level} is replaced by the level text "Error", "Warn", "Info", "Verbose", or "Debug". [br]
##     {message} is replaced by the message.
@export var log_format := "{timestamp} [{label}] {level}: {message}"
## The label to use for logs from this logger.
@export var label := ""
## What style of time to use for the logged timestamp.
@export var time_mode := Time_Mode.MSEC
@export_group("Level Texts")
@export var error_level_text := "Error"
@export var warning_level_text := "Warning"
@export var info_level_text := "Info"
@export var verbose_level_text := "Verbose"
@export var debug_level_text := "Debug"


func send_log(message: String, level: NullLogger.Level = NullLogger.Level.INFO):
    var time

    match time_mode:
        Time_Mode.MSEC:
            time = Time.get_ticks_msec()
        Time_Mode.USEC:
            time = Time.get_ticks_usec()
        Time_Mode.SYSTEM:
            time = Time.get_datetime_string_from_system()
        _:
            time = Time.get_ticks_msec()

    var level_string

    match level:
        NullLogger.Level.ERROR:
            level_string = error_level_text
        NullLogger.Level.WARNING:
            level_string = warning_level_text
        NullLogger.Level.INFO:
            level_string = info_level_text
        NullLogger.Level.VERBOSE:
            level_string = verbose_level_text
        NullLogger.Level.DEBUG:
            level_string = debug_level_text

    var log_line = log_format.format(
        {
            "timestamp": time,
            "label": label,
            "level": level_string,
            "message": message
        }
    )

    super.send_log(log_line, level)
