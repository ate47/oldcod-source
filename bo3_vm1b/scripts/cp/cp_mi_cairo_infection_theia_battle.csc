#using scripts/codescripts/struct;
#using scripts/cp/_load;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/util_shared;

#namespace cp_mi_cairo_infection_theia_battle;

// Namespace cp_mi_cairo_infection_theia_battle
// Params 0
// Checksum 0xc7243470, Offset: 0x4e0
// Size: 0x15a
function main()
{
    for ( i = 3; i <= 8 ; i++ )
    {
        str_name = "p7_fxanim_cp_infection_sarah_building_0" + i + "_bundle";
        s_test = struct::get( str_name, "scriptbundlename" );
        
        if ( isdefined( s_test ) )
        {
            level scene::init( str_name );
        }
    }
    
    level thread function_6b2436b8();
    level.var_b4ad2ec5 = [];
    level.var_b4ad2ec5[ "p7_fxanim_cp_infection_sarah_building_03_bundle" ] = &function_9bd322a9;
    level.var_b4ad2ec5[ "p7_fxanim_cp_infection_sarah_building_04_bundle" ] = &function_362b8d1c;
    level.var_b4ad2ec5[ "p7_fxanim_cp_infection_sarah_building_05_bundle" ] = &function_538e886b;
    level.var_b4ad2ec5[ "p7_fxanim_cp_infection_sarah_building_06_bundle" ] = &function_8cb957be;
    level.var_b4ad2ec5[ "p7_fxanim_cp_infection_sarah_building_07_bundle" ] = &function_c22685d5;
    level.var_b4ad2ec5[ "p7_fxanim_cp_infection_sarah_building_08_bundle" ] = &function_1733f8a8;
    init_clientfields();
}

// Namespace cp_mi_cairo_infection_theia_battle
// Params 0
// Checksum 0xbcfb153d, Offset: 0x648
// Size: 0x6f
function function_6b2436b8()
{
    util::waitforallclients();
    
    for ( i = 3; i <= 8 ; i++ )
    {
        for ( localclientnum = 0; localclientnum < level.localplayers.size ; localclientnum++ )
        {
            function_6712dcb2( localclientnum, "m_sarah_building_0" + i, 0 );
        }
    }
}

// Namespace cp_mi_cairo_infection_theia_battle
// Params 0
// Checksum 0xbf1dad43, Offset: 0x6c0
// Size: 0xfa
function init_clientfields()
{
    n_clientbits = getminbitcountfornum( 8 );
    clientfield::register( "world", "building_destruction_callback", 1, n_clientbits, "int", &building_destruction_callback, 0, 0 );
    clientfield::register( "world", "building_end_callback", 1, 1, "int", &building_end_callback, 0, 0 );
    clientfield::register( "world", "vtol_fog_bank", 1, 1, "int", &function_68142842, 0, 0 );
    clientfield::register( "scriptmover", "sarah_tac_mode_disable", 1, 1, "int", &sarah_tac_mode_disable, 0, 0 );
}

// Namespace cp_mi_cairo_infection_theia_battle
// Params 7
// Checksum 0x6cba0fb9, Offset: 0x7c8
// Size: 0x6a
function sarah_tac_mode_disable( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        self tmodesetflag( 9 );
        return;
    }
    
    self tmodeclearflag( 9 );
}

// Namespace cp_mi_cairo_infection_theia_battle
// Params 7
// Checksum 0xb1fe690e, Offset: 0x840
// Size: 0xb2
function building_destruction_callback( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        str_name = "p7_fxanim_cp_infection_sarah_building_0" + newval + "_bundle";
        s_test = struct::get( str_name, "scriptbundlename" );
        
        if ( isdefined( s_test ) )
        {
            level scene::play( str_name );
            function_6712dcb2( localclientnum, "m_sarah_building_0" + newval, 1 );
        }
    }
}

