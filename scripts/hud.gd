extends CanvasLayer

#font is from here: https://www.dafont.com/dogica.font

func _ready() -> void:
	Signals.update_ui.connect(_update_ui)

func _update_ui(rabbits, lives):
	$Rabbits_Label.text = str("Rabbits : ",rabbits,"/4")
	#$Lives_Label.text = str("Lives : ",lives,"x")
