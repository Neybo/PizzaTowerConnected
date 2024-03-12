if state == states.tube
{
    if (floor(image_index) >= 6)
    {
        with playerid
        {
			event_perform(ev_step_begin, 0)
			visible = true
			tube_id = -1;
            if sprite_index != spr_dashpadmach
            {
                sprite_index = spr_dashpadmach
                vsp = 0
                image_index = 0
                instance_create(x, y, obj_jumpdust)
            }
            xscale = other.image_xscale
            if place_meeting(x, y, other.id)
            {
                while place_meeting(x, y, other.id)
                    x += sign(other.image_xscale)
            }
            machhitAnim = 0
            state = states.mach3
            if movespeed < 14
                movespeed = 14
				GamepadSetVibration(0, 1, 1, 0.9)
            if !place_meeting(x, y, other.id)
            {
				repeat (6)
	                with instance_create(x, y, obj_debris) 
						sprite_index = spr_waterdrop
                with other
                {
                    state = states.normal
                    playerid = -1
                }
            }
        }
    }
}
