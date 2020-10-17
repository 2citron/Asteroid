extends KinematicBody2D

var speed = 800
var velocity = Vector2()


func _ready():
	pass

func _create(pos,dir):
	position = pos
	velocity = Vector2(speed, 0).rotated(dir)
	

func _physics_process(_delta):
	velocity = move_and_slide(velocity)
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		print("I collided with ", collision.collider.name)
		queue_free()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
