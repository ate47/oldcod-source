#using scripts/core_common/abilities/ability_util;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/filter_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace perks;

// Namespace perks/perks
// Params 0, eflags: 0x2
// Checksum 0xec57dab6, Offset: 0x5e8
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "perks", &__init__, undefined, undefined );
}

// Namespace perks/perks
// Params 0
// Checksum 0x1e746d68, Offset: 0x628
// Size: 0x354
function __init__()
{
    clientfield::register( "allplayers", "flying", 1, 1, "int", &flying_callback, 0, 1 );
    callback::on_localclient_connect( &on_local_client_connect );
    callback::on_localplayer_spawned( &on_localplayer_spawned );
    callback::on_spawned( &on_player_spawned );
    level.killtrackerfxenable = 1;
    level._monitor_tracker = &monitor_tracker_perk;
    level.sitrepscan1_enable = getdvarint( "scr_sitrepscan1_enable", 2 );
    level.sitrepscan1_setoutline = getdvarint( "scr_sitrepscan1_setoutline", 1 );
    level.sitrepscan1_setsolid = getdvarint( "scr_sitrepscan1_setsolid", 1 );
    level.sitrepscan1_setlinewidth = getdvarint( "scr_sitrepscan1_setlinewidth", 1 );
    level.sitrepscan1_setradius = getdvarint( "scr_sitrepscan1_setradius", 50000 );
    level.sitrepscan1_setfalloff = getdvarfloat( "scr_sitrepscan1_setfalloff", 0.01 );
    level.sitrepscan1_setdesat = getdvarfloat( "scr_sitrepscan1_setdesat", 0.4 );
    level.sitrepscan2_enable = getdvarint( "scr_sitrepscan2_enable", 2 );
    level.sitrepscan2_setoutline = getdvarint( "scr_sitrepscan2_setoutline", 10 );
    level.sitrepscan2_setsolid = getdvarint( "scr_sitrepscan2_setsolid", 0 );
    level.sitrepscan2_setlinewidth = getdvarint( "scr_sitrepscan2_setlinewidth", 1 );
    level.sitrepscan2_setradius = getdvarint( "scr_sitrepscan2_setradius", 50000 );
    level.sitrepscan2_setfalloff = getdvarfloat( "scr_sitrepscan2_setfalloff", 0.01 );
    level.sitrepscan2_setdesat = getdvarfloat( "scr_sitrepscan2_setdesat", 0.4 );
    
    /#
        level thread updatedvars();
    #/
}

