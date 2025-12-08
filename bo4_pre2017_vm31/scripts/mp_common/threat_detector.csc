#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/duplicaterender_mgr;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/weapons/decoy;
#using scripts/core_common/weapons/weaponobjects;

#namespace threat_detector;

// Namespace threat_detector/threat_detector
// Params 0, eflags: 0x2
// Checksum 0x88030b2a, Offset: 0x228
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "threat_detector", &__init__, undefined, undefined );
}

// Namespace threat_detector/threat_detector
// Params 0
// Checksum 0x1eecc599, Offset: 0x268
// Size: 0x6c
function __init__()
{
    level.sensorhandle = 1;
    level.sensors = [];
    clientfield::register( "missile", "threat_detector", 1, 1, "int", &spawnedthreatdetector, 0, 0 );
}

// Namespace threat_detector/threat_detector
// Params 7
// Checksum 0x397774a6, Offset: 0x2e0
// Size: 0x20c
function spawnedthreatdetector( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval != 1 )
    {
        return;
    }
    
    if ( getlocalplayer( localclientnum ) != self.owner )
    {
        return;
    }
    
    sensorindex = level.sensors.size;
    level.sensorhandle++;
    level.sensors[ sensorindex ] = spawnstruct();
    level.sensors[ sensorindex ].handle = level.sensorhandle;
    level.sensors[ sensorindex ].cent = self;
    level.sensors[ sensorindex ].team = self.team;
    level.sensors[ sensorindex ].owner = self getowner( localclientnum );
    level.sensors[ sensorindex ].owner addsensorgrenadearea( self.origin, level.sensorhandle );
    self.owner thread sensorgrenadethink( self, level.sensorhandle, localclientnum );
    self.owner thread clearthreatdetectorondelete( self, level.sensorhandle, localclientnum );
}

// Namespace threat_detector/threat_detector
// Params 3
// Checksum 0x6f45b980, Offset: 0x4f8
// Size: 0x21c
function sensorgrenadethink( sensorent, sensorhandle, localclientnum )
{
    sensorent endon( #"death" );
    
    if ( isdefined( sensorent.owner ) == 0 )
    {
        return;
    }
    
    while ( true )
    {
        players = getplayers( localclientnum );
        
        foreach ( player in players )
        {
            if ( self util::isenemyplayer( player ) )
            {
                if ( player hasperk( localclientnum, "specialty_nomotionsensor" ) || player hasperk( localclientnum, "specialty_sengrenjammer" ) )
                {
                    player duplicate_render::set_player_threat_detected( localclientnum, 0 );
                    continue;
                }
                
                threatdetectorradius = getdvarfloat( "cg_threatDetectorRadius", 0 );
                threatdetectorradiussqrd = threatdetectorradius * threatdetectorradius;
                
                if ( distancesquared( player.origin, sensorent.origin ) < threatdetectorradiussqrd )
                {
                    player duplicate_render::set_player_threat_detected( localclientnum, 1 );
                    continue;
                }
                
                player duplicate_render::set_player_threat_detected( localclientnum, 0 );
            }
        }
        
        wait 1;
    }
}

// Namespace threat_detector/threat_detector
// Params 3
// Checksum 0x68326a0a, Offset: 0x720
// Size: 0x1ba
function clearthreatdetectorondelete( sensorent, sensorhandle, localclientnum )
{
    sensorent waittill( "death" );
    entindex = 0;
    
    for ( i = 0; i < level.sensors.size ; i++ )
    {
        size = level.sensors.size;
        
        if ( sensorhandle == level.sensors[ i ].handle )
        {
            level.sensors[ i ].owner removesensorgrenadearea( sensorhandle );
            entindex = 0;
            break;
        }
    }
    
    players = getplayers( localclientnum );
    
    foreach ( player in players )
    {
        if ( self util::isenemyplayer( player ) )
        {
            player duplicate_render::set_player_threat_detected( localclientnum, 0 );
        }
    }
}

