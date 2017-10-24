running
testReferToLocallyDefinedClass
	
	| moduleClass |
	moduleClass := workspace evaluate: 'ThreadSafeTranscript'.
	self assert: moduleClass equals: (workspace module classNamed: #ThreadSafeTranscript)
	