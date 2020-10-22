m4_define([foow], [b4_warn([[foow fubar]])])
m4_define([foowat], [b4_warn_at([[foow.y:2.3]],
                                    [[foow.y:5.4]], [[foowat fubar]])])
m4_define([fooc], [b4_complain([[fooc fubar]])])
m4_define([foocat], [b4_complain_at([[fooc.y:1.1]],
                                        [[fooc.y:10.6]], [[foocat fubar]])])
m4_define([foof], [b4_fatal([[foof fubar]])])
m4_if(foow, [1], [yes])
m4_if(foowat, [1], [yes])
m4_if(fooc, [1], [yes])
m4_if(foocat, [1], [yes])
m4_if(foof, [1], [yes])
