function scr_player_knightpepbump(){
	alarm[5] = 2
    alarm[7] = 60
    hsp = (-xscale * movespeed)
    if (grounded && vsp > 0)
    {
        state = states.knightpep
        sprite_index = spr_knightpepland
        image_index = 0
        groundpoundsnd = scr_soundeffect(sfx_groundpound)
        if hurted
            hurted = 0
    }
    if (floor(image_index) == (image_number - 1))
        image_index = (image_number - 1)
}