initialization
initializeWidgets

	text := self instantiate: TextModel.
	text
		aboutToStyle: true;
		isCodeCompletionAllowed: true;
		autoAccept: true.
		
	text
		bindKeyCombination: $d command
		toAction: [ model evaluate: self selectedString ].
		
	text
		bindKeyCombination: $p command
		toAction: [ model printResultOf: self selectedString ].