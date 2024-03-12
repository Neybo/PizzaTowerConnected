if (state == states.tube)
{
    if (floor(image_index) >= 11 && (!shot))
    {
        shot = 1
        with (playerid)
        {
			visible = false
            state = states.tube
            tube_id = other.id
            if (other.stored_spd == 0)
                other.stored_spd = 1
            hsp = (other.hsp * other.movespeed)
            vsp = (other.vsp * other.movespeed)
            tube_vsp = (other.vsp * other.movespeed)
            stored_spd = 0
        }
    }
    else if (!shot)
    {
        with (playerid)
        {
			visible = false
            hsp = 0
            vsp = 0
        }
    }
    with (playerid)
    {
        if (!(place_meeting(x, y, other.id)))
        {
            with (other)
            {
                playerid = -1
                state = states.normal
                shot = 0
            }
        }
    }
}
