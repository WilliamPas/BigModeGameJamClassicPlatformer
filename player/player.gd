extends CharacterBody2D


@export var speed : float = 300.0
@export var jump_velocity : float = -800.0
@export var double_jump_velocity : float = -600.0
@export var weight : float = 1400
@export var hover_coef : float = 2.9
@export var run_coef : float = 2.0
var has_double_jumped : bool = false
var has_hovered : bool = false

var can_double_jump : bool = true
var can_hover : bool = true

# Get the gravity from the project settings to be synced with RigidBody nodes.

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		# Handle Hover 
		# Expected behavior: can jump while holding "look_up" key and always hover when available
		# -- this looks kinda clunky, is there a better way to handle this?
		if can_hover and not has_hovered and Input.is_action_pressed("look_up") and velocity.y > weight * hover_coef * delta:
			velocity.y = weight * hover_coef * delta
		else:
			velocity.y += (gravity + weight) * delta
	else:
		has_double_jumped = false
		has_hovered = false

	if Input.is_action_just_released("look_up") and not is_on_floor():
		has_hovered = true
		has_double_jumped = true

	# Handle Jump.
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = jump_velocity
		elif not has_double_jumped:
			velocity.y = double_jump_velocity
			has_double_jumped = true

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