// Namespace cp_mi_cairo_infection_theia_battle
// Params 7
// Checksum 0x3f0f7932, Offset: 0x900
// Size: 0xd1
function building_end_callback( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( !binitialsnap )
    {
        if ( newval )
        {
            for ( i = 3; i <= 8 ; i++ )
            {
                str_name = "p7_fxanim_cp_infection_sarah_building_0" + i + "_bundle";
                s_test = struct::get( str_name, "scriptbundlename" );
                
                if ( isdefined( s_test ) )
                {
                    level scene::add_scene_func( str_name, level.var_b4ad2ec5[ str_name ], "play" );
                    level thread scene::play( str_name );
                }
            }
        }
    }
}

// Namespace cp_mi_cairo_infection_theia_battle
// Params 3
// Checksum 0xb2d40efe, Offset: 0x9e0
// Size: 0x103
function function_6712dcb2( localclientnum, str_targetname, b_show )
{
    if ( !isdefined( b_show ) )
    {
        b_show = 1;
    }
    
    var_5cee1345 = getentarray( localclientnum, str_targetname, "targetname" );
    
    if ( b_show )
    {
        foreach ( model in var_5cee1345 )
        {
            model show();
        }
        
        return;
    }
    
    foreach ( model in var_5cee1345 )
    {
        model hide();
    }
}

// Namespace cp_mi_cairo_infection_theia_battle
// Params 7
// Checksum 0xf07958ef, Offset: 0xaf0
// Size: 0x7a
function function_68142842( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( oldval != newval )
    {
        if ( newval == 1 )
        {
            setworldfogactivebank( localclientnum, 2 );
            return;
        }
        
        setworldfogactivebank( localclientnum, 1 );
    }
}

// Namespace cp_mi_cairo_infection_theia_battle
// Params 1
// Checksum 0xb5452292, Offset: 0xb78
// Size: 0x52
function function_9bd322a9( a_ents )
{
    a_ents[ "sarah_building_03" ] siegecmd( "set_anim", "p7_fxanim_cp_infection_sarah_building_03_sanim", "set_shot", "default", "pause", "goto_end" );
}

// Namespace cp_mi_cairo_infection_theia_battle
// Params 1
// Checksum 0xd479156b, Offset: 0xbd8
// Size: 0x52
function function_362b8d1c( a_ents )
{
    a_ents[ "sarah_building_04" ] siegecmd( "set_anim", "p7_fxanim_cp_infection_sarah_building_04_sanim", "set_shot", "default", "pause", "goto_end" );
}

// Namespace cp_mi_cairo_infection_theia_battle
// Params 1
// Checksum 0x10f2f558, Offset: 0xc38
// Size: 0x52
function function_538e886b( a_ents )
{
    a_ents[ "sarah_building_05" ] siegecmd( "set_anim", "p7_fxanim_cp_infection_sarah_building_05_sanim", "set_shot", "default", "pause", "goto_end" );
}

// Namespace cp_mi_cairo_infection_theia_battle
// Params 1
// Checksum 0x36356029, Offset: 0xc98
// Size: 0x52
function function_8cb957be( a_ents )
{
    a_ents[ "sarah_building_06" ] siegecmd( "set_anim", "p7_fxanim_cp_infection_sarah_building_06_sanim", "set_shot", "default", "pause", "goto_end" );
}

// Namespace cp_mi_cairo_infection_theia_battle
// Params 1
// Checksum 0xc30b43a1, Offset: 0xcf8
// Size: 0x52
function function_c22685d5( a_ents )
{
    a_ents[ "sarah_building_07" ] siegecmd( "set_anim", "p7_fxanim_cp_infection_sarah_building_07_sanim", "set_shot", "default", "pause", "goto_end" );
}

// Namespace cp_mi_cairo_infection_theia_battle
// Params 1
// Checksum 0x6b5f82f6, Offset: 0xd58
// Size: 0x52
function function_1733f8a8( a_ents )
{
    a_ents[ "sarah_building_08" ] siegecmd( "set_anim", "p7_fxanim_cp_infection_sarah_building_08_sanim", "set_shot", "default", "pause", "goto_end" );
}

