#using scripts/codescripts/struct;
#using scripts/shared/audio_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/postfx_shared;
#using scripts/shared/scene_shared;

#namespace cp_mi_cairo_infection_sim_reality_starts;

// Namespace cp_mi_cairo_infection_sim_reality_starts
// Params 0
// Checksum 0x71465994, Offset: 0x3b0
// Size: 0x12
function main()
{
    init_clientfields();
}

// Namespace cp_mi_cairo_infection_sim_reality_starts
// Params 0
// Checksum 0x8514e98a, Offset: 0x3d0
// Size: 0x34a
function init_clientfields()
{
    clientfield::register( "toplayer", "sim_out_of_bound", 1, 1, "counter", &callback_out_of_bound, 0, 0 );
    clientfield::register( "world", "sim_lgt_tree_glow_01", 1, 1, "int", &callback_lgt_tree_glow_01, 0, 0 );
    clientfield::register( "world", "sim_lgt_tree_glow_02", 1, 1, "int", &callback_lgt_tree_glow_02, 0, 0 );
    clientfield::register( "world", "sim_lgt_tree_glow_03", 1, 1, "int", &callback_lgt_tree_glow_03, 0, 0 );
    clientfield::register( "world", "sim_lgt_tree_glow_04", 1, 1, "int", &callback_lgt_tree_glow_04, 0, 0 );
    clientfield::register( "world", "sim_lgt_tree_glow_05", 1, 1, "int", &callback_lgt_tree_glow_05, 0, 0 );
    clientfield::register( "world", "lgt_tree_glow_05_fade_out", 1, 1, "int", &function_c27ea863, 0, 0 );
    clientfield::register( "world", "sim_lgt_tree_glow_all_off", 1, 1, "int", &callback_lgt_tree_glow_all_off, 0, 0 );
    clientfield::register( "toplayer", "pstfx_frost_up", 1, 1, "counter", &callback_pstfx_frost_up, 0, 0 );
    clientfield::register( "toplayer", "pstfx_frost_down", 1, 1, "counter", &callback_pstfx_frost_down, 0, 0 );
    clientfield::register( "toplayer", "pstfx_frost_up_baby", 1, 1, "counter", &callback_pstfx_frost_up_baby, 0, 0 );
    clientfield::register( "toplayer", "pstfx_exit_all", 1, 1, "counter", &function_9d61ff9d, 0, 0 );
    clientfield::register( "scriptmover", "infection_baby_shader", 1, 1, "int", &callback_baby_skin_shader, 0, 0 );
    clientfield::register( "world", "toggle_sim_fog_banks", 1, 1, "int", &callback_toggle_sim_fog_banks, 0, 0 );
    clientfield::register( "world", "break_baby", 1, 1, "int", &callback_break_baby, 0, 0 );
}

// Namespace cp_mi_cairo_infection_sim_reality_starts
// Params 7
// Checksum 0x1970d8cb, Offset: 0x728
// Size: 0x6e
function callback_out_of_bound( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    player = getlocalplayer( localclientnum );
    player postfx::stoppostfxbundle();
    player.pstfx_frost = 0;
}

// Namespace cp_mi_cairo_infection_sim_reality_starts
// Params 7
// Checksum 0x3e68ef49, Offset: 0x7a0
// Size: 0x62
function callback_lgt_tree_glow_01( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( oldval != newval )
    {
        if ( newval == 1 )
        {
            exploder::exploder( "lgt_tree_glow_01" );
        }
    }
}

// Namespace cp_mi_cairo_infection_sim_reality_starts
// Params 7
// Checksum 0x6226a62f, Offset: 0x810
// Size: 0x62
function callback_lgt_tree_glow_02( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( oldval != newval )
    {
        if ( newval == 1 )
        {
            exploder::exploder( "lgt_tree_glow_02" );
        }
    }
}

// Namespace cp_mi_cairo_infection_sim_reality_starts
// Params 7
// Checksum 0x35943017, Offset: 0x880
// Size: 0x62
function callback_lgt_tree_glow_03( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( oldval != newval )
    {
        if ( newval == 1 )
        {
            exploder::exploder( "lgt_tree_glow_03" );
        }
    }
}

// Namespace cp_mi_cairo_infection_sim_reality_starts
// Params 7
// Checksum 0x8e05f5f9, Offset: 0x8f0
// Size: 0x62
function callback_lgt_tree_glow_04( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( oldval != newval )
    {
        if ( newval == 1 )
        {
            exploder::exploder( "lgt_tree_glow_04" );
        }
    }
}

// Namespace cp_mi_cairo_infection_sim_reality_starts
// Params 7
// Checksum 0x9d5326b6, Offset: 0x960
// Size: 0x7a
function callback_lgt_tree_glow_05( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( oldval != newval )
    {
        if ( newval == 1 )
        {
            exploder::exploder( "lgt_tree_glow_05" );
            exploder::exploder( "lgt_tree_glow_05_fade_out" );
        }
    }
}

