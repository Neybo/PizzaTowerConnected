if !other.sugary
	exit;

with other.id
{
	mask_index = spr_player_mask;
	if image_index < 18
		image_index = 18;
}
if !collisioned
	event_user(0)
