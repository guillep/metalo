visiting
visitMessageNode: aRBMessageNode 
	
	aRBMessageNode isSelfSend ifTrue: [ 
		aRBMessageNode selector: (metaModule internSelfSendSelector: aRBMessageNode selector) ].
	aRBMessageNode receiver acceptVisitor: self.
	aRBMessageNode arguments do: [ :each | each acceptVisitor: self ].