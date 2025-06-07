extends Node

#@export var water_scene: PackedScene
#
#var start = Vector2(8, 120)
#var abstand = 16
#
#func _ready() -> void:
	#var height = start  # Anfangsposition für die Zeile
	#for y in range(5):
		#var next = Vector2(0, 0)  # Reset für jede Zeile
		#for x in range(30):
			#var water = water_scene.instantiate()
			#water.position = height + next
			#add_child(water)
			#next += Vector2(abstand, 0)  # Nach rechts verschieben
		#height += Vector2(0, -abstand)  # Nächste Zeile nach oben verschieben
