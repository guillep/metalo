binding
replaceBindingWith: aBinding
	
	"I have to make the referencing class point to the class in the binding."
	self assert: aBinding value isClass.
	
	"This should recompiler the subclass if the superclass has a different format."
	self flag: #possibleBug.
	referencingClass superclass: aBinding value.