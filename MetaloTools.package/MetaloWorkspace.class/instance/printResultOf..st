actions
printResultOf: aString 
	
	| value |
	value := self evaluate: aString.
	value inspect.