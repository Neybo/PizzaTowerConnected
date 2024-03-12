if OLD_GAMEPLAY
	exit;

if global.panic && global.fill > 0 && !instance_exists(obj_secretfound)
    global.fill -= fillrate
if global.fill <= 0 && global.panic && !instance_exists(obj_pizzaface) && !global.racing && !string_startswith(room_get_name(room), "tower_")
    instance_create(obj_player.x, obj_player.y, obj_pizzaface)
else if global.fill <= 0 && global.panic && string_startswith(room_get_name(room), "tower_") 
&& !global.racing
{
    instance_destroy(obj_fadeout)
    with (obj_player)
    {
        image_blend = c_white
        grav = 0.5
        a = 0
        targetDoor = "A"
        room = timesuproom
        state = states.timesup
        sprite_index = spr_Timesup
        image_index = 0
        fmod_stop_all()
        scr_soundeffect(mu_timesup)
        instance_destroy(obj_hallway)
    }
   instance_create(0, 0, obj_timesup)
}
global.fill = max(global.fill, 0)
