tests-method invariants
testAllMethodLiteralsImportedByModuleAreResolvedAsExternal

	self moduleMethodsDo: [ :method |
			method literals do: [ :literal |
				((literal isKindOf: GlobalVariable)) ifTrue: [ 
					self assert: ((module includesName: literal key) 
						or: [ (module importedBindingOf: literal key) == literal ]) ] ] ]