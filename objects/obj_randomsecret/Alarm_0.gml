seconds--;
if seconds < 0
{
	instance_destroy(obj_hallway)
	instance_destroy(obj_fadeout)
	instance_create(0, 0, obj_timesup)
	with (obj_player)
    {
        image_blend = c_white
		visible = true
        grav = 0.5
        a = 0
        targetDoor = "A"
        room = timesuproom
        state = states.timesup
        sprite_index = spr_Timesup
        image_index = 0
        fmod_stop_all()
        scr_soundeffect(mu_timesup)
    }
	instance_destroy()
}
alarm[0] = 60















