imports
imports
	^ {(#'Tool-DependencyAnalyser' -> #(#DAPackageRelationGraph)).
	(#'Network-Kernel' -> #(#NetworkKernelMetaloManifest #HTTPProgress)).
	(#'AST-Core' -> #(#RBParser)).
	(#Kernel -> #(#Error #Behavior #Object #CompiledMethod #Warning)).
	(#Slot
		->
			#(#AnonymousClassInstaller #GlobalVariable #InstanceVariableSlot #ObjectLayout)).
	(#'Network-Tests' -> #(#NetworkTestsMetaloManifest)).
	(#Metalo -> #(#MLModule)).
	(#'OpalCompiler-Core' -> #(#OpalCompiler)).
	(#'Collections-Strings' -> #(#Symbol)).
	(#'SUnit-Core' -> #(#TestCase)).
	(#'Collections-Unordered' -> #(#Dictionary)).
	(#Transcript -> #(#Transcript)).
	(#'Collections-Sequenceable' -> #(#OrderedCollection)).
	(#'RPackage-Core' -> #(#RPackageOrganizer #RPackage)).
	(#'System-Support' -> #(#SystemNavigation #Smalltalk))}