if (!instance_exists(baddieID))
    refresh--
if (refresh <= 0 && (!(point_in_camera(x, y, view_camera[0]))))
{
    with (instance_create(x, (y - 20), content))
    {
        if (other.platformid != -4)
            platformid = other.platformid
        image_xscale = other.image_xscale
        state = states.walk
        stunned = 10
        vsp = -2
        other.baddieID = id
        killreward = false
    }
    refresh = 50
}
scr_collide()
