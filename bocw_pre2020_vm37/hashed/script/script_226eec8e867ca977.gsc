#using script_17dcb1172e441bf6;
#using script_1ee011cd0961afd7;
#using script_2a5bf5b4a00cee0d;
#using script_47851dbeea22fe66;
#using script_634ae70c663d1cc9;
#using script_774302f762d76254;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace namespace_85f9e33a;

// Namespace namespace_85f9e33a/namespace_85f9e33a
// Params 0
// Checksum 0x80f724d1, Offset: 0x328
// Size: 0x4
function init()
{
    
}

// Namespace namespace_85f9e33a/namespace_85f9e33a
// Params 0
// Checksum 0xbe617a58, Offset: 0x338
// Size: 0x16
function main()
{
    level.doa.var_18f8e489 = [];
}

// Namespace namespace_85f9e33a/namespace_85f9e33a
// Params 0
// Checksum 0xcfd43a51, Offset: 0x358
// Size: 0x174
function function_81853592()
{
    self notify( "58b1be112128f168" );
    self endon( "58b1be112128f168" );
    self thread namespace_268747c0::function_978c05b5();
    result = self waittill( #"destroy_hazard" );
    
    if ( is_true( self.var_7c56394 ) && is_true( result.var_760a0807 ) )
    {
        arrayremovevalue( level.doa.var_18f8e489, self );
        namespace_1e25ad94::debugmsg( "Deleting Flogger trap permenently at:" + self.origin );
    }
    
    util::wait_network_frame();
    
    if ( isdefined( self.trigger ) )
    {
        for ( i = 0; i < self.trigger.size ; i++ )
        {
            self.trigger[ i ] namespace_268747c0::function_54f185a();
        }
        
        self.trigger = [];
    }
    
    if ( isdefined( self.script_model ) )
    {
        self.script_model delete();
    }
}

// Namespace namespace_85f9e33a/namespace_85f9e33a
// Params 2
// Checksum 0xa8b04d5f, Offset: 0x4d8
// Size: 0xd8
function function_ecfc6c75( trap, var_7c56394 = 0 )
{
    hazard = namespace_ec06fe4a::spawnmodel( trap.origin, "p8_fxanim_mp_zmuseum_flogger_trap_mod" );
    
    if ( isdefined( hazard ) )
    {
        hazard.targetname = "hazard";
        hazard.var_fd5301f9 = "flogger";
        hazard.angles = trap.angles;
        hazard enablelinkto();
    }
    
    trap.script_model = hazard;
    trap.var_7c56394 = var_7c56394;
    trap.trigger = [];
    trap thread function_80eed528();
    return trap;
}

// Namespace namespace_85f9e33a/namespace_85f9e33a
// Params 2
// Checksum 0x7363f0c6, Offset: 0x5b8
// Size: 0xf4
function function_7fb58446( trap, page = 0 )
{
    if ( page )
    {
        if ( !isdefined( level.doa.var_18f8e489 ) )
        {
            level.doa.var_18f8e489 = [];
        }
        else if ( !isarray( level.doa.var_18f8e489 ) )
        {
            level.doa.var_18f8e489 = array( level.doa.var_18f8e489 );
        }
        
        level.doa.var_18f8e489[ level.doa.var_18f8e489.size ] = trap;
        return;
    }
    
    function_ecfc6c75( trap );
}

// Namespace namespace_85f9e33a/namespace_85f9e33a
// Params 0
// Checksum 0x8923e6e2, Offset: 0x6b8
// Size: 0x334
function function_9d10940b()
{
    self notify( "114d0987241d6ea0" );
    self endon( "114d0987241d6ea0" );
    level endon( #"game_over" );
    
    while ( true )
    {
        wait 0.5;
        state = namespace_4dae815d::function_59a9cf1d();
        
        if ( state == 0 )
        {
            continue;
        }
        
        foreach ( trap in level.doa.var_18f8e489 )
        {
            time = gettime();
            
            if ( isdefined( trap.var_eb9d64bb ) && time < trap.var_eb9d64bb )
            {
                continue;
            }
            
            trap.var_eb9d64bb = time + 2000 + randomint( 600 );
            
            if ( !isdefined( trap.script_model ) )
            {
                activate = 0;
                
                if ( isdefined( trap.var_f8660931 ) )
                {
                    distsq = distancesquared( trap.origin, trap.var_f8660931.origin );
                    
                    if ( distsq < sqr( 3200 ) )
                    {
                        activate = 1;
                    }
                }
                
                if ( !activate )
                {
                    trap.var_f8660931 = namespace_ec06fe4a::function_6eacecf5( trap.origin, 3200 );
                    
                    if ( isdefined( trap.var_f8660931 ) )
                    {
                        activate = 1;
                    }
                    else
                    {
                        trap.var_f8660931 = namespace_ec06fe4a::function_bd3709ce( trap.origin, 1200 );
                        
                        if ( isdefined( trap.var_f8660931 ) )
                        {
                            activate = 1;
                        }
                    }
                }
                
                if ( activate )
                {
                    function_ecfc6c75( trap, 1 );
                    trap.var_eb9d64bb += 5000;
                    namespace_1e25ad94::debugmsg( "Paging IN flogger trap at:" + trap.origin );
                }
                
                continue;
            }
            
            trap.var_f8660931 = namespace_ec06fe4a::function_f3eab80e( trap.origin, 3600 );
            
            if ( !isdefined( trap.var_f8660931 ) )
            {
                trap notify( #"destroy_hazard", { #var_760a0807:0 } );
                namespace_1e25ad94::debugmsg( "Paging out flogger trap at:" + trap.origin );
            }
        }
    }
}

// Namespace namespace_85f9e33a/namespace_85f9e33a
// Params 0
// Checksum 0x1cbdc255, Offset: 0x9f8
// Size: 0x130
function function_a76494d5()
{
    level.doa.var_18f8e489 = [];
    level thread function_9d10940b();
    
    if ( isdefined( level.doa.var_a77e6349 ) )
    {
        traps = [[ level.doa.var_a77e6349 ]]->function_87f950c1( "flogger" );
        page = 1;
    }
    else
    {
        traps = [[ level.doa.var_39e3fa99 ]]->function_242886d5( "flogger" );
    }
    
    foreach ( trap in traps )
    {
        function_7fb58446( trap, page );
    }
}

// Namespace namespace_85f9e33a/namespace_85f9e33a
// Params 0
// Checksum 0xce3d44c4, Offset: 0xb30
// Size: 0x464
function function_80eed528()
{
    self notify( "b52698cb90f171c" );
    self endon( "b52698cb90f171c" );
    level endon( #"game_over" );
    self endon( #"destroy_hazard" );
    self thread function_81853592();
    
    if ( !isdefined( self.script_model ) )
    {
        self notify( #"destroy_hazard" );
    }
    
    self.script_model useanimtree( "generic" );
    self.script_model solid();
    length = getanimlength( #"p8_fxanim_mp_museum_flogger_trap_anim" ) - 0.2;
    
    while ( self.trigger.size < 2 )
    {
        self.trigger[ self.trigger.size ] = self namespace_268747c0::function_678eaf60( "flogger", self.origin, 1024, 1, 1024 );
    }
    
    self.trigger[ 0 ] linkto( self.script_model, "link_p7_zm_shi_flogger_trap_end_log__02", ( -100, 0, 0 ) );
    self.trigger[ 1 ] linkto( self.script_model, "link_p7_zm_shi_flogger_trap_end_log__01", ( -100, 0, 0 ) );
    self.trigger[ 0 ] thread function_ab141bd8( self.script_model, self );
    self.trigger[ 1 ] thread function_ab141bd8( self.script_model, self );
    initial = 1;
    
    while ( self.trigger.size == 2 )
    {
        self.script_model stopanimscripted();
        
        if ( isdefined( self.trigger[ 0 ] ) )
        {
            self.trigger[ 0 ] triggerenable( 0 );
        }
        
        if ( isdefined( self.trigger[ 1 ] ) )
        {
            self.trigger[ 1 ] triggerenable( 0 );
        }
        
        if ( !is_true( initial ) )
        {
            wait randomfloatrange( 7, 11 );
        }
        
        if ( self.trigger.size != 2 )
        {
            continue;
        }
        
        initial = 0;
        loops = randomint( 3 ) + 1;
        self.trigger[ 0 ] triggerenable( 1 );
        self.trigger[ 1 ] triggerenable( 1 );
        
        while ( loops )
        {
            self.script_model namespace_e32bb68::function_3a59ec34( "evt_doa_hazard_flogger_eng_start" );
            self.script_model namespace_e32bb68::function_3a59ec34( "evt_doa_hazard_flogger_eng_loop" );
            self.script_model thread function_b98fe7eb();
            self.script_model namespace_268747c0::play_anim( #"p8_fxanim_mp_museum_flogger_trap_anim", 1 );
            wait length;
            self.script_model namespace_e32bb68::function_ae271c0b( "evt_doa_hazard_flogger_eng_loop" );
            self.script_model namespace_e32bb68::function_3a59ec34( "evt_doa_hazard_flogger_eng_stop" );
            loops--;
        }
    }
    
    self thread function_80eed528();
}

// Namespace namespace_85f9e33a/namespace_85f9e33a
// Params 0
// Checksum 0x242fb2b9, Offset: 0xfa0
// Size: 0x8a
function function_b98fe7eb()
{
    self notify( "3f8a43405cc41991" );
    self endon( "3f8a43405cc41991" );
    self endon( #"death" );
    
    for ( log = 0; true ; log = !log )
    {
        self waittill( #"hash_4460cb197033d052" );
        self namespace_e32bb68::function_3a59ec34( "evt_doa_hazard_flogger_whoosh_" + log );
    }
}

// Namespace namespace_85f9e33a/namespace_85f9e33a
// Params 2
// Checksum 0x7ad3a833, Offset: 0x1038
// Size: 0x328
function function_ab141bd8( model, trap )
{
    self notify( "1d9a1ebe622168df" );
    self endon( "1d9a1ebe622168df" );
    self endon( #"death", #"hash_5dc5b7f198cd1bec" );
    fling_force = 190;
    
    while ( isdefined( self ) )
    {
        result = self waittill( #"trigger" );
        guy = result.activator;
        
        if ( isdefined( guy ) )
        {
            if ( is_true( guy.boss ) )
            {
                continue;
            }
            
            if ( !isdefined( guy.var_62abb118 ) )
            {
                guy.var_62abb118 = 0;
            }
            
            if ( guy.var_62abb118 < gettime() )
            {
                guy.var_62abb118 = gettime() + 1000;
                guy namespace_83eb6304::function_3ecfde67( "pungi_damage" );
                model namespace_e32bb68::function_3a59ec34( "evt_doa_hazard_flogger_impact" );
            }
            
            if ( isplayer( guy ) )
            {
                guy dodamage( isdefined( trap.damage ) ? trap.damage : guy.health + 100, guy.origin );
                guy playrumbleonentity( "damage_heavy" );
                
                if ( isdefined( trap.var_2e485cc ) )
                {
                    guy thread status_effect::status_effect_apply( trap.var_2e485cc, guy.currentweapon, self, 1 );
                }
                
                continue;
            }
            
            if ( !is_true( guy.var_e66cd6fb ) )
            {
                v_centroid = guy getcentroid();
                v_away_from_source = vectornormalize( self.origin - v_centroid );
                v_away_from_source *= 128;
                v_away_from_source = ( v_away_from_source[ 0 ], v_away_from_source[ 1 ], randomintrange( 128, 200 ) );
                guy startragdoll();
                guy launchragdoll( fling_force * anglestoup( guy.angles ) + ( v_away_from_source[ 0 ], v_away_from_source[ 1 ], 0 ) );
            }
            
            guy thread namespace_ec06fe4a::function_570729f0( 0.2 );
        }
    }
}

