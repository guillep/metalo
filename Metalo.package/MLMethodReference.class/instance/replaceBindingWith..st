bindings
replaceBindingWith: newBinding
	
	referencingMethod literals withIndexDo: [ :literal :index |
		 literal == referencedBinding ifTrue: [
			referencingMethod literalAt: index put: newBinding ] ]