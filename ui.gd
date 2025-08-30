extends Control

signal add_cube


func _on_add_cube_button_pressed() -> void:
	add_cube.emit()
