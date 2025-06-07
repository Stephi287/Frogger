extends Node2D

var image1_should_be_visible: bool = false
var image2_should_be_visible: bool = false
var image3_should_be_visible: bool = false
var image4_should_be_visible: bool = false
var image5_should_be_visible: bool = false

var score = 0
var lives = 3

func reset():
	image1_should_be_visible = false
	image2_should_be_visible = false
	image3_should_be_visible = false
	image4_should_be_visible = false
	image5_should_be_visible = false
	score = 0
	lives = 3
