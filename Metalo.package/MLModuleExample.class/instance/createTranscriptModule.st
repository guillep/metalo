examples
createTranscriptModule

	module := MLModule newNamed: #'Transcript-Core'.

	module doImport: #PackageManifest from: #Kernel.
	module doImport: #Mutex from: #Kernel.
	module doImport: #Character from: #'Kernel'.
	module doImport: #String from: #'Collections-Sequenceable'.
	module doImport: #Model from: #'System-Model'.
	module doImport: #Smalltalk from: #'System-Support'.

	module declareVariableNamed: #Transcript.

	MLRPackageLoader new
		rpackageName: #'Transcript-Core';
		module: module;
		load.