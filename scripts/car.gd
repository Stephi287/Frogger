extends Area2D

@export var speed = 15
@export var direction = Vector2.LEFT
@export var car_type = 0

@onready var sprite: Sprite2D = $Sprite2D
@onready var collision: CollisionShape2D = $CollisionShape2D

@onready var lives_label = get_node("../../Control/Lives")

var border_left = -8
var border_right = 488

func _ready() -> void:
	add_sprite_to_car()
	
func _process(delta: float) -> void:
	position += direction * delta * speed

	if is_car_out_of_border():
		queue_free()

func _on_area_entered(area: Area2D) -> void:
	if area.name == "Frog":
		area.queue_free()
		Gamestate.lives -= 1
		if Gamestate.lives == 0:
			Gamestate.reset()
		lives_label = str(Gamestate.lives)
		get_tree().call_deferred("reload_current_scene")

	
func add_sprite_to_car():
	match car_type:
		0: 
			sprite.texture = load('res://sprites/car_red.png')
			add_collision_shape(7,5)
		1: 
			sprite.texture = load('res://sprites/car_turquoise.png')
			add_collision_shape(7,5)

		2: 
			sprite.texture = load('res://sprites/car_blue.png')
			add_collision_shape(7,5)

		3: 
			sprite.texture = load('res://sprites/car_purple.png')
			add_collision_shape(7,5)
		4: 
			sprite.texture = load('res://sprites/car_pink.png')
			add_collision_shape(7,5)

func add_collision_shape(x,y):
	collision.shape = RectangleShape2D.new()
	collision.shape.extents = Vector2(x, y)
	
func is_car_out_of_border() -> bool:
	return position.x < border_left or position.x > border_right
