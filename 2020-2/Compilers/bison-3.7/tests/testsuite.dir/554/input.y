%code top { /* -*- c -*- */
/* Adjust to the compiler.
  We used to do it here, but each time we add a new line,
  we have to adjust all the line numbers in error messages.
  It's simpler to use a constant include to a varying file.  */
#include <testsuite.h>
}

%code {
  #include <stdio.h>

static void yyerror (const char *msg);
  static int yylex (void);
}

%define lr.type canonical-lr

%token
        HACTIVATE HAFTER /*HAND*/ HARRAY HAT
        HBEFORE HBEGIN HBOOLEAN
        HCHARACTER HCLASS /*HCOMMENT*/ HCONC
        HDELAY HDO
        HELSE HEND HEQ /*HEQV*/ HEXTERNAL
        HFOR
        HGE HGO HGOTO HGT
        HHIDDEN
        HIF /*HIMP*/ HIN HINNER HINSPECT HINTEGER HIS
        HLABEL HLE HLONG HLT
        HNAME HNE HNEW HNONE /*HNOT*/ HNOTEXT
        /*HOR*/ HOTHERWISE
        HPRIOR HPROCEDURE HPROTECTED
        HQUA
        HREACTIVATE HREAL HREF
        HSHORT HSTEP HSWITCH
        HTEXT HTHEN HTHIS HTO
        HUNTIL
        HVALUE HVAR HVIRTUAL
        HWHEN HWHILE

        HASSIGNVALUE HASSIGNREF
        /*HDOT*/ HPAREXPSEPARATOR HLABELSEPARATOR HSTATEMENTSEPARATOR
        HBEGPAR HENDPAR
        HEQR HNER
        HADD HSUB HMUL HDIV HINTDIV HEXP
        HDOTDOTDOT

%token HIDENTIFIER
%token HBOOLEANKONST HINTEGERKONST HCHARACTERKONST
%token HREALKONST
%token HTEXTKONST


%right HASSIGN
%left   HORELSE
%left   HANDTHEN
%left   HEQV
%left   HIMP
%left   HOR
%left   HAND

%left   HNOT

%left HVALRELOPERATOR HREFRELOPERATOR HOBJRELOPERATOR

%left   HCONC

%left HTERMOPERATOR
%left UNEAR
%left HFACTOROPERATOR
%left         HPRIMARYOPERATOR

%left   HQUA

%left   HDOT

%start  MAIN_MODULE


%%


/* GRAMATIKK FOR PROGRAM MODULES */
MAIN_MODULE     :       {}
                        MODULS
                |       error HSTATEMENTSEPARATOR MBEE_DECLSTMS
                ;
EXT_DECLARATION :       HEXTERNAL
                        MBEE_TYPE
                        HPROCEDURE
                                {}
                        EXT_LIST
                |
                        HEXTERNAL
                        HIDENTIFIER
                        HPROCEDURE
                                {}
                        HIDENTIFIER {}
                        EXTERNAL_KIND_ITEM
                |       HEXTERNAL
                        HCLASS
                                {}
                        EXT_LIST

                ;
EXTERNAL_KIND_ITEM:     EXT_IDENT
                        HOBJRELOPERATOR
                                {}
                        MBEE_TYPE HPROCEDURE
                        HIDENTIFIER
                                {}
                        HEADING EMPTY_BLOCK
                                {}
/*              |
                        EXT_IDENT
                                {}
                        MBEE_REST_EXT_LIST
                ;
MBEE_REST_EXT_LIST:     /* EMPTY
                |       HPAREXPSEPARATOR EXT_KIND_LIST
                ;
EXT_KIND_LIST   :       EXT_KIND_ITEM
                |       EXT_KIND_LIST HPAREXPSEPARATOR EXT_KIND_ITEM
                ;
EXT_KIND_ITEM   :       HIDENTIFIER
                        EXT_IDENT
                                {}*/
                ;
EMPTY_BLOCK     :       /*EMPT*/
                |       HBEGIN HEND
                ;
EXT_LIST        :       EXT_ITEM
                |       EXT_LIST HPAREXPSEPARATOR EXT_ITEM
                ;
EXT_ITEM        :       HIDENTIFIER
                        EXT_IDENT
                ;
