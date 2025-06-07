extends Area2D

@export var riding_turtle = false
@export var riding_log = false
var cur_turtle
var cur_log
var is_on_water = false
var lanes_entered = [false, false, false, false, false, false]
@onready var score_label = get_node("../Control/Score")
@onready var lives_label = get_node("../Control/Lives")

func _process(delta: float) -> void:
	#Frosch reitet Schildkröte
	if riding_turtle:
		var turtle_velo = cur_turtle.direction * cur_turtle.speed
		position += turtle_velo * delta
	
	#Frosch reitet Baumstamm
	if riding_log:
		var log_velo = cur_log.direction * cur_log.speed
		position += log_velo * delta
		
	if is_on_water and not riding_log and not riding_turtle:
		print("Frosch fiel ins Wasser")
		frog_died()
	
	#Frosch Bewegung
	if Input.is_action_just_pressed("ui_up"):
		position += Vector2(0,-16)
	if Input.is_action_just_pressed("ui_down"):
		position += Vector2(0,16)
	if Input.is_action_just_pressed("ui_left"):
		position += Vector2(-16,0)
	if Input.is_action_just_pressed("ui_right"):
		position += Vector2(16,0)
		
func set_riding_turtle(turtle):
		riding_turtle = not riding_turtle
		cur_turtle = turtle
		
		#Frosch mittig auf Schildkröte setzen
		if riding_turtle and cur_turtle:
			global_position = cur_turtle.global_position
		
		#Punkte vergeben
		Gamestate.score += 1
		score_label.text = str(Gamestate.score)
			
func set_riding_log(log):
	if cur_log == null or cur_log != log: 
		riding_log = true
		cur_log = log
		
	if riding_log and cur_log:
		correct_frog_pos(log)
	
	#Punkte vergeben
	Gamestate.score += 1
	score_label.text = str(Gamestate.score)

func clear_riding_log(log):
	#Bewegung auf Log möglich -> Abspringen nur wenn eigener Log verlassen wird
	if cur_log == log:
		riding_log = false
		cur_log = null
		
func correct_frog_pos(log):
	var snap_points = [
		log.get_node("SnapLeft").global_position,
		log.get_node("SnapCenter").global_position,
		log.get_node("SnapRight").global_position
	]
	# Nächsten Snap-Point zur aktuellen Position finden
	var nearest = snap_points[0]
	var min_dist = global_position.distance_to(nearest)
	for p in snap_points:
		var d = global_position.distance_to(p)
		if d < min_dist:
			nearest = p
			min_dist = d
	# Frosch auf Snap-Position setzen
	global_position = nearest
	
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.name == "Frog":
		is_on_water = true

func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.name == "Frog":
		is_on_water = false


func _on_winning_area_1_entered(area: Area2D) -> void:
	if area.name == "Frog" and Gamestate.image1_should_be_visible == false:
		var texture_rect1 = get_node("../Control/TextureRect")
		texture_rect1.visible = true
		print(texture_rect1.name)
		print(texture_rect1.visible)
		Gamestate.image1_should_be_visible = true
		#Punkte vergeben
		Gamestate.score += 50
		score_label.text = str(Gamestate.score)
		get_tree().call_deferred("reload_current_scene")
	elif area.name == "Frog" and Gamestate.image1_should_be_visible == true:
		frog_died()

func _on_winning_area_2_entered(area: Area2D) -> void:
	if area.name == "Frog" and Gamestate.image2_should_be_visible == false:
		var texture_rect1 = get_node("../Control/TextureRect2")
		texture_rect1.visible = true
		Gamestate.image2_should_be_visible = true
		#Punkte vergeben
		Gamestate.score += 50
		score_label.text = str(Gamestate.score)
		get_tree().call_deferred("reload_current_scene")
	elif area.name == "Frog" and Gamestate.image2_should_be_visible == true:
		frog_died()

func _on_winning_area_3_entered(area: Area2D) -> void:
	if area.name == "Frog" and Gamestate.image3_should_be_visible == false:
		var texture_rect1 = get_node("../Control/TextureRect3")
		texture_rect1.visible = true
		Gamestate.image3_should_be_visible = true
		#Punkte vergeben
		Gamestate.score += 50
		score_label.text = str(Gamestate.score)
		get_tree().call_deferred("reload_current_scene")
	elif area.name == "Frog" and Gamestate.image3_should_be_visible == true:
		frog_died()

func _on_winning_area_4_entered(area: Area2D) -> void:
	if area.name == "Frog" and Gamestate.image4_should_be_visible == false:
		var texture_rect1 = get_node("../Control/TextureRect4")
		texture_rect1.visible = true
		Gamestate.image4_should_be_visible = true
		#Punkte vergeben
		Gamestate.score += 50
		score_label.text = str(Gamestate.score)
		get_tree().call_deferred("reload_current_scene")
	elif area.name == "Frog" and Gamestate.image4_should_be_visible == true:
		frog_died()

func _on_winning_area_5_entered(area: Area2D) -> void:
	if area.name == "Frog" and Gamestate.image5_should_be_visible == false:
		var texture_rect1 = get_node("../Control/TextureRect5")
		texture_rect1.visible = true
		Gamestate.image5_should_be_visible = true
		#Punkte vergeben
		Gamestate.score += 50
		score_label.text = str(Gamestate.score)
		get_tree().call_deferred("reload_current_scene")
	elif area.name == "Frog" and Gamestate.image5_should_be_visible == true:
		frog_died()


func _on_lane_1_area_entered(area: Area2D) -> void:
	if area.name == "Frog" and lanes_entered[0] == false:
		lanes_entered[0] = true
		Gamestate.score += 1
		score_label.text = str(Gamestate.score)


func _on_lane_2_area_entered(area: Area2D) -> void:
	if area.name == "Frog" and lanes_entered[1] == false:
		lanes_entered[1] = true
		Gamestate.score += 1
		score_label.text = str(Gamestate.score)


func _on_lane_3_area_entered(area: Area2D) -> void:
	if area.name == "Frog" and lanes_entered[2] == false:
		lanes_entered[2] = true
		Gamestate.score += 1
		score_label.text = str(Gamestate.score)


func _on_lane_4_area_entered(area: Area2D) -> void:
	if area.name == "Frog" and lanes_entered[3] == false:
		lanes_entered[3] = true
		Gamestate.score += 1
		score_label.text = str(Gamestate.score)


func _on_lane_5_area_entered(area: Area2D) -> void:
	if area.name == "Frog" and lanes_entered[4] == false:
		lanes_entered[4] = true
		Gamestate.score += 1
		score_label.text = str(Gamestate.score)


func _on_lane_6_area_entered(area: Area2D) -> void:
	if area.name == "Frog" and lanes_entered[5] == false:
		lanes_entered[5] = true
		Gamestate.score += 1
		score_label.text = str(Gamestate.score)

func frog_died():
	Gamestate.lives -= 1
	if Gamestate.lives == 0:
		Gamestate.reset()
	lives_label = str(Gamestate.lives)
	get_tree().call_deferred("reload_current_scene")
