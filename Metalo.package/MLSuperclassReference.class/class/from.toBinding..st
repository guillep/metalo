instance-creation
from: aClass toBinding: aBinding
	
	^ self new
		referencingClass: aClass;
		referencedBinding: aBinding;
		yourself