extends CanvasLayer

#font is from here: https://www.dafont.com/dogica.font
var is_game_over = false

func _ready() -> void:
	Signals.update_ui.connect(_update_ui)
	Signals.game_over.connect(_game_over_sequence)
	Signals.game_won.connect(game_won_sequence)
	
func _process(delta: float) -> void:
	
	if is_game_over == false:
		if Input.is_action_just_pressed("action_1"):
			$Title_label.visible = false
		return
	if Input.is_action_just_pressed("action_1"):
		get_tree().reload_current_scene()

func _update_ui(rabbits, lives):
	$Rabbits_Label.text = str("Rabbits : ",rabbits,"/4")
	#$Lives_Label.text = str("Lives : ",lives,"x")
	
func _game_over_sequence():
	await get_tree().create_timer(1).timeout
	$Title_label.visible = true
	$Title_label.text = "Game Over"
	await get_tree().create_timer(0.5).timeout
	$RestartText.visible = true
	is_game_over = true
	
func game_won_sequence():
	$GameOverPanel.visible = true
	
	

	
