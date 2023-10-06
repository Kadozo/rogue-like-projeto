extends CharacterBody2D
class_name  enemy_base

@export_category("Variables")
@export var _move_speed:float = 200
@export var _health:int = 10

@onready var player = get_tree().get_first_node_in_group("player")

func _physics_process(delta:float) -> void:
	_move()
	

func _move() -> void:
	pass