EXT_IDENT       :       /* EMPTY */
                |       HVALRELOPERATOR {}
                        HTEXTKONST
                ;
/* GRAMATIKK FOR TYPER */
NO_TYPE         :       /*EMPT*/
                ;
MBEE_TYPE       :       NO_TYPE
                |       TYPE
                ;
TYPE            :       HREF HBEGPAR
                        HIDENTIFIER
                                {}
                        HENDPAR
                |       HTEXT
                |       HBOOLEAN
                |       HCHARACTER
                |       HSHORT HINTEGER
                |       HINTEGER
                |       HREAL
                |       HLONG HREAL
                ;

/* GRAMATIKK FOR DEL AV SETNINGER */
MBEE_ELSE_PART  :       /*EMPT*/
/*              |       HELSE
                        HIF
                        EXPRESSION
                        HTHEN   {}
                        BLOCK   {}
                        MBEE_ELSE_PART          {}*/
                |       HELSE   {}
                        BLOCK
                ;
FOR_LIST        :       FOR_LIST_ELEMENT
                |       FOR_LIST_ELEMENT
                        HPAREXPSEPARATOR
                        FOR_LIST
                ;
FOR_LIST_ELEMENT:       EXPRESSION
                        MBEE_F_L_EL_R_PT
                ;
MBEE_F_L_EL_R_PT:       /*EMPT*/
                |       HWHILE
                        EXPRESSION
                |       HSTEP
                        EXPRESSION
                        HUNTIL
                        EXPRESSION
                ;
GOTO            :       HGO
                        HTO
                |       HGOTO
                ;
CONN_STATE_R_PT :       WHEN_CLAUSE_LIST
                |       HDO   {}
                        BLOCK
                ;
WHEN_CLAUSE_LIST:       HWHEN
                        HIDENTIFIER
                        HDO    {}
                        BLOCK
                |       WHEN_CLAUSE_LIST
                        HWHEN
                        HIDENTIFIER
                        HDO    {}
                        BLOCK
                ;
MBEE_OTWI_CLAUS :       /*EMPT*/
                |       HOTHERWISE {}

                        BLOCK
                ;
ACTIVATOR       :       HACTIVATE
                |       HREACTIVATE
                ;
SCHEDULE        :       /*EMPT*/
                |       ATDELAY EXPRESSION      {}
                        PRIOR
                |       BEFOREAFTER             {}
                        EXPRESSION
                ;
ATDELAY         :       HAT
                |       HDELAY
                ;
BEFOREAFTER     :       HBEFORE
                |       HAFTER
                ;
PRIOR           :       /*EMPT*/
                |       HPRIOR
                ;
/* GRAMATIKK FOR SETNINGER OG DEKLARASJONER */
MODULSTATEMENT  :       HWHILE
                        EXPRESSION
                        HDO     {}
                        BLOCK
                |       HIF
                        EXPRESSION
                        HTHEN   {}
                        BLOCK   {}
                        MBEE_ELSE_PART
                |       HFOR
                        HIDENTIFIER
                        HASSIGN {}
                        FOR_LIST
                        HDO     {}
                        BLOCK
                |       GOTO
                        EXPRESSION
                |       HINSPECT
                        EXPRESSION              {}
                        CONN_STATE_R_PT
                                {}
                        MBEE_OTWI_CLAUS
                |       HINNER
                |       HIDENTIFIER
                        HLABELSEPARATOR
                                {}
                        DECLSTATEMENT
                |       EXPRESSION_SIMP
                        HBEGIN
                                {}
                        IMPORT_SPEC_MODULE
                                {}
                        MBEE_DECLSTMS
                        HEND
                |       EXPRESSION_SIMP HBEGIN error HSTATEMENTSEPARATOR
                        MBEE_DECLSTMS HEND
                |       EXPRESSION_SIMP HBEGIN error HEND
                |       EXPRESSION_SIMP
                |       ACTIVATOR EXPRESSION SCHEDULE
                |       HBEGIN
                                {}
                        MBEE_DECLSTMS
                        HEND
                |       MBEE_TYPE HPROCEDURE
                        HIDENTIFIER
                                {}
                        HEADING BLOCK
                |       HIDENTIFIER
                        HCLASS
                        NO_TYPE
                                {}
                        IMPORT_SPEC_MODULE
                        HIDENTIFIER
                                {}
                        HEADING
                        BLOCK
                |       HCLASS
                        NO_TYPE
                        HIDENTIFIER
                                {}
                        HEADING
                        BLOCK
                |       EXT_DECLARATION
                |       /*EMPT*/
                ;
