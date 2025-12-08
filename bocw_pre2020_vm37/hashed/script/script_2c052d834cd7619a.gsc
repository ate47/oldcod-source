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

#namespace namespace_52ba5a8a;

// Namespace namespace_52ba5a8a/namespace_2c7d0af1
// Params 3
// Checksum 0xaa276ea3, Offset: 0x208
// Size: 0x1b2, Type: bool
function function_124c1a34( player, model, note )
{
    blade = namespace_ec06fe4a::spawnmodel( self.origin, model );
    
    if ( !isdefined( blade ) )
    {
        return false;
    }
    
    blade.targetname = "blade";
    blade setplayercollision( 0 );
    blade enablelinkto();
    blade linkto( self, "tag_origin", ( 0, -70, 0 ) );
    trigger = namespace_ec06fe4a::spawntrigger( "trigger_radius", blade.origin, 1 | 512 | 8, 30, 50 );
    
    if ( !isdefined( trigger ) )
    {
        blade delete();
        return false;
    }
    
    trigger.targetname = "blade";
    trigger enablelinkto();
    trigger linkto( blade );
    trigger thread function_7daf5356( player, note );
    blade namespace_e32bb68::function_3a59ec34( "evt_doa_pickup_sawblade_active_lp" );
    self.blade = blade;
    self.trigger = trigger;
    return true;
}

// Namespace namespace_52ba5a8a/namespace_2c7d0af1
// Params 1
// Checksum 0xbb035199, Offset: 0x3c8
// Size: 0x228
function sawbladeupdate( model = "zombietron_sawblade" )
{
    note = namespace_ec06fe4a::function_7fcca25d( "end_sawblad_pickup" );
    self endon( note );
    waitframe( 1 );
    self endon( #"blades_done" );
    
    if ( isplayer( self ) )
    {
        self endon( #"disconnect" );
    }
    
    if ( !isdefined( self.doa.var_1739bd8e ) )
    {
        self.doa.var_1739bd8e = [];
    }
    
    org = namespace_ec06fe4a::spawnmodel( self.origin, "tag_origin" );
    
    if ( !isdefined( org ) )
    {
        return;
    }
    
    org.targetname = "sawbladeUpdate";
    org.angles = ( 0, randomint( 180 ), 0 );
    org enablelinkto();
    self.doa.var_1739bd8e[ self.doa.var_1739bd8e.size ] = org;
    org linkto( self, "tag_origin", ( 0, 0, 32 ) );
    self thread function_40fc311d( org, note );
    self thread function_20139eee( org, note );
    result = org function_124c1a34( self, model, note );
    
    if ( result == 0 )
    {
        self notify( note );
    }
    
    while ( isdefined( org ) )
    {
        org rotateto( org.angles + ( 0, 180, 0 ), 0.4 );
        wait 0.4;
    }
}

// Namespace namespace_52ba5a8a/namespace_2c7d0af1
// Params 2, eflags: 0x4
// Checksum 0x3c30b092, Offset: 0x5f8
// Size: 0x1d0
function private function_7daf5356( player, endnote )
{
    player endon( endnote );
    
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
        
        guy namespace_e32bb68::function_3a59ec34( "evt_doa_pickup_sawblade_active_impact" );
        
        if ( isactor( guy ) )
        {
            vel = vectorscale( self.origin - player.origin, 0.2 );
            
            if ( !is_true( guy.no_gib ) )
            {
                guy namespace_ed80aead::function_1f275794( vel, player );
                guy thread namespace_ec06fe4a::function_570729f0( 0.5, player );
            }
            else
            {
                guy thread namespace_ec06fe4a::function_570729f0( 0, player );
            }
            
            continue;
        }
        
        guy thread namespace_ec06fe4a::function_570729f0( 0, player );
    }
}

// Namespace namespace_52ba5a8a/namespace_2c7d0af1
// Params 2, eflags: 0x4
// Checksum 0x444a81b7, Offset: 0x7d0
// Size: 0x9e
function private function_40fc311d( *org, endnote )
{
    self endon( endnote );
    
    if ( isplayer( self ) )
    {
        self endon( #"disconnect" );
    }
    
    timeout = self namespace_1c2a96f9::function_4808b985( 40 );
    
    while ( !namespace_dfc652ee::function_f759a457() )
    {
        waitframe( 1 );
    }
    
    wait timeout;
    self notify( endnote );
}

// Namespace namespace_52ba5a8a/namespace_2c7d0af1
// Params 2, eflags: 0x4
// Checksum 0x1e09f36b, Offset: 0x878
// Size: 0x204
function private function_20139eee( org, endnote )
{
    self waittill( endnote, #"player_died", #"kill_shield", #"disconnect", #"death", #"enter_vehicle", #"hash_df25520ab279dff" );
    
    if ( isdefined( self ) )
    {
        self notify( endnote );
    }
    
    util::wait_network_frame();
    
    if ( isdefined( org.trigger ) )
    {
        org.trigger delete();
    }
    
    if ( isdefined( org.blade ) )
    {
        org.blade unlink();
        vel = ( 0, 0, 20 );
        
        if ( isdefined( self ) )
        {
            vel = org.blade.origin - self.origin;
        }
        
        org.blade physicslaunch( org.blade.origin, vel );
        org.blade namespace_e32bb68::function_ae271c0b( "evt_doa_pickup_sawblade_active_lp" );
        org.blade namespace_e32bb68::function_3a59ec34( "evt_doa_pickup_sawblade_lose_blade" );
        wait 5;
        org.blade delete();
    }
    
    if ( isdefined( self ) )
    {
        arrayremovevalue( self.doa.var_1739bd8e, org );
    }
    
    org delete();
}

