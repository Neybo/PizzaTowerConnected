if (!active)
{
    y = (ystart + sprite_height)
    if (distance_to_object(obj_player) < 250)
    {
        active = true
        scr_soundeffect(sfx_whoosh) // temp?
    }
}
else
    y = lerp(y, ystart, 0.4)
