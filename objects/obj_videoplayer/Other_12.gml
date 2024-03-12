/// @description aspect ratio and shit
var surf = surfacecheck

if !surfacechecked
{
	drawwidth = surface_get_width(surf)
	drawheight = surface_get_height(surf)
}

surfacechecked = true


var wid = drawwidth

var heig = drawheight

if wid <= width && heig <= height // we good return with offsets calc'ed
{
	var basex = x
	var basey = y 
	x = basex + ((width - wid) / 2)
	y = basey + ((height - heig) / 2)
	show_debug_message("RETURN!")
	return;
}
// time for maths pain, edit: not really lol!

/* width == height? 1:1

var ratio = 1 // 1:ratio 

if wid == heig
{
	ratio = 1
}
else
{
	ratio = wid / heig // yum
} */ // not important ?

 if heig > height && wid <= width
{
	var scale = height / heig
	wid *= scale
	heig *= scale
}
if wid > width 
{
	var scale = width / wid
	wid *= scale
	heig *= scale
}
var basex = x
var basey = y 
x = basex + ((width - wid) / 2)
y = basey + abs(((height - heig) / 2))
basesize = false
drawwidth = wid
drawheight = heig
if !(wid <= width && heig <= height)
{
	// FUCK YOU!
	event_perform(ev_alarm, 0)
}
if (y - ystart) + drawheight > height // manually say FUCK YOU!
{
	var offset = (y - ystart) + drawheight - height
	y -= offset
	y += offset / 7.25
}




