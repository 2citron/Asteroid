extends Area2D

var speed = 200
var velocity = Vector2()
var rng = RandomNumberGenerator.new()
onready var screen_size = get_viewport_rect().size
export (PackedScene) var shard

func _ready():
	pass
	
func _create(pos):
	position = pos
	rng.randomize()
	speed = rng.randf_range(100, 300)
	rotation_degrees = rng.randf_range(0,360)


func _process(delta):
	position.x = wrapf(position.x, 0, screen_size.x)
	position.y = wrapf(position.y, 0, screen_size.y)
	position += Vector2(1, 0).rotated(rotation) * speed * delta


func _on_Asteroid_body_entered(body):
	if "Bullet" in body.name:
		queue_free()
		PlayerInfo.score += 500
		body.queue_free()
		rng.randomize()
		var shards = rng.randf_range(2, 4)
		
		for i in shards:
			var s = shard.instance()
			rng.randomize()
			var dir = rng.randf_range(0, 360)
			s._create(global_position)
			get_parent().add_child(s)
	if "Player" in body.name:
		body.queue_free()
		PlayerInfo.vie -=1
		if PlayerInfo.vie < 0:
			print("Oui")
			get_tree().change_scene("res://scenes/Restart.tscn")
		else:
			get_tree().reload_current_scene()

