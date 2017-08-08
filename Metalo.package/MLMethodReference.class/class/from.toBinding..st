instance-creation
from: aMethod toBinding: aBinding
	
	^ self new
		referencingMethod: aMethod;
		referencedBinding: aBinding;
		yourself