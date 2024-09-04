extends CharacterBody2D

@onready var anim =  $AnimatedSprite2D
const GRAVITY = 1000
const SPEED = 300

enum State  { Idle , Run , Jump}

var current_state

func _ready():
	current_state = State.Idle
	 
func player_fail(delta):
	if !is_on_floor():
		velocity.y += GRAVITY * delta
		
func player_idle():
	if is_on_floor():
		current_state = State.Idle

func player_run():
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction :
		velocity.x = direction * SPEED
	else :
		current_state = State.Idle
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if direction != 0:
		current_state = State.Run
		if direction > 0:
			anim.flip_h = false
		else:
			anim.flip_h = true
	

func player_jump(delta):
	var space = Input.is_action_just_pressed("jump")
	if space :
		current_state = State.Jump
		velocity.y = -300
	
	if !is_on_floor() && space :
		var direction = Input.get_axis("ui_left", "ui_right")
		current_state = State.Jump
		if direction :
			velocity.x = direction * 300 
	

func player_animation():
	if (current_state == State.Idle):
		anim.play("idle")
	elif (current_state == State.Run) :
		anim.play("run")
	elif (current_state == State.Jump) :
		anim.play("jump")

func _physics_process(delta):
	player_fail(delta)
	player_run()
	player_jump(delta)
	player_idle()
	
	move_and_slide()
	player_animation()

	
