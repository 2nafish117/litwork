extends Node

var player_info: Dictionary
var player_choices: Dictionary

onready var http := $HTTPRequest

var remote_server: String = "https://httpbin.org/get"

func send_player_info():
	http.connect("request_completed", self, "_http_send_player_info_request_completed")
	var body = {"name": "Godette"}
	var error = http.request(remote_server, [], true, HTTPClient.METHOD_POST, player_info)
	if error != OK:
		push_error("An error occurred in the HTTP request.")
	pass


func _http_send_player_info_request_completed(result, response_code, headers, body):
	var response = parse_json(body.get_string_from_utf8())
	print(response.headers["User-Agent"])


