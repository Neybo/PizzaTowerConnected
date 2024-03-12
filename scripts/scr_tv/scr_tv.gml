function tv_default_condition() {
	return place_meeting(x, y, obj_player);
}

function tv_push_prompt(array)
{
	// @param array Array containing prompt data made with tv_create_prompt
	if FINAL_GAMEPLAY
	{
		with obj_tv
			ds_list_add(tvprompts_list, array);
	}
}
function tv_push_prompt_once(array, saved)
{
	// @param array Array containing prompt data made with tv_create_prompt
	// @param saved String containing path to saved TV prompt
		with obj_tv
		{
			try
			{
				if special_prompts != undefined && ds_map_find_value(special_prompts, saved) != 1
				{
					tv_push_prompt(array);
					
					// save
					ds_map_set(special_prompts, saved, 1);
				
					ini_open("saveData" + string(global.saveslot) + ".ini");
					ini_write_real("Prompts", saved, 1);
					ini_close();
				}
			}
			catch (e)
			{
				e = 0
			}
		}
}

function tv_push_prompt_array(array)
{
	// @param array Array containing... another array
	for(var i = 0; i < array_length(array); i++)
		tv_push_prompt(array[i]);
}

function tv_create_prompt(text, tvon, sprite, textspeed)
{
	// @param text The text to display in the speech bubble
	// @param tvon Keep TV on
	// @param sprite Sprite for the TV
	// @param textspeed Text scroll speed
	var array = [text, tvon, sprite, textspeed];
	return array;
}

function tv_do_expression(sprite)
{
	with obj_tv
    {
        if expressionsprite != sprite && bubblespr == noone
        {
            state = 250
            expressionsprite = sprite
            switch expressionsprite
            {
				case spr_tv_exprhurt:
                    expressionbuffer = 60
                    break
                case spr_tv_exprcollect:
                    expressionbuffer = 150
                    break
            }
        }
    }
}
