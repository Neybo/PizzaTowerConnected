if (sprite_index == spr_gustavo_war1)
{
    if distance_to_pos(x, y, obj_player.x, obj_player.y, 250, 150)
    {
        sprite_index = spr_gustavo_war2
        image_index = 0
        hsp = ((-image_xscale) * 8)
        vsp = -12
        with (instance_create((x + (image_xscale * 60)), (y + 8), obj_gustavo_warmissile))
        {
            if (other.image_xscale > 0)
                direction = 0
            else
                direction = 180
        }
    }
}
else
{
    if (floor(image_index) == (image_number - 1))
        image_index = (image_number - 1)
    depth = -100
    x += hsp
    y += vsp
    if (vsp < 20)
        vsp += 0.5
    if (y > (room_height + 200))
        instance_destroy()
}
