extends AudioStreamPlayer

const level_music = preload("res://assets/music and sound/great_beholder_preview_wip.mp3")

func _play_music(music: AudioStream, volume = -20.0):
	if stream == music:
		return
	stream = music
	volume_db = volume
	play()
	
func play_music_level():
	if not playing:
		finished.connect( play_music_level )
		_play_music(level_music)


func loop_music():
	play_music_level()
