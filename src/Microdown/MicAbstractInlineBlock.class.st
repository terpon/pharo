"
I am an inline block generated by inline splitter, to parse inline text.

I am characterized by:
- start & end: locations of my opener & closer delimiters in initial string
- substring: concerned text (without delimiters so)
- kind: my type, symbol which must be the same than my relative delimiter type (#basic for normal text)
- children: array in case of nested inline blocks


"
Class {
	#name : #MicAbstractInlineBlock,
	#superclass : #Object,
	#instVars : [
		'start',
		'end',
		'kind',
		'children',
		'substring'
	],
	#category : #'Microdown-ModelInline'
}

{ #category : #constructor }
MicAbstractInlineBlock class >> from: aStartInteger to: anEndInteger withKind: aKind withSubstring: aString [
	^ self new 
		start: aStartInteger; 
		end: anEndInteger; 
		kind: aKind; 
		substring: aString; 
		children: Array empty; 
		cleanSubstring; yourself.	
]

{ #category : #constructor }
MicAbstractInlineBlock class >> from: aStartInteger to: anEndInteger withKind: aKind withSubstring: aString withChildren: aChildren [
	^ self new 
		start: aStartInteger; 
		end: anEndInteger; 
		kind: aKind; 
		substring: aString; 
		children: aChildren; 
		cleanSubstring; yourself.	
]

{ #category : #testing }
MicAbstractInlineBlock class >> isEvaluated [
	^ true
]

{ #category : #accessing }
MicAbstractInlineBlock >> children [
	^ children
]

{ #category : #accessing }
MicAbstractInlineBlock >> children: anArray [
	children := anArray
]

{ #category : #printing }
MicAbstractInlineBlock >> childrenPrintOn [
	^ (children asString allButFirst: 9) allButLast
]

{ #category : #operations }
MicAbstractInlineBlock >> cleanSubstring [
	self isOnlyChild ifTrue: [ 
		self substring: ( String streamContents: [:s | 
			(self substring splitOn: self escapeCharacter)
				doWithIndex: [:each :i | 
					(each isEmpty and: i>1) ifTrue: [ s << self escapeCharacter ] ifFalse: [ s << each ] ] ] ) ]
]

{ #category : #accessing }
MicAbstractInlineBlock >> end [
	^ end
]

{ #category : #accessing }
MicAbstractInlineBlock >> end: anInteger [
	end := anInteger
]

{ #category : #operations }
MicAbstractInlineBlock >> escapeCharacter [
	^ MicEscapeDelimiter markup
]

{ #category : #testing }
MicAbstractInlineBlock >> isOnlyChild [
	^ children isEmpty
]

{ #category : #accessing }
MicAbstractInlineBlock >> kind [
	^ kind
]

{ #category : #accessing }
MicAbstractInlineBlock >> kind: aKind [
	kind := aKind
]

{ #category : #accessing }
MicAbstractInlineBlock >> literal [
	^ substring copyFrom: start to: end. 
]

{ #category : #printing }
MicAbstractInlineBlock >> printOn: aStream [
	(self kind == #basic) 
		ifTrue: [ aStream nextPutAll: self substring ] 
		ifFalse: [ 
			| contents |
			contents := children 
				ifEmpty: [ self substring ] 
				ifNotEmpty: [ self childrenPrintOn ].
			aStream nextPut: $[;
				nextPutAll: contents;
				nextPut: $];
				nextPut: $(;
				nextPutAll: self kind;
				nextPut: $) 
		]
			
]

{ #category : #accessing }
MicAbstractInlineBlock >> start [ 	
	^ start
]

{ #category : #accessing }
MicAbstractInlineBlock >> start: anInteger [
	start := anInteger 
]

{ #category : #obsolete }
MicAbstractInlineBlock >> substring [
	^ substring
]

{ #category : #obsolete }
MicAbstractInlineBlock >> substring: aSubString [
	substring := aSubString
]
