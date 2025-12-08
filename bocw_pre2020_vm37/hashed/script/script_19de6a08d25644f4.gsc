#using scripts\core_common\ai\systems\ai_interface;

#namespace namespace_835228b4;

// Namespace namespace_835228b4/namespace_297e5893
// Params 0
// Checksum 0x97b42437, Offset: 0x68
// Size: 0x15c
function function_7304e94b()
{
    ai::registermatchedinterface( #"dog", #"chaseenemyonspawn", 1, array( 1, 0 ) );
    ai::registermatchedinterface( #"dog", #"spacing_near_dist", 120 );
    ai::registermatchedinterface( #"dog", #"spacing_far_dist", 480 );
    ai::registermatchedinterface( #"dog", #"spacing_horz_dist", 144 );
    ai::registermatchedinterface( #"dog", #"spacing_value", 0 );
    ai::registermatchedinterface( #"dog", #"min_run_dist", 700 );
}

