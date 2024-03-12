if !display_video 
	return;
	
var _data = video_draw();
var _status = _data[0];

if (_status == 0)
{
    var _surface = _data[1];
		
	if !surfacechecked
	{
		surfacecheck = _surface
		event_user(2)
	}
	if !basesize
		draw_surface_stretched(_surface, x, y, drawwidth, drawheight);
	else
		draw_surface(_surface, x, y)
}