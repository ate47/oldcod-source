#using scripts/codescripts/struct;
#using scripts/cp/cp_mi_zurich_coalescence_util;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/util_shared;

#namespace root_cairo;

// Namespace root_cairo
// Params 0
// Checksum 0xf819d85d, Offset: 0x358
// Size: 0x22
function main()
{
    init_clientfields();
    init_effects();
}

// Namespace root_cairo
// Params 0
// Checksum 0x985e2fb, Offset: 0x388
// Size: 0x72
function init_clientfields()
{
    clientfield::register( "scriptmover", "vtol_spawn_fx", 1, 1, "counter", &function_c969e4b5, 0, 0 );
    clientfield::register( "world", "cairo_client_ents", 1, 1, "int", &function_889c4970, 0, 0 );
}

// Namespace root_cairo
// Params 0
// Checksum 0xd132ea01, Offset: 0x408
// Size: 0x1b
function init_effects()
{
    level._effect[ "vtol_spawn_fx" ] = "explosions/fx_exp_lightning_fold_infection";
}

// Namespace root_cairo
// Params 7
// Checksum 0x77cd380, Offset: 0x430
// Size: 0x2e5
function function_889c4970( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        if ( isdefined( level.var_fdb616fc ) && level.var_fdb616fc )
        {
            return;
        }
        
        level.var_fdb616fc = 1;
        scene::add_scene_func( "p7_fxanim_cp_zurich_cairo_b_collapse_01_bundle", &zurich_util::function_4dd02a03, "init", "cairo_root_client_cleanup" );
        level thread scene::init( "p7_fxanim_cp_zurich_cairo_b_collapse_01_bundle" );
        scene::add_scene_func( "p7_fxanim_cp_zurich_cairo_b_collapse_02_bundle", &zurich_util::function_4dd02a03, "init", "cairo_root_client_cleanup" );
        level thread scene::init( "p7_fxanim_cp_zurich_cairo_b_collapse_02_bundle" );
        scene::add_scene_func( "p7_fxanim_cp_zurich_cairo_b_collapse_03_bundle", &zurich_util::function_4dd02a03, "init", "cairo_root_client_cleanup" );
        level thread scene::init( "p7_fxanim_cp_zurich_cairo_b_collapse_03_bundle" );
        scene::add_scene_func( "p7_fxanim_cp_zurich_cairo_lightpole_bundle", &zurich_util::function_4dd02a03, "init", "cairo_root_client_cleanup" );
        level thread scene::init( "p7_fxanim_cp_zurich_cairo_lightpole_bundle" );
        scene::add_scene_func( "p7_fxanim_cp_zurich_sinkhole_01_bundle", &zurich_util::function_4dd02a03, "init", "cairo_root_client_cleanup" );
        level thread scene::init( "p7_fxanim_cp_zurich_sinkhole_01_bundle" );
        scene::add_scene_func( "p7_fxanim_cp_zurich_sinkhole_02_bundle", &zurich_util::function_4dd02a03, "init", "cairo_root_client_cleanup" );
        level thread scene::init( "p7_fxanim_cp_zurich_sinkhole_02_bundle" );
        var_84828c57 = getentarray( localclientnum, "cairo_client_building", "targetname" );
        array::thread_all( var_84828c57, &function_ea552f44, localclientnum );
        var_c9a3a65d = getentarray( localclientnum, "cairo_client_explode", "targetname" );
        array::thread_all( var_c9a3a65d, &function_9f362d5c, localclientnum );
        return;
    }
    
    level notify( #"cairo_root_client_cleanup" );
    level.var_fdb616fc = undefined;
}

// Namespace root_cairo
// Params 1
// Checksum 0x60115c55, Offset: 0x720
// Size: 0x52
function function_ea552f44( localclientnum )
{
    self waittill( #"trigger" );
    assert( isdefined( self.script_string ), "<dev string:x28>" );
    level thread scene::play( "p7_fxanim_cp_zurich_cairo_" + self.script_string );
}

// Namespace root_cairo
// Params 1
// Checksum 0x6247fddf, Offset: 0x780
// Size: 0x52
function function_9f362d5c( localclientnum )
{
    self waittill( #"trigger" );
    assert( isdefined( self.script_string ), "<dev string:x63>" );
    level thread scene::play( "p7_fxanim_cp_zurich_" + self.script_string );
}

// Namespace root_cairo
// Params 7
// Checksum 0x6d78a6ae, Offset: 0x7e0
// Size: 0x62
function function_c969e4b5( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    playfxontag( localclientnum, level._effect[ "vtol_spawn_fx" ], self, "tag_origin" );
}

