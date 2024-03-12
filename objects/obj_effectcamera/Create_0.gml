function effect_handle_update(effect, data)
{
	var stagedata = effect[stage]
	for (var i = 0; i < 4; i++)
	{
		var tweens_info = stagedata[i]
		var amount_of_shit = array_length(tweens_info)
		for (var j = 0; j < amount_of_shit; j++)
		{
			var tween_info = tweens_info[j]
			if variable_struct_exists(tween_info, "blank")
				continue;
			
			var variable = variable_struct_get(data[i], tween_info.variable)
			
			if variable_struct_exists(tween_info, "index")
			{
				var index = tween_info.index
				variable[index] = Approach(variable[index], tween_info.value, tween_info.speed, false)
			}
			else
				variable = Approach(variable, tween_info.value, tween_info.speed, false)
				
			variable_struct_set(data[i], tween_info.variable, variable)
		}
	}
	
	var checkdata = stagedata[4]
	var nextstage = false
	if !variable_struct_exists(checkdata, "never")
	{
		var surfdatacheck = data[checkdata.data_index]
		var variable = variable_struct_get(surfdatacheck, checkdata.variable)
	
	
		if variable_struct_exists(checkdata, "index")
			nextstage = variable[checkdata.index] == checkdata.value
		else
			nextstage = variable == checkdata.value
		
		if nextstage
		{
			stage++
			if stage == array_length(effect)
				stage = 0
		}
	}
}

function effect_draw_full_data(datas)
{
	for (var i = 0; i < 4; i++)
	{
		effect_draw_surface_data(datas[i], i)
	}
}

function effect_draw_surface_data(data, index = 0)
{
	var partx = (index % 2) * 480
	var party = (index > 1) * 270 
	
	var posx = (480 * (data.scale[0] < 0 ? -data.scale[0] : 0))
	var posy = (270 * (data.scale[1] < 0 ? -data.scale[1] : 0))
 	
	draw_surface_part_ext(application_surface, partx, party, 480, 270, 
	posx + data.position[0], posy + data.position[1], 
	data.scale[0], data.scale[1], data.blend, data.alpha)
}

surface_data_default = [
	{position: [0,0], scale: [1,1], alpha: 1, blend: c_white}, // top left
	{position: [480,0], scale: [1,1], alpha: 1, blend: c_white}, // top right
	{position: [0,270], scale: [1,1], alpha: 1, blend: c_white}, // bottom left
	{position: [480,270], scale: [1,1], alpha: 1, blend: c_white}, // bottom right
]

surface_data = []
array_copy(surface_data, 0, surface_data_default, 0, array_length(surface_data_default))

function yspd(s){return s/480*270}

