imports
doImport: aName from: aContainerModuleName 
	
	| import |
	import := self import: aName from: aContainerModuleName.
	import resolveUsing: self defaultNameResolver.
	
	"We should have the reason also..."
	import binding isUnbound
		ifTrue: [ 
			self error: ('Cannot resolve import: {name} from: {package}' format: {
				'name' -> aName.
				'package' -> aContainerModuleName } asDictionary) ].