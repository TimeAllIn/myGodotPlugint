class_name v_rocker extends Panel

@onready var rocker: Control = $rocker

##摇杆的比例大小,取值范围(0f,0.5f),否则无法正常运行
@export var rocker_size:float = 0.2
#归零坐标
##摇杆的中心位置
var zero_position:Vector2
func _ready() -> void:
	var temp_p:Vector2
	
	rocker.set_size(get_size() * rocker_size)
	rocker._set_position(get_size() * (0.5 - rocker_size/2))
	
	zero_position = rocker.get_position()
	pass

var drag = false  
var drag_from:Vector2

var value:Vector2

func _on_rocker_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:  
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:  
			# 鼠标左键按下时记录鼠标位置和标记开始拖动  
			drag = true  
			drag_from = get_global_mouse_position() 
		elif event.button_index == MOUSE_BUTTON_LEFT and not event.pressed and drag:  
			# 鼠标左键释放时结束拖动  
			drag = false  
  
	if drag and event is InputEventMouseMotion:   
		var new_pos = get_global_mouse_position()   
		var delta = new_pos - drag_from 
		var move = rocker.get_position() + delta
		rocker._set_position(move)
		drag_from = new_pos
		set_size_normalized()
	else:
		rocker._set_position(zero_position)
	value = (rocker.get_position() - zero_position).normalized()
	pass	
func set_size_normalized():
	var temp_position = rocker.get_position()
	
	if temp_position.x > zero_position.x * 2:
		temp_position.x = zero_position.x * 2
	elif temp_position.x <= 0:
		temp_position.x = 0
		
	if temp_position.y > zero_position.y * 2:
		temp_position.y = zero_position.y * 2
	elif temp_position.y <= 0:
		temp_position.y = 0
	rocker._set_position(temp_position)
	
	pass
 
