rebol []
data: parse/all read/binary %strings.txt "^/^M"

add-string: func[name str][
	if all [str not empty? str][
		replace/all str {"} {\"}
		replace/all str {'} {\'}
		append resources rejoin [{^-<string name="} name {">} str {</string>^/}]
	]
]
add-string2: func[name str][
	if all [str not empty? str][
		replace/all str {"} {\"}
		replace/all str {'} {\'}
		append resources rejoin [{^-<string name="} name {" formatted="false">} str {</string>^/}]
	]
]
foreach line data [

	foreach [a b sYes sNo sOK sQuit sPerm c d e f g h i j k l m] parse/all line "^-" [
		probe a

		dir: either a = "en" [
			%res\common-res\values
		][
			rejoin [%res\common-res\values- a]
		]
		if not exists? dir [make-dir dir]

		resources:  rejoin [
			#{} ;-- to force result be a binary so the UTF encoding is not corrupted
			{<?xml version="1.0" encoding="utf-8"?>^/
			<resources>^/}
		]

		add-string  "yes"               sYes
		add-string  "no"                sNo
		add-string  "OK"                sOK
		add-string  "quitQuestion"      sQuit
		add-string  "storagePermission" sPerm
		add-string2 "visitGame"         c
		add-string2 "visitWebsite"      d
		add-string  "official"          e
		add-string  "Facebook"          f
		add-string  "Twitter"           g
		add-string  "merchandise"       h
		add-string  "Machinarium"       i
		add-string  "Botanicula"        j
		add-string  "Chuchel"           k
		add-string  "GPSignOut"         l
		add-string  "loginFailed"       m

		write/binary dir/common-strings.xml join resources {</resources>}
	]
]

halt