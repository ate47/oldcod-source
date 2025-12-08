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

#namespace namespace_7da86f3c;

// Namespace namespace_7da86f3c/namespace_e7909880
// Params 1
// Checksum 0xd645e00c, Offset: 0x1c0
// Size: 0x232
function function_eeb092f5( player )
{
    self notify( "ae20755c6391d34" );
    self endon( "ae20755c6391d34" );
    
    if ( isplayer( player ) )
    {
        player endon( #"disconnect" );
    }
    else if ( isai( player ) )
    {
        player endon( #"death" );
    }
    
    if ( !isdefined( player.doa.var_c980e593 ) )
    {
        player.doa.var_c980e593 = namespace_ec06fe4a::spawnmodel( player.origin, "tag_origin" );
        
        if ( isdefined( player.doa.var_c980e593 ) )
        {
            level.doa.active_attractors[ level.doa.active_attractors.size ] = player.doa.var_c980e593;
            level thread function_4cf8bbc4( player, player.doa.var_c980e593 );
            player.doa.var_c980e593 enablelinkto();
            player.doa.var_c980e593 linkto( player, "tag_origin", ( 0, 0, 60 ) );
        }
        else
        {
            return;
        }
    }
    
    timeout = player namespace_1c2a96f9::function_4808b985( 25 );
    
    while ( !namespace_dfc652ee::function_f759a457() )
    {
        waitframe( 1 );
    }
    
    level waittilltimeout( timeout, #"game_over" );
    
    if ( isdefined( player ) )
    {
        player notify( #"hash_1c99dfc5992f1a01" );
        player.doa.var_c980e593 = undefined;
    }
}

// Namespace namespace_7da86f3c/namespace_e7909880
// Params 2
// Checksum 0x241a6ad9, Offset: 0x400
// Size: 0x1ac
function function_4cf8bbc4( player, orb )
{
    orb namespace_83eb6304::function_3ecfde67( "magnet_on" );
    orb namespace_e32bb68::function_3a59ec34( "evt_doa_pickup_magnet_active_lp" );
    player waittill( #"entering_last_stand", #"hash_1c99dfc5992f1a01", #"disconnect", #"player_died", #"death" );
    
    if ( isdefined( orb ) )
    {
        orb namespace_83eb6304::turnofffx( "magnet_on" );
        orb namespace_83eb6304::function_3ecfde67( "magnet_fade" );
    }
    
    wait 1;
    
    if ( isdefined( orb ) )
    {
        orb namespace_83eb6304::turnofffx( "magnet_fade" );
        orb namespace_e32bb68::function_ae271c0b( "evt_doa_pickup_magnet_active_lp" );
        orb namespace_e32bb68::function_3a59ec34( "evt_doa_pickup_magnet_active_end" );
    }
    
    util::wait_network_frame();
    orb delete();
    arrayremovevalue( level.doa.active_attractors, undefined );
}

// Namespace namespace_7da86f3c/namespace_e7909880
// Params 0
// Checksum 0x5780cfb4, Offset: 0x5b8
// Size: 0x20e
function function_77af9e81()
{
    type = [[ self.def ]]->gettype();
    
    if ( !function_9ded1b6c( type ) )
    {
        return;
    }
    
    self notify( "6ebf679c30a35b79" );
    self endon( "6ebf679c30a35b79" );
    self endon( #"picked_up" );
    self endon( #"death" );
    self thread function_68126677();
    
    if ( isdefined( self.var_d438ec42 ) )
    {
        self [[ self.var_d438ec42 ]]();
    }
    
    arrayremovevalue( level.doa.active_attractors, undefined );
    
    while ( true )
    {
        self.attractors = [];
        
        if ( isdefined( self.var_d7e0da8b ) )
        {
            self [[ self.var_d7e0da8b ]]();
        }
        
        foreach ( orb in level.doa.active_attractors )
        {
            if ( !isdefined( orb ) )
            {
                continue;
            }
            
            distsq = distancesquared( orb.origin, self.origin );
            
            if ( distsq < getdvarint( #"hash_5f8a3b48d8ebee04", sqr( 400 ) ) )
            {
                self.attractors[ self.attractors.size ] = orb;
            }
        }
        
        waitframe( 1 );
    }
}

// Namespace namespace_7da86f3c/namespace_e7909880
// Params 1
// Checksum 0xf4dbcbad, Offset: 0x7d0
// Size: 0x42, Type: bool
function function_9ded1b6c( type )
{
    if ( type == 1 || type == 9 || type == 8 )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_7da86f3c/namespace_e7909880
// Params 1, eflags: 0x4
// Checksum 0x5dbeb3ec, Offset: 0x820
// Size: 0x3b2
function private function_68126677( var_624b8d02 = getdvarint( #"hash_5f8a3b48d8ebee04", sqr( 400 ) ) )
{
    self notify( #"hash_2d37cb44b7f0c612" );
    self endon( #"hash_2d37cb44b7f0c612" );
    self endon( #"picked_up" );
    self endon( #"death" );
    self.var_76d7c415 = self.origin;
    
    while ( true )
    {
        waitframe( 1 );
        
        if ( self.attractors.size == 0 && is_true( self.var_e48718a6 ) )
        {
            if ( self.origin[ 0 ] != self.var_76d7c415[ 0 ] || self.origin[ 1 ] != self.var_76d7c415[ 1 ] )
            {
                trace = bullettrace( self.origin, self.origin + ( 0, 0, -500 ), 0, undefined );
                self.groundpos = namespace_ec06fe4a::function_65ee50ba( self.origin ) + ( 0, 0, 32 );
                self moveto( self.groundpos, 1 );
                self waittilltimeout( 1.1, #"movedone", #"picked_up", #"hash_2d37cb44b7f0c612", #"death" );
                self.var_76d7c415 = self.origin;
                self.var_e48718a6 = undefined;
            }
            
            continue;
        }
        
        forcemag = isdefined( self.forcemag ) ? self.forcemag : 10;
        
        foreach ( force in self.attractors )
        {
            if ( !isdefined( force ) )
            {
                continue;
            }
            
            distsq = distancesquared( self.origin, force.origin );
            
            if ( distsq > var_624b8d02 )
            {
                continue;
            }
            
            if ( isdefined( force.var_dacf4d3f ) )
            {
                origin = force.origin + force.var_dacf4d3f;
            }
            else
            {
                origin = force.origin;
            }
            
            var_58b1f132 = vectornormalize( origin - self.origin );
            scale = ( var_624b8d02 - distsq ) / var_624b8d02;
            movevec = vectorscale( var_58b1f132, forcemag * scale );
            self.origin += movevec;
            self.var_e48718a6 = 1;
        }
    }
}

