extends Node

var player_info: Dictionary
var player_choices: Dictionary

onready var http := $HTTPRequest

var remote_server: String = "https://httpbin.org/get"

func send_player_info():
	var error = http.connect("request_completed", self, "_http_send_player_info_request_completed")
	if error != OK:
		push_error("Error in http signal connection")
	error = http.request(remote_server, [], true, HTTPClient.METHOD_POST, player_info)
	if error != OK:
		push_error("An error occurred in the HTTP request.")
	pass


func _http_send_player_info_request_completed(_result, _response_code, _headers, body):
	var response = parse_json(body.get_string_from_utf8())
	print(response.headers["User-Agent"])

func set_default_player_info():
	player_info["name"] = "mc"
	player_info["sex"] = "male"
	player_info["email"] = "mc@mc.com"
	
func _ready() -> void:
	set_default_player_info()

