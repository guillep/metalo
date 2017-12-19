private-class-installer-API
at: aName ifAbsent: aBlock
	
	| binding |
	binding := self bindingOf: aName.
	binding ifNil: [ ^ aBlock value ].
	^ binding value