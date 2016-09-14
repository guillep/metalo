formatter-compatibility
do: aBlockClosure 
	
	self flag: #possiblebug.
	"This method is called from #formatSelectorAndArguments: which is trying to print the selector into a stream.
	It does a class comparison and since we are not a Symbol instance, it fails!
	Thus, this ends up calling #do:"
	
	^ symbol do: aBlockClosure