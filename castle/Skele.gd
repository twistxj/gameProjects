extends CharacterBody2D
# Setup constants
const UP = Vector2(0,-1)
const GRAVITY = 25
const MAXSPEED = 50
const MAXGRAVITY = 50
const JUMPSPEED = 500
const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var movement = Vector2()
var moving_right = true
var player_in_range = false

func _physics_process(delta):
	if(!$DownRay.is_colliding() || $RightRay.is_colliding()):
		var collider = $RightRay.get_collider()
		if collider && collider.name == "Player":
			movement = Vector2.ZERO
			player_in_range = true
		else:
			moving_right =  !moving_right
			scale.x = -scale.x
	move_enemy()
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	$AnimatedSprite2D.play("idle")
	move_and_slide()

func animate():
	if movement!=Vector2.ZERO:
		$AnimatedSprite2D.play("walk")
	else:
		$AnimatedSprite2D.play("idle")

func move_enemy():
	movement.y= movement.y + GRAVITY
	if(movement.y > MAXGRAVITY):
		movement.y = MAXGRAVITY
		
	if(is_on_floor()):
		movement.y = 0
	if !player_in_range:
		movement.x = MAXSPEED if moving_right else -MAXSPEED
	velocity.x = movement.x
	#movement = move_and_slide()
