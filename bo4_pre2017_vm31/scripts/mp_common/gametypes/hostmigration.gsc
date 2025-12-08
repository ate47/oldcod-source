#using scripts/core_common/hostmigration_shared;
#using scripts/core_common/hud_shared;
#using scripts/core_common/hud_util_shared;
#using scripts/core_common/struct;

#namespace hostmigration;

// Namespace hostmigration/hostmigration
// Params 0
// Checksum 0x80f724d1, Offset: 0x130
// Size: 0x4
function callback_hostmigrationsave()
{
    
}

// Namespace hostmigration/hostmigration
// Params 0
// Checksum 0x80f724d1, Offset: 0x140
// Size: 0x4
function callback_prehostmigrationsave()
{
    
}

// Namespace hostmigration/hostmigration
// Params 0
// Checksum 0x7c5e95a0, Offset: 0x150
// Size: 0x1dc
function callback_hostmigration()
{
    setslowmotion( 1, 1, 0 );
    level.hostmigrationreturnedplayercount = 0;
    
    if ( level.inprematchperiod )
    {
        level waittill( "prematch_over" );
    }
    
    if ( level.gameended )
    {
        println( "<dev string:x28>" + gettime() + "<dev string:x44>" );
        return;
    }
    
    println( "<dev string:x28>" + gettime() );
    level.hostmigrationtimer = 1;
    sethostmigrationstatus( 1 );
    level notify( #"host_migration_begin" );
    thread locktimer();
    players = level.players;
    
    for ( i = 0; i < players.size ; i++ )
    {
        player = players[ i ];
        player thread hostmigrationtimerthink();
    }
    
    level endon( #"host_migration_begin" );
    hostmigrationwait();
    level.hostmigrationtimer = undefined;
    sethostmigrationstatus( 0 );
    println( "<dev string:x6b>" + gettime() );
    level notify( #"host_migration_end" );
}