#region eff1
effect1data = [
	[
		[{variable: "position", index: 0, value: 480, speed: 11}],
		[{variable: "position", index: 1, value: 270, speed: yspd(11)}],
		[{variable: "position", index: 1, value: 0, speed: yspd(11)}],
		[{variable: "position", index: 0, value: 0, speed: 11}],
		{data_index: 0, variable: "position", index: 0, value: 480}
	],
	[
		[{variable: "position", index: 1, value: 270, speed: yspd(11)}],
		[{variable: "position", index: 0, value: 0, speed: 11}],
		[{variable: "position", index: 0, value: 480, speed: 11}],
		[{variable: "position", index: 1, value: 0, speed: yspd(11)}],
		{data_index: 0, variable: "position", index: 1, value: 270}
	],
	[
		[{variable: "position", index: 0, value: 0, speed: 11}],
		[{variable: "position", index: 1, value: 0, speed: yspd(11)}],
		[{variable: "position", index: 1, value: 270, speed: yspd(11)}],
		[{variable: "position", index: 0, value: 480, speed: 11}],
		{data_index: 0, variable: "position", index: 0, value: 0}
	],
	[
		[{variable: "position", index: 1, value: 0, speed: yspd(11)}],
		[{variable: "position", index: 0, value: 480, speed: 11}],
		[{variable: "position", index: 0, value: 0, speed: 11}],
		[{variable: "position", index: 1, value: 270, speed: yspd(11)}],
		{data_index: 0, variable: "position", index: 1, value: 0}
	],
]
#endregion
#region eff2
effect2data = [
	[
		[{variable: "scale", index: 0, value: -1, speed: 0.05}],
		[{variable: "scale", index: 1, value: -1, speed: 0.05}],
		[{variable: "scale", index: 0, value: -1, speed: 0.05}],
		[{variable: "scale", index: 1, value: -1, speed: 0.05}],
		{data_index: 0, variable: "scale", index: 0, value: -1}
	],
	[
		[{variable: "scale", index: 1, value: -1, speed: 0.05}],
		[{variable: "scale", index: 0, value: -1, speed: 0.05}],
		[{variable: "scale", index: 1, value: -1, speed: 0.05}],
		[{variable: "scale", index: 0, value: -1, speed: 0.05}],
		{data_index: 0, variable: "scale", index: 1, value: -1}
	],
	[
		[{variable: "scale", index: 0, value: 1, speed: 0.05}],
		[{variable: "scale", index: 1, value: 1, speed: 0.05}],
		[{variable: "scale", index: 0, value: 1, speed: 0.05}],
		[{variable: "scale", index: 1, value: 1, speed: 0.05}],
		{data_index: 0, variable: "scale", index: 0, value: 1}
	],
	[
		[{variable: "scale", index: 1, value: 1, speed: 0.05}],
		[{variable: "scale", index: 0, value: 1, speed: 0.05}],
		[{variable: "scale", index: 1, value: 1, speed: 0.05}],
		[{variable: "scale", index: 0, value: 1, speed: 0.05}],
		{data_index: 0, variable: "scale", index: 1, value: 1}
	],
]
#endregion
#region eff3
effect3data = [
	[
		[{variable: "position", index: 0, value: 480, speed: 11}, 
		{variable: "scale", index: 0, value: -1, speed: 0.1}],
		[{variable: "position", index: 1, value: 270, speed: yspd(11)},
		{variable: "scale", index: 1, value: -1, speed: 0.1}],
		[{variable: "position", index: 1, value: 0, speed: yspd(11)},
		{variable: "scale", index: 0, value: -1, speed: 0.1}],
		[{variable: "position", index: 0, value: 0, speed: 11},
		{variable: "scale", index: 1, value: -1, speed: 0.1}],
		{data_index: 0, variable: "position", index: 0, value: 480}
	],
	[
		[{variable: "position", index: 1, value: 270, speed: yspd(11)},
		{variable: "scale", index: 1, value: -1, speed: 0.1}],
		[{variable: "position", index: 0, value: 0, speed: 11},
		{variable: "scale", index: 0, value: -1, speed: 0.1}],
		[{variable: "position", index: 0, value: 480, speed: 11},
		{variable: "scale", index: 1, value: -1, speed: 0.1}],
		[{variable: "position", index: 1, value: 0, speed: yspd(11)},
		{variable: "scale", index: 0, value: -1, speed: 0.1}],
		{data_index: 0, variable: "position", index: 1, value: 270}
	],
	[
		[{variable: "position", index: 0, value: 0, speed: 11},
		{variable: "scale", index: 0, value: 1, speed: 0.1}],
		[{variable: "position", index: 1, value: 0, speed: yspd(11)},
		{variable: "scale", index: 1, value: 1, speed: 0.1}],
		[{variable: "position", index: 1, value: 270, speed: yspd(11)},
		{variable: "scale", index: 0, value: 1, speed: 0.1}],
		[{variable: "position", index: 0, value: 480, speed: 11},
		{variable: "scale", index: 1, value: 1, speed: 0.1}],
		{data_index: 0, variable: "position", index: 0, value: 0}
	],
	[
		[{variable: "position", index: 1, value: 0, speed: yspd(11)},
		{variable: "scale", index: 1, value: 1, speed: 0.1}],
		[{variable: "position", index: 0, value: 480, speed: 11},
		{variable: "scale", index: 0, value: 1, speed: 0.1}],
		[{variable: "position", index: 0, value: 0, speed: 11},
		{variable: "scale", index: 1, value: 1, speed: 0.1}],
		[{variable: "position", index: 1, value: 270, speed: yspd(11)},
		{variable: "scale", index: 0, value: 1, speed: 0.1}],
		{data_index: 0, variable: "position", index: 1, value: 0}
	],
]
#endregion

effects = [effect1data, effect2data, effect3data]
cureffect = -1
stage = 0



