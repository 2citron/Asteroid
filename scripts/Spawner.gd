extends Node2D
export (PackedScene) var asteroid

onready var timer = $Timer
var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	timer.wait_time = rng.randf_range(5, 15)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(_delta):

func _on_Timer_timeout():
	var a = asteroid.instance()
	rng.randomize()
	var dir = rng.randf_range(0, 360)
	a._create(global_position)
	get_parent().add_child(a)
