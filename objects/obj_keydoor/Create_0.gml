image_speed = 0.35
targetRoom = room
target_x = 0
target_y = 0

depth = 4;
if scr_depthcheck()
	depth += 100;

targetDoor = "A"

spr_locked = spr_doorkey;
spr_opening = spr_doorkeyopen;
spr_open = spr_doorvisited;
lockspr = spr_lock;
if check_sugary()
{
	spr_locked = spr_keydoor_ss
	spr_opening = spr_door_ss
	spr_open = spr_door_ss
	lockspr = spr_lock_ss
}
sprite_index = spr_locked;

