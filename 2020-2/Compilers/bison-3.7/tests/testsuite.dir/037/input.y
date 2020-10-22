%token A "a
%token B "b"
%token AB "ab" // Used to complain that "ab" was already used.
%token C '1
%token TWO "2"
%token TICK_TWELVE "'12" // Used to complain that "'12" was already used.

%%

start: %empty;

// Used to report a syntax error because it didn't see any kind of symbol
// identifier.
%type <f> 'a
;
%type <f> "a
;
// Used to report a syntax error because it didn't see braced code.
%destructor { free ($$)
