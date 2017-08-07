binding
bindTo: aNameResolver
	
	self imports do: [ :each | each resolveUsing: aNameResolver ]