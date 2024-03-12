instance_create(x, y, obj_playerexplosion)
with (instance_create(x, y, obj_sausageman_dead))
{
    depth = -200
    sprite_index = spr_ratblock6_dead
    var ix = 1
    if (other.image_angle > 90)
        ix = -1
    hsp = (ix * 8)
    vsp = -12
    image_xscale = (-ix)
}