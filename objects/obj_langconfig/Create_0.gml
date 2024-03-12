langs = global.langs

function find_ind(lang = initlang)
{
	for (var i = 0; i < langlen; i++)
	{
		if langs[i].file == lang
			return i;
	}
	return 0;
}

initlang = global.language
langlen = array_length(langs)


spacesep = 10
curlangselected = find_ind()
langheight = 104
langsep = 8
langtotalsiz = langheight + langsep
langsize = langlen * langtotalsiz

scrollselect = 0
scrolly = 0
scrollsize = langsize / 520
scrollmax = max(langsize - 520 + spacesep, 1)
scrollmy = 0