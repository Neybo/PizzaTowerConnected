if (room != rank_room && minutes <= 0 && seconds <= 0 && addseconds <= 0)
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
    instance_destroy()
}