IMPORT_SPEC_MODULE:
                ;
DECLSTATEMENT   :       MODULSTATEMENT
                |       TYPE
                        HIDENTIFIER
                        MBEE_CONSTANT
                        HPAREXPSEPARATOR
                                {}
                        IDENTIFIER_LISTC
                |       TYPE
                        HIDENTIFIER
                        MBEE_CONSTANT
                |       MBEE_TYPE
                        HARRAY  {}
                        ARR_SEGMENT_LIST
                |       HSWITCH
                        HIDENTIFIER
                        HASSIGN {}
                        SWITCH_LIST
                ;
BLOCK           :       DECLSTATEMENT
                |       HBEGIN MBEE_DECLSTMS HEND
                |       HBEGIN error HSTATEMENTSEPARATOR MBEE_DECLSTMS HEND
                |       HBEGIN error HEND
                ;
MBEE_DECLSTMS   :       MBEE_DECLSTMSU
                ;
MBEE_DECLSTMSU  :       DECLSTATEMENT
                |       MBEE_DECLSTMSU
                        HSTATEMENTSEPARATOR
                        DECLSTATEMENT
                ;
MODULS          :       MODULSTATEMENT
                |       MODULS HSTATEMENTSEPARATOR MODULSTATEMENT
                ;
/* GRAMATIKK FOR DEL AV DEKLARASJONER */
ARR_SEGMENT_LIST:       ARR_SEGMENT
                |       ARR_SEGMENT_LIST
                        HPAREXPSEPARATOR
                        ARR_SEGMENT
                ;
ARR_SEGMENT     :       ARRAY_SEGMENT
                        HBEGPAR
                        BAUND_PAIR_LIST HENDPAR
                ;
ARRAY_SEGMENT   :       ARRAY_SEGMENT_EL        {}

                |       ARRAY_SEGMENT_EL
                        HPAREXPSEPARATOR
                        ARRAY_SEGMENT
                ;
ARRAY_SEGMENT_EL:       HIDENTIFIER
                ;
BAUND_PAIR_LIST :       BAUND_PAIR
                |       BAUND_PAIR
                        HPAREXPSEPARATOR
                        BAUND_PAIR_LIST
                ;
BAUND_PAIR      :       EXPRESSION
                        HLABELSEPARATOR
                        EXPRESSION
                ;
SWITCH_LIST     :       EXPRESSION
                |       EXPRESSION
                        HPAREXPSEPARATOR
                        SWITCH_LIST
                ;
HEADING         :       MBEE_FMAL_PAR_P HSTATEMENTSEPARATOR {}
                        MBEE_MODE_PART  {}
                        MBEE_SPEC_PART  {}
                        MBEE_PROT_PART  {}
                        MBEE_VIRT_PART
                ;
MBEE_FMAL_PAR_P :       /*EMPT*/
                |       FMAL_PAR_PART
                ;
FMAL_PAR_PART   :       HBEGPAR NO_TYPE
                        MBEE_LISTV HENDPAR
                ;
MBEE_LISTV      :       /*EMPT*/
                |       LISTV
                ;
LISTV           :       HIDENTIFIER
                |       FPP_CATEG HDOTDOTDOT
                |       HIDENTIFIER     {}
                        HPAREXPSEPARATOR LISTV
                |       FPP_SPEC
                |       FPP_SPEC
                        HPAREXPSEPARATOR LISTV
                ;
FPP_HEADING     :       HBEGPAR NO_TYPE
                        FPP_MBEE_LISTV HENDPAR
                ;
FPP_MBEE_LISTV  :       /*EMPT*/
                |       FPP_LISTV
                ;
FPP_LISTV       :       FPP_CATEG HDOTDOTDOT
                |       FPP_SPEC
                |       FPP_SPEC
                        HPAREXPSEPARATOR LISTV
                ;
