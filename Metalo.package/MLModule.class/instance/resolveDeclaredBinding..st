binding-resolution
resolveDeclaredBinding: aName

	^ [self localBindingOf: aName]
		on: MLUnresolvedNameError
		do: [ :err | self importedBindingOf: aName ]