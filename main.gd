@tool
extends EditorPlugin


func _enter_tree():
	add_autoload_singleton("NullLogger", "res://addons/NullLogger/scripts/null_logger.gd")

	add_custom_type("Logger", "Node", preload("res://addons/NullLogger/scripts/logger.gd"), preload("res://addons/NullLogger/assets/logger.svg"))
	add_custom_type("FormattedLogger", "Logger", preload("res://addons/NullLogger/scripts/formatted_logger.gd"), preload("res://addons/NullLogger/assets/logger.svg"))
	add_custom_type("Transport", "Node", preload("res://addons/NullLogger/scripts/transport.gd"), preload("res://addons/NullLogger/assets/transport.svg"))
	add_custom_type("FileTransport", "Transport", preload("res://addons/NullLogger/scripts/file_transport.gd"), preload("res://addons/NullLogger/assets/transport.svg"))
	add_custom_type("ConsoleTransport", "Transport", preload("res://addons/NullLogger/scripts/console_transport.gd"), preload("res://addons/NullLogger/assets/transport.svg"))


func _exit_tree():
	remove_custom_type("Logger")
	remove_custom_type("FormattedLogger")
	remove_custom_type("Transport")
	remove_custom_type("FileTransport")
	remove_custom_type("ConsoleTransport")

	remove_autoload_singleton("NullLogger")
