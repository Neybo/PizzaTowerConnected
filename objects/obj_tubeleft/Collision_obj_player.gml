if other.tube_id == id
    exit;
if other.state == states.hurt
    exit;
if other.state == states.gotoplayer
    exit;

var _offset_x = 32 * image_xscale
var _offset_y = 14 * image_yscale
with other
{
    hsp = 0
    vsp = 0
    movespeed = 0
    tube_vsp = 0
    state = states.pipe
    x = Approach(x, (other.x + _offset_x), other.approach_spd)
    y = Approach(y, (other.y + _offset_y), other.approach_spd)
}
if floor(other.x) == x + _offset_x && floor(other.y) == y + _offset_y
{
    other.state = states.pipe
    other.tube_id = id
    other.hsp = hsp * movespeed
    other.vsp = vsp * movespeed
    other.tube_vsp = vsp * movespeed
}
