extends enemy_base

@onready var navigation_agent = $navigation as NavigationAgent2D

func _move()->void:
	find_path_to(player)
	var _direction = (navigation_agent.get_next_path_position() - global_position).normalized()
	velocity = _direction * _move_speed
	move_and_slide()
func find_path_to(target):	
	navigation_agent.target_position = target.position
