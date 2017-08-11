undeclareds
checkUndeclaredBinding: aBinding

	| references undeclaredBinding |
	references := self referencesToBinding: aBinding.
	references ifEmpty: [ ^ self ].
	
	"We create a new undeclared binding and we set the old value we had to it.
	We then replace all references to it in superclasses and method literals"
	undeclaredBinding := self declareUndeclaredBinding: aBinding name.
	undeclaredBinding value: aBinding value.
	references do: [ :each | each replaceBindingWith: undeclaredBinding  ]