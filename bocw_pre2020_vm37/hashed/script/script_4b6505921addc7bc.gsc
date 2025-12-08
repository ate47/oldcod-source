#using script_3dc93ca9902a9cda;
#using script_758226507b1afa11;
#using script_86ebb5dd573a003;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\stealth\utility;
#using scripts\core_common\struct;
#using scripts\core_common\teleport_shared;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\skipto;
#using scripts\cp_common\util;

#namespace namespace_c80e7f5f;

// Namespace namespace_c80e7f5f/namespace_c80e7f5f
// Params 0
// Checksum 0x80f724d1, Offset: 0xa40
// Size: 0x4
function init()
{
    
}

// Namespace namespace_c80e7f5f/namespace_c80e7f5f
// Params 0
// Checksum 0x5c6054b7, Offset: 0xa50
// Size: 0x34
function function_9b0b17f9()
{
    self waittill( #"hash_22afaac46a93db1" );
    dialogue::radio( "vox_cp_stkt_02001_park_wejustpassedund_65" );
}

// Namespace namespace_c80e7f5f/namespace_c80e7f5f
// Params 0
// Checksum 0x146275, Offset: 0xa90
// Size: 0xf4
function function_28def7d4()
{
    level flag::wait_till( "flag_park_vo_street" );
    dialogue::radio( "vox_cp_stkt_10100_park_thestasiarestop_01" );
    level thread function_8af8d6fd();
    level flag::wait_till( "flag_inside_lobby" );
    dialogue::radio( "vox_cp_stkt_10500_park_bellifyourespot_12" );
    level flag::wait_till( "flag_tranq_vo" );
    level thread dialogue::radio( "vox_cp_stkt_10500_park_youcantranqthew_6b" );
    wait 2.5;
    level flag::set( "flag_dart_gun_ready" );
}

// Namespace namespace_c80e7f5f/namespace_c80e7f5f
// Params 0
// Checksum 0x815edc5c, Offset: 0xb90
// Size: 0x1d4
function function_8af8d6fd()
{
    level endon( #"lobby_door_opened" );
    var_38d138fb = [];
    var_38d138fb[ var_38d138fb.size ] = "vox_cp_stkt_10100_park_bellyouneedtogo_ba";
    var_38d138fb[ var_38d138fb.size ] = "vox_cp_stkt_10100_park_wedonthavealoto_20";
    var_38d138fb[ var_38d138fb.size ] = "vox_cp_stkt_10100_park_bellwhereareyou_3c";
    e_vol = getent( "vol_apt_street_main_path", "targetname" );
    player = getplayers()[ 0 ];
    
    while ( true )
    {
        if ( player istouchingvolume( e_vol.origin, e_vol getmins(), e_vol getmaxs() ) )
        {
            level notify( #"stop_street_vo_nag" );
            
            while ( player istouchingvolume( e_vol.origin, e_vol getmins(), e_vol getmaxs() ) )
            {
                waitframe( 1 );
            }
            
            continue;
        }
        
        level thread namespace_11998b8f::function_ec76072d( 1, var_38d138fb, 15, "stop_street_vo_nag", "lobby_door_opened" );
        
        while ( !player istouchingvolume( e_vol.origin, e_vol getmins(), e_vol getmaxs() ) )
        {
            waitframe( 1 );
        }
    }
}

// Namespace namespace_c80e7f5f/namespace_c80e7f5f
// Params 0
// Checksum 0xcd34e46, Offset: 0xd70
// Size: 0x3c2
function function_a9c3a1f0()
{
    level endon( #"apt_street_done" );
    level flag::wait_till_any( array( "apt_street_lobby_entry", "flag_inside_lobby" ) );
    
    while ( !isdefined( level.var_17d88287 ) || isdefined( level.var_17d88287 ) && level.var_17d88287.size < 2 )
    {
        waitframe( 1 );
    }
    
    var_e140e85b = undefined;
    var_b0aa872f = undefined;
    male = undefined;
    
    foreach ( guy in level.var_17d88287 )
    {
        if ( guy.script_noteworthy === "lobby_police_01" )
        {
            var_e140e85b = guy;
        }
        
        if ( guy.script_noteworthy === "lobby_police_02" )
        {
            var_b0aa872f = guy;
        }
    }
    
    foreach ( guy in level.var_41aba0f0 )
    {
        if ( guy.script_noteworthy === "lobby_civ_male" )
        {
            male = guy;
        }
    }
    
    party = [];
    party[ party.size ] = [ "mgc1", male ];
    party[ party.size ] = [ "sts2", var_b0aa872f ];
    convo = [];
    convo[ convo.size ] = "vox_cp_stkt_10600_gmc1_theywereamerica_d9";
    convo[ convo.size ] = 0.25;
    convo[ convo.size ] = "vox_cp_stkt_10600_gms2_whatisthemansna_e7";
    convo[ convo.size ] = 0.15;
    convo[ convo.size ] = "vox_cp_stkt_10600_gmc1_wolfgangbeckerh_a8";
    convo[ convo.size ] = 0.25;
    convo[ convo.size ] = "vox_cp_stkt_10600_gms2_howdoyouknowhim_1a";
    convo[ convo.size ] = 0.15;
    convo[ convo.size ] = "vox_cp_stkt_10600_gmc1_idontwerejustli_bd";
    convo[ convo.size ] = 0.25;
    convo[ convo.size ] = "vox_cp_stkt_10600_gms2_whatdoeshedofor_0f";
    convo[ convo.size ] = 0.15;
    convo[ convo.size ] = "vox_cp_stkt_10600_gmc1_hesaprofessorof_ce";
    convo[ convo.size ] = 3;
    level waittill( #"hash_771e5ca058e26261" );
    level waittill( #"apt_street_done" );
    wait 3;
    var_99d73dab = undefined;
}

// Namespace namespace_c80e7f5f/namespace_c80e7f5f
// Params 0
// Checksum 0xa3d13b48, Offset: 0x1140
// Size: 0x5c
function function_a1d5baeb()
{
    level flag::wait_till( "flag_apt_near_front_door" );
    dialogue::radio( "vox_cp_stkt_10500_park_imabouttophonek_a0" );
    wait 0.75;
    level thread namespace_5ceacc03::function_81b3f069();
}

// Namespace namespace_c80e7f5f/namespace_c80e7f5f
// Params 0
// Checksum 0x843c5e03, Offset: 0x11a8
// Size: 0x1c
function function_84378e8a()
{
    dialogue::radio( "vox_cp_stkt_11050_park_niceworknowfind_16" );
}

// Namespace namespace_c80e7f5f/namespace_c80e7f5f
// Params 0
// Checksum 0x4eeba69a, Offset: 0x11d0
// Size: 0x84
function function_ba5c6b95()
{
    level flag::wait_till( "flag_wife_is_darted" );
    wait 5;
    level flag::set( "flag_wife_darted_vo" );
    dialogue::radio( "vox_cp_stkt_11375_park_shellbeoutforho_6b" );
    level flag::set( "flag_wife_darted_vo_done" );
}

// Namespace namespace_c80e7f5f/namespace_c80e7f5f
// Params 0
// Checksum 0xd30f140c, Offset: 0x1260
// Size: 0xa4
function function_e1af55d1()
{
    level waittill( #"hash_341edafabf8168e4" );
    vol = getent( "apt_downstairs_bedroom_vol", "targetname" );
    
    if ( getplayers()[ 0 ] istouching( vol ) )
    {
        dialogue::radio( "vox_cp_stkt_11210_park_krausiscomingge_cd" );
    }
    
    wait 0.5;
    dialogue::radio( "vox_cp_stkt_11210_park_ifkrausseesyout_d7" );
}

// Namespace namespace_c80e7f5f/namespace_c80e7f5f
// Params 0
// Checksum 0x19fb7862, Offset: 0x1310
// Size: 0x4c
function function_c60ce98d()
{
    level endon( #"apartment_explosive_placed" );
    level flag::wait_till( "flag_player_near_lower_bedroom" );
    dialogue::radio( "vox_cp_stkt_11250_park_bellkrausisinth_47" );
}

// Namespace namespace_c80e7f5f/namespace_c80e7f5f
// Params 0
// Checksum 0xaa9917b4, Offset: 0x1368
// Size: 0x1cc
function function_74581093()
{
    self endon( #"death" );
    level endon( #"flag_wife_is_darted", #"flag_edda_umbrella" );
    
    if ( level flag::get( "flag_wife_is_darted" ) || level flag::get( "flag_edda_umbrella" ) )
    {
        return;
    }
    
    if ( is_true( self.spotted ) )
    {
        return;
    }
    
    level waittill( #"phone_picked_up" );
    wait 0.4;
    self.nofacialfiller = 1;
    self dialogue::queue( "vox_cp_stkt_11075_edda_hello_33" );
    wait 1.5;
    self dialogue::queue( "vox_cp_stkt_11075_edda_imsorrytheresno_52" );
    wait 1.75;
    self dialogue::queue( "vox_cp_stkt_11075_edda_wellyesthatsmyn_36" );
    wait 2.25;
    self dialogue::queue( "vox_cp_stkt_11075_edda_lookimcertainyo_81" );
    wait 1.75;
    self dialogue::queue( "vox_cp_stkt_11075_edda_ofcourseitsnopr_1b" );
    wait 1.25;
    self dialogue::queue( "vox_cp_stkt_11075_edda_andagoodevening_89" );
    self.nofacialfiller = undefined;
    level flag::set( "flag_apt_wife_phone_call_done" );
}

// Namespace namespace_c80e7f5f/namespace_c80e7f5f
// Params 0
// Checksum 0x751780cc, Offset: 0x1540
// Size: 0x24
function function_b2659110()
{
    self dialogue::queue( "vox_cp_stkt_11200_edda_yesfranzitsrigh_5e" );
}

// Namespace namespace_c80e7f5f/namespace_c80e7f5f
// Params 0
// Checksum 0x37a076f0, Offset: 0x1570
// Size: 0xac
function function_74866b7c()
{
    level endon( #"flag_kraus_spotted_player" );
    wait 4;
    level.child dialogue::queue( "vox_cp_stkt_11200_will_mamaicantfindmy_c8" );
    
    if ( !flag::get( "flag_wife_is_darted" ) )
    {
        wait 1;
        level.var_3559e9e dialogue::queue( "vox_cp_stkt_11200_edda_illbeupinafewmi_50" );
    }
    
    wait 1;
    dialogue::radio( "vox_cp_stkt_11200_park_shitwemissedthe_4c" );
}

// Namespace namespace_c80e7f5f/namespace_c80e7f5f
// Params 0
// Checksum 0x66b69dfb, Offset: 0x1628
// Size: 0x24
function function_d2ae6f8d()
{
    wait 2.5;
    dialogue::radio( "vox_cp_stkt_11200_park_watchitkrausisc_7b" );
}

// Namespace namespace_c80e7f5f/namespace_c80e7f5f
// Params 0
// Checksum 0x2be1604a, Offset: 0x1658
// Size: 0x24
function function_952d90b5()
{
    wait 3;
    self dialogue::queue( "vox_cp_stkt_11225_krus_shouldhaveknown_88" );
}

// Namespace namespace_c80e7f5f/namespace_c80e7f5f
// Params 0
// Checksum 0x5c8414f6, Offset: 0x1688
// Size: 0x24
function function_ed37b989()
{
    wait 3;
    self dialogue::queue( "vox_cp_stkt_11225_krus_eddahmmm_84" );
}

// Namespace namespace_c80e7f5f/namespace_c80e7f5f
// Params 0
// Checksum 0x80f724d1, Offset: 0x16b8
// Size: 0x4
function function_6589b125()
{
    
}

// Namespace namespace_c80e7f5f/namespace_c80e7f5f
// Params 0
// Checksum 0xbcc2b05, Offset: 0x16c8
// Size: 0xf4
function function_96de90a7()
{
    level endon( #"flag_briefcase_found" );
    dialogue::radio( "vox_cp_stkt_11500_park_ivelostsightofk_ec" );
    level flag::set( "flag_give_blacklight" );
    wait 6;
    dialogue::radio( "vox_cp_stkt_11500_park_krausisfinishin_74" );
    wait 6;
    dialogue::radio( "vox_cp_stkt_11500_park_yourerunningout_c6" );
    wait 6;
    dialogue::radio( "vox_cp_stkt_11500_park_kraushasleftthe_fe" );
    wait 6;
    
    if ( isalive( level.child ) )
    {
        level.child dialogue::queue( "vox_cp_stkt_11500_will_dadisthatyou_be" );
    }
}

// Namespace namespace_c80e7f5f/namespace_c80e7f5f
// Params 0
// Checksum 0x8445fce, Offset: 0x17c8
// Size: 0xac
function function_4b72e85()
{
    level flag::wait_till( "flag_briefcase_found" );
    wait 1.5;
    dialogue::radio( "vox_cp_stkt_11500_park_ivelostyourvisu_d2" );
    level waittill( #"hash_6a03e5dcd38585c8" );
    dialogue::radio( "vox_cp_stkt_11500_park_bellhaveyoufoun_8c" );
    level flag::wait_till( "flag_close_briefcase" );
    dialogue::radio( "vox_cp_stkt_11500_park_understoodjustp_4d" );
}

// Namespace namespace_c80e7f5f/namespace_c80e7f5f
// Params 4
// Checksum 0x55c980c8, Offset: 0x1880
// Size: 0x474
function function_f29bdbdf( party, convo, islooping = 0, levelnotify )
{
    assert( isarray( party ), "<dev string:x38>" );
    assert( isarray( convo ), "<dev string:x67>" );
    level endon( #"hash_c09417d2f88858b" );
    
    if ( isstring( levelnotify ) )
    {
        level endon( levelnotify );
    }
    
    foreach ( member in party )
    {
        assert( isentity( member[ 1 ] ), "<dev string:x96>" );
        member[ 1 ] endon( #"hash_17ed2687a4e410ba" );
    }
    
    while ( islooping )
    {
        foreach ( vo in convo )
        {
            if ( isfloat( vo ) || isint( vo ) )
            {
                wait vo;
                continue;
            }
            
            assert( isstring( vo ), "<dev string:xca>" );
            
            if ( !soundexists( vo ) )
            {
                /#
                    text = "<dev string:xfa>" + vo + "<dev string:x11e>";
                    iprintlnbold( text );
                    println( text );
                #/
                
                continue;
            }
            
            talker = undefined;
            
            foreach ( member in party )
            {
                assert( isarray( member ) && member.size == 2, "<dev string:x123>" );
                var_3c49e075 = member[ 0 ];
                var_1ed8f16a = member[ 1 ];
                assert( isstring( var_3c49e075 ), "<dev string:x14b>" );
                assert( isentity( var_1ed8f16a ), "<dev string:x96>" );
                
                if ( issubstr( vo, var_3c49e075 ) )
                {
                    talker = var_1ed8f16a;
                }
            }
            
            if ( isdefined( talker ) && isalive( talker ) )
            {
                talker dialogue::queue( vo );
            }
        }
    }
}

