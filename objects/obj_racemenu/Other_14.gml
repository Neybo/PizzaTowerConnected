/// @description back

event_user(5)
backdelay = 0.1

if (menu == racestates.create_making || menu == racestates.create_loading 
	|| menu == racestates.joining_setting || menu == racestates.joining_loading)
{
	menu = racestates.creating_or_joining
}
if (menu == racestates.created)
{
	menu = racestates.creating_or_joining
}
if (menu == racestates.joined)
{
	menu = racestates.joining_setting
}