binding-resolution
bindingOf: aName

	"Should not use exceptions here..."
	^ [[self localBindingOf: aName]
		on: MLUnresolvedNameError
		do: [ :err |  self importedBindingOf: aName ]]
			on: NotFound
			do: [ :err | self undeclaredBindingOf: aName ]