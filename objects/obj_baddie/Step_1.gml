event_user(0);

if !instance_exists(obj_player)
	exit;

// provoke
if obj_player.x > x - 400 && obj_player.x < x + 400 
&& y <= obj_player.y + 50 && y >= obj_player.y - 50
&& obj_player.state == states.backbreaker && obj_player.sprite_index == obj_player.spr_taunt
&& !tauntdid
{
	tauntdid = true
	alarm[5] = 10
	stunned = 0;
	bombreset = 0;
	scaredbuffer = 0;
}