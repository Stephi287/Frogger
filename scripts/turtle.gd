extends Area2D

@export var speed = 15
@export var direction = Vector2.LEFT
@export var type = 0

@onready var sprite: Sprite2D = $Sprite2D
@onready var collision: CollisionShape2D = $CollisionShape2D

var border_left = -8
var border_right = 488
	
func _process(delta: float) -> void:
	
	position += direction * delta * speed

	if is_out_of_border():
		queue_free()
	
func is_out_of_border() -> bool:
	return position.x < border_left or position.x > border_right

func _on_area_entered(area: Area2D) -> void:
	if area.name == "Frog":
		area.set_riding_turtle(self)

func _on_area_exited(area: Area2D) -> void:
	if area.name == "Frog":
		area.set_riding_turtle(self)