// Namespace cp_mi_cairo_infection_sim_reality_starts
// Params 7
// Checksum 0xc746dff5, Offset: 0x9e8
// Size: 0x62
function function_c27ea863( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( oldval != newval )
    {
        if ( newval == 1 )
        {
            exploder::stop_exploder( "lgt_tree_glow_05_fade_out" );
        }
    }
}

// Namespace cp_mi_cairo_infection_sim_reality_starts
// Params 7
// Checksum 0xe7096072, Offset: 0xa58
// Size: 0x99
function callback_lgt_tree_glow_all_off( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( oldval != newval )
    {
        if ( newval == 1 )
        {
            for ( i = 1; i <= 5 ; i++ )
            {
                str_exploder_name = "lgt_tree_glow_0" + i;
                exploder::stop_exploder( str_exploder_name );
            }
        }
    }
}

// Namespace cp_mi_cairo_infection_sim_reality_starts
// Params 7
// Checksum 0xe28653e0, Offset: 0xb00
// Size: 0xc2
function callback_pstfx_frost_up( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    player = getlocalplayer( localclientnum );
    
    if ( !isdefined( player.pstfx_frost ) )
    {
        player.pstfx_frost = 0;
    }
    
    if ( player.pstfx_frost == 0 && newval == 1 )
    {
        playsound( 0, "evt_freeze_start", ( 0, 0, 0 ) );
        player.pstfx_frost = 1;
        player postfx::playpostfxbundle( "pstfx_frost_loop" );
    }
}

// Namespace cp_mi_cairo_infection_sim_reality_starts
// Params 7
// Checksum 0x3f6ad617, Offset: 0xbd0
// Size: 0xc2
function callback_pstfx_frost_down( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    player = getlocalplayer( localclientnum );
    
    if ( !isdefined( player.pstfx_frost ) )
    {
        player.pstfx_frost = 0;
    }
    
    if ( player.pstfx_frost == 1 && newval == 1 )
    {
        playsound( 0, "evt_freeze_end", ( 0, 0, 0 ) );
        player.pstfx_frost = 0;
        player thread postfx::exitpostfxbundle();
    }
}

// Namespace cp_mi_cairo_infection_sim_reality_starts
// Params 7
// Checksum 0xcfd8778a, Offset: 0xca0
// Size: 0xaa
function callback_pstfx_frost_up_baby( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    player = getlocalplayer( localclientnum );
    player.pstfx_frost = -1;
    player postfx::playpostfxbundle( "pstfx_baby_frost_up" );
    player postfx::playpostfxbundle( "pstfx_baby_frost_loop" );
    playsound( 0, "evt_freeze_start", ( 0, 0, 0 ) );
}

// Namespace cp_mi_cairo_infection_sim_reality_starts
// Params 7
// Checksum 0xbcd757c0, Offset: 0xd58
// Size: 0x62
function function_9d61ff9d( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    player = getlocalplayer( localclientnum );
    player thread postfx::exitpostfxbundle();
}

// Namespace cp_mi_cairo_infection_sim_reality_starts
// Params 7
// Checksum 0x1da1bfd4, Offset: 0xdc8
// Size: 0x72
function callback_toggle_sim_fog_banks( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    n_bank = 0;
    
    if ( newval == 1 )
    {
        n_bank = 2;
    }
    else
    {
        n_bank = 0;
    }
    
    setworldfogactivebank( localclientnum, n_bank );
}

// Namespace cp_mi_cairo_infection_sim_reality_starts
// Params 7
// Checksum 0xccdee0a9, Offset: 0xe48
// Size: 0x82
function callback_break_baby( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( !binitialsnap && !bnewent )
    {
        if ( newval != oldval && newval == 1 )
        {
            level thread scene::play( "p7_fxanim_cp_infection_baby_bundle" );
            exploder::exploder( "inf_boa_crying" );
        }
    }
}

// Namespace cp_mi_cairo_infection_sim_reality_starts
// Params 7
// Checksum 0x1c15d884, Offset: 0xed8
// Size: 0x165
function callback_baby_skin_shader( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    start_time = gettime();
    anim_time = 15;
    vien_start_time = 2;
    eyeball_start_time = 3;
    updating = 1;
    
    while ( updating )
    {
        time = gettime();
        time_in_seconds = ( time - start_time ) / 1000;
        
        if ( time_in_seconds >= anim_time )
        {
            time_in_seconds = anim_time;
            updating = 0;
        }
        
        n_desaturation = time_in_seconds / 15;
        
        if ( time_in_seconds < vien_start_time )
        {
            n_vein = 0;
        }
        else
        {
            n_vein = 1 - ( 15 - time_in_seconds ) / ( anim_time - vien_start_time );
        }
        
        if ( time_in_seconds < eyeball_start_time )
        {
            n_eyeball = 0;
        }
        else
        {
            n_eyeball = 1 - ( 15 - time_in_seconds ) / ( anim_time - eyeball_start_time );
        }
        
        self mapshaderconstant( 0, 0, "scriptVector1", n_desaturation, n_vein, 0, 0 );
        self mapshaderconstant( 0, 0, "scriptVector0", n_eyeball, 0, 0 );
        wait 0.01;
    }
}

