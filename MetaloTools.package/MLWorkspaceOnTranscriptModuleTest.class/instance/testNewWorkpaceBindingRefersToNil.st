running
testNewWorkpaceBindingRefersToNil
	
	self assert: (workspace evaluate: 'ThreadSafeTranscript') name equals: ThreadSafeTranscript name
	