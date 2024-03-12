if ((other.state != states.tumble 
|| (other.sprite_index != other.spr_tumble 
&& other.sprite_index != other.spr_tumblestart 
&& other.sprite_index != other.spr_tumbleend)) 
&& other.state != states.backbreaker && other.state != states.chainsaw 
&& other.state != states.bump && other.y > other.yprevious && other.y <= (y + 10))
{
	if (other.state == states.punch)
		other.movespeed = abs(other.hsp);
	other.y = y - 49;
	other.state = states.grind;
}
