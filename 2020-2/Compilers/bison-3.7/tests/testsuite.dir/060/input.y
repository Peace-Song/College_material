%type <m4_errprintn(DEAD %type)> exp
%token <m4_errprintn(DEAD %token)> a
%token b
%initial-action
{
  $$;
  $<m4_errprintn(DEAD %initial-action)>$
};
%printer
{
  $$
  $<m4_errprintn(DEAD %printer)>$
} <> <*>;
%lex-param
{
  m4_errprintn(DEAD %lex-param)
};
%parse-param
{
  m4_errprintn(DEAD %parse-param)
};
%%
exp:
  a a[name] b
  {
    $$;
    $1;
    $<m4_errprintn(DEAD action 1)>$
    $<m4_errprintn(DEAD action 2)>1
    $<m4_errprintn(DEAD action 3)>name
    $<m4_errprintn(DEAD action 4)>0
    ;
  };
