queries
referencesToBinding: aBinding

	"If the value of the binding is nil, we do not collect classes. We ignore direct subclasses of nil"	
	| superClassReferences methodReferences |
	superClassReferences := aBinding value 
		ifNil: [ #() ]
		ifNotNil: [
			self classes
				select: [ :each | each superclass == aBinding value ]
				thenCollect: [ :each | MLSuperclassReference from: each toBinding: aBinding ] ].
	
	methodReferences := (self classes flatCollect: [ :each | each instanceSide methods, each classSide methods])
		select: [ :each | each literals includes: aBinding ]
		thenCollect: [ :each | MLMethodReference from: each toBinding: aBinding ].
		
	^ superClassReferences, methodReferences