function gms_self_isowner() {
	return gms_self_admin_rights() > 5
}
// a few people :)

function gms_other_isowner(userid) {
	return gms_other_admin_rights(userid) > 5
}