#using script_164a456ce05c3483;
#using script_17dcb1172e441bf6;
#using script_1a9763988299e68d;
#using script_1b01e95a6b5270fd;
#using script_1b0b07ff57d1dde3;
#using script_1ce46999727f2f2b;
#using script_1ee011cd0961afd7;
#using script_2a5bf5b4a00cee0d;
#using script_40f967ad5d18ea74;
#using script_47851dbeea22fe66;
#using script_4d748e58ce25b60c;
#using script_5701633066d199f2;
#using script_5f20d3b434d24884;
#using script_6b6510e124bad778;
#using script_74a56359b7d02ab6;
#using script_774302f762d76254;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\hud_message_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace namespace_b7d49cfd;

// Namespace namespace_b7d49cfd/namespace_b7d49cfd
// Params 0
// Checksum 0x7bad5bb4, Offset: 0x5c0
// Size: 0x154
function init()
{
    level.doa.var_cb342cbc = &function_258d537d;
    
    if ( !isdefined( level.doa.var_258d537d ) )
    {
        level.doa.var_258d537d = spawnstruct();
        level.doa.var_258d537d.camera = struct::get( "podium_camera" );
        level.doa.var_258d537d.props = struct::get_array( "podium_prop" );
        level.doa.var_258d537d.var_ba1ebafb = struct::get_array( "podium_zombie_spot" );
        level.doa.var_258d537d.var_b969d349 = struct::get_array( "podium_playerpos" );
        assert( level.doa.var_258d537d.var_b969d349.size == 4 );
    }
}

