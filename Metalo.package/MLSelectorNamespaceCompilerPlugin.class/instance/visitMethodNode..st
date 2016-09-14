accessing
visitMethodNode: aRBMethodNode 
	
	aRBMethodNode selector: (metaModule internModuleSelector: aRBMethodNode selector).
	aRBMethodNode statements do: [ :statement | statement acceptVisitor: self ]