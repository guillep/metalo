compilation
binding
	
	^ binding ifNil: [ binding := module name -> module class ]