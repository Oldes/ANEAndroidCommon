rebol []
data: parse/all read/binary %strings.txt "^/^M"

foreach line data [
	foreach [a b sYes sNo sOK sQuit sPerm] parse/all line "^-" [
		probe a
		if sPerm [
			replace/all sPerm {"} {\"}
			replace/all sPerm {'} {\'}
		]
		dir: either a = "en" [
			%res\common-res\values
		][
			rejoin [%res\common-res\values- a]
		]
		if not exists? dir [make-dir dir]
		write/binary dir/common-strings.xml rejoin [
#{} ;-- to force result be a binary so the UTF encoding is not corrupted
{<?xml version="1.0" encoding="utf-8"?>
<resources>
	<string name="yes">} sYes {</string>
	<string name="no">} sNo {</string>
	<string name="OK">} sOK {</string>
	<string name="quitQuestion">} sQuit {</string>
}	either sPerm [rejoin [{	<string name="storagePermission">} sPerm {</string>^/}]][""]
{</resources>}
		]
	]
]

halt