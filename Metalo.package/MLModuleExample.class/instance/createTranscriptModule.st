examples
createTranscriptModule

	module := MLModule newNamed: #'Transcript-Core'.

	module import: #PackageManifest from: #Kernel.
	module import: #Mutex from: #Kernel.
	module import: #Character from: #'Kernel'.
	module import: #String from: #'Collections-Sequenceable'.
	module import: #Model from: #'System-Model'.
	module import: #Smalltalk from: #'System-Support'.

	module declareVariableNamed: #Transcript.

	MLRPackageLoader new
		rpackageName: #'Transcript-Core';
		module: module;
		load.