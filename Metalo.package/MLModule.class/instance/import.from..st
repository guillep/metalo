imports
import: aName from: aContainerModuleName 
	
	| newImport |
	self assertNameNotLocallyDeclared: aName.
	
	newImport := MLImport name: aName from: aContainerModuleName.
	self imports
		detect: [ :each | each importedName = newImport importedName ]
		ifFound: [ :found | 
			found = newImport
				ifTrue: [ "An import already exists for the same name and module."
					^ found ]
				ifFalse: [ 
					self error: ('Cannot import {1} from {2}: {1} is already imported from {3}'
						format: { aName . aContainerModuleName . found moduleName }) ] ].
	
	self declareBinding: newImport binding.
	
	imports add: newImport.
	^ newImport