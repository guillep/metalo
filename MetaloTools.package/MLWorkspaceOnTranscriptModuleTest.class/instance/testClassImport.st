running
testClassImport
	
	| module importedClass |
	
	module := workspace module.
	self deny: (module hasImportNamed: #AsciiCharset).
	
	workspace evaluate: 'self import: #AsciiCharset from: #Kernel.'.
	self assert: (module hasImportNamed: #AsciiCharset).
	
	importedClass := workspace evaluate: 'AsciiCharset'.
	self assert: importedClass equals: AsciiCharset
	