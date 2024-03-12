function sh_destroy(args)
{
	if !WC_debug
		return "You do not have permission to use this command";
	if array_length(args) < 2
		return "Not enough arguments. Usage: destroy <instance(:index)";
	
	// get arguments
	var pretarget = args[1];
	
	// resolve target
	var target_one = false; // only target one instance
	var target = noone;
	
	if pretarget != "global" && pretarget != "all"
	{
		var obj = WCscr_findobj(pretarget);
		if is_array(obj)
		{
			target = obj[0];
			target_one = obj[1];
		}
		else
			return obj;
	}
	if target == noone // target non existent
		return "Instance " + pretarget + " doesn't exist";
		
	instance_destroy(target)
		
	if target != global && target != all
	{		
		return "MOST LIKELY WRECKED OBJECT LOL"
	}
	else if target == all
		return "All isn't allowed"
	else
		return "Global isn't allowed"
}
function meta_destroy()
{
	return
	{
		description: "destroy an instance",
		arguments: ["instance"],
		suggestions: [
			function()
			{
				var obj_array = [];
				for(var i = 0; i < instance_count; i++)
				{
					var inst = instance_find(all, i);
					if !instance_exists(inst)
						continue;
					var obj = inst.object_index;
					
					for(var j = 0; j < instance_number(obj); j++)
					{
						if instance_find(obj, j).id == inst.id
							array_push(obj_array, object_get_name(obj) + ":" + string(j));
					}
				}
				array_sort(obj_array, true);
				return obj_array;
			},
			[],
			[]
		],
		argumentDescriptions: [
			"an instance"
		],
	}
}
