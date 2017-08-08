undeclareds
removeUndeclaredBinding: aMLUndeclaredBinding 
	
	"Potential bug: if somebody sends as argument a binding with the same name but different identity we may remove a wrong binding."
	undeclaredBindings removeKey: aMLUndeclaredBinding name