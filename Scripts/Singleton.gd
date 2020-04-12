extends Node

var enemyCount = 0

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS
	var music_file = "res://Assets/Sound/game_music.ogg"
	var stream = AudioStream.new()
	var music_player = AudioStreamPlayer.new()
	if File.new().file_exists(music_file):
		var music = load(music_file)
		music_player.stream = music
		music_player.play()
		add_child(music_player)

