mop
internModuleSelector: selector

	^ (selectors like: selector) ifNil: [ | privateSelector |
			privateSelector := MLSelector new symbol: selector.
			selectors add: privateSelector.
			privateSelector ]