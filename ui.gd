extends Control

signal add_cube
signal add_desk


func _on_add_cube_button_pressed() -> void:
	add_cube.emit()


func _on_add_desk_button_pressed() -> void:
	add_desk.emit()
