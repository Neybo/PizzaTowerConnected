function sh_roomcheck(args)
{
	if release
		return "You won't do this command. It will crash. This is only used by me.";
	instance_create(0, 0, obj_roomcheck)
}
function meta_roomcheck()
{
	return
	{
		description: "roomcheck like delta rune",
		arguments: [],
		suggestions: [
			function()
			{
				return [];
			},
			[],
			[]
		],
		argumentDescriptions: [],
	}
}
