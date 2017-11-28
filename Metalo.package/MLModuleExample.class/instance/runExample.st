examples
runExample

	self setupGlobalRegistry.
	self createTranscriptModule.
	self testTranscriptModule.
	
	^ MLModuleRegistry global at: #'Transcript-Core'