// Namespace namespace_b7d49cfd/namespace_b7d49cfd
// Params 1
// Checksum 0xf1b4e05a, Offset: 0x720
// Size: 0x194
function function_eb32ec24( var_a5cecef6 )
{
    self endon( #"death" );
    wait 1;
    self clientfield::set( "set_name_bubble", 1 );
    wait 2;
    level notify( #"hash_3a5e52bbc39e1c91" );
    self clientfield::set( "set_name_bubble", 0 );
    level waittill( #"hash_72eda4cc72eb05df" );
    self thread namespace_6e90e490::function_47e11416( var_a5cecef6, 2, 1 );
    wait 3;
    self thread namespace_6e90e490::function_47e11416( var_a5cecef6, 2, 1 );
    wait 9;
    self thread namespace_6e90e490::function_47e11416( var_a5cecef6, 2, 1 );
    wait 4;
    level notify( #"gem_drop" );
    self thread namespace_6e90e490::function_47e11416( var_a5cecef6, 2, 1 );
    wait 3;
    self thread namespace_6e90e490::function_47e11416( var_a5cecef6, 2, 1 );
    wait 6;
    self thread namespace_6e90e490::function_47e11416( var_a5cecef6, 2, 1 );
}

// Namespace namespace_b7d49cfd/namespace_b7d49cfd
// Params 1
// Checksum 0xdb034b6e, Offset: 0x8c0
// Size: 0x19c
function function_ae2b7e13( var_a5cecef6 )
{
    self endon( #"death" );
    level waittill( #"hash_3a5e52bbc39e1c91" );
    self clientfield::set( "set_name_bubble", 1 );
    wait 2;
    level notify( #"hash_7d5c782c9416b38d" );
    self clientfield::set( "set_name_bubble", 0 );
    
    if ( level.doa.var_89d17662.size == 2 )
    {
        level notify( #"hash_72eda4cc72eb05df" );
    }
    else
    {
        level waittill( #"hash_72eda4cc72eb05df" );
    }
    
    self thread namespace_6e90e490::function_47e11416( var_a5cecef6, 2, 1 );
    wait 5;
    self thread namespace_6e90e490::function_47e11416( var_a5cecef6, 2, 1 );
    wait 4;
    self thread namespace_6e90e490::function_47e11416( var_a5cecef6, 2, 1 );
    wait 10;
    self thread namespace_6e90e490::function_47e11416( var_a5cecef6, 2, 1 );
    wait 3;
    self thread namespace_6e90e490::function_47e11416( var_a5cecef6, 2, 1 );
}

// Namespace namespace_b7d49cfd/namespace_b7d49cfd
// Params 1
// Checksum 0x8f7e538, Offset: 0xa68
// Size: 0x14c
function function_2a2af1eb( var_a5cecef6 )
{
    self endon( #"death" );
    level waittill( #"hash_7d5c782c9416b38d" );
    self clientfield::set( "set_name_bubble", 1 );
    wait 2;
    level notify( #"hash_2a4a15e11b70b32" );
    self clientfield::set( "set_name_bubble", 0 );
    
    if ( level.doa.var_89d17662.size == 3 )
    {
        level notify( #"hash_72eda4cc72eb05df" );
    }
    else
    {
        level waittill( #"hash_72eda4cc72eb05df" );
    }
    
    self thread namespace_6e90e490::function_47e11416( var_a5cecef6, 2, 1 );
    wait 7;
    self thread namespace_6e90e490::function_47e11416( var_a5cecef6, 2, 1 );
    wait 11;
    self thread namespace_6e90e490::function_47e11416( var_a5cecef6, 2, 1 );
}

// Namespace namespace_b7d49cfd/namespace_b7d49cfd
// Params 1
// Checksum 0x8206c003, Offset: 0xbc0
// Size: 0x174
function function_14456228( var_a5cecef6 )
{
    self endon( #"death" );
    level waittill( #"hash_2a4a15e11b70b32" );
    self clientfield::set( "set_name_bubble", 1 );
    wait 2;
    level notify( #"hash_72eda4cc72eb05df" );
    self clientfield::set( "set_name_bubble", 0 );
    self thread namespace_6e90e490::function_47e11416( var_a5cecef6, 2, 1 );
    wait 4;
    self thread namespace_6e90e490::function_47e11416( var_a5cecef6, 2, 1 );
    wait 6;
    self thread namespace_6e90e490::function_47e11416( var_a5cecef6, 2, 1 );
    wait 5;
    self thread namespace_6e90e490::function_47e11416( var_a5cecef6, 2, 1 );
    wait 3;
    self thread namespace_6e90e490::function_47e11416( var_a5cecef6, 2, 1 );
    wait 8;
    self thread namespace_6e90e490::function_47e11416( var_a5cecef6, 2, 1 );
}

// Namespace namespace_b7d49cfd/namespace_b7d49cfd
// Params 2
// Checksum 0xb6ebc8a8, Offset: 0xd40
// Size: 0x122
function function_4ec353f8( var_a5cecef6, idx )
{
    self endon( #"death" );
    level waittill( #"hash_58caf0ade03043bb" );
    
    switch ( idx )
    {
        case 0:
            self thread function_eb32ec24( var_a5cecef6 );
            break;
        case 1:
            self thread function_ae2b7e13( var_a5cecef6 );
            break;
        case 2:
            self thread function_2a2af1eb( var_a5cecef6 );
            break;
        case 3:
            self thread function_14456228( var_a5cecef6 );
            break;
        default:
            assert( 0 );
            break;
    }
}

// Namespace namespace_b7d49cfd/namespace_b7d49cfd
// Params 1
// Checksum 0xfb285f87, Offset: 0xe70
// Size: 0x1c8
function function_879d4ceb( idx )
{
    self endon( #"death" );
    self.ignoreall = 1;
    self.takedamage = 0;
    self useanimtree( "generic" );
    angles = self.angles;
    origin = self.origin;
    
    switch ( idx )
    {
        case 0:
            myanim = "ch_ram_05_02_block_nrc_vign_cheering_d_loop";
            var_c8b84175 = 43;
            break;
        case 1:
            myanim = "ai_civ_base_cover_stn_pointidle";
            var_c8b84175 = 44;
            break;
        case 2:
            myanim = "ai_civ_base_standidle_officer";
            var_c8b84175 = 45;
            break;
        case 3:
            myanim = "ch_new_06_01_chase_vign_sitting_civs_right_civ01_loop";
            var_c8b84175 = 46;
            break;
    }
    
    self thread function_4ec353f8( var_c8b84175, idx );
    self.myanim = myanim;
    self.var_f9b5545b = getanimlength( myanim );
    
    while ( true )
    {
        self.angles = angles;
        self.origin = origin;
        self thread animation::play( self.myanim );
        wait self.var_f9b5545b;
    }
}

// Namespace namespace_b7d49cfd/namespace_b7d49cfd
// Params 1
// Checksum 0xbc578f9f, Offset: 0x1040
// Size: 0x9c
function function_13281cbd( var_ae2e8e1f )
{
    self endon( #"death" );
    self useanimtree( "generic" );
    self thread function_1e962dea();
    self thread function_d32e5650();
    self thread function_1f6e2084();
    self thread function_6d378d86( var_ae2e8e1f );
}

// Namespace namespace_b7d49cfd/namespace_b7d49cfd
// Params 0
// Checksum 0x93160e0b, Offset: 0x10e8
// Size: 0xe6
function function_1f6e2084()
{
    self endon( #"death" );
    self notify( "6c8ece475fa4920d" );
    self endon( "6c8ece475fa4920d" );
    angles = self.angles;
    origin = self.origin;
    
    while ( true )
    {
        self.angles = angles;
        self.origin = origin;
        idleanim = self.animarray[ randomint( self.animarray.size ) ];
        animlength = getanimlength( idleanim );
        self thread animation::play( idleanim );
        wait animlength;
    }
}

// Namespace namespace_b7d49cfd/namespace_b7d49cfd
// Params 0
// Checksum 0xa08b2e91, Offset: 0x11d8
// Size: 0xee
function function_1e962dea()
{
    self endon( #"death" );
    
    while ( true )
    {
        if ( !isdefined( level.doa.var_e3c3fa5a ) )
        {
            wait randomfloatrange( 0.1, 2 );
            continue;
        }
        
        anim_ang = vectortoangles( level.doa.var_e3c3fa5a.origin - self.origin );
        self rotateto( ( 0, anim_ang[ 1 ], 0 ), randomfloatrange( 0.5, 2 ) );
        self waittill( #"rotatedone" );
    }
}

// Namespace namespace_b7d49cfd/namespace_b7d49cfd
// Params 0
// Checksum 0xe13f8d69, Offset: 0x12d0
// Size: 0x180
function function_d32e5650()
{
    self endon( #"death" );
    var_1159929c = array( "bo3_ai_zombie_attack_v1", "bo3_ai_zombie_attack_v2", "bo3_ai_zombie_attack_v3", "bo3_ai_zombie_attack_v4", "bo3_ai_zombie_attack_v6", "ai_zombie_base_idle_au_v1", "ai_zombie_base_idle_au_v1_high", "ai_zombie_base_au_attack_v1", "ai_zombie_base_au_attack_v2", "ai_zombie_base_au_attack_v3", "ai_zombie_base_au_attack_v4" );
    var_b64682f2 = array( "ai_zombie_doa_cheer_v1", "ai_zombie_doa_cheer_v2", "ai_zombie_doa_cheer_v3" );
    self.animarray = var_1159929c;
    self.var_2cbcf8e2 = "zombie_outro_mood_angry";
    
    while ( true )
    {
        result = level waittill( #"zombie_outro_mood_angry", #"hash_6b71fd0ed387fe82", #"hash_749ca0969fe37f63" );
        self.var_2cbcf8e2 = result._notify;
        
        if ( result._notify == "zombie_outro_mood_angry" )
        {
            self.animarray = var_1159929c;
        }
        else
        {
            self.animarray = var_b64682f2;
        }
        
        self thread function_1f6e2084();
    }
}

// Namespace namespace_b7d49cfd/namespace_b7d49cfd
// Params 1
// Checksum 0xe1bd3470, Offset: 0x1458
// Size: 0x114
function function_6d378d86( var_ae2e8e1f )
{
    self endon( #"death" );
    wait randomfloatrange( 1, 4 );
    
    if ( isdefined( var_ae2e8e1f ) )
    {
        wait var_ae2e8e1f;
    }
    
    while ( true )
    {
        if ( randomint( 100 ) <= 1 )
        {
            switch ( self.var_2cbcf8e2 )
            {
                case #"zombie_outro_mood_angry":
                    var_b6373ec2 = 40;
                    break;
                case #"hash_6b71fd0ed387fe82":
                    var_b6373ec2 = 41;
                    break;
                case #"hash_749ca0969fe37f63":
                    var_b6373ec2 = 42;
                    break;
            }
            
            self thread namespace_6e90e490::function_47e11416( var_b6373ec2, 2 );
            wait 2;
        }
        
        wait 1;
    }
}

// Namespace namespace_b7d49cfd/namespace_b7d49cfd
// Params 0
// Checksum 0x789dc2c1, Offset: 0x1578
// Size: 0x13c
function function_ac2a1e0f()
{
    level endon( #"podiumalldone" );
    level waittill( #"gem_drop" );
    var_b7b96881 = struct::get( "podium_gem_spot" );
    gems = 50;
    
    while ( gems )
    {
        gems--;
        spawner::global_spawn_throttle();
        spot = var_b7b96881.origin + ( randomintrange( -256, 256 ), randomintrange( -256, 256 ), 0 );
        gem = namespace_dfc652ee::function_b8f6a8cd( undefined, spot, 1, 1, randomfloatrange( 0.75, 2.2 ) );
        
        if ( isdefined( gem ) )
        {
            gem notify( #"hash_2a866f50cc161ca8" );
        }
    }
}

// Namespace namespace_b7d49cfd/namespace_b7d49cfd
// Params 0
// Checksum 0x6de48f0a, Offset: 0x16c0
// Size: 0xb34
function function_258d537d()
{
    if ( getplayers().size > 1 )
    {
        namespace_ec06fe4a::function_87612422( level.doa.var_258d537d.camera.origin, level.doa.var_258d537d.camera.angles, 1, 6, 0 );
        level namespace_7f5aeb59::function_67f054d7( 1.5 );
        var_564dda4 = level.lighting_state;
        level clientfield::set( "setTOD", 0 );
        level util::set_lighting_state( 0, 0 );
        level clientfield::set( "banner_event", 0 );
        level.var_7dcdbe16 = 1;
        
        foreach ( player in getplayers() )
        {
            player clientfield::set_to_player( "cutscene", 2 );
            level clientfield::set_world_uimodel( player.doa.score.var_d252ca7f, 0 );
        }
        
        foreach ( prop in level.doa.var_258d537d.props )
        {
            assert( !isdefined( prop.scriptmodel ) );
            prop.scriptmodel = namespace_ec06fe4a::spawnmodel( prop.origin, prop.model, prop.angles, "podium prop" );
            
            if ( isdefined( prop.script_noteworthy ) )
            {
                prop.scriptmodel setscale( float( prop.script_noteworthy ) );
            }
        }
        
        foreach ( guy in level.doa.var_258d537d.var_ba1ebafb )
        {
            assert( !isdefined( guy.scriptmodel ) );
            guy.scriptmodel = namespace_ec06fe4a::spawnmodel( guy.origin, guy.model, guy.angles, "podium crowd" );
            guy.scriptmodel thread function_13281cbd( guy.script_int );
        }
        
        players = function_29309b72();
        winner = players[ 0 ];
        idx = 0;
        level.doa.var_89d17662 = [];
        
        foreach ( spot in level.doa.var_258d537d.var_b969d349 )
        {
            if ( idx >= players.size )
            {
                break;
            }
            
            clone = namespace_ec06fe4a::spawnmodel( spot.origin, "tag_origin", spot.angles, "podium clone body" );
            
            if ( isdefined( clone ) )
            {
                level.doa.var_89d17662[ level.doa.var_89d17662.size ] = clone;
                player = players[ idx ];
                
                if ( player.doa.color == "green" )
                {
                    clone setmodel( "c_t9_cp_usa_hero_adler_infil_vietnam_body" );
                    clone attach( "zombietron_hero_woods_head1", "j_head" );
                }
                
                if ( player.doa.color == "blue" )
                {
                    clone setmodel( "c_t9_usa_pl_deltaforce_infiltration_arms_blue_zombietron" );
                    clone attach( "c_t8_bo_soldier_blue_head_zombietron", "j_head" );
                }
                
                if ( player.doa.color == "red" )
                {
                    clone setmodel( "c_zombietron_fb_red" );
                }
                
                if ( player.doa.color == "yellow" )
                {
                    clone setmodel( "c_zombietron_fb_yellow" );
                }
                
                clone clientfield::set( "setPlayerOwner", player.entnum + 1 );
                clone thread function_879d4ceb( idx );
                idx++;
                spot.var_6c5d23f4 = clone;
            }
        }
        
        level namespace_7f5aeb59::function_836aeb74( 1.5 );
        namespace_4dae815d::function_21cd3890( 3 );
        level thread function_ac2a1e0f();
        level thread function_4dc9990( winner );
        level waittilltimeout( 30, #"podium_abort" );
        namespace_ec06fe4a::function_87612422( [[ level.doa.var_39e3fa99 ]]->function_ffcf1d1() );
        level namespace_7f5aeb59::function_67f054d7( 1.5 );
        
        foreach ( prop in level.doa.var_258d537d.props )
        {
            assert( isdefined( prop.scriptmodel ) );
            prop.scriptmodel delete();
            prop.scriptmodel = undefined;
        }
        
        foreach ( guy in level.doa.var_258d537d.var_ba1ebafb )
        {
            guy.scriptmodel delete();
            guy.scriptmodel = undefined;
        }
        
        foreach ( spot in level.doa.var_258d537d.var_b969d349 )
        {
            if ( isdefined( spot.var_6c5d23f4 ) )
            {
                spot.var_6c5d23f4 delete();
                spot.var_6c5d23f4 = undefined;
            }
        }
        
        level.var_7dcdbe16 = undefined;
        
        foreach ( player in getplayers() )
        {
            player clientfield::set_to_player( "cutscene", 0 );
            player clientfield::increment_to_player( "resetCamera" );
            level clientfield::set_world_uimodel( player.doa.score.var_d252ca7f, 1 );
        }
        
        level clientfield::set( "setTOD", var_564dda4 );
        level util::set_lighting_state( var_564dda4, 0 );
        level notify( #"podiumalldone" );
        namespace_4dae815d::function_21cd3890( 1 );
        level namespace_7f5aeb59::function_836aeb74( 1.5 );
    }
}

// Namespace namespace_b7d49cfd/namespace_b7d49cfd
// Params 1
// Checksum 0xe007a067, Offset: 0x2200
// Size: 0x5c
function function_4dc9990( winner )
{
    level endon( #"podiumalldone" );
    
    while ( true )
    {
        if ( winner usebuttonpressed() )
        {
            level notify( #"podium_abort" );
            return;
        }
        
        waitframe( 1 );
    }
}

// Namespace namespace_b7d49cfd/namespace_b7d49cfd
// Params 0
// Checksum 0x8ac8c043, Offset: 0x2268
// Size: 0xe8
function function_29309b72()
{
    players = namespace_7f5aeb59::function_23e1f90f();
    
    for ( i = 1; i < players.size ; i++ )
    {
        for ( j = i; j > 0 && int( players[ j - 1 ] namespace_eccff4fb::function_5ce79923() ) < int( players[ j ] namespace_eccff4fb::function_5ce79923() ) ; j-- )
        {
            array::swap( players, j, j - 1 );
        }
    }
    
    return players;
}

