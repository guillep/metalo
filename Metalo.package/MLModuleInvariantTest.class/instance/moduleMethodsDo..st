running
moduleMethodsDo: block
	
	networkModule classes do: [ :class |
		class methods do: block.
		class class methods do: block ]