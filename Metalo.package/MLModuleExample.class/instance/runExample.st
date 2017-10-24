as yet unclassified
runExample

	self setupGlobalRegistry.
	self createTranscriptModule.
	self testTranscriptModule.
	
	^ MLModuleRegistry global at: #'Transcript-Core'