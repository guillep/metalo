Class {
	#name : 'MLCompilerBootstrapDemo',
	#superclass : 'Object',
	#instVars : [
		'environment',
		'loadedModules'
	],
	#category : 'Modules',
	#package : 'Modules'
}

{ #category : 'as yet unclassified' }
MLCompilerBootstrapDemo >> importASTCore [

	self importKernel.
	self importAnnouncements.
	self importCollectionsStreams.
	self importCollectionsWeak.
	self importCollectionsNative.
	self importVirtualSessionManager.
	self importVirtualSystemAnnouncer.
	^ self loadModuleFromPackageNamed: 'AST-Core'
]

{ #category : 'as yet unclassified' }
MLCompilerBootstrapDemo >> importASTCoreTests [

	self importSUnit.
	self importParametrizedTests.
	self importASTCore.
	self importWeirdASTCoreTestsDependencies.
	self importOpalCompiler.
	"The ast tests require an extension from SystemCommands-SourceCodeCommands on the ASTs!!!"
	self importSystemCommandsSourceCodeCommands.
	^ self loadModuleFromPackageNamed: 'AST-Core-Tests'
]

{ #category : 'as yet unclassified' }
MLCompilerBootstrapDemo >> importAnnouncements [

	self importCollectionsUnordered.
	self importWeirdAnnouncementDependencies.
	^ self loadModuleFromPackageNamed: 'Announcements-Core'
]

{ #category : 'as yet unclassified' }
MLCompilerBootstrapDemo >> importCollectionsAbstract [

	self importVirtualCollectionStrings.
	self importVirtualExceptions.
	^ self loadModuleFromPackageNamed: 'Collections-Abstract'
]

{ #category : 'as yet unclassified' }
MLCompilerBootstrapDemo >> importCollectionsArithmetic [

	self importKernel.
	self importCollectionsNative.
	^ self loadModuleFromPackageNamed: 'Collections-Arithmetic'
]

{ #category : 'as yet unclassified' }
MLCompilerBootstrapDemo >> importCollectionsNative [

	self importCollectionsSequenceable.
	^ self
		  loadModuleFromPackageNamed: 'Collections-Native'
		  except: { #Float32Array. #Float64Array. #ByteArray }
]

{ #category : 'as yet unclassified' }
MLCompilerBootstrapDemo >> importCollectionsSequenceable [

	self importCollectionsAbstract.
	^ self
		  loadModuleFromPackageNamed: 'Collections-Sequenceable'
		  except: { #Array. #SharedQueue }
]

{ #category : 'as yet unclassified' }
MLCompilerBootstrapDemo >> importCollectionsStack [

	self importCollectionsSequenceable.
	^ self loadModuleFromPackageNamed: 'Collections-Stack'
]

{ #category : 'as yet unclassified' }
MLCompilerBootstrapDemo >> importCollectionsStreams [

	self importKernel.
	self importCollectionsSequenceable.
	^ self loadModuleFromPackageNamed: 'Collections-Streams'
]

{ #category : 'as yet unclassified' }
MLCompilerBootstrapDemo >> importCollectionsSupport [

	self importKernel.
	^ self loadModuleFromPackageNamed: 'Collections-Support'
]

{ #category : 'as yet unclassified' }
MLCompilerBootstrapDemo >> importCollectionsUnordered [

	self importKernel.
	self importCollectionsAbstract.
	self importCollectionsSequenceable.
	self importCollectionsSupport.
	self importWeirdCollectionsUnorderedDependencies.
	^ self loadModuleFromPackageNamed: 'Collections-Unordered'
]

{ #category : 'as yet unclassified' }
MLCompilerBootstrapDemo >> importCollectionsWeak [

	self importKernel.
	self importCollectionsSupport.
	self importCollectionsUnordered.
	^ self
		  loadModuleFromPackageNamed: 'Collections-Weak'
		  except: { #Array. #SharedQueue }
]

{ #category : 'as yet unclassified' }
MLCompilerBootstrapDemo >> importKernel [
	
	^ self loadVirtualModuleNamed: #Kernel withAll: #(ProtoObject
			Object
			UndefinedObject 
		   #Array 
		   #Context 
		   #Boolean 
		   #True 
		   #False 
		   #BlockClosure 
		   #CleanBlockClosure 
		   #ConstantBlockClosure 
		   #ConstantBlockClosure1Arg 
		   #ConstantBlockClosure2Arg 
		   #ConstantBlockClosure3Arg 

			"Required by the VM!"
		   #Array 
		   #ByteArray 
		   #Float32Array 
		   #Float64Array 

		   #Magnitude 
		   #Number 
		   #Integer 
		   #SmallInteger 
		   #Float 
		   #NumberParser 

		   #PackageManifest 

		   #Behavior 
		   #ClassDescription 
		   #Class 
		   #Metaclass 
		   #FixedLayout 
		   #VariableLayout 
		   #WeakLayout 
		   #EphemeronLayout 
		   #WordLayout 
		   #DoubleWordLayout 
		   #DoubleByteLayout 
		   #ByteLayout 
		   #CompiledMethodLayout 

		   #CompiledCode 
		   #CompiledMethod 
		   #CompiledBlock 

		   #Processor 
		   #Process 
		   #Semaphore 

		   #EncoderForSistaV1 
		   #AdditionalMethodState 

		   #Pragma 
		   #Character 
		   #ScaledDecimal 
		   #Variable 
		   #GlobalVariable 

			"DNU support"
		   #Message )
]

{ #category : 'as yet unclassified' }
MLCompilerBootstrapDemo >> importOpalCompiler [

	| module |
	self importCollectionsUnordered.
	self importASTCore.
	self importVirtualBytecodeInterpreter.
	self importCollectionsStack.
	self importVirtualBindings.
	self importWeirdCompilerDependencies.
	self importVirtualUIManager.
	self importVirtualAuthor.
	self importCollectionsArithmetic.
	module := self loadModuleFromPackageNamed: 'OpalCompiler-Core'.
	(module at: #OCASTTranslator) initialize.
	^ module
]

{ #category : 'as yet unclassified' }
MLCompilerBootstrapDemo >> importOpalTests [
	
	self importASTCore.
	self importOpalCompiler.
	self importParametrizedTests.
	self importWeirdOpalTestsDependencies.
	self importASTCoreTests.
	^ self loadModuleFromPackageNamed: 'OpalCompiler-Tests'
]

{ #category : 'imports' }
MLCompilerBootstrapDemo >> importParametrizedTests [

	self importSUnit.	
	^ self loadModuleFromPackageNamed: #'ParametrizedTests'
]

{ #category : 'as yet unclassified' }
MLCompilerBootstrapDemo >> importSUnit [

	self importKernel.
	self importAnnouncements.
	self importCollectionsWeak.
	self importVirtualExecutionEnvironment.
	self importVirtualTime.
	self importVirtualAuthor.
	self importVirtualSystemAnnouncer.
	self importWeirdSUnitDependencies.
	^ self loadModuleFromPackageNamed: 'SUnit-Core'
]

{ #category : 'as yet unclassified' }
MLCompilerBootstrapDemo >> importSystemCommandsSourceCodeCommands [

	self importKernel.
	self importVirtualSystemCommandsDependencies.
	self importVirtualUIManager.
	self importASTCore.
	^ self loadModuleFromPackageNamed:
		  'SystemCommands-SourceCodeCommands'
]

{ #category : 'as yet unclassified' }
MLCompilerBootstrapDemo >> importVirtualAuthor [

	^ self
		  loadVirtualModuleNamed: #'Virtual-Author'
		  withAll: #( Author )
]

{ #category : 'as yet unclassified' }
MLCompilerBootstrapDemo >> importVirtualBindings [

	^ self
		loadVirtualModuleNamed: #'Virtual-Bindings'
		withAll:
			#( UndeclaredVariable AdditionalBinding DoItVariable WorkspaceVariable
			   NewUndeclaredWarning )
]

{ #category : 'as yet unclassified' }
MLCompilerBootstrapDemo >> importVirtualBytecodeInterpreter [

	^ self
		loadVirtualModuleNamed: #'Virtual-BytecodeInterpreter'
		withAll: #( InstructionClient InstructionStream )
]

{ #category : 'as yet unclassified' }
MLCompilerBootstrapDemo >> importVirtualCollectionStrings [

	^ self
		  loadVirtualModuleNamed: #'Collection-Strings'
		  withAll: #( String ByteString Symbol CharacterSet )
]

{ #category : 'as yet unclassified' }
MLCompilerBootstrapDemo >> importVirtualExceptions [

	self importKernel.
	^ self
		  loadVirtualModuleNamed: #'Virtual-Exceptions'
		  withAll:
			  #( Error Notification RuntimeSyntaxError Exception Halt Deprecation
			     UnhandledException Warning SubscriptOutOfBounds
			     DomainError OutOfMemory UnhandledError Abort UndeclaredVariableRead
			     UndeclaredVariableWrite BlockCannotReturn ArgumentsCountMismatch )
]

{ #category : 'as yet unclassified' }
MLCompilerBootstrapDemo >> importVirtualExecutionEnvironment [

	^ self
		  loadVirtualModuleNamed: #'Virtual-ExecutionEnvironment'
		  withAll:
			  #( #ExecutionEnvironment #CurrentExecutionEnvironment #DefaultExecutionEnvironment )
]

{ #category : 'as yet unclassified' }
MLCompilerBootstrapDemo >> importVirtualSessionManager [

	^ self
		  loadVirtualModuleNamed: #'Virtual-SessionManager'
		  withAll: #( SessionManager )
]

{ #category : 'as yet unclassified' }
MLCompilerBootstrapDemo >> importVirtualSystemAnnouncer [

	^ self
		  loadVirtualModuleNamed: #'Virtual-SystemAnnouncer'
		  withAll: #( SystemAnnouncer )
]

{ #category : 'as yet unclassified' }
MLCompilerBootstrapDemo >> importVirtualSystemCommandsDependencies [

	^ self
		  loadVirtualModuleNamed: #'Virtual-SystemCommand-Dependencies'
		  withAll:
			  #( CmdCommand SycOpenContextMenuCommand CmdMenuCommandActivationStrategy
			     SycCmCommand RBRefactoringError SycSourceCodeMenuActivation
			     RBRenameArgumentOrTemporaryRefactoring
			     CmdCommandAborted RBInlineMethodRefactoring
			     RBInlineTemporaryRefactoring RBExtractToTemporaryTransformation
			     RBExtractSetUpMethodAndOccurrences
			     RBExtractMethodAndOccurrences SycMethodNameEditorPresenter
			     CmdShortcutActivation ClySourceCodeContext
			     RBMethodName RBExtractMethodTransformation
			     RBTemporaryToInstanceVariableRefactoring )
]

{ #category : 'as yet unclassified' }
MLCompilerBootstrapDemo >> importVirtualTime [

	^ self
		  loadVirtualModuleNamed: #'Virtual-Time'
		  withAll: #( DateAndTime Duration )
]

{ #category : 'as yet unclassified' }
MLCompilerBootstrapDemo >> importVirtualUIManager [

	^ self
		  loadVirtualModuleNamed: #'Virtual-UIManager'
		  withAll: #( #UIManager)
]

{ #category : 'as yet unclassified' }
MLCompilerBootstrapDemo >> importWeirdASTCoreTestsDependencies [

	^ self
		  loadVirtualModuleNamed: #'Weird-ASTTests-Dependencies'
		  withAll: #( ChunkImportTestCase CodeImporter MCMethodDefinition
			     MCMockClassE Bitmap File MirrorPrimitives RBReplaceSubtreeTransformation
			     TextBackgroundColor Text )
]

{ #category : 'as yet unclassified' }
MLCompilerBootstrapDemo >> importWeirdAnnouncementDependencies [

	^ self
		  loadVirtualModuleNamed: #'Weird-Announcements-Dependencies'
		  withAll: #( WeakMessageSend MessageSend )
]

{ #category : 'as yet unclassified' }
MLCompilerBootstrapDemo >> importWeirdCollectionsUnorderedDependencies [

	^ self
		  loadVirtualModuleNamed:
		  #'Weird-Collection-Unordered-Dependencies'
		  withAll: #( #Smalltalk )
]

{ #category : 'as yet unclassified' }
MLCompilerBootstrapDemo >> importWeirdCompilerDependencies [

	^ self
		  loadVirtualModuleNamed: #'Weird-Compiler-Dependencies'
		  withAll: #( #ClassDefinitionPrinter
		     #SmalltalkImage )
]

{ #category : 'asd' }
MLCompilerBootstrapDemo >> importWeirdOpalTestsDependencies [

	^ self
		  loadVirtualModuleNamed: #'Weird-CompilerTests-Dependencies'
		  withAll:
			  #( ProvideAnswerNotification SystemDictionary Point SelfVariable
			     SuperVariable ThisContextVariable Undeclared File )
]

{ #category : 'as yet unclassified' }
MLCompilerBootstrapDemo >> importWeirdSUnitDependencies [

	^ self
		  loadVirtualModuleNamed: #'Weird-SUnit-Dependencies'
		  withAll: #( #Color #MethodAdded #MethodModified #MethodRemoved )
]

{ #category : 'initialization' }
MLCompilerBootstrapDemo >> initialize [

	super initialize.
	environment := MLListEnvironment new.
	loadedModules := Dictionary new
]

{ #category : 'as yet unclassified' }
MLCompilerBootstrapDemo >> loadModuleFromPackageNamed: aName [

	| module |
	loadedModules at: aName ifPresent: [ :found | ^ found ].

	module := MLModule fromPackage: aName nameResolver: environment.
	loadedModules at: aName put: module.
	environment add: module.
	^ module
]

{ #category : 'as yet unclassified' }
MLCompilerBootstrapDemo >> loadModuleFromPackageNamed: aName except: namesNotToLoad [

	| module |
	loadedModules at: aName ifPresent: [ :found | ^ found ].

	module := MLModule fromPackage: aName except: namesNotToLoad nameResolver: environment.
	loadedModules at: aName put: module.
	environment add: module.
	^ module
]

{ #category : 'as yet unclassified' }
MLCompilerBootstrapDemo >> loadVirtualModuleNamed: aName withAll: listOfClassesImportedFromOriginalSystem [

	| virtualModule |
	loadedModules at: aName ifPresent: [ :found |  ^ found ].
	
	virtualModule := MLFilterModule on: MLSystemModule new named: aName.
	listOfClassesImportedFromOriginalSystem do: [ :e |
		virtualModule filterName: e ].

	loadedModules at: aName put: virtualModule.
	environment add: virtualModule.
	^ virtualModule
]

{ #category : 'as yet unclassified' }
MLCompilerBootstrapDemo >> runASTTests [

	| sunit asttests astsuite |
	sunit := self importSUnit.
	asttests := self importASTCoreTests.

	"AST tests depend on the compiler tests extensions too!!!!!"
	astsuite := (sunit at: #TestSuite) named: 'ast tests'.
	(asttests classes
		 select: [ :e | e isTestCase ]
		 thenCollect: [ :e | e buildSuite ]) do: [ :subsuite |
		astsuite addTests: subsuite tests ].
	^ astsuite run
]

{ #category : 'as yet unclassified' }
MLCompilerBootstrapDemo >> runCompilerTests [

	| sunit compilerTests compilersuite |
	sunit := self importSUnit.
	compilerTests := self importOpalTests.

	compilersuite := (sunit at: #TestSuite) named: 'compiler tests'.
	(compilerTests classes
		 select: [ :e | e isTestCase ]
		 thenCollect: [ :e | e buildSuite ]) do: [ :subsuite |
		compilersuite addTests: subsuite tests ].
	^ compilersuite run
]
