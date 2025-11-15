extends Sprite2D

func _fit_to_viewport():
	if texture == null:
		return

	var viewport_size = get_viewport_rect().size
	var tex_size = texture.get_size()

	# Scale in X and Y so the sprite exactly matches the viewport size
	scale = viewport_size / tex_size
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_fit_to_viewport()
	get_viewport().size_changed.connect(_fit_to_viewport)
