accessing
selectedString
	
	| selection |
	selection := text getSelection.
	^ (text text copyFrom: selection first to: selection last) asString