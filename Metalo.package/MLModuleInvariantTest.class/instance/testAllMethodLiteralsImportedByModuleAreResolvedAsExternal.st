tests-method invariants
testAllMethodLiteralsImportedByModuleAreResolvedAsExternal

	self moduleMethodsDo: [ :method |
			method literals do: [ :literal |
				((literal isKindOf: MLModuleBinding)) ifTrue: [ 
					self assert: ((networkModule includesName: literal key) 
						or: [ (networkModule importedBindingOf: literal key) == literal ]) ] ] ]