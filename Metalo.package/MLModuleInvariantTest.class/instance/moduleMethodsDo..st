as yet unclassified
moduleMethodsDo: block
	
	module classes do: [ :class |
		class methods do: block.
		class class methods do: block ]