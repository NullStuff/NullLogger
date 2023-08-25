extends Node
## Abstract base class for Transports. Does not do anything on it's own.
##
## Many Transports are intended to be used as singletons in your project's 'autoruns'. This way they
## can be refrenced "globally" by name by checking the 'enable' box. You can change the
## "global" name of your Transport by changing it's name in autoruns. To create multiple Transports
## with different settings, simply create multiple scene trees and add them each to 'autoruns'.


## Method that needs to be overridden by child classes to handle logging a message.
func _push(_message: String, _level):
    push_error("Transport nodes are an abstract class and therefore do not implement any functionality. You are likely looking for a child class such as FileTransport or ConsoleTransport")
    return
