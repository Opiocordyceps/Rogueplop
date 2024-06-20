extends HSlider

func _ready():
	value = GlobalWorldEnvironment.environment.get_adjustment_brightness()


func _on_value_changed(value):
	GlobalWorldEnvironment.environment.set_adjustment_brightness(value)
