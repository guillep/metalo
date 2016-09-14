mop
internSelfSendSelector: selector

	^ (privateSelectors like: selector) ifNil: [ selector ]