#using scripts/core_common/struct;
#using scripts/core_common/util_shared;
#using scripts/mp_common/gametypes/perplayer;
#using scripts/mp_common/util;

#namespace teargrenades;

// Namespace teargrenades/teargrenades
// Params 0
// Checksum 0xba67ff47, Offset: 0x160
// Size: 0xbc
function main()
{
    level.tearradius = 170;
    level.tearheight = 128;
    level.teargasfillduration = 7;
    level.teargasduration = 23;
    level.tearsufferingduration = 3;
    level.teargrenadetimer = 4;
    fgmonitor = perplayer::init( "tear_grenade_monitor", &startmonitoringtearusage, &stopmonitoringtearusage );
    perplayer::enable( fgmonitor );
}

// Namespace teargrenades/teargrenades
// Params 0
// Checksum 0xbd9e4dbb, Offset: 0x228
// Size: 0x1c
function startmonitoringtearusage()
{
    self thread monitortearusage();
}

// Namespace teargrenades/teargrenades
// Params 1
// Checksum 0xaeb6118a, Offset: 0x250
// Size: 0x1a
function stopmonitoringtearusage( disconnected )
{
    self notify( #"stop_monitoring_tear_usage" );
}

// Namespace teargrenades/teargrenades
// Params 0
// Checksum 0xb285c6af, Offset: 0x278
// Size: 0x26a
function monitortearusage()
{
    self endon( #"stop_monitoring_tear_usage" );
    waitframe( 1 );
    weapon = getweapon( "tear_grenade" );
    
    if ( !self hasweapon( weapon ) )
    {
        return;
    }
    
    prevammo = self getammocount( weapon );
    
    while ( true )
    {
        ammo = self getammocount( weapon );
        
        if ( ammo < prevammo )
        {
            num = prevammo - ammo;
            
            /#
            #/
            
            for ( i = 0; i < num ; i++ )
            {
                grenades = getentarray( "grenade", "classname" );
                bestdist = undefined;
                bestg = undefined;
                
                for ( g = 0; g < grenades.size ; g++ )
                {
                    if ( !isdefined( grenades[ g ].teargrenade ) )
                    {
                        dist = distance( grenades[ g ].origin, self.origin + ( 0, 0, 48 ) );
                        
                        if ( !isdefined( bestdist ) || dist < bestdist )
                        {
                            bestdist = dist;
                            bestg = g;
                        }
                    }
                }
                
                if ( isdefined( bestdist ) )
                {
                    grenades[ bestg ].teargrenade = 1;
                    grenades[ bestg ] thread teargrenade_think( self.team );
                }
            }
        }
        
        prevammo = ammo;
        waitframe( 1 );
    }
}

// Namespace teargrenades/teargrenades
// Params 1
// Checksum 0xd6debc84, Offset: 0x4f0
// Size: 0x54
function teargrenade_think( team )
{
    wait level.teargrenadetimer;
    ent = spawnstruct();
    ent thread tear( self.origin );
}

// Namespace teargrenades/teargrenades
// Params 1
// Checksum 0xb02bb053, Offset: 0x550
// Size: 0x260
function tear( pos )
{
    trig = spawn( "trigger_radius", pos, 0, level.tearradius, level.tearheight );
    starttime = gettime();
    self thread teartimer();
    self endon( #"tear_timeout" );
    
    while ( true )
    {
        waitresult = trig waittill( "trigger" );
        player = waitresult.activator;
        
        if ( player.sessionstate != "playing" )
        {
            continue;
        }
        
        time = ( gettime() - starttime ) / 1000;
        currad = level.tearradius;
        curheight = level.tearheight;
        
        if ( time < level.teargasfillduration )
        {
            currad *= time / level.teargasfillduration;
            curheight *= time / level.teargasfillduration;
        }
        
        offset = player.origin + ( 0, 0, 32 ) - pos;
        offset2d = ( offset[ 0 ], offset[ 1 ], 0 );
        
        if ( lengthsquared( offset2d ) > currad * currad )
        {
            continue;
        }
        
        if ( player.origin[ 2 ] - pos[ 2 ] > curheight )
        {
            continue;
        }
        
        player.teargasstarttime = gettime();
        
        if ( !isdefined( player.teargassuffering ) )
        {
            player thread teargassuffering();
        }
    }
}

// Namespace teargrenades/teargrenades
// Params 0
// Checksum 0x1e81a067, Offset: 0x7b8
// Size: 0x1e
function teartimer()
{
    wait level.teargasduration;
    self notify( #"tear_timeout" );
}

// Namespace teargrenades/teargrenades
// Params 0
// Checksum 0x64773afc, Offset: 0x7e0
// Size: 0xde
function teargassuffering()
{
    self endon( #"death" );
    self endon( #"disconnect" );
    self.teargassuffering = 1;
    
    if ( self util::mayapplyscreeneffect() )
    {
        self shellshock( "teargas", 60 );
    }
    
    while ( true )
    {
        if ( gettime() - self.teargasstarttime > level.tearsufferingduration * 1000 )
        {
            break;
        }
        
        wait 1;
    }
    
    self shellshock( "teargas", 1 );
    
    if ( self util::mayapplyscreeneffect() )
    {
        self.teargassuffering = undefined;
    }
}

/#

    // Namespace teargrenades/teargrenades
    // Params 3
    // Checksum 0xac8ad4b, Offset: 0x8c8
    // Size: 0x2f6, Type: dev
    function drawcylinder( pos, rad, height )
    {
        time = 0;
        
        while ( true )
        {
            currad = rad;
            curheight = height;
            
            if ( time < level.teargasfillduration )
            {
                currad *= time / level.teargasfillduration;
                curheight *= time / level.teargasfillduration;
            }
            
            for ( r = 0; r < 20 ; r++ )
            {
                theta = r / 20 * 360;
                theta2 = ( r + 1 ) / 20 * 360;
                line( pos + ( cos( theta ) * currad, sin( theta ) * currad, 0 ), pos + ( cos( theta2 ) * currad, sin( theta2 ) * currad, 0 ) );
                line( pos + ( cos( theta ) * currad, sin( theta ) * currad, curheight ), pos + ( cos( theta2 ) * currad, sin( theta2 ) * currad, curheight ) );
                line( pos + ( cos( theta ) * currad, sin( theta ) * currad, 0 ), pos + ( cos( theta ) * currad, sin( theta ) * currad, curheight ) );
            }
            
            time += 0.05;
            
            if ( time > level.teargasduration )
            {
                break;
            }
            
            waitframe( 1 );
        }
    }

#/
