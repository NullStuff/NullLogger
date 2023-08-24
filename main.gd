@tool
extends EditorPlugin


func _enter_tree():
	add_autoload_singleton("NullLogger", "res://addons/null_logger/scripts/null_logger.gd")

	add_custom_type("Logger", "Node", preload("./scripts/logger.gd"), preload("./assets/logger.svg"))
	add_custom_type("FormattedLogger", "Logger", preload("./scripts/formatted_logger.gd"), preload("./assets/logger.svg"))
	add_custom_type("Transport", "Node", preload("./scripts/transport.gd"), preload("./assets/transport.svg"))
	add_custom_type("FileTransport", "Transport", preload("./scripts/file_transport.gd"), preload("./assets/transport.svg"))
	add_custom_type("ConsoleTransport", "Transport", preload("./scripts/console_transport.gd"), preload("./assets/transport.svg"))


func _exit_tree():
	remove_custom_type("Logger")
	remove_custom_type("FormattedLogger")
	remove_custom_type("Transport")
	remove_custom_type("FileTransport")
	remove_custom_type("ConsoleTransport")

	remove_autoload_singleton("NullLogger")
