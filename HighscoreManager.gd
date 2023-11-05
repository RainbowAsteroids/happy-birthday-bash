extends Node

const high_score_filename := "user://highscore.dat"

var is_highscore := false
var score := 0:
	set(value):
		score = value

		if score > high_score:
			is_highscore = true
			high_score = score

var high_score := 0

func reset():
	score = 0
	is_highscore = false

func read():
	var file = FileAccess.open(high_score_filename, FileAccess.READ)

	file.seek(0)
	high_score = file.get_64()
	file.flush()

	file.close()

func commit():
	var file = FileAccess.open(high_score_filename, FileAccess.WRITE)

	file.seek(0)
	file.store_64(high_score)
	file.flush()

	file.close()

func _ready():
	if FileAccess.file_exists(high_score_filename):
		read()
	commit()

func _exit_tree():
	commit()