FPP_SPEC        :       FPP_CATEG SPECIFIER HIDENTIFIER
                |       FPP_CATEG FPP_PROC_DECL_IN_SPEC
                ;
FPP_CATEG       :       HNAME HLABELSEPARATOR
                |       HVALUE HLABELSEPARATOR
                |       HVAR HLABELSEPARATOR
                |       /*EMPT*/
                ;
FPP_PROC_DECL_IN_SPEC:  MBEE_TYPE HPROCEDURE
                        HIDENTIFIER
                                        {}
                        FPP_HEADING {} { /* Yes, two "final" actions. */ }
                ;
IDENTIFIER_LISTV:       HIDENTIFIER
                |       HDOTDOTDOT
                |       HIDENTIFIER     {}
                        HPAREXPSEPARATOR IDENTIFIER_LISTV
                ;
MBEE_MODE_PART  :       /*EMPT*/
                |       MODE_PART
                ;
MODE_PART       :       NAME_PART
                |       VALUE_PART
                |       VAR_PART
                |       NAME_PART VALUE_PART
                |       VALUE_PART NAME_PART
                |       NAME_PART VAR_PART
                |       VAR_PART NAME_PART
                |       VALUE_PART VAR_PART
                |       VAR_PART VALUE_PART
                |       VAR_PART NAME_PART VALUE_PART
                |       NAME_PART VAR_PART VALUE_PART
                |       NAME_PART VALUE_PART VAR_PART
                |       VAR_PART VALUE_PART NAME_PART
                |       VALUE_PART VAR_PART NAME_PART
                |       VALUE_PART NAME_PART VAR_PART
                ;
NAME_PART       :       HNAME           {}
                        IDENTIFIER_LISTV
                        HSTATEMENTSEPARATOR
                ;
VAR_PART        :       HVAR            {}
                        IDENTIFIER_LISTV
                        HSTATEMENTSEPARATOR
                ;
VALUE_PART      :       HVALUE          {}
                        IDENTIFIER_LISTV HSTATEMENTSEPARATOR
                ;
MBEE_SPEC_PART  :       /*EMPT*/
                |       SPEC_PART
                ;
SPEC_PART       :       ONE_SPEC
                |       SPEC_PART ONE_SPEC
                ;
ONE_SPEC        :       SPECIFIER IDENTIFIER_LIST HSTATEMENTSEPARATOR
                |       NO_TYPE HPROCEDURE HIDENTIFIER HOBJRELOPERATOR
                          {}
                        PROC_DECL_IN_SPEC HSTATEMENTSEPARATOR
                |       FPP_PROC_DECL_IN_SPEC HSTATEMENTSEPARATOR
                |       MBEE_TYPE HPROCEDURE HIDENTIFIER HSTATEMENTSEPARATOR
                |       MBEE_TYPE HPROCEDURE HIDENTIFIER HPAREXPSEPARATOR
                        IDENTIFIER_LIST HSTATEMENTSEPARATOR
                ;
SPECIFIER       :       TYPE
                |       MBEE_TYPE
                        HARRAY
                |       HLABEL
                |       HSWITCH
                ;
PROC_DECL_IN_SPEC:      MBEE_TYPE HPROCEDURE
                        HIDENTIFIER
                                        {}
                        HEADING
                                        {}
                        MBEE_BEGIN_END
                ;
MBEE_BEGIN_END  :       /* EMPTY */
                |       HBEGIN HEND
                ;
MBEE_PROT_PART  :       /*EMPT*/
                |       PROTECTION_PART
                ;
PROTECTION_PART :       PROT_SPECIFIER IDENTIFIER_LIST
                        HSTATEMENTSEPARATOR
                |       PROTECTION_PART  PROT_SPECIFIER
                        IDENTIFIER_LIST HSTATEMENTSEPARATOR
                ;
PROT_SPECIFIER  :       HHIDDEN
                |       HPROTECTED
                |       HHIDDEN
                        HPROTECTED
                |       HPROTECTED
                        HHIDDEN
                ;
MBEE_VIRT_PART  :       /*EMPT*/
                |       VIRTUAL_PART
                ;
