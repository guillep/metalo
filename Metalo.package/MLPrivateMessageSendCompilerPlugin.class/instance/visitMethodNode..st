visiting
visitMethodNode: aRBMethodNode 
	
	aRBMethodNode statements do: [ :statement | statement acceptVisitor: self ]