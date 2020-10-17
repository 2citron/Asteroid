extends KinematicBody2D

var speed = 500
var velocity = Vector2()
var acc = Vector2()
var friction = 0.65
export (PackedScene) var bullet
onready var canon = $Canon
onready var screen_size = get_viewport_rect().size

func _ready():
	pass

func _physics_process(delta):
	_get_input(delta)
	
	var dir = get_global_mouse_position() - global_position
	if dir.length() > 5:
		rotation = dir.angle()
		velocity = move_and_slide(velocity)
		velocity = velocity.linear_interpolate(Vector2(0,0), friction * delta)
	position.x = wrapf(position.x, 0, screen_size.x)
	position.y = wrapf(position.y, 0, screen_size.y)



func _get_input(delta):
	var forward = Input.is_action_pressed("drive")
	var shoot = Input.is_action_just_pressed("shoot")
	
	if forward:
		acc = Vector2(speed, 0).rotated(rotation)
	else:
		acc = Vector2(0, 0)
	velocity += acc * delta

	if shoot:
		var b = bullet.instance()
		b._create(canon.global_position,rotation)
		get_parent().add_child(b)
