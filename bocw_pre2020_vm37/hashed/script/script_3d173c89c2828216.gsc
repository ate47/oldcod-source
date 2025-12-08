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

#namespace namespace_5f74ac47;

// Namespace namespace_5f74ac47/namespace_5bb43837
// Params 0
// Checksum 0xd9eb361f, Offset: 0x260
// Size: 0x174
function function_f44fbe7c()
{
    if ( !isdefined( self.doa.var_121de807 ) )
    {
        self.doa.var_121de807 = namespace_ec06fe4a::spawntrigger( "trigger_radius", self.origin, 1 | 512 | 8, 130, 50 );
        
        if ( isdefined( self.doa.var_121de807 ) )
        {
            self.doa.var_121de807.targetname = "stunBear";
            self.doa.var_121de807 enablelinkto();
            self.doa.var_121de807 linkto( self );
            self.doa.var_121de807 thread function_510ce803( self );
            self namespace_e32bb68::function_3a59ec34( "evt_doa_pickup_teddybear_active_lp" );
            self namespace_83eb6304::function_3ecfde67( "stunbear" );
        }
    }
    
    self thread function_6a9ffef0();
    self thread function_7343529d( self.doa.var_121de807 );
}

// Namespace namespace_5f74ac47/namespace_5bb43837
// Params 0, eflags: 0x4
// Checksum 0x6665fb17, Offset: 0x3e0
// Size: 0x8c
function private function_79cb4037()
{
    self notify( "4772f0b9037b019e" );
    self endon( "4772f0b9037b019e" );
    self endon( #"death" );
    self.doa.stunned = 1;
    self namespace_83eb6304::function_3ecfde67( "stunbear_affected" );
    wait 20;
    self.doa.stunned = 0;
    self namespace_83eb6304::turnofffx( "stunbear_affected" );
}

// Namespace namespace_5f74ac47/namespace_5bb43837
// Params 1, eflags: 0x4
// Checksum 0xa96553cc, Offset: 0x478
// Size: 0x1a8
function private function_510ce803( player )
{
    self notify( "136e5185ad2742c2" );
    self endon( "136e5185ad2742c2" );
    player endon( #"hash_26b5087b9dec0906" );
    
    if ( isplayer( player ) )
    {
        player endon( #"disconnect" );
    }
    
    self endon( #"death" );
    
    while ( true )
    {
        result = self waittill( #"trigger" );
        guy = result.activator;
        
        if ( !isdefined( guy ) || !isdefined( guy.doa ) )
        {
            continue;
        }
        
        if ( is_true( guy.var_bbdaef90 ) )
        {
            continue;
        }
        
        if ( is_true( guy.boss ) )
        {
            continue;
        }
        
        if ( guy.doa.stunned === 0 )
        {
            guy namespace_e32bb68::function_3a59ec34( "evt_doa_pickup_teddybear_repulse" );
            guy namespace_83eb6304::function_3ecfde67( "stunbear_contact" );
            player playrumbleonentity( "slide_rumble" );
            guy thread function_79cb4037();
        }
    }
}

// Namespace namespace_5f74ac47/namespace_5bb43837
// Params 0, eflags: 0x4
// Checksum 0xcd5c846c, Offset: 0x628
// Size: 0xd6
function private function_6a9ffef0()
{
    self notify( "5307d3ab3474ed7a" );
    self endon( "5307d3ab3474ed7a" );
    self endon( #"hash_26b5087b9dec0906" );
    
    if ( isplayer( self ) )
    {
        self endon( #"disconnect" );
    }
    
    timeout = self namespace_1c2a96f9::function_4808b985( 20 );
    self waittilltimeout( timeout, #"entering_last_stand", #"doa_exit_taken", #"player_died", #"death" );
    self notify( #"hash_26b5087b9dec0906" );
}

// Namespace namespace_5f74ac47/namespace_5bb43837
// Params 1, eflags: 0x4
// Checksum 0x1e3cf831, Offset: 0x708
// Size: 0x16c
function private function_7343529d( trigger )
{
    self notify( "25c35a49521632a7" );
    self endon( "25c35a49521632a7" );
    self waittill( #"hash_26b5087b9dec0906", #"disconnect", #"doa_exit_taken" );
    
    if ( isdefined( self ) )
    {
        self notify( #"hash_26b5087b9dec0906" );
        self namespace_83eb6304::turnofffx( "stunbear" );
        self namespace_83eb6304::function_3ecfde67( "stunbear_fade" );
        self stoploopsound( 2 );
    }
    
    wait 0.5;
    util::wait_network_frame();
    
    if ( isdefined( self ) )
    {
        self namespace_e32bb68::function_ae271c0b( "evt_doa_pickup_teddybear_active_lp" );
        self namespace_e32bb68::function_3a59ec34( "evt_doa_pickup_teddybear_active_end" );
        self namespace_83eb6304::turnofffx( "stunbear_fade" );
    }
    
    if ( isdefined( trigger ) )
    {
        trigger delete();
    }
}

