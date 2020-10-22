%define api.push_pull both
%define lr.keep_unreachable_states maybe
%define namespace "foo"
%define variant
%define parser_class_name {parser}
%define filename_type {filename}
%%
start: %empty;
