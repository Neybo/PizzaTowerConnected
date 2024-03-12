if (playerid > -1)
    return;
if (state != states.normal)
    return;
if (other.state == states.hurt)
    return;
if (other.state == states.gotoplayer)
    return;
if (other.state == states.stringfall)
    return;
if (other.state == states.stringjump)
    return;
if (other.state == states.stringfling)
    return;
if (object_index != obj_tubeenter && other.state != states.tube)
    return;
var _offset_x = (32 * image_xscale)
var _offset_y = (14 * image_yscale)
with (other)
{
    if (other.object_index == obj_tubeenter)
    {
		visible = false
        shot = 0
        if (state != states.tube)
        {
            repeat (6)
                with instance_create(x, y, obj_debris) 
					sprite_index = spr_waterdrop
        }
    }
    state = states.tube
    hsp = 0
    movespeed = 0
    vsp = 0
    tube_vsp = 0
    x = Approach(x, (other.xstart + _offset_x), other.approach_spd)
    y = Approach(y, (other.ystart + _offset_y), other.approach_spd)
    if (y > (other.y + _offset_y))
        tube_vsp = (-other.approach_spd)
}
if (floor(other.x) == (xstart + _offset_x) && floor(other.y) == (ystart + _offset_y))
{
    GamepadSetVibration(0, 0.8, 0.8, 0.65)
    other.x = (xstart + _offset_x)
    other.y = (ystart + _offset_y)
    image_index = 0
    playerid = other.id
    image_speed = 0.5
    other.state = states.tube
    other.tube_vsp = 0
    state = states.tube
}
