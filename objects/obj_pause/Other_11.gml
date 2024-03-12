/// @description em em em em em em em em em em em em
function create_pausebg()
{
	custompausebg = false
	pausebg = sprite_create_from_surface(application_surface, 0, 0, 
	surface_get_width(application_surface), surface_get_height(application_surface), 
	false, false, 0, 0); // nothing
}

if file_exists("custom/pausebgdata.txt")
{
	var bgs = [];
	var num = 0;
	var file = file_text_open_read("custom/pausebgdata.txt");
	while (!file_text_eof(file))
	{
		var newbg = file_text_readln(file);
		
		if string_ord_at(newbg, string_length(newbg)) == 10
			newbg = string_copy(newbg, 1, string_length(newbg) - 2)// remove the bitch!
		
		if file_exists("custom/pausebgs/" + newbg)
		{
			bgs[num++] = newbg
		}
	}
	
	if num == 0 && global.pausebg
	{
		create_pausebg()
	}
	else
	{
		randomize()
		try
		{
			var chosenpausebg = sprite_add("custom/pausebgs/" + bgs[irandom(num - 1)], 
			1, false, false, 0,0)
		
			if sprite_exists(chosenpausebg)
			{
				pausebg = chosenpausebg
				custompausebg = true;
			}
			else if global.pausebg
				create_pausebg()
		}
		catch(e)
		{
			e = 0
			if global.pausebg
				create_pausebg()
		}
	}
		
	file_text_close(file);
}
else if global.pausebg
{
	create_pausebg()
}
else
	custompausebg = false;
instance_create(x,y,obj_pausefadeout)

jukeboxused = false;
secretsoutof = scr_secretsoutof()
timepausebg = -2















