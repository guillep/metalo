initialization
initializeWidgets

	text := self instantiate: TextModel.
	text
		aboutToStyle: true;
		isCodeCompletionAllowed: true;
		autoAccept: true.
		
	text
		bindKeyCombination: $d command
		toAction: [ self evaluate: self selectedString ].
		
	text
		bindKeyCombination: $p command
		toAction: [ self printResultOf: self selectedString ].