function scr_checkskin(skin, player = undefined)
{
	if player == undefined
	{
		player = obj_player;
	}
	
	if !instance_exists(player)
		return false;
	
	enum checkskin
	{
		p_anton,
		p_antononly,
		p_peter,
		n_big,
		n_goise,
		s_sbombic
	}
	
	if skin == checkskin.p_anton // anton or annie
		return (player.character == "P" && player.paletteselect == 14) 
		or (player.character == "SP" && player.paletteselect == 13) 
	if skin == checkskin.p_antononly // only anton (for the voice clip)
		return (player.character == "P" && player.paletteselect == 14) 
	if skin == checkskin.p_peter
		return player.character == "P" && player.paletteselect == 18;
	if skin == checkskin.n_big
		return player.character == "N" && player.paletteselect == 14;
	if skin == checkskin.n_goise
		return player.character == "N" && player.paletteselect == 12;
	if skin == checkskin.s_sbombic
		return player.character == "S" && player.paletteselect == 13;

	return false;
}