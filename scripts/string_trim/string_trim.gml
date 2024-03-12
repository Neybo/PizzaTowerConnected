function string_trim(str){
	var newstart = 1
	var newend = string_length(str)
	var newendcheck = newend
	while string_char_at(str, newstart) == " "
	{
		if newend - newstart < 0
			break;
		newstart++
		newend--
	}
	while string_char_at(str, newendcheck) == " "
	{
		if newend - newstart < 0
			break;
		newend--
		newendcheck--
	}
	if newend - newstart < 0
		return str;
	return string_copy(str, newstart, newend)
}