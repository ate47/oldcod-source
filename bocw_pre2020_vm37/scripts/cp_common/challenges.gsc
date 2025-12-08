#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\cp_common\achievements;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\util;

#namespace challenges;

// Namespace challenges/challenges
// Params 0, eflags: 0x6
// Checksum 0x5fc67f8e, Offset: 0x1a0
// Size: 0x3c
function private autoexec __init__system__()
{
    system::register( #"challenges", &preinit, undefined, undefined, undefined );
}

// Namespace challenges/challenges
// Params 0, eflags: 0x4
// Checksum 0x6261b332, Offset: 0x1e8
// Size: 0x64
function private preinit()
{
    init_shared();
    callback::on_start_gametype( &start_gametype );
    level.challenges_callback_vehicledamaged = &vehicledamaged;
    level.challenges_callback_vehiclekilled = &vehiclekilled;
}

// Namespace challenges/challenges
// Params 0
// Checksum 0x555d8f23, Offset: 0x258
// Size: 0x114
function start_gametype()
{
    if ( !isdefined( level.challengescallbacks ) )
    {
        level.challengescallbacks = [];
    }
    
    waittillframeend();
    
    if ( canprocesschallenges() )
    {
        registerchallengescallback( "actorKilled", &function_6219dcd5 );
        registerchallengescallback( "actorDamaged", &function_f5b31539 );
        registerchallengescallback( "VehicleKilled", &function_8e9b2d44 );
        registerchallengescallback( "VehicleDamaged", &function_b7b0cce0 );
    }
    
    callback::on_connect( &on_player_connect );
    callback::on_connect( &function_706ec529 );
}

// Namespace challenges/challenges
// Params 2
// Checksum 0xf53e4770, Offset: 0x378
// Size: 0x2c
function function_8e9b2d44( data, time )
{
    function_6219dcd5( data, time );
}

// Namespace challenges/challenges
// Params 2
// Checksum 0x4da7ff8, Offset: 0x3b0
// Size: 0x2c
function function_b7b0cce0( data, time )
{
    function_f5b31539( data, time );
}

// Namespace challenges/challenges
// Params 2
// Checksum 0x97ac9f82, Offset: 0x3e8
// Size: 0x14
function function_f5b31539( *data, *time )
{
    
}

// Namespace challenges/challenges
// Params 2
// Checksum 0x7f2aa1fe, Offset: 0x408
// Size: 0x14
function function_6219dcd5( *data, *time )
{
    
}

// Namespace challenges/challenges
// Params 1
// Checksum 0x59ee5b2, Offset: 0x428
// Size: 0x130
function function_c400b259( v_location )
{
    self endon( #"death", #"stop_catching_immolation_secondaries" );
    
    if ( !isdefined( v_location ) )
    {
        return;
    }
    
    self util::delay_notify( 2, "stop_catching_immolation_secondaries" );
    n_start_time = gettime();
    
    while ( gettime() - n_start_time < 2 )
    {
        waitresult = self waittill( #"hash_52761aa926d57509" );
        e_enemy = waitresult.victim;
        
        if ( !isdefined( e_enemy ) )
        {
            break;
        }
        
        if ( length( v_location - e_enemy.origin ) < 200 )
        {
            if ( !isdefined( e_enemy.var_317391f2 ) )
            {
                e_enemy.var_317391f2 = 1;
                self stats::function_dad108fa( #"hash_648b44b764428dc6", 1 );
            }
        }
    }
}

// Namespace challenges/challenges
// Params 0
// Checksum 0xbafaab8f, Offset: 0x560
// Size: 0xa8
function function_824f9287()
{
    self endon( #"death", #"stop_catching_rapid_strike_attacks" );
    self util::delay_notify( 2, "stop_catching_rapid_strike_attacks" );
    n_start_time = gettime();
    
    while ( gettime() - n_start_time < 2 )
    {
        self waittill( #"hash_751f1e13da443972" );
        self stats::function_dad108fa( #"hash_160d1ea6e56efc27", 1 );
    }
}

// Namespace challenges/challenges
// Params 6
// Checksum 0x109ce7f7, Offset: 0x610
// Size: 0x124
function actorkilled( einflictor, attacker, idamage, smeansofdeath, weapon = level.weaponnone, shitloc )
{
    attacker endon( #"disconnect" );
    data = spawnstruct();
    data.victim = self;
    data.einflictor = einflictor;
    data.attacker = attacker;
    data.idamage = idamage;
    data.smeansofdeath = smeansofdeath;
    data.weapon = weapon;
    data.shitloc = shitloc;
    data.time = gettime();
    data.victimweapon = data.victim.currentweapon;
    function_ff5f9a00( data );
    data.attacker notify( #"hash_63bd9f951d975b7" );
}

// Namespace challenges/challenges
// Params 1
// Checksum 0x9cc1b209, Offset: 0x740
// Size: 0x6c
function function_ff5f9a00( data )
{
    if ( isdefined( data.attacker ) )
    {
        data.attacker endon( #"disconnect" );
    }
    
    waitframe( 1 );
    util::waittillslowprocessallowed();
    level thread dochallengecallback( "actorKilled", data );
}

// Namespace challenges/challenges
// Params 5
// Checksum 0x5cfdcf8f, Offset: 0x7b8
// Size: 0x10c
function actordamaged( einflictor, attacker, idamage, weapon = level.weaponnone, shitloc )
{
    attacker endon( #"disconnect" );
    data = spawnstruct();
    data.victim = self;
    data.einflictor = einflictor;
    data.attacker = attacker;
    data.idamage = idamage;
    data.weapon = weapon;
    data.shitloc = shitloc;
    data.time = gettime();
    data.victimweapon = data.victim.currentweapon;
    function_5e9d4ad3( data );
    data.attacker notify( #"hash_1c23cf76970db631" );
}

// Namespace challenges/challenges
// Params 1
// Checksum 0xeea6739, Offset: 0x8d0
// Size: 0x6c
function function_5e9d4ad3( data )
{
    if ( isdefined( data.attacker ) )
    {
        data.attacker endon( #"disconnect" );
    }
    
    waitframe( 1 );
    util::waittillslowprocessallowed();
    level thread dochallengecallback( "actorDamaged", data );
}

// Namespace challenges/challenges
// Params 6
// Checksum 0x5102187e, Offset: 0x948
// Size: 0x134
function vehiclekilled( einflictor, attacker, idamage, smeansofdeath, weapon, shitloc )
{
    if ( isdefined( level.var_e855c811 ) )
    {
        return;
    }
    
    if ( !isdefined( weapon ) )
    {
        weapon = level.weaponnone;
    }
    
    attacker endon( #"disconnect" );
    data = spawnstruct();
    data.victim = self;
    data.einflictor = einflictor;
    data.attacker = attacker;
    data.idamage = idamage;
    data.smeansofdeath = smeansofdeath;
    data.weapon = weapon;
    data.shitloc = shitloc;
    data.time = gettime();
    data.victimweapon = data.victim.currentweapon;
    function_94d6aade( data );
    data.attacker notify( #"hash_56b121e50d70ac18" );
}

// Namespace challenges/challenges
// Params 1
// Checksum 0xa176b30b, Offset: 0xa88
// Size: 0x6c
function function_94d6aade( data )
{
    if ( isdefined( data.attacker ) )
    {
        data.attacker endon( #"disconnect" );
    }
    
    waitframe( 1 );
    util::waittillslowprocessallowed();
    level thread dochallengecallback( "VehicleKilled", data );
}

// Namespace challenges/challenges
// Params 5
// Checksum 0xc9890792, Offset: 0xb00
// Size: 0x10c
function vehicledamaged( einflictor, attacker, idamage, weapon = level.weaponnone, shitloc )
{
    attacker endon( #"disconnect" );
    data = spawnstruct();
    data.victim = self;
    data.einflictor = einflictor;
    data.attacker = attacker;
    data.idamage = idamage;
    data.weapon = weapon;
    data.shitloc = shitloc;
    data.time = gettime();
    data.victimweapon = data.victim.currentweapon;
    function_2de75dbd( data );
    data.attacker notify( #"hash_324a232de36f6e68" );
}

// Namespace challenges/challenges
// Params 1
// Checksum 0xf21b6781, Offset: 0xc18
// Size: 0x5c
function function_2de75dbd( data )
{
    if ( isdefined( data.attacker ) )
    {
        data.attacker endon( #"disconnect" );
    }
    
    waitframe( 1 );
    level thread dochallengecallback( "VehicleDamaged", data );
}

// Namespace challenges/challenges
// Params 0
// Checksum 0x1c5b6893, Offset: 0xc80
// Size: 0x24
function function_f901cb3c()
{
    self thread function_8332bc5e( "career_decorations" );
}

// Namespace challenges/challenges
// Params 2
// Checksum 0xe8b47abe, Offset: 0xcb0
// Size: 0x6c
function function_8332bc5e( statname, n_amount = 1 )
{
    self endon( #"disconnect" );
    
    if ( !isplayer( self ) )
    {
        return;
    }
    
    self stats::function_dad108fa( statname, n_amount );
}

// Namespace challenges/challenges
// Params 0
// Checksum 0x281c0604, Offset: 0xd28
// Size: 0x34
function function_706ec529()
{
    self.challenge_callback_cp = &function_7b4387e1;
    
    /#
        self thread function_ba92458e();
    #/
}

// Namespace challenges/challenges
// Params 1
// Checksum 0xe104bfa0, Offset: 0xd68
// Size: 0x32
function function_f752d6a9( challenge_index )
{
    return tablelookup( #"gamedata/stats/cp/statsmilestones3.csv", 0, challenge_index, 5 );
}

// Namespace challenges/challenges
// Params 7
// Checksum 0x49dc3ccc, Offset: 0xda8
// Size: 0x25a
function function_7b4387e1( *rewardxp, *maxval, *row, *tablenumber, challengetype, itemindex, challengeindex )
{
    self function_18b65152();
    
    if ( challengeindex == 565 )
    {
        self givedecoration( "cp_medal_all_accolades" );
    }
    
    tier = int( tablelookup( #"gamedata/stats/cp/statsmilestones3.csv", 0, challengeindex, 1 ) );
    
    switch ( challengetype )
    {
        case 0:
            challengename = function_f752d6a9( challengeindex );
            
            switch ( challengename )
            {
                case #"hash_20faf480b8f9146a":
                    break;
                case #"hash_381ccf00b363923d":
                    self givedecoration( "cp_medal_all_calling_cards" );
                    break;
            }
            
            break;
        case 1:
            if ( itemindex != 0 )
            {
                self stats::set_stat( #"itemstats", itemindex, #"hash_798921f18e351b13", tier, 1 );
                self achievements::function_c3541c14( tier );
            }
            
            break;
        case 4:
            var_9327960d = tablelookup( #"gamedata/stats/cp/statsmilestones3.csv", 0, challengeindex, 13 );
            self stats::set_stat( #"attachments", var_9327960d, #"hash_798921f18e351b13", tier, 1 );
            break;
    }
}

// Namespace challenges/challenges
// Params 0
// Checksum 0x38e5e953, Offset: 0x1010
// Size: 0x2e4
function function_18b65152()
{
    if ( sessionmodeisonlinegame() )
    {
        return;
    }
    
    var_80b995df = self stats::get_stat( #"playerstatslist", #"cp_challenges", #"statvalue" );
    
    if ( var_80b995df > 0 )
    {
        var_e1617d73 = tablelookuprowcount( #"gamedata/stats/cp/statsmilestones3.csv" );
        challenge_data = [];
        
        for ( i = 0; i < var_e1617d73 - 1 ; i++ )
        {
            challenge_data = tablelookuprow( #"gamedata/stats/cp/statsmilestones3.csv", i );
            var_2a9d0df5 = challenge_data[ 3 ];
            
            if ( var_2a9d0df5 == "global" )
            {
                challenge_stat_name = challenge_data[ 4 ];
                
                if ( isdefined( challenge_stat_name ) && challenge_stat_name != "" )
                {
                    var_85321896 = self stats::get_stat( #"playerstatslist", challenge_stat_name, #"statvalue" );
                    
                    if ( challenge_data[ 10 ] != "" )
                    {
                        var_a15c6663 = int( challenge_data[ 2 ] );
                        
                        if ( var_85321896 >= var_a15c6663 )
                        {
                            var_f220a4fb = "";
                            var_f220a4fb = challenge_data[ 16 ];
                            
                            switch ( var_f220a4fb )
                            {
                                case #"missions":
                                    self stats::function_dad108fa( #"hash_13eb46cb3c4c5613", 1 );
                                    break;
                                case #"tott":
                                    self stats::function_dad108fa( #"hash_34e0fb49ecfca3e4", 1 );
                                    break;
                                case #"career":
                                    self stats::function_dad108fa( #"career_mastery", 1 );
                                    break;
                            }
                        }
                    }
                }
            }
        }
        
        self stats::set_stat( #"playerstatslist", #"cp_challenges", #"statvalue", 0 );
    }
}

/#

    // Namespace challenges/challenges
    // Params 1
    // Checksum 0x20516ed0, Offset: 0x1300
    // Size: 0x3c, Type: dev
    function function_6d4abfcd( n_time )
    {
        self endon( #"disconnect" );
        wait n_time;
        self thread util::function_2e0c1f7d();
    }

    // Namespace challenges/challenges
    // Params 0
    // Checksum 0x5c1de158, Offset: 0x1348
    // Size: 0x80, Type: dev
    function function_ba92458e()
    {
        while ( true )
        {
            if ( getdvarint( #"hash_557c55de257d4066", 0 ) == 1 )
            {
                self function_1b7d307e();
                setdvar( #"hash_557c55de257d4066", 0 );
            }
            
            wait 0.1;
        }
    }

    // Namespace challenges/challenges
    // Params 0
    // Checksum 0xacce6b5a, Offset: 0x13d0
    // Size: 0x4c8, Type: dev
    function function_1b7d307e()
    {
        var_2418c386 = [];
        array::add( var_2418c386, "<dev string:x38>" );
        array::add( var_2418c386, "<dev string:x4c>" );
        array::add( var_2418c386, "<dev string:x60>" );
        array::add( var_2418c386, "<dev string:x74>" );
        array::add( var_2418c386, "<dev string:x88>" );
        array::add( var_2418c386, "<dev string:x9c>" );
        array::add( var_2418c386, "<dev string:xb0>" );
        array::add( var_2418c386, "<dev string:xc4>" );
        array::add( var_2418c386, "<dev string:xd8>" );
        array::add( var_2418c386, "<dev string:xec>" );
        array::add( var_2418c386, "<dev string:x100>" );
        array::add( var_2418c386, "<dev string:x114>" );
        array::add( var_2418c386, "<dev string:x12d>" );
        array::add( var_2418c386, "<dev string:x146>" );
        array::add( var_2418c386, "<dev string:x15f>" );
        array::add( var_2418c386, "<dev string:x176>" );
        array::add( var_2418c386, "<dev string:x194>" );
        array::add( var_2418c386, "<dev string:x1b1>" );
        array::add( var_2418c386, "<dev string:x1cd>" );
        array::add( var_2418c386, "<dev string:x1e7>" );
        array::add( var_2418c386, "<dev string:x203>" );
        array::add( var_2418c386, "<dev string:x21a>" );
        array::add( var_2418c386, "<dev string:x236>" );
        array::add( var_2418c386, "<dev string:x251>" );
        array::add( var_2418c386, "<dev string:x26d>" );
        array::add( var_2418c386, "<dev string:x281>" );
        array::add( var_2418c386, "<dev string:x292>" );
        array::add( var_2418c386, "<dev string:x2a9>" );
        array::add( var_2418c386, "<dev string:x2c3>" );
        array::add( var_2418c386, "<dev string:x2dc>" );
        array::add( var_2418c386, "<dev string:x2f6>" );
        array::add( var_2418c386, "<dev string:x30d>" );
        
        foreach ( challenge in var_2418c386 )
        {
            self stats::function_dad108fa( challenge, 1000 );
            iprintln( "<dev string:x329>" + challenge );
            wait 1;
        }
    }

#/
