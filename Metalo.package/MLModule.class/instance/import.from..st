imports
import: aName from: aContainerModuleName 
	
	| import |
	import := MLImport name: aName from: aContainerModuleName.
	import checkConflictsOn: self.
	
	"Resolve the import. Fail if cannot resolve."
	import resolveUsing: self defaultNameResolver.
	import binding isUnbound
		ifTrue: [ 
			self error: ('Cannot resolve import: {name} from: {package}' format: {
				'name' -> aName.
				'package' -> aContainerModuleName } asDictionary) ].

	self declareBinding: import binding.
	imports add: import.
	^ import