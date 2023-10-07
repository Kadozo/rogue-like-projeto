extends CharacterBody2D
class_name  enemy_base


var _loading_dash: bool = false
var _is_dashing: bool = false
var _dash_direction: Vector2

@export_category("Variables")
@export var _enemy_type: String = "chase"
@export var _move_speed: float = 192
@export var _dash_speed:float = 768

@export_category("Objects")
@export var _dash_wait_timer: Timer = null
@export var _dash_timer: Timer = null

@onready var player = get_tree().get_first_node_in_group("player")


func _physics_process(delta:float) -> void:
	var _player_distance:float = global_position.distance_to(player.global_position)
	
	if _loading_dash:
		return
		
	match _enemy_type:
		"chase":
			_chase()
		"chase_and_dash":
			_chase_and_dash()
	move_and_slide()

func _chase() -> void:
	var _direction:Vector2 = global_position.direction_to(player.global_position)
	velocity = _move_speed * _direction
	
func _chase_and_dash() -> void:
	if not _is_dashing:
		_chase()
	else:
		var _direction:Vector2 = global_position.direction_to(player.global_position)
		velocity = _dash_direction * _dash_speed


func _on_range_area_body_entered(_body) -> void:
	if _enemy_type != "chase_and_dash":
		return
	
	if _is_dashing:
		return
	
	if _body.name == "player":
		_dash_wait_timer.start()
		_dash_direction = global_position.direction_to(player.global_position)
		_loading_dash = true
		
func _on_dash_wait_timer_timeout():
	_loading_dash = false
	_is_dashing = true
	_dash_timer.start()


func _on_dash_timer_timeout():
	_is_dashing = false
