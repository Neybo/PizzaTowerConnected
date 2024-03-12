var size_of_bar = 500 / scrollsize
var bar_pos_ext = (500 - size_of_bar) * (scrolly / scrollmax)


scrolly += (-mouse_wheel_up() + mouse_wheel_down()) * 12

var mouse_in_rect = point_in_rectangle(mouse_x,mouse_y,480 + 320, 20 + bar_pos_ext, 
	480 + 336, 20 + (size_of_bar + bar_pos_ext))

if keyboard_check_pressed(vk_up)
	curlangselected = max(curlangselected - 1, 0)
if keyboard_check_pressed(vk_down)
	curlangselected = min(curlangselected + 1, langlen - 1)


if scrollselect == 2
{
	if mouse_check_button_released(mb_left) 
		scrollselect = 0
	
	scrolly -= (scrollmy - mouse_y) 
	scrollmy = mouse_y
}
else if mouse_check_button_pressed(mb_left)
{
	if mouse_in_rect
	{
		scrollselect = 2
		scrollmy = mouse_y
	}
}
else
	scrollselect = mouse_in_rect

scrolly = clamp(scrolly, 0, scrollmax)
