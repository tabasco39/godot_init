extends CharacterBody2D


var speed = -60.0
const JUMP_VELOCITY = -400.0
@onready var anim = $AnimatedSprite2D

var facing_right = false

func flip():
	#facing_right = !facing_right
	scale.x = abs(scale.x) * -1
	print("Facing : ", facing_right)
	if facing_right:
		speed = abs(speed)
	else:
		speed = abs(speed) * -1


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	if $RayCast2D.is_colliding() and is_on_floor():
		flip()

	velocity.x = speed
	move_and_slide()
