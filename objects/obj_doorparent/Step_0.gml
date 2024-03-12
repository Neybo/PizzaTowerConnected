if !doCheck
	return;

with obj_boxofpizza
{
	if place_meeting(x, y - image_yscale * 6, other)
		targetDoor = other.door;
}
with obj_door
{
	if place_meeting(x, y, other) && targetRoom != room
		targetDoor = other.door;
}
with obj_hallway
{
	if place_meeting(x, y, other) && targetRoom != room
		targetDoor = other.door;
}
with obj_keydoor
{
	if place_meeting(x, y, other)
		targetDoor = other.door;
}
with obj_verticalhallway
{
	if place_meeting(x, y, other)
		targetDoor = other.door;
}
with obj_geromedoor
{
	if place_meeting(x, y, other)
		targetDoor = other.door;
}
with obj_pitfall
{
	if place_meeting(x, y, other)
		targetDoor = other.door;
}
with obj_taxi
{
	if place_meeting(x, y, other)
		targetDoor = other.door;
}
