extends enemy_base

func _move()->void:
	var _direction:Vector2 = (player.global_position - global_position).normalized()
	velocity = _direction*_move_speed
	move_and_slide()
