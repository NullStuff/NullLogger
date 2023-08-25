extends Transport
## A Transport which outputs logs to a log file.
##
## The transport will fail if another FileTransport already has the logfile open, therefore it is
## recommended to create a singleton for each log file you create and add that singleton to each
## logger which should output to the console.


## Path to store log files.
@export_dir var logging_path := "user://logs/"
## Format for the saved log's filename. Formats are available: [br]
##     {timestamp} is replaced by the time when the application is started. This time may be very slightly later than the actual application start time.
@export var filename_format := "{timestamp}.log"


var _log_file: FileAccess
var _time := Time.get_datetime_string_from_system()


func _init():
    _open_log_file()


func push(message: String, _level = NullLogger.Level.INFO):
    if _log_file == null:
        push_error("Log file lost? Trying to find it again...")
        if !_open_log_file():
            return

    _log_file.store_line(message)


## Returns true if opening the file succeeded, or false if it did not.
func _open_log_file() -> bool:
    var log_file_path = logging_path + filename_format.format({"timestamp": _time})

    _log_file = FileAccess.open(log_file_path, FileAccess.READ_WRITE)

    if _log_file == null:
        push_error("Logger could not open log file!")
        return false

    return true


func _exit_tree():
    if _log_file != null:
        _log_file.close()