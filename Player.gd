extends KinematicBody


export var speed := 7.0
export var jump_strenght := 5.0
export var gravity := 50

var _velocity := Vector3.ZERO
var _snap_vector := Vector3.DOWN

onready var _model: CSGCylinder = $CSGCylinder

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	var move_direction := Vector3.ZERO
	move_direction.x = Input.get_action_strength('ui_right') - Input.get_action_strength('ui_left')
	move_direction.z = Input.get_action_strength("ui_down") - Input.get_action_strength('ui_up')
	move_direction = move_direction.normalized()
	
	_velocity.x = move_direction.x * speed
	_velocity.z = move_direction.z * speed
	_velocity.y -= gravity * delta
	
	var just_landed := is_on_floor() and _snap_vector == Vector3.ZERO
	var is_jumping := is_on_floor() and Input.is_action_just_pressed("ui_accept")
	if is_jumping:
		_velocity.y = jump_strenght
		_snap_vector = Vector3.ZERO
	elif just_landed:
		_snap_vector = Vector3.DOWN
	_velocity = move_and_slide_with_snap(_velocity, _snap_vector, Vector3.UP, true)
# Called every frame. 'delta' is the elapsed time since the previous frame.
