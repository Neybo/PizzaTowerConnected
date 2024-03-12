if (state == states.walk)
{
    with (obj_destructibles)
    {
        if place_meeting((x - other.hsp), y, other.id)
            instance_destroy()
        if place_meeting(x, (y - other.vsp), other.id)
            instance_destroy()
    }
    if (abs((x - targetplayer.x)) < 16)
    {
        if (grounded && vsp > -1)
            hsp = 0
        else if (!grounded)
            hsp = (image_xscale * movespeed)
    }
    else
    {
        if (x != targetplayer.x && grounded)
            image_xscale = (-(sign((x - targetplayer.x))))
        hsp = (image_xscale * movespeed)
    }
    var inst_front = collision_line(x, (y + 25), (x + (sign(hsp) * 78)), (y + 25), obj_solid, false, true)
    var inst_down = collision_line((x + (sign(hsp) * 16)), y, (x + (sign(hsp) * 16)), (y + 64), obj_solid, false, true)
    var inst_down2 = collision_line((x + (sign(hsp) * 16)), y, (x + (sign(hsp) * 16)), (y + 64), obj_platform, false, true)
    var inst_up = collision_line((x + (sign(hsp) * 96)), (y + 25), (x + (sign(hsp) * 96)), ((y - 78) + 50), obj_platform, false, true)
    if ((inst_front != noone || inst_up != -4 || (inst_down == noone && inst_down2 == -4)) && targetplayer.y <= (y + 32) && grounded && ((!instance_exists(inst_front)) || inst_front.object_index == obj_solid) && ((!instance_exists(inst_down)) || inst_down.object_index == obj_solid))
    {
        vsp = -11
        image_index = 0
        hsp = (image_xscale * movespeed)
    }
}
