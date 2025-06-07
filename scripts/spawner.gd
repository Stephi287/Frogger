extends Node2D

@export var car_scene: PackedScene
@export var log_scene: PackedScene
@export var turtle_scene: PackedScene
@export var frog: Area2D

var lane_data

var lane_data_1 = [
	{ "y": 216, "dir": Vector2.LEFT,  "speed": 40, "interval": 2.5, "type": 0 },
	{ "y": 200, "dir": Vector2.RIGHT, "speed": 50, "interval": 1.5, "type": 1 },
	{ "y": 184, "dir": Vector2.LEFT,  "speed": 60, "interval": 2.0, "type": 2 },
	{ "y": 168, "dir": Vector2.RIGHT, "speed": 70, "interval": 3.0, "type": 3 },
	{ "y": 152, "dir": Vector2.LEFT,  "speed": 90, "interval": 1.5, "type": 4 },
]

var lane_data_2 = [
	{ "y": 216, "dir": Vector2.LEFT,  "speed": 45, "interval": 1.5, "type": 0 },
	{ "y": 200, "dir": Vector2.RIGHT, "speed": 40, "interval": 3, "type": 1 },
	{ "y": 184, "dir": Vector2.LEFT,  "speed": 50, "interval": 2, "type": 2 },
	{ "y": 168, "dir": Vector2.RIGHT, "speed": 60, "interval": 3, "type": 3 },
	{ "y": 152, "dir": Vector2.LEFT,  "speed": 80, "interval": 2.5, "type": 4 },
]

var water_lane_data = [
	{ "y": 120, "dir": Vector2.LEFT,  "speed": 40, "interval": 5.0, "type": 0 },
	{ "y": 104, "dir": Vector2.RIGHT, "speed": 30, "interval": 4.5, "type": 1 },
	{ "y": 88, "dir": Vector2.RIGHT,  "speed": 40, "interval": 3.0, "type": 2 },
	{ "y": 72, "dir": Vector2.LEFT, "speed": 60, "interval": 2.0, "type": 0 },
	{ "y": 56, "dir": Vector2.RIGHT,  "speed": 80, "interval": 2.5, "type": 1 },
]
func _ready():
	if randi() % 2 == 1:
		lane_data = lane_data_1
	else:
		lane_data = lane_data_2
		
	# für jede lane wird das Intervall in dem Autos spawnen festgelegt
	for lane in lane_data:
		var timer = Timer.new()
		timer.wait_time = lane.interval
		timer.one_shot = false
		add_child(timer)
		timer.start()
		timer.timeout.connect(func(): spawn_car(lane))
		
	for water_lane in water_lane_data:
		var timer = Timer.new()
		timer.wait_time = water_lane.interval
		timer.one_shot = false
		add_child(timer)
		timer.start()
		timer.timeout.connect(func(): spawn_water_obstacles(water_lane))

func spawn_car(lane):
	var car = car_scene.instantiate()
	car.position = Vector2(
		327 if lane.dir == Vector2.LEFT else -8,  # Startpunkt außerhalb vom Bildschirm
		lane.y
	)
	car.direction = lane.dir
	car.speed = lane.speed
	car.car_type = lane.type  # Falls du später Sprite/Collider ändern willst
	add_child(car)

func spawn_water_obstacles(water_lane):
	var water_obstacle = null
	if water_lane.type == 0:
		water_obstacle = turtle_scene.instantiate()
	else:
		water_obstacle = log_scene.instantiate()
		
	water_obstacle.position = Vector2(
		345 if water_lane.dir == Vector2.LEFT else -25,  # Startpunkt außerhalb vom Bildschirm
		water_lane.y
	)
	water_obstacle.direction = water_lane.dir
	water_obstacle.speed = water_lane.speed
	water_obstacle.type = water_lane.type  # Falls du später Sprite/Collider ändern willst
	add_child(water_obstacle)
