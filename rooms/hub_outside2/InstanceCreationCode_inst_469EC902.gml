
if fullgame
{
	dialogue = [
	"This door leads to a replica of the hub in the final game of Pizza Tower!",
	"It contains final game versions of levels, but only a fewas of now.",
	"It is currently WIP so don't expect too much."
	]
	
	if global.levelstyle = 0 or global.gameplay = 0
		array_push(dialogue, "NOTE: The old level style or old gameplay setting will not affect the levels here.")
}
else
	dialogue = [
	"There was a door here that took you to a replica of the hub in the final game of Pizza Tower.",
	"You don't have Pizza Tower on Steam."
	]