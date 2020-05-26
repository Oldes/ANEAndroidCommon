rebol []
res-dir: %res-bota\common-res\

make-dir/deep res-dir

data: parse/all read/binary %strings-bota.csv "^/^M"

add-string: func[name str][
	if all [str not empty? str][
		replace/all str {"} {\"}
		replace/all str {'} {\'}
		append resources rejoin [{^-<string name="} name {">} str {</string>^/}]
	]
]

if not exists? res-dir [make-dir/deep res-dir]

foreach line data [

	foreach [a b sYes sNo sOK sQuit sPerm c d e f g h i j k l m n] parse/all line "^-" [
		probe a

		dir: either a = "en" [res-dir/values][rejoin [res-dir/values- a]]
		if not exists? dir [make-dir dir]

		resources:  rejoin [
			#{} ;-- to force result be a binary so the UTF encoding is not corrupted
			{<?xml version="1.0" encoding="utf-8"?>^/<resources>^/}
		]

		add-string "yes"               sYes
		add-string "no"                sNo
		add-string "OK"                sOK
		add-string "quitQuestion"      sQuit
		add-string "storagePermission" sPerm
		add-string "visitGame"         c
		add-string "visitWebsite"      d
		add-string "official"          e
		add-string "Facebook"          f
		add-string "Twitter"           g
		add-string "merchandise"       h
		add-string "Machinarium"       i
		add-string "Chuchel"           j
		add-string "Samorost"          k
		add-string "GPSignOut"         l
		add-string "loginFailed"       m
		add-string "buyGame"           n
		write/binary dir/common-strings.xml join resources {</resources>}
	]
]

halt