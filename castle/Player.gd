extends CharacterBody2D
# Setup constants
const UP = Vector2(0,-1)
const GRAVITY = 50
const MAXSPEED = 50
const MAXGRAVITY = 100
const JUMPSPEED = 500
const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var movement = Vector2()

func _physics_process(delta):
	if Input.is_action_pressed("left"):
		movement.x = -MAXSPEED
		$AnimatedSprite2D.play("walk")
		$AnimatedSprite2D.set_flip_h(true)
	elif Input.is_action_pressed("right"):
		movement.x = MAXSPEED
		$AnimatedSprite2D.play("walk")
		$AnimatedSprite2D.set_flip_h(false)
	else:
		movement.x = 0
		$AnimatedSprite2D.play("idle")
	if is_on_floor():
		if Input.is_action_pressed("jump"):
			movement.y = -JUMPSPEED
			#$AnimatedSprite2D.play("jump")
	movement.y = movement.y + GRAVITY
	
	if movement.y > MAXGRAVITY:
		movement.y = MAXGRAVITY

	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
