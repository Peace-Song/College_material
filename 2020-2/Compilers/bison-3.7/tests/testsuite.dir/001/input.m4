m4_include(b4_skeletonsdir/[c.m4])

b4_output_begin([output.txt])

b4_gsub([[abcd]],
  [a], [b])
b4_gsub([[abcd]],
  [a], [b],
  [b], [c],
  [c], [d])

_b4_comment([["/* () */"]])
_b4_comment([["/* (  */"]])
_b4_comment([["/*  ) */"]])
_b4_comment([["/* [] */"]])

b4_comment([["/* () */"]])
b4_comment([["/* (  */"]])
b4_comment([["/*  ) */"]])
b4_comment([["/* [] */"]])

b4_output_end([output.txt])
