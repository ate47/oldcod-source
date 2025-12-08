#using scripts/core_common/array_shared;
#using scripts/core_common/rat_shared;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/mp_common/bots/mp_bot;
#using scripts/mp_common/gametypes/dev;
#using scripts/mp_common/util;

#namespace rat;

/#

    // Namespace rat/rat
    // Params 0, eflags: 0x2
    // Checksum 0x83e38c05, Offset: 0x168
    // Size: 0x34, Type: dev
    function autoexec __init__sytem__()
    {
        system::register( "rat", &__init__, undefined, undefined );
    }

    // Namespace rat/rat
    // Params 0
    // Checksum 0x603556c6, Offset: 0x1a8
    // Size: 0xa4, Type: dev
    function __init__()
    {
        rat_shared::init();
        level.rat.common.gethostplayer = &util::gethostplayer;
        level.rat.deathcount = 0;
        rat_shared::addratscriptcmd( "addenemy", &rscaddenemy );
        setdvar( "rat_death_count", 0 );
    }

    // Namespace rat/rat
    // Params 1
    // Checksum 0x56d3b442, Offset: 0x258
    // Size: 0x284, Type: dev
    function rscaddenemy( params )
    {
        player = [[ level.rat.common.gethostplayer ]]();
        team = "axis";
        
        if ( isdefined( player.pers[ "team" ] ) )
        {
            team = util::getotherteam( player.pers[ "team" ] );
        }
        
        bot = dev::getormakebot( team );
        
        if ( !isdefined( bot ) )
        {
            println( "Could not add test client" );
            ratreportcommandresult( params._id, 0, "Could not add test client" );
            return;
        }
        
        bot thread testenemy( team );
        bot thread deathcounter();
        wait 2;
        pos = ( float( params.x ), float( params.y ), float( params.z ) );
        bot setorigin( pos );
        
        if ( isdefined( params.ax ) )
        {
            angles = ( float( params.ax ), float( params.ay ), float( params.az ) );
            bot setplayerangles( angles );
        }
        
        ratreportcommandresult( params._id, 1 );
    }

    // Namespace rat/rat
    // Params 1
    // Checksum 0x8f653c14, Offset: 0x4e8
    // Size: 0x82, Type: dev
    function testenemy( team )
    {
        self endon( #"disconnect" );
        
        while ( !isdefined( self.pers[ "team" ] ) )
        {
            waitframe( 1 );
        }
        
        if ( level.teambased )
        {
            self notify( #"menuresponse", { #menu:game.menu[ "menu_team" ], #response:team } );
        }
    }

    // Namespace rat/rat
    // Params 0
    // Checksum 0x5a9ab015, Offset: 0x578
    // Size: 0x5c, Type: dev
    function deathcounter()
    {
        self waittill( "death" );
        level.rat.deathcount++;
        setdvar( "rat_death_count", level.rat.deathcount );
    }

#/
