#using script_164a456ce05c3483;
#using script_17dcb1172e441bf6;
#using script_1a9763988299e68d;
#using script_1b01e95a6b5270fd;
#using script_1b0b07ff57d1dde3;
#using script_1ee011cd0961afd7;
#using script_2a5bf5b4a00cee0d;
#using script_350cffecd05ef6cf;
#using script_40f967ad5d18ea74;
#using script_47851dbeea22fe66;
#using script_4d748e58ce25b60c;
#using script_5701633066d199f2;
#using script_5f20d3b434d24884;
#using script_74a56359b7d02ab6;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace namespace_dcd37093;

// Namespace namespace_dcd37093/namespace_25c52f74
// Params 0
// Checksum 0x334abb81, Offset: 0x2b8
// Size: 0x48c
function function_d28e9b17()
{
    self notify( #"hash_562d458e34274132" );
    waitframe( 1 );
    self endon( #"hash_1e2c098e8231a30f", #"hash_562d458e34274132" );
    
    if ( isplayer( self ) )
    {
        self endon( #"disconnect" );
    }
    
    org = namespace_ec06fe4a::spawnmodel( self.origin, "tag_origin" );
    
    if ( isdefined( org ) )
    {
        org.targetname = "boxingPickupUpdate";
        org.angles = ( 0, randomint( 180 ), 0 );
        org setmodel( "tag_origin" );
        self.doa.var_c3159deb = org;
    }
    else
    {
        return;
    }
    
    leftglove = namespace_ec06fe4a::spawnmodel( self.origin + ( 0, 60, 32 ), "zombietron_boxing_gloves_lt" );
    
    if ( isdefined( leftglove ) )
    {
        leftglove.targetname = "leftglove";
        leftglove setplayercollision( 0 );
        leftglove linkto( org, "tag_origin", ( 0, 60, 32 ), ( 90, 0, 0 ) );
        trigger = namespace_ec06fe4a::spawntrigger( "trigger_radius", leftglove.origin, 1 | 512 | 8, 40, 50 );
        
        if ( isdefined( trigger ) )
        {
            trigger.targetname = "leftGlove";
            trigger enablelinkto();
            trigger linkto( leftglove );
            trigger thread function_7c757878( self, "MOD_IMPACT", &function_c2d94d61 );
        }
    }
    
    org.var_f9c2f48c = leftglove;
    org.trigger1 = trigger;
    rightglove = namespace_ec06fe4a::spawnmodel( self.origin + ( 0, -60, 32 ), "zombietron_boxing_gloves_rt" );
    
    if ( isdefined( rightglove ) )
    {
        rightglove.targetname = "rightGlove";
        rightglove setplayercollision( 0 );
        rightglove linkto( org, "tag_origin", ( 0, -60, 32 ), ( 90, 0, 0 ) );
        trigger = namespace_ec06fe4a::spawntrigger( "trigger_radius", rightglove.origin, 1 | 512 | 8, 40, 50 );
        
        if ( isdefined( trigger ) )
        {
            trigger.targetname = "rightGlove";
            trigger enablelinkto();
            trigger linkto( rightglove );
            trigger thread function_7c757878( self, "MOD_IMPACT", &function_c2d94d61 );
        }
    }
    
    org.var_b981836 = rightglove;
    org.trigger2 = trigger;
    org linkto( self, "", ( 0, 0, 10 ), ( 0, 0, 0 ) );
    self thread function_61888137( org );
    self thread function_f0855523( org );
    self waittill( #"hash_6733dfa48ff87a81" );
    leftglove setmodel( "zombietron_boxing_gloves_expiring_lt" );
    rightglove setmodel( "zombietron_boxing_gloves_expiring_rt" );
}

// Namespace namespace_dcd37093/namespace_25c52f74
// Params 0
// Checksum 0x8aa274f6, Offset: 0x750
// Size: 0x94
function function_c2d94d61()
{
    self namespace_83eb6304::function_3ecfde67( "boxing_stars" );
    waitresult = self waittilltimeout( 2, #"actor_corpse", #"entitydeleted" );
    
    if ( isdefined( waitresult.corpse ) )
    {
        waitresult.corpse namespace_83eb6304::function_3ecfde67( "boxing_stars" );
    }
}

// Namespace namespace_dcd37093/namespace_25c52f74
// Params 3, eflags: 0x4
// Checksum 0xc70c124d, Offset: 0x7f0
// Size: 0x260
function private function_7c757878( player, mod = "MOD_CRUSH", var_70c63791 )
{
    player endon( #"hash_1e2c098e8231a30f" );
    
    if ( isplayer( player ) )
    {
        player endon( #"disconnect" );
    }
    
    self endon( #"death" );
    
    while ( true )
    {
        result = self waittill( #"trigger" );
        guy = result.activator;
        
        if ( isplayer( guy ) )
        {
            continue;
        }
        
        if ( is_true( guy.boss ) )
        {
            continue;
        }
        
        if ( is_true( guy.knocked_out ) )
        {
            continue;
        }
        
        guy namespace_e32bb68::function_3a59ec34( "evt_doa_pickup_boxers_active_impact" );
        guy namespace_83eb6304::function_3ecfde67( "boxing_pow" );
        
        if ( isdefined( var_70c63791 ) )
        {
            guy thread [[ var_70c63791 ]]();
        }
        
        guy.knocked_out = 1;
        
        if ( !isvehicle( guy ) )
        {
            dir = guy.origin - self.origin;
            guy thread namespace_ec06fe4a::function_5678f0d( dir, 50 );
            guy thread namespace_ec06fe4a::function_570729f0( 0, player, mod );
        }
        else
        {
            self dodamage( guy.health + 1, guy.origin, player, player, "none", mod, 0, getweapon( "none" ) );
        }
        
        player playrumbleonentity( "damage_light" );
    }
}

// Namespace namespace_dcd37093/namespace_25c52f74
// Params 1, eflags: 0x4
// Checksum 0x482d5d8b, Offset: 0xa58
// Size: 0xf6
function private function_61888137( *org )
{
    self endon( #"hash_1e2c098e8231a30f", #"hash_562d458e34274132" );
    
    if ( isplayer( self ) )
    {
        self endon( #"disconnect" );
    }
    
    timeout = self namespace_1c2a96f9::function_4808b985( 30 );
    
    while ( !namespace_dfc652ee::function_f759a457() )
    {
        waitframe( 1 );
    }
    
    wait timeout - 3;
    self notify( #"hash_6733dfa48ff87a81" );
    wait 3;
    self namespace_e32bb68::function_3a59ec34( "evt_doa_pickup_boxers_active_end" );
    self notify( #"hash_1e2c098e8231a30f" );
}

// Namespace namespace_dcd37093/namespace_25c52f74
// Params 1, eflags: 0x4
// Checksum 0x39dc0568, Offset: 0xb58
// Size: 0x324
function private function_f0855523( org )
{
    result = self waittill( #"hash_1e2c098e8231a30f", #"entering_last_stand", #"kill_shield", #"hash_df25520ab279dff", #"hash_562d458e34274132", #"player_died", #"disconnect", #"enter_vehicle", #"death" );
    self notify( #"hash_1e2c098e8231a30f" );
    
    if ( isdefined( org ) && isdefined( org.trigger1 ) )
    {
        org.trigger1 delete();
    }
    
    if ( isdefined( org ) && isdefined( org.trigger2 ) )
    {
        org.trigger2 delete();
    }
    
    if ( isdefined( org ) && isdefined( org.var_f9c2f48c ) )
    {
        org.var_f9c2f48c unlink();
    }
    
    if ( isdefined( org ) && isdefined( org.var_b981836 ) )
    {
        org.var_b981836 unlink();
    }
    
    if ( isdefined( self ) )
    {
        if ( isdefined( org ) && isdefined( org.var_f9c2f48c ) )
        {
            vel = org.var_f9c2f48c.origin - self.origin;
            org.var_f9c2f48c physicslaunch( org.var_f9c2f48c.origin, vel );
        }
        
        if ( isdefined( org ) && isdefined( org.var_b981836 ) )
        {
            vel = org.var_b981836.origin - self.origin;
            org.var_b981836 physicslaunch( org.var_b981836.origin, vel );
        }
        
        self.doa.var_c3159deb = undefined;
    }
    
    wait 5;
    
    if ( isdefined( org ) && isdefined( org.var_f9c2f48c ) )
    {
        org.var_f9c2f48c delete();
    }
    
    if ( isdefined( org ) && isdefined( org.var_b981836 ) )
    {
        org.var_b981836 delete();
    }
    
    if ( isdefined( org ) )
    {
        org delete();
    }
}

