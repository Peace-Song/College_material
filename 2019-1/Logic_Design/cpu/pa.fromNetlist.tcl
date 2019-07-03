
# PlanAhead Launch Script for Post-Synthesis pin planning, created by Project Navigator

create_project -name cpu -dir "/home/peacesong/Documents/Workspace/2019-1/Logic_Design/cpu/planAhead_run_1" -part xc3s50antqg144-4
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "/home/peacesong/Documents/Workspace/2019-1/Logic_Design/cpu/tb.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {/home/peacesong/Documents/Workspace/2019-1/Logic_Design/cpu} }
set_param project.pinAheadLayout  yes
set_property target_constrs_file "tb.ucf" [current_fileset -constrset]
add_files [list {tb.ucf}] -fileset [get_property constrset [current_run]]
link_design
