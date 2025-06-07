extends Control

func _ready() -> void:
	#Bereits erreichte Froschis
	if Gamestate.image1_should_be_visible == true:
		$TextureRect.visible = true
	if Gamestate.image2_should_be_visible == true:
		$TextureRect2.visible = true
	if Gamestate.image3_should_be_visible == true:
		$TextureRect3.visible = true
	if Gamestate.image4_should_be_visible == true:
		$TextureRect4.visible = true
	if Gamestate.image5_should_be_visible == true:
		$TextureRect5.visible = true
	
	#Punktestand
	$Score.text = str(Gamestate.score)
	
	$Lives.text = str(Gamestate.lives)
	
