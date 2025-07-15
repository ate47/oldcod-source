#using scripts/cp/_oed;
#using scripts/shared/clientfield_shared;
#using scripts/shared/stealth;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;

#namespace stealth_tagging;

// Namespace stealth_tagging
// Params 0
// Checksum 0xe9c07cd6, Offset: 0x148
// Size: 0x2
function init()
{
    
}

// Namespace stealth_tagging
// Params 0
// Checksum 0x50df55b1, Offset: 0x158
// Size: 0x1e, Type: bool
function enabled()
{
    return isdefined( self.stealth ) && isdefined( self.stealth.tagging );
}

// Namespace stealth_tagging
// Params 0
// Checksum 0x45f6e95a, Offset: 0x180
// Size: 0x55, Type: bool
function get_tagged()
{
    return isdefined( self.stealth.tagging.tagged ) && isdefined( self.stealth ) && isdefined( self.stealth.tagging ) && self.stealth.tagging.tagged;
}

// Namespace stealth_tagging
// Params 0
// Checksum 0x1bb2dc3f, Offset: 0x1e0
// Size: 0x475
function tagging_thread()
{
    assert( isplayer( self ) );
    assert( self enabled() );
    self endon( #"disconnect" );
    timeinc = 0.25;
    wait randomfloatrange( 0.05, 1 );
    
    while ( true )
    {
        if ( self playerads() > 0.3 )
        {
            vec_eye_dir = anglestoforward( self getplayerangles() );
            vec_eye_pos = self getplayercamerapos();
            rangesq = self.stealth.tagging.range * self.stealth.tagging.range;
            trace = bullettrace( vec_eye_pos, vec_eye_pos + vec_eye_dir * 32000, 1, self );
            
            foreach ( enemy in level.stealth.enemies[ self.team ] )
            {
                if ( !isdefined( enemy ) || !isalive( enemy ) )
                {
                    continue;
                }
                
                if ( isdefined( enemy.stealth.tagging.tagged ) && ( !enemy enabled() || enemy.stealth.tagging.tagged ) )
                {
                    continue;
                }
                
                if ( !isactor( enemy ) )
                {
                    continue;
                }
                
                enemyentnum = enemy getentitynumber();
                bdirectaiming = isdefined( trace[ "entity" ] ) && trace[ "entity" ] == enemy;
                bbroadaiming = 0;
                
                if ( !bdirectaiming )
                {
                    distsq = distancesquared( enemy.origin, vec_eye_pos );
                    vec_enemy_dir = vectornormalize( enemy.origin + ( 0, 0, 30 ) - vec_eye_pos );
                    
                    if ( distsq < rangesq && vectordot( vec_enemy_dir, vec_eye_dir ) > self.stealth.tagging.tag_fovcos )
                    {
                        bbroadaiming = self tagging_sight_trace( vec_eye_pos, enemy );
                    }
                }
                
                if ( bdirectaiming || bbroadaiming )
                {
                    if ( !isdefined( self.stealth.tagging.tag_times[ enemyentnum ] ) )
                    {
                        self.stealth.tagging.tag_times[ enemyentnum ] = 0;
                    }
                    
                    self.stealth.tagging.tag_times[ enemyentnum ] += 1 / self.stealth.tagging.tag_time * timeinc;
                    
                    if ( self.stealth.tagging.tag_times[ enemyentnum ] >= 1 )
                    {
                        if ( isplayer( self ) )
                        {
                            self playsoundtoplayer( "uin_gadget_fully_charged", self );
                        }
                        
                        enemy thread tagging_set_tagged( 1 );
                    }
                    
                    continue;
                }
                
                if ( isdefined( self.stealth.tagging.tag_times[ enemyentnum ] ) )
                {
                    self.stealth.tagging.tag_times[ enemyentnum ] = undefined;
                }
            }
        }
        
        wait timeinc;
    }
}

// Namespace stealth_tagging
// Params 1
// Checksum 0x1a90f703, Offset: 0x660
// Size: 0xa2
function tagging_set_tagged( tagged )
{
    if ( isalive( self ) )
    {
        self oed::set_force_tmode( tagged );
        
        if ( isdefined( self.stealth ) && isdefined( self.stealth.tagging ) )
        {
            if ( !tagged )
            {
                self.stealth.tagging.tagged = undefined;
            }
            else
            {
                self.stealth.tagging.tagged = tagged;
            }
        }
        
        self clientfield::set( "tagged", tagged );
    }
}

// Namespace stealth_tagging
// Params 2
// Checksum 0x2e037de2, Offset: 0x710
// Size: 0xcc
function tagging_sight_trace( vec_eye_pos, enemy )
{
    result = 0;
    
    if ( isactor( enemy ) )
    {
        if ( !result && sighttracepassed( vec_eye_pos, enemy gettagorigin( "j_head" ), 0, self ) )
        {
            result = 1;
        }
        
        if ( !result && sighttracepassed( vec_eye_pos, enemy gettagorigin( "j_spinelower" ), 0, self ) )
        {
            result = 1;
        }
    }
    
    if ( !result && sighttracepassed( vec_eye_pos, enemy.origin, 0, self ) )
    {
        result = 1;
    }
    
    return result;
}

