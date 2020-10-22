m4_define([b4_api_PREFIX], [YY])

m4_define([b4_symbol_dump],
[$1, dnl
b4_symbol_if([$1], [is_token], [Token], [Nonterminal]), dnl
b4_symbol([$1], [tag]), dnl
b4_symbol([$1], [id]), dnl
b4_symbol([$1], [code]), dnl
b4_symbol([$1], [type]),
])

b4_output_begin([symbols.csv])
number, class, tag, id, code, type,
b4_symbol_foreach([b4_symbol_dump])dnl
b4_output_end
