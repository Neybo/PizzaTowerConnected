var playergetsshotgun = false
if room == graveyard_secret1
	playergetsshotgun = true
	
with obj_player
{
	shotgunAnim = playergetsshotgun
}

if !string_contains(room_name, "secret")
	instance_destroy(); 
	
if room == secret_entrance && secretsleft == 0
{
	seconds = -1
	alarm[0] = -1
}