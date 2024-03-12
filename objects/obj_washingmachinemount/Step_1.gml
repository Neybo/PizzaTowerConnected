if obj_player.state != states.hookshot && !visible
{
	visible = true;
	instance_create(x, y, obj_genericpoofeffect);
}