// Namespace perks/perks
// Params 0
// Checksum 0x5a92e9fe, Offset: 0x988
// Size: 0x220
function updatesitrepscan()
{
    self endon( #"death" );
    
    while ( true )
    {
        self oed_sitrepscan_enable( level.sitrepscan1_enable );
        self oed_sitrepscan_setoutline( level.sitrepscan1_setoutline );
        self oed_sitrepscan_setsolid( level.sitrepscan1_setsolid );
        self oed_sitrepscan_setlinewidth( level.sitrepscan1_setlinewidth );
        self oed_sitrepscan_setradius( level.sitrepscan1_setradius );
        self oed_sitrepscan_setfalloff( level.sitrepscan1_setfalloff );
        self oed_sitrepscan_setdesat( level.sitrepscan1_setdesat );
        self oed_sitrepscan_enable( level.sitrepscan2_enable, 1 );
        self oed_sitrepscan_setoutline( level.sitrepscan2_setoutline, 1 );
        self oed_sitrepscan_setsolid( level.sitrepscan2_setsolid, 1 );
        self oed_sitrepscan_setlinewidth( level.sitrepscan2_setlinewidth, 1 );
        self oed_sitrepscan_setradius( level.sitrepscan2_setradius, 1 );
        self oed_sitrepscan_setfalloff( level.sitrepscan2_setfalloff, 1 );
        self oed_sitrepscan_setdesat( level.sitrepscan2_setdesat, 1 );
        wait 1;
    }
}

/#

    // Namespace perks/perks
    // Params 0
    // Checksum 0x1c86869, Offset: 0xbb0
    // Size: 0x2ec, Type: dev
    function updatedvars()
    {
        while ( true )
        {
            level.sitrepscan1_enable = getdvarint( "scr_sitrepscan1_enable", level.sitrepscan1_enable );
            level.sitrepscan1_setoutline = getdvarint( "scr_sitrepscan1_setoutline", level.sitrepscan1_setoutline );
            level.sitrepscan1_setsolid = getdvarint( "scr_sitrepscan1_setsolid", level.sitrepscan1_setsolid );
            level.sitrepscan1_setlinewidth = getdvarint( "scr_sitrepscan1_setlinewidth", level.sitrepscan1_setlinewidth );
            level.sitrepscan1_setradius = getdvarint( "scr_sitrepscan1_setradius", level.sitrepscan1_setradius );
            level.sitrepscan1_setfalloff = getdvarfloat( "scr_sitrepscan1_setfalloff", level.sitrepscan1_setfalloff );
            level.sitrepscan1_setdesat = getdvarfloat( "scr_sitrepscan1_setdesat", level.sitrepscan1_setdesat );
            level.sitrepscan2_enable = getdvarint( "scr_sitrepscan2_enable", level.sitrepscan2_enable );
            level.sitrepscan2_setoutline = getdvarint( "scr_sitrepscan2_setoutline", level.sitrepscan2_setoutline );
            level.sitrepscan2_setsolid = getdvarint( "scr_sitrepscan2_setsolid", level.sitrepscan2_setsolid );
            level.sitrepscan2_setlinewidth = getdvarint( "scr_sitrepscan2_setlinewidth", level.sitrepscan2_setlinewidth );
            level.sitrepscan2_setradius = getdvarint( "scr_sitrepscan2_setradius", level.sitrepscan2_setradius );
            level.sitrepscan2_setfalloff = getdvarfloat( "scr_sitrepscan2_setfalloff", level.sitrepscan2_setfalloff );
            level.sitrepscan2_setdesat = getdvarfloat( "scr_sitrepscan2_setdesat", level.sitrepscan2_setdesat );
            level.friendlycontentoutlines = getdvarint( "friendlyContentOutlines", level.friendlycontentoutlines );
            wait 1;
        }
    }

#/

// Namespace perks/perks
// Params 7
// Checksum 0x9c1e4a47, Offset: 0xea8
// Size: 0x4c
function flying_callback( local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    self.flying = newval;
}

// Namespace perks/perks
// Params 1
// Checksum 0x286f9f8f, Offset: 0xf00
// Size: 0x10c
function on_local_client_connect( local_client_num )
{
    registerrewindfx( local_client_num, "player/fx_plyr_footstep_tracker_l" );
    registerrewindfx( local_client_num, "player/fx_plyr_footstep_tracker_r" );
    registerrewindfx( local_client_num, "player/fx_plyr_flying_tracker_l" );
    registerrewindfx( local_client_num, "player/fx_plyr_flying_tracker_r" );
    registerrewindfx( local_client_num, "player/fx_plyr_footstep_tracker_lf" );
    registerrewindfx( local_client_num, "player/fx_plyr_footstep_tracker_rf" );
    registerrewindfx( local_client_num, "player/fx_plyr_flying_tracker_lf" );
    registerrewindfx( local_client_num, "player/fx_plyr_flying_tracker_rf" );
}

// Namespace perks/perks
// Params 1
// Checksum 0xa25c389b, Offset: 0x1018
// Size: 0x74
function on_localplayer_spawned( local_client_num )
{
    if ( self != getlocalplayer( local_client_num ) )
    {
        return;
    }
    
    self thread monitor_tracker_perk_killcam( local_client_num );
    self thread monitor_detectnearbyenemies( local_client_num );
    self thread monitor_tracker_existing_players( local_client_num );
}

// Namespace perks/perks
// Params 1
// Checksum 0x8f2ac938, Offset: 0x1098
// Size: 0x94
function on_player_spawned( local_client_num )
{
    /#
        self thread watch_perks_change( local_client_num );
    #/
    
    self notify( #"perks_changed" );
    self thread updatesitrepscan();
    
    /#
        self thread updatesitrepscan();
    #/
    
    self thread killtrackerfx_on_death( local_client_num );
    self thread monitor_tracker_perk( local_client_num );
}

/#

    // Namespace perks/perks
    // Params 2
    // Checksum 0x49d573cf, Offset: 0x1138
    // Size: 0xc2, Type: dev
    function array_equal( &a, &b )
    {
        if ( isdefined( a ) && isdefined( b ) && isarray( a ) && isarray( b ) && a.size == b.size )
        {
            for ( i = 0; i < a.size ; i++ )
            {
                if ( !( a[ i ] === b[ i ] ) )
                {
                    return 0;
                }
            }
            
            return 1;
        }
        
        return 0;
    }

    // Namespace perks/perks
    // Params 1
    // Checksum 0xb19fb2ea, Offset: 0x1208
    // Size: 0xd4, Type: dev
    function watch_perks_change( local_client_num )
    {
        self notify( #"watch_perks_change" );
        self endon( #"watch_perks_change" );
        self endon( #"death" );
        self endon( #"disconnect" );
        self.last_perks = self getperks( local_client_num );
        
        while ( isdefined( self ) )
        {
            perks = self getperks( local_client_num );
            
            if ( !array_equal( perks, self.last_perks ) )
            {
                self.last_perks = perks;
                self notify( #"perks_changed" );
            }
            
            wait 1;
        }
    }

#/

// Namespace perks/perks
// Params 1
// Checksum 0x2b7d06cc, Offset: 0x12e8
// Size: 0xea
function get_players( local_client_num )
{
    players = [];
    entities = getentarray( local_client_num );
    
    if ( isdefined( entities ) )
    {
        foreach ( ent in entities )
        {
            if ( ent isplayer() )
            {
                players[ players.size ] = ent;
            }
        }
    }
    
    return players;
}

// Namespace perks/perks
// Params 1
// Checksum 0x4f86e989, Offset: 0x13e0
// Size: 0x100
function monitor_tracker_existing_players( local_client_num )
{
    self endon( #"death" );
    self endon( #"monitor_tracker_existing_players" );
    self notify( #"monitor_tracker_existing_players" );
    players = getplayers( local_client_num );
    
    foreach ( player in players )
    {
        if ( isdefined( player ) && player != self )
        {
            player thread monitor_tracker_perk( local_client_num );
        }
        
        waitframe( 1 );
    }
}

// Namespace perks/perks
// Params 1
// Checksum 0xe8632d96, Offset: 0x14e8
// Size: 0x2c0
function monitor_tracker_perk_killcam( local_client_num )
{
    self notify( "monitor_tracker_perk_killcam" + local_client_num );
    self endon( "monitor_tracker_perk_killcam" + local_client_num );
    self endon( #"death" );
    predictedlocalplayer = getlocalplayer( local_client_num );
    
    if ( !isdefined( level.trackerspecialtyself ) )
    {
        level.trackerspecialtyself = [];
        level.trackerspecialtycounter = 0;
    }
    
    if ( !isdefined( level.trackerspecialtyself[ local_client_num ] ) )
    {
        level.trackerspecialtyself[ local_client_num ] = [];
    }
    
    if ( predictedlocalplayer getinkillcam( local_client_num ) )
    {
        nonpredictedlocalplayer = getnonpredictedlocalplayer( local_client_num );
        
        if ( predictedlocalplayer hasperk( local_client_num, "specialty_tracker" ) )
        {
            servertime = getservertime( local_client_num );
            
            for ( count = 0; count < level.trackerspecialtyself[ local_client_num ].size ; count++ )
            {
                if ( level.trackerspecialtyself[ local_client_num ][ count ].time < servertime && level.trackerspecialtyself[ local_client_num ][ count ].time > servertime - 5000 )
                {
                    positionandrotationstruct = level.trackerspecialtyself[ local_client_num ][ count ];
                    tracker_playfx( local_client_num, positionandrotationstruct );
                }
            }
        }
        
        return;
    }
    
    for ( ;; )
    {
        waitframe( 1 );
        positionandrotationstruct = self gettrackerfxposition( local_client_num );
        
        if ( isdefined( positionandrotationstruct ) )
        {
            positionandrotationstruct.time = getservertime( local_client_num );
            level.trackerspecialtyself[ local_client_num ][ level.trackerspecialtycounter ] = positionandrotationstruct;
            level.trackerspecialtycounter++;
            
            if ( level.trackerspecialtycounter > 20 )
            {
                level.trackerspecialtycounter = 0;
            }
        }
    }
}

// Namespace perks/perks
// Params 1
// Checksum 0x44136403, Offset: 0x17b0
// Size: 0x238
function monitor_tracker_perk( local_client_num )
{
    self notify( #"monitor_tracker_perk" );
    self endon( #"monitor_tracker_perk" );
    self endon( #"death" );
    self endon( #"disconnect" );
    self.flying = 0;
    self.tracker_flying = 0;
    self.tracker_last_pos = self.origin;
    offset = ( 0, 0, getdvarfloat( "perk_tracker_fx_foot_height", 0 ) );
    dist2 = 1024;
    
    while ( isdefined( self ) )
    {
        waitframe( 1 );
        watcher = getlocalplayer( local_client_num );
        
        if ( !isdefined( watcher ) || self == watcher )
        {
            return;
        }
        
        if ( isdefined( watcher ) && watcher hasperk( local_client_num, "specialty_tracker" ) )
        {
            friend = self isfriendly( local_client_num, 1 );
            camooff = 1;
            
            if ( !isdefined( self._isclone ) || !self._isclone )
            {
                camo_val = self clientfield::get( "camo_shader" );
                
                if ( camo_val != 0 )
                {
                    camooff = 0;
                }
            }
            
            if ( !friend && isalive( self ) && camooff )
            {
                positionandrotationstruct = self gettrackerfxposition( local_client_num );
                
                if ( isdefined( positionandrotationstruct ) )
                {
                    self tracker_playfx( local_client_num, positionandrotationstruct );
                }
                
                continue;
            }
            
            self.tracker_flying = 0;
        }
    }
}

// Namespace perks/perks
// Params 2
// Checksum 0xf9694f0e, Offset: 0x19f0
// Size: 0x84
function tracker_playfx( local_client_num, positionandrotationstruct )
{
    handle = playfx( local_client_num, positionandrotationstruct.fx, positionandrotationstruct.pos, positionandrotationstruct.fwd, positionandrotationstruct.up );
    self killtrackerfx_track( local_client_num, handle );
}

// Namespace perks/perks
// Params 2
// Checksum 0x400bd076, Offset: 0x1a80
// Size: 0x108
function killtrackerfx_track( local_client_num, handle )
{
    if ( handle && isdefined( self.killtrackerfx ) )
    {
        servertime = getservertime( local_client_num );
        killfxstruct = spawnstruct();
        killfxstruct.time = servertime;
        killfxstruct.handle = handle;
        index = self.killtrackerfx.index;
        
        if ( index >= 40 )
        {
            index = 0;
        }
        
        self.killtrackerfx.array[ index ] = killfxstruct;
        self.killtrackerfx.index = index + 1;
    }
}

// Namespace perks/perks
// Params 1
// Checksum 0xb2a218a5, Offset: 0x1b90
// Size: 0x214
function killtrackerfx_on_death( local_client_num )
{
    self endon( #"disconnect" );
    
    if ( !( isdefined( level.killtrackerfxenable ) && level.killtrackerfxenable ) )
    {
        return;
    }
    
    predictedlocalplayer = getlocalplayer( local_client_num );
    
    if ( predictedlocalplayer == self )
    {
        return;
    }
    
    if ( isdefined( self.killtrackerfx ) )
    {
        self.killtrackerfx.array = [];
        self.killtrackerfx.index = 0;
        self.killtrackerfx = undefined;
    }
    
    killtrackerfx = spawnstruct();
    killtrackerfx.array = [];
    killtrackerfx.index = 0;
    self.killtrackerfx = killtrackerfx;
    self waittill( "death" );
    servertime = getservertime( local_client_num );
    
    foreach ( killfxstruct in killtrackerfx.array )
    {
        if ( isdefined( killfxstruct ) && killfxstruct.time + 5000 > servertime )
        {
            killfx( local_client_num, killfxstruct.handle );
        }
    }
    
    killtrackerfx.array = [];
    killtrackerfx.index = 0;
    killtrackerfx = undefined;
}

// Namespace perks/perks
// Params 1
// Checksum 0xd5fe9f9e, Offset: 0x1db0
// Size: 0x4d0
function gettrackerfxposition( local_client_num )
{
    positionandrotation = undefined;
    player = self;
    
    if ( isdefined( self._isclone ) && self._isclone )
    {
        player = self.owner;
    }
    
    playfastfx = player hasperk( local_client_num, "specialty_trackerjammer" );
    
    if ( isdefined( self.flying ) && self.flying )
    {
        offset = ( 0, 0, getdvarfloat( "perk_tracker_fx_fly_height", 0 ) );
        dist2 = 1024;
        
        if ( isdefined( self.trailrightfoot ) && self.trailrightfoot )
        {
            if ( playfastfx )
            {
                fx = "player/fx_plyr_flying_tracker_rf";
            }
            else
            {
                fx = "player/fx_plyr_flying_tracker_r";
            }
        }
        else if ( playfastfx )
        {
            fx = "player/fx_plyr_flying_tracker_lf";
        }
        else
        {
            fx = "player/fx_plyr_flying_tracker_l";
        }
    }
    else
    {
        offset = ( 0, 0, getdvarfloat( "perk_tracker_fx_foot_height", 0 ) );
        dist2 = 1024;
        
        if ( isdefined( self.trailrightfoot ) && self.trailrightfoot )
        {
            if ( playfastfx )
            {
                fx = "player/fx_plyr_footstep_tracker_rf";
            }
            else
            {
                fx = "player/fx_plyr_footstep_tracker_r";
            }
        }
        else if ( playfastfx )
        {
            fx = "player/fx_plyr_footstep_tracker_lf";
        }
        else
        {
            fx = "player/fx_plyr_footstep_tracker_l";
        }
    }
    
    pos = self.origin + offset;
    fwd = anglestoforward( self.angles );
    right = anglestoright( self.angles );
    up = anglestoup( self.angles );
    vel = self getvelocity();
    
    if ( lengthsquared( vel ) > 1 )
    {
        up = vectorcross( vel, right );
        
        if ( lengthsquared( up ) < 0.0001 )
        {
            up = vectorcross( fwd, vel );
        }
        
        fwd = vel;
    }
    
    if ( self isplayer() && self isplayerwallrunning() )
    {
        if ( self isplayerwallrunningright() )
        {
            up = vectorcross( up, fwd );
        }
        else
        {
            up = vectorcross( fwd, up );
        }
    }
    
    if ( !self.tracker_flying )
    {
        self.tracker_flying = 1;
        self.tracker_last_pos = self.origin;
    }
    else if ( distancesquared( self.tracker_last_pos, pos ) > dist2 )
    {
        positionandrotation = spawnstruct();
        positionandrotation.fx = fx;
        positionandrotation.pos = pos;
        positionandrotation.fwd = fwd;
        positionandrotation.up = up;
        self.tracker_last_pos = self.origin;
        
        if ( isdefined( self.trailrightfoot ) && self.trailrightfoot )
        {
            self.trailrightfoot = 0;
        }
        else
        {
            self.trailrightfoot = 1;
        }
    }
    
    return positionandrotation;
}

// Namespace perks/perks
// Params 1
// Checksum 0x80e68a80, Offset: 0x2288
// Size: 0x8b4
function monitor_detectnearbyenemies( local_client_num )
{
    self endon( #"death" );
    controllermodel = getuimodelforcontroller( local_client_num );
    sixthsensemodel = createuimodel( controllermodel, "hudItems.sixthsense" );
    enemynearbytime = 0;
    enemylosttime = 0;
    previousenemydetectedbitfield = 0;
    setuimodelvalue( sixthsensemodel, 0 );
    
    while ( true )
    {
        localplayer = getlocalplayer( local_client_num );
        
        if ( localplayer getinkillcam( local_client_num ) == 1 || !localplayer isplayer() || localplayer hasperk( local_client_num, "specialty_detectnearbyenemies" ) == 0 || isalive( localplayer ) == 0 )
        {
            setuimodelvalue( sixthsensemodel, 0 );
            previousenemydetectedbitfield = 0;
            self waittill( "death", "spawned", "perks_changed" );
            continue;
        }
        
        enemynearbyfront = 0;
        enemynearbyback = 0;
        enemynearbyleft = 0;
        enemynearbyright = 0;
        enemydetectedbitfield = 0;
        team = localplayer.team;
        innerdetect = getdvarint( "specialty_detectnearbyenemies_inner", 1 );
        outerdetect = getdvarint( "specialty_detectnearbyenemies_outer", 1 );
        zdetect = getdvarint( "specialty_detectnearbyenemies_zthreshold", 1 );
        localplayeranglestoforward = anglestoforward( localplayer.angles );
        players = getplayers( local_client_num );
        clones = getclones( local_client_num );
        sixthsenseents = arraycombine( players, clones, 0, 0 );
        
        foreach ( sixthsenseent in sixthsenseents )
        {
            if ( sixthsenseent isfriendly( local_client_num, 1 ) || sixthsenseent == localplayer )
            {
                continue;
            }
            
            if ( !isalive( sixthsenseent ) )
            {
                continue;
            }
            
            distancescalarsq = 1;
            zscalarsq = 1;
            player = sixthsenseent;
            
            if ( isdefined( sixthsenseent._isclone ) && sixthsenseent._isclone )
            {
                player = sixthsenseent.owner;
            }
            
            if ( player isplayer() && player hasperk( local_client_num, "specialty_sixthsensejammer" ) )
            {
                distancescalarsq = getdvarfloat( "specialty_sixthsensejammer_distance_scalar", 0.01 );
                zscalarsq = getdvarfloat( "specialty_sixthsensejammer_z_scalar", 0.01 );
            }
            
            if ( previousenemydetectedbitfield == 0 )
            {
                distancesq = 360000 * distancescalarsq;
            }
            else
            {
                distancesq = 490000 * distancescalarsq;
            }
            
            distcurrentsq = distancesquared( sixthsenseent.origin, localplayer.origin );
            zdistcurrent = sixthsenseent.origin[ 2 ] - localplayer.origin[ 2 ];
            zdistcurrentsq = zdistcurrent * zdistcurrent;
            
            if ( distcurrentsq < distancesq )
            {
                distancemask = 1;
                
                if ( previousenemydetectedbitfield > 16 )
                {
                    znearbycheck = 122500 * zscalarsq;
                }
                else
                {
                    znearbycheck = 10000 * zscalarsq;
                }
                
                if ( zdistcurrentsq < znearbycheck && zdetect )
                {
                    distancemask = 16;
                }
                
                vector = sixthsenseent.origin - localplayer.origin;
                vector = ( vector[ 0 ], vector[ 1 ], 0 );
                vectorflat = vectornormalize( vector );
                cosangle = vectordot( vectorflat, localplayeranglestoforward );
                
                if ( cosangle > 0.7071 )
                {
                    enemydetectedbitfield |= 1 * distancemask;
                    continue;
                }
                
                if ( cosangle < -0.7071 )
                {
                    enemydetectedbitfield |= 2 * distancemask;
                    continue;
                }
                
                localplayeranglestoright = anglestoright( localplayer.angles );
                cosangle = vectordot( vectorflat, localplayeranglestoright );
                
                if ( cosangle < 0 )
                {
                    enemydetectedbitfield |= 4 * distancemask;
                    continue;
                }
                
                enemydetectedbitfield |= 8 * distancemask;
            }
        }
        
        if ( enemydetectedbitfield )
        {
            enemylosttime = 0;
            
            if ( previousenemydetectedbitfield != enemydetectedbitfield && enemynearbytime >= 0.05 )
            {
                setuimodelvalue( sixthsensemodel, enemydetectedbitfield );
                enemynearbytime = 0;
                diff = enemydetectedbitfield ^ previousenemydetectedbitfield;
                
                if ( diff & enemydetectedbitfield )
                {
                    self playsound( 0, "uin_sixth_sense_ping_on" );
                }
                
                if ( diff & previousenemydetectedbitfield )
                {
                }
                
                previousenemydetectedbitfield = enemydetectedbitfield;
            }
            
            enemynearbytime += 0.05;
        }
        else
        {
            enemynearbytime = 0;
            
            if ( previousenemydetectedbitfield != 0 && enemylosttime >= 0.05 )
            {
                setuimodelvalue( sixthsensemodel, 0 );
                previousenemydetectedbitfield = 0;
            }
            
            enemylosttime += 0.05;
        }
        
        wait 0.05;
    }
    
    setuimodelvalue( sixthsensemodel, 0 );
}

