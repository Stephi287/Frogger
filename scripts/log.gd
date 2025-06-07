extends Area2D

@export var speed = 15
@export var direction = Vector2.LEFT
@export var type = 1

@onready var sprite: Sprite2D = $Sprite2D
@onready var collision: CollisionShape2D = $CollisionShape2D

var border_left = -30
var border_right = 345

func _ready() -> void:
	add_sprite_to_log()
	
func _process(delta: float) -> void:
	position += direction * delta * speed

	if is_out_of_border():
		queue_free()
	
func add_sprite_to_log():
	match type:
		1: 
			sprite.texture = load('res://sprites/log_medium.png')
			add_collision_shape(16,4)
		2: 
			sprite.texture = load('res://sprites/log_large.png')
			add_collision_shape(24,4)

func add_collision_shape(x,y):
	collision.shape = RectangleShape2D.new()
	collision.shape.extents = Vector2(x, y)
	
func is_out_of_border() -> bool:
	return position.x < border_left or position.x > border_right

func _on_area_entered(area: Area2D) -> void:
	if area.name == "Frog":
		area.set_riding_log(self)

func _on_area_exited(area: Area2D) -> void:
	if area.name == "Frog":
		area.clear_riding_log(self)
