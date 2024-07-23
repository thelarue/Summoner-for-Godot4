extends Area2D
class_name InteractionArea

@export var action_name: String = "interact"

var interact: Callable = func():
	pass


func _on_body_entered(body):
	InteractionManager.reg_area(self)
	print("body entered")


func _on_body_exited(body):
	InteractionManager.unreg_area(self)
	print("body exited")
