tests
testCreateSubclassOfUnboundClassHasUnboundSuperclass

	"Point class exists and inherits from an UndefinedClass"
	self assert: (module classNamed: self definedClassName) superclass isUndefinedSubclass 