
if instance_exists(obj_player)
{
	x = obj_player.x;
	y = obj_player.y;
}

frameone = true;

panto = [0, 0];
pancur = [0, 0];

shake_mag = 0;
shake_mag_acc = 0;

zoom = 1;
angle = 0;
limitcam = [0, 0, room_width, room_height];

camera_set_view_size(view_camera[0], 960, 540);
camera_set_view_angle(view_camera[0], 0);

targetoverride = noone
targetgoingback = false
