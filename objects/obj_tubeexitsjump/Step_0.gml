if (state == states.tube)
{
    if (floor(image_index) >= 6)
    {
        with (playerid)
        {
            visible = true
			event_perform(ev_step_begin, 0)
            sprite_index = spr_superspringplayer
            state = states.Sjump
            vsp = -10
            if place_meeting(x, y, obj_solid)
            {
                while place_meeting(x, y, obj_solid)
                    y--
            }
            GamepadSetVibration(0, 1, 1, 0.9)
        }
    }
    with (playerid)
    {
        if (!(place_meeting(x, y, other.id)))
        {
            with (other)
            {
                GamepadSetVibration(0, 1, 1, 0.65)
                playerid = -1
                state = states.normal
            }
        }
    }
}
