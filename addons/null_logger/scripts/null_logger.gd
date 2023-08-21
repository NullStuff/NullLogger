extends Node


## A log level. These may be used to refer to a single level, or a level and all levels below it.
enum Level {
    ERROR, ## Log only errors. The error level also uses printerr() when outputting to console.
    WARNING, ## Log errors and warnings.
    INFO, ## Log info, and above
    VERBOSE, ## Log verbose, and above
    DEBUG ## Log debug, and above
}
