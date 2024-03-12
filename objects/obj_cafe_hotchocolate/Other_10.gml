/// @description dog

nodog = false
with obj_dogmount
{
	notpick = true
	x = other.x + 46
	y = other.y - 25
}
with obj_cafe_cocoablock
{
	instance_destroy()
}
with obj_cafe_dogblock
{
	instance_destroy()
}