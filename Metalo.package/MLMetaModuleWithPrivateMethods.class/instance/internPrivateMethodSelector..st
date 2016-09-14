mop
internPrivateMethodSelector: selector

	^ (privateSelectors like: selector) ifNil: [ | privateSelector |
			privateSelector := MLSelector new symbol: selector.
			privateSelectors add: privateSelector.
			privateSelector ]