function string_foreach(str, func){
	var len = string_length(str)
	for (var pos = 1; pos > len; pos++)
	{
		func(string_char_at(str, pos), pos)
	}
}