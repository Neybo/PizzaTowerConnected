event_inherited();

selarray = [
	[spr_nohat, "Empty", "Don't you already have a hat?"],
	[spr_cowboyhat1, "Cowboy Hat", "Yeehaw."],
	[spr_hat_snickcrown, "Snick Crown", "For the king of the 4 Snicks."],
	[spr_hat_cowboy2, "Sheriff Hat", "Weirdly western."],
	[spr_hat_scatman, "JPEG Top Hat", "It smells like a public bathroom."],
	[spr_hat_discord, "Discord", "/register with JohnBot."]
];
if (!check_online())
	array_delete(selarray, 5, 1)
	
spr_idle = selarray[0][0];

selvert = false;
event_user(0);