VIRTUAL_PART    :       HVIRTUAL
                        HLABELSEPARATOR
                        MBEE_SPEC_PART
                ;
IDENTIFIER_LIST :       HIDENTIFIER
                |       IDENTIFIER_LIST HPAREXPSEPARATOR
                        HIDENTIFIER
                ;
IDENTIFIER_LISTC:       HIDENTIFIER
                        MBEE_CONSTANT
                |       IDENTIFIER_LISTC HPAREXPSEPARATOR
                        HIDENTIFIER
                        MBEE_CONSTANT
                ;
MBEE_CONSTANT   :       /* EMPTY */
                |       HVALRELOPERATOR
                                {}
                        EXPRESSION
                ;

/* GRAMATIKK FOR UTTRYKK */
EXPRESSION      :       EXPRESSION_SIMP
                |       HIF
                        EXPRESSION
                        HTHEN
                        EXPRESSION
                        HELSE
                        EXPRESSION
                ;
EXPRESSION_SIMP :       EXPRESSION_SIMP
                        HASSIGN
                        EXPRESSION
                |

                        EXPRESSION_SIMP
                        HCONC
                        EXPRESSION_SIMP
                |       EXPRESSION_SIMP HOR
                        HELSE
                        EXPRESSION_SIMP
                        %prec HORELSE
                |       EXPRESSION_SIMP HAND
                        HTHEN
                        EXPRESSION_SIMP
                        %prec HANDTHEN
                |       EXPRESSION_SIMP
                        HEQV EXPRESSION_SIMP
                |       EXPRESSION_SIMP
                        HIMP EXPRESSION_SIMP
                |       EXPRESSION_SIMP
                        HOR EXPRESSION_SIMP
                |       EXPRESSION_SIMP
                        HAND EXPRESSION_SIMP
                |       HNOT EXPRESSION_SIMP
                |       EXPRESSION_SIMP
                        HVALRELOPERATOR
                        EXPRESSION_SIMP
                |       EXPRESSION_SIMP
                        HREFRELOPERATOR
                        EXPRESSION_SIMP
                |       EXPRESSION_SIMP
                        HOBJRELOPERATOR
                        EXPRESSION_SIMP
                |       HTERMOPERATOR
                        EXPRESSION_SIMP %prec UNEAR
                |       EXPRESSION_SIMP
                        HTERMOPERATOR
                        EXPRESSION_SIMP
                |       EXPRESSION_SIMP
                        HFACTOROPERATOR
                        EXPRESSION_SIMP
                |       EXPRESSION_SIMP
                        HPRIMARYOPERATOR
                        EXPRESSION_SIMP
                |       HBEGPAR
                        EXPRESSION HENDPAR
                |       HTEXTKONST
                |       HCHARACTERKONST
                |       HREALKONST
                |       HINTEGERKONST
                |       HBOOLEANKONST
                |       HNONE
                |       HIDENTIFIER
                                {}
                        MBEE_ARG_R_PT
                |       HTHIS HIDENTIFIER
                |       HNEW
                        HIDENTIFIER
                        ARG_R_PT
                |       EXPRESSION_SIMP
                        HDOT
                        EXPRESSION_SIMP
                |       EXPRESSION_SIMP
                        HQUA HIDENTIFIER
                ;
ARG_R_PT        :       /*EMPTY*/
                |       HBEGPAR
                        ARGUMENT_LIST HENDPAR
                ;
MBEE_ARG_R_PT   :       /*EMPTY*/
                |       HBEGPAR
                        ARGUMENT_LIST HENDPAR
                ;
ARGUMENT_LIST   :       EXPRESSION
                |       EXPRESSION
                        HPAREXPSEPARATOR
                        ARGUMENT_LIST
                ;


%%




/* A C error reporting function.  */
static
void yyerror (const char *msg)
{
  fprintf (stderr, "%s\n", msg);
}
static int
yylex (void)
{
  static int const input[] = {
    0
  };
  static int const *inputp = input;
  return *inputp++;
}

#include <stdlib.h> /* getenv. */
#include <string.h> /* strcmp. */
int
main (int argc, char const* argv[])
{
  (void) argc;
  (void) argv;
  return yyparse ();
}
