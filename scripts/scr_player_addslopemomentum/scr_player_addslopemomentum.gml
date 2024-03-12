function scr_player_addslopemomentum(longslope_spd, tallslope_spd) //gml_Script_scr_player_addslopemomentum
{
	if OLD_GAMEPLAY || !global.slopebitch
		exit;
	
    with instance_place(x, y + 1, obj_slope)
    {
        if sign(image_xscale) == -sign(other.xscale)
        {
            if (abs(image_yscale) < abs(image_xscale))
                other.movespeed += longslope_spd
            else
                other.movespeed += tallslope_spd
        }
        else if abs(image_yscale) < abs(image_xscale)
            other.movespeed -= longslope_spd 
        else
            other.movespeed -= tallslope_spd
    }
}
function scr_pizzaball_addslopemomentum(longslope_spd, tallslope_spd)
{
    with instance_place(x, y + 1, obj_slope)
    {
        if sign(image_xscale) == -sign(other.image_xscale)
        {
            if abs(image_yscale) < abs(image_xscale)
                other.slopespeed += longslope_spd
            else
                other.slopespeed += tallslope_spd
        }
        else if abs(image_yscale) < abs(image_xscale)
            other.slopespeed -= longslope_spd
        else
            other.slopespeed -= tallslope_spd
    }
    if slopespeed < 0
        slopespeed = 0
    if slopespeed > 10
        slopespeed = 10
    if movespeed < 1
        slopespeed = 0
}
