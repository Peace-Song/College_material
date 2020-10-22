%code top { /* -*- c -*- */
/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>
}


%%
stat:
  sym_a sym_b { func($sym.field); }
| sym_a sym_b { func($<aa>sym.field); }
| sym_a sym_b { func($[sym.field]); }
| sym_a sym_b { func($<aa>[sym.field]); }
| sym_a sym_b { func($sym); }
| sym_a sym_b { func($<aa>sym); }
| sym_a sym_b { func($[sym]); } sym_a sym_b { func($<aa>[sym]); }
;

stat1:
  sym_a sym_b { func($sym-field); }
| sym_a sym_b { func($<aa>sym-field); }
| sym_a sym_b { func($[sym-field]); }
| sym_a sym_b { func($<aa>[sym-field]); }
| sym_a sym_b { func($sym); }
| sym_a sym_b { func($<aa>sym); }
| sym_a sym_b { func($[sym]); } sym_a sym_b { func($<aa>[sym]); }
;

sym_a: 'a';
sym_b: 'b';
