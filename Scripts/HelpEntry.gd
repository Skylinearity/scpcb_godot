extends Resource
class_name HelpEntry

@export var command: String
@export_multiline var text: String

const BUFFER: String = "******************************"

func fetch_text() -> String:
	return "HELP - " + command + "\n" + BUFFER + "\n" + text + "\n" + BUFFER
