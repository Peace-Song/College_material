%output "input.c"
%left 'a'

%%

start: resolved_conflict 'a' reported_conflicts 'a' ;

/* S/R conflict resolved as reduce, so the state with item
 * (resolved_conflict: 'a' . unreachable1) and all it transition successors are
 * unreachable, and the associated production is useless.  */
resolved_conflict:
    'a' unreachable1
  | %prec 'a'
  ;

/* S/R conflict that need not be reported since it is unreachable because of
 * the previous conflict resolution.  Nonterminal unreachable1 and all its
 * productions are useless.  */
unreachable1:
    'a' unreachable2
  |
  ;

/* Likewise for a R/R conflict and nonterminal unreachable2.  */
unreachable2: | ;

/* Make sure remaining S/R and R/R conflicts are still reported correctly even
 * when their states are renumbered due to state removal.  */
reported_conflicts:
    'a'
  | 'a'
  |
  ;

