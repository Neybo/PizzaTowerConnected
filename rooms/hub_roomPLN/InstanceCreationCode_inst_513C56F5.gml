basespr = spr_snicknpc_re;
sprite_index = basespr;

dialogue = [
	"Thanks for coming. It's quite empty here...",
	"I still have the games here, though some of my friends changed them a bit...",
	"And I should warn you, they aren't as easy as before.",
]
donefunc = function()
{
	dialogue = [
		"Good luck."
	]
}
if random_bool(20)
{
	dialogue = [
		"Pssst..",
		"You can parry Snuck.",
		"Don't tell him I said that."
	]
}
// playing as snick
with obj_player
{
	if character == "S" other.dialogue = [
		"...",
		"Nice disguise."
	]
	donefunc = function()
	{
		dialogue = [
			"...?"
		]
	}
}
