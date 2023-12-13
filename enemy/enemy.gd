extends CharacterBody2D


@export var speed : float = 200.0
@export var jump_velocity : float = -800.0
@export var double_jump_velocity : float = -600.0
@export var weight : float = 1400
@export var hover_coef : float = 2.9
@export var run_coef : float = 2.0
@export_range(0.0, 1.0) var acceleration : float = 0.1
@export_range(0.0, 1.0) var friction : float = 0.15
var has_double_jumped : bool = false
var has_hovered : bool = false

var can_double_jump : bool = false
var can_hover : bool = true

# Get the gravity from the project settings to be synced with RigidBody nodes.

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	if not is_on_floor():
		velocity.y += (gravity + weight) * delta

	#var direction = ($Player.position - self.position).normalized()
	var direction = 0
	if direction != 0:
		velocity.x = lerp(velocity.x, direction * speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0.0, friction)

	move_and_slide()
	
func _on_VisibilityNotifier2D_screen_exited():
	print("dead")
	queue_free()
