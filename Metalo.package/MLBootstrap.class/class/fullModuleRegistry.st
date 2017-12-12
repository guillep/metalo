public API
fullModuleRegistry	
	^ FullModuleRegistry ifNil: [ FullModuleRegistry := self createFullModuleRegistry ]