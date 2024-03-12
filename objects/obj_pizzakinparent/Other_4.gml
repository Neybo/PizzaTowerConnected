event_inherited();
switch object_index
{
	case obj_pizzakinshroom:
	case obj_toppinmallow:
		if !global.shroomfollow
			instance_destroy()
		break
	case obj_pizzakincheese:
	case obj_toppinchoco:
		if !global.cheesefollow
			instance_destroy()
		break
	case obj_pizzakintomato:
	case obj_toppincrack:
		if !global.tomatofollow
			instance_destroy()
		break
	case obj_pizzakinsausage:
	case obj_toppinworm:
		if !global.sausagefollow
			instance_destroy()
		break
	case obj_pizzakinpineapple:
	case obj_toppincandy:
		if !global.pineapplefollow
			instance_destroy()
		break
}

