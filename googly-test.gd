extends Node2D

@onready var eye = $"SugarCookie/Sprites/Sugar-cookie-pupil-left"
@onready var pos_label = $CanvasLayer/Label
@onready var vel_label = $CanvasLayer/Label2

func _process(_delta):
	pos_label.text = "eye position: {0}".format([eye.position])
	vel_label.text = "eye velocity: {0}".format([eye.velocity])
