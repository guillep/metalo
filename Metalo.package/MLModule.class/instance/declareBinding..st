binding
declareBinding: aBinding

	(self hasUndeclaredBinding: aBinding name)
		ifTrue: [ | undeclaredBinding |
			undeclaredBinding := self bindingOf: aBinding name.
			self removeUndeclaredBinding: undeclaredBinding.
			aBinding value: undeclaredBinding value ].