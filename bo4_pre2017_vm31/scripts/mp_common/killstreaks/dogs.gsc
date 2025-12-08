#using scripts/core_common/array_shared;
#using scripts/core_common/influencers_shared;
#using scripts/core_common/scoreevents_shared;
#using scripts/core_common/spawning_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/tweakables_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/values_shared;
#using scripts/core_common/weapons/weapon_utils;
#using scripts/core_common/weapons/weapons;
#using scripts/mp_common/gametypes/battlechatter;
#using scripts/mp_common/gametypes/dev;
#using scripts/mp_common/killstreaks/killstreakrules;
#using scripts/mp_common/killstreaks/killstreaks;
#using scripts/mp_common/killstreaks/supplydrop;
#using scripts/mp_common/util;

#namespace dogs;

// Namespace dogs/dogs
// Params 0
// Checksum 0x665dad08, Offset: 0x4f0
// Size: 0xc0
function init()
{
    level.dog_targets = [];
    level.dog_targets[ level.dog_targets.size ] = "trigger_radius";
    level.dog_targets[ level.dog_targets.size ] = "trigger_multiple";
    level.dog_targets[ level.dog_targets.size ] = "trigger_use_touch";
    level.var_a16d1f64 = [];
    
    /#
        level thread function_cced6d39();
    #/
    
    level.dogsonflashdogs = &function_f436e711;
}

// Namespace dogs/dogs
// Params 0
// Checksum 0x4a4deda6, Offset: 0x5b8
// Size: 0x264
function init_spawns()
{
    spawns = getnodearray( "spawn", "script_noteworthy" );
    
    if ( !isdefined( spawns ) || !spawns.size )
    {
        println( "<dev string:x28>" );
        return;
    }
    
    dog_spawner = getent( "dog_spawner", "targetname" );
    
    if ( !isdefined( dog_spawner ) )
    {
        println( "<dev string:x48>" );
        return;
    }
    
    valid = spawning::get_spawnpoint_array( "mp_tdm_spawn" );
    dog = dog_spawner spawnfromspawner();
    
    foreach ( spawn in spawns )
    {
        valid = arraysort( valid, spawn.origin, 0 );
        
        for ( i = 0; i < 5 ; i++ )
        {
            if ( dog findpath( spawn.origin, valid[ i ].origin, 1, 0 ) )
            {
                level.var_a16d1f64[ level.var_a16d1f64.size ] = spawn;
                break;
            }
        }
    }
    
    /#
        if ( !level.var_a16d1f64.size )
        {
            println( "<dev string:x6b>" );
        }
    #/
    
    dog delete();
}

// Namespace dogs/dogs
// Params 0
// Checksum 0xe2ae65b5, Offset: 0x828
// Size: 0x26
function initkillstreak()
{
    if ( tweakables::gettweakablevalue( "killstreak", "allowdogs" ) )
    {
    }
}

// Namespace dogs/dogs
// Params 1
// Checksum 0x47991ec2, Offset: 0x858
// Size: 0x1f0, Type: bool
function function_98406011( hardpointtype )
{
    if ( !function_62a07a8b() )
    {
        return false;
    }
    
    if ( !self killstreakrules::iskillstreakallowed( hardpointtype, self.team ) )
    {
        return false;
    }
    
    killstreak_id = self killstreakrules::killstreakstart( "dogs", self.team );
    self thread function_4aae4772();
    
    if ( killstreak_id == -1 )
    {
        return false;
    }
    
    if ( level.teambased )
    {
        foreach ( team in level.teams )
        {
            if ( team == self.team )
            {
            }
        }
    }
    
    self killstreaks::play_killstreak_start_dialog( "dogs", self.team, 1 );
    self addweaponstat( getweapon( "dogs" ), "used", 1 );
    var_544a3985 = self.deathcount;
    level thread function_ec5275d9( self, var_544a3985, killstreak_id );
    level notify( #"hash_643b7356" );
    return true;
}

// Namespace dogs/dogs
// Params 0
// Checksum 0x2deaa294, Offset: 0xa50
// Size: 0x62
function function_4aae4772()
{
    self endon( #"disconnect" );
    self.var_6903e20a = 1;
    self.var_1f6801c8 = 0;
    self waittill( "death", "game_over", "dogs_complete" );
    self.var_1f6801c8 = 0;
    self.var_6903e20a = undefined;
}

// Namespace dogs/dogs
// Params 0
// Checksum 0x678dc7bb, Offset: 0xac0
// Size: 0x124, Type: bool
function function_62a07a8b()
{
    dog_spawner = getent( "dog_spawner", "targetname" );
    
    if ( !isdefined( dog_spawner ) )
    {
        println( "<dev string:x93>" );
        return false;
    }
    
    spawns = getnodearray( "spawn", "script_noteworthy" );
    
    if ( level.var_a16d1f64.size <= 0 )
    {
        println( "<dev string:x28>" );
        return false;
    }
    
    exits = getnodearray( "exit", "script_noteworthy" );
    
    if ( exits.size <= 0 )
    {
        println( "<dev string:xb0>" );
        return false;
    }
    
    return true;
}

// Namespace dogs/dogs
// Params 0
// Checksum 0x7ee66819, Offset: 0xbf0
// Size: 0x44
function function_1b915ebe()
{
    self setmodel( "german_shepherd_vest" );
    self setenemymodel( "german_shepherd_vest_black" );
}

// Namespace dogs/dogs
// Params 0
// Checksum 0xe097822a, Offset: 0xc40
// Size: 0x154
function init_dog()
{
    assert( isai( self ) );
    self.targetname = "attack_dog";
    self.animtree = "dog.atr";
    self.type = "dog";
    self.accuracy = 0.2;
    self.health = 100;
    self.maxhealth = 100;
    self.secondaryweapon = "";
    self.sidearm = "";
    self.grenadeammo = 0;
    self.goalradius = 128;
    self.nododgemove = 1;
    self.ignoresuppression = 1;
    self.suppressionthreshold = 1;
    self.disablearrivals = 0;
    self.pathenemyfightdist = 512;
    self.soundmod = "dog";
    self thread function_e5624260();
    self thread function_67f34e48();
}

// Namespace dogs/dogs
// Params 2
// Checksum 0xe5aab5e5, Offset: 0xda0
// Size: 0x5a
function function_7181571a( owner, team )
{
    assert( level.var_a16d1f64.size > 0 );
    return array::random( level.var_a16d1f64 );
}

// Namespace dogs/dogs
// Params 2
// Checksum 0x298d843, Offset: 0xe08
// Size: 0x156
function function_10582f80( origin, team )
{
    players = getplayers();
    score = 0;
    
    foreach ( player in players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( !isalive( player ) )
        {
            continue;
        }
        
        if ( player.sessionstate != "playing" )
        {
            continue;
        }
        
        if ( distancesquared( player.origin, origin ) > 4194304 )
        {
            continue;
        }
        
        if ( player.team == team )
        {
            score++;
            continue;
        }
        
        score--;
    }
    
    return score;
}

// Namespace dogs/dogs
// Params 3
// Checksum 0x6382371e, Offset: 0xf68
// Size: 0x54
function function_6ece2d8c( owner, team, requireddeathcount )
{
    self setentityowner( owner );
    self.team = team;
    self.requireddeathcount = requireddeathcount;
}

// Namespace dogs/dogs
// Params 1
// Checksum 0xe4bc13ee, Offset: 0xfc8
// Size: 0x2c
function function_971fce06( team )
{
    self influencers::create_entity_enemy_influencer( "dog", team );
}

// Namespace dogs/dogs
// Params 4
// Checksum 0x3ab15903, Offset: 0x1000
// Size: 0x168
function function_4b764fa6( owner, team, spawn_node, requireddeathcount )
{
    dog_spawner = getent( "dog_spawner", "targetname" );
    dog = dog_spawner spawnfromspawner();
    dog forceteleport( spawn_node.origin, spawn_node.angles );
    dog init_dog();
    dog function_6ece2d8c( owner, team, requireddeathcount );
    dog function_1b915ebe();
    dog function_971fce06( team );
    dog thread function_62d0f1eb();
    dog thread function_8262b7af();
    dog thread dog_patrol();
    dog thread function_49bbd420();
    return dog;
}

// Namespace dogs/dogs
// Params 0
// Checksum 0xf3cd1467, Offset: 0x1170
// Size: 0xd8
function function_49bbd420()
{
    self endon( #"death" );
    
    while ( true )
    {
        waitresult = self waittill( "damage" );
        
        if ( weapon_utils::isflashorstunweapon( waitresult.weapon ) )
        {
            damage_area = spawn( "trigger_radius", self.origin, 0, 128, 128 );
            waitresult.attacker thread function_f436e711( damage_area );
            waitframe( 1 );
            damage_area delete();
        }
    }
}

// Namespace dogs/dogs
// Params 3
// Checksum 0x497377ea, Offset: 0x1250
// Size: 0x214
function function_ec5275d9( owner, deathcount, killstreak_id )
{
    requireddeathcount = deathcount;
    team = owner.team;
    level.var_fb1a25fe = 0;
    owner thread function_1415306e();
    level thread function_ab8fa017();
    count = 0;
    
    while ( count < 10 )
    {
        if ( level.var_fb1a25fe )
        {
            break;
        }
        
        for ( dogs = dog_manager_get_dogs(); dogs.size < 5 && count < 10 && !level.var_fb1a25fe ; dogs = dog_manager_get_dogs() )
        {
            node = function_7181571a( owner, team );
            level function_4b764fa6( owner, team, node, requireddeathcount );
            count++;
            wait randomfloatrange( 2, 5 );
        }
        
        level waittill( "dog_died" );
    }
    
    for ( ;; )
    {
        dogs = dog_manager_get_dogs();
        
        if ( dogs.size <= 0 )
        {
            killstreakrules::killstreakstop( "dogs", team, killstreak_id );
            
            if ( isdefined( owner ) )
            {
                owner notify( #"dogs_complete" );
            }
            
            return;
        }
        
        level waittill( "dog_died" );
    }
}

// Namespace dogs/dogs
// Params 0
// Checksum 0x4ab0e8af, Offset: 0x1470
// Size: 0xbc
function function_fb1a25fe()
{
    level.var_fb1a25fe = 1;
    dogs = dog_manager_get_dogs();
    
    foreach ( dog in dogs )
    {
        dog notify( #"abort" );
    }
    
    level notify( #"hash_fb1a25fe" );
}

// Namespace dogs/dogs
// Params 0
// Checksum 0x975d4b87, Offset: 0x1538
// Size: 0x54
function function_1415306e()
{
    level endon( #"hash_fb1a25fe" );
    self util::wait_endon( 45, "disconnect", "joined_team", "joined_spectators" );
    function_fb1a25fe();
}

// Namespace dogs/dogs
// Params 0
// Checksum 0xfb8b2535, Offset: 0x1598
// Size: 0x34
function function_ab8fa017()
{
    level endon( #"hash_fb1a25fe" );
    level waittill( "game_ended" );
    function_fb1a25fe();
}

// Namespace dogs/dogs
// Params 0
// Checksum 0x571d112, Offset: 0x15d8
// Size: 0x20
function function_8262b7af()
{
    self waittill( "death" );
    level notify( #"dog_died" );
}

// Namespace dogs/dogs
// Params 0
// Checksum 0xf32d5762, Offset: 0x1600
// Size: 0xbc
function dog_leave()
{
    self clearentitytarget();
    self val::set( "dog_leave", "ignoreall", 1 );
    self.goalradius = 30;
    self setgoal( self function_e5321612() );
    self util::wait_endon( 20, "goal", "bad_path" );
    self delete();
}

// Namespace dogs/dogs
// Params 0
// Checksum 0x197a638c, Offset: 0x16c8
// Size: 0x428
function dog_patrol()
{
    self endon( #"death" );
    
    /#
        self endon( #"debug_patrol" );
    #/
    
    for ( ;; )
    {
        if ( level.var_fb1a25fe )
        {
            self dog_leave();
            return;
        }
        
        if ( isdefined( self.enemy ) )
        {
            wait randomintrange( 3, 5 );
            continue;
        }
        
        nodes = [];
        objectives = function_c5dd1773();
        
        for ( i = 0; i < objectives.size ; i++ )
        {
            objective = array::random( objectives );
            nodes = getnodesinradius( objective.origin, 256, 64, 512, "Path", 16 );
            
            if ( nodes.size )
            {
                break;
            }
        }
        
        if ( !nodes.size )
        {
            player = self function_b973c0b6();
            
            if ( isdefined( player ) )
            {
                nodes = getnodesinradius( player.origin, 1024, 0, 128, "Path", 8 );
            }
        }
        
        if ( !nodes.size && isdefined( self.script_owner ) )
        {
            if ( isalive( self.script_owner ) && self.script_owner.sessionstate == "playing" )
            {
                nodes = getnodesinradius( self.script_owner.origin, 512, 256, 512, "Path", 16 );
            }
        }
        
        if ( !nodes.size )
        {
            nodes = getnodesinradius( self.origin, 1024, 512, 512, "Path" );
        }
        
        if ( nodes.size )
        {
            nodes = array::randomize( nodes );
            
            foreach ( node in nodes )
            {
                if ( isdefined( node.script_noteworthy ) )
                {
                    continue;
                }
                
                if ( isdefined( node.var_88aac8ef ) && isalive( node.var_88aac8ef ) )
                {
                    continue;
                }
                
                self setgoal( node );
                node.var_88aac8ef = self;
                nodes = [];
                event = self waittill( "goal", "bad_path", "enemy", "abort" );
                
                if ( event._notify == "goal" )
                {
                    util::wait_endon( randomintrange( 3, 5 ), "damage", "enemy", "abort" );
                }
                
                node.var_88aac8ef = undefined;
                break;
            }
        }
        
        wait 0.5;
    }
}

// Namespace dogs/dogs
// Params 0
// Checksum 0x6479e870, Offset: 0x1af8
// Size: 0x30a
function function_c5dd1773()
{
    if ( !isdefined( level.var_4dec1e08 ) )
    {
        level.var_4dec1e08 = [];
        level.var_15d329d5 = 0;
    }
    
    if ( level.gametype == "tdm" || level.gametype == "dm" )
    {
        return level.var_4dec1e08;
    }
    
    if ( gettime() >= level.var_15d329d5 )
    {
        level.var_4dec1e08 = [];
        
        foreach ( target in level.dog_targets )
        {
            ents = getentarray( target, "classname" );
            
            foreach ( ent in ents )
            {
                if ( level.gametype == "koth" )
                {
                    if ( isdefined( ent.targetname ) && ent.targetname == "radiotrigger" )
                    {
                        level.var_4dec1e08[ level.var_4dec1e08.size ] = ent;
                    }
                    
                    continue;
                }
                
                if ( level.gametype == "sd" )
                {
                    if ( isdefined( ent.targetname ) && ent.targetname == "bombzone" )
                    {
                        level.var_4dec1e08[ level.var_4dec1e08.size ] = ent;
                    }
                    
                    continue;
                }
                
                if ( !isdefined( ent.script_gameobjectname ) )
                {
                    continue;
                }
                
                if ( !issubstr( ent.script_gameobjectname, level.gametype ) )
                {
                    continue;
                }
                
                level.var_4dec1e08[ level.var_4dec1e08.size ] = ent;
            }
        }
        
        level.var_15d329d5 = gettime() + randomintrange( 5000, 10000 );
    }
    
    return level.var_4dec1e08;
}

// Namespace dogs/dogs
// Params 0
// Checksum 0x118db84a, Offset: 0x1e10
// Size: 0x20c
function function_b973c0b6()
{
    players = getplayers();
    closest = undefined;
    distsq = 99999999;
    
    foreach ( player in players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( !isalive( player ) )
        {
            continue;
        }
        
        if ( player.sessionstate != "playing" )
        {
            continue;
        }
        
        if ( isdefined( self.script_owner ) && player == self.script_owner )
        {
            continue;
        }
        
        if ( level.teambased )
        {
            if ( player.team == self.team )
            {
                continue;
            }
        }
        
        if ( gettime() - player.lastfiretime > 3000 )
        {
            continue;
        }
        
        if ( !isdefined( closest ) )
        {
            closest = player;
            distsq = distancesquared( self.origin, player.origin );
            continue;
        }
        
        d = distancesquared( self.origin, player.origin );
        
        if ( d < distsq )
        {
            closest = player;
            distsq = d;
        }
    }
    
    return closest;
}

// Namespace dogs/dogs
// Params 0
// Checksum 0xedcf6e24, Offset: 0x2028
// Size: 0x34
function dog_manager_get_dogs()
{
    dogs = getentarray( "attack_dog", "targetname" );
    return dogs;
}

// Namespace dogs/dogs
// Params 0
// Checksum 0x485eb75c, Offset: 0x2068
// Size: 0x70
function function_62d0f1eb()
{
    if ( !isdefined( self.script_owner ) )
    {
        return;
    }
    
    self endon( #"clear_owner" );
    self endon( #"death" );
    self.script_owner endon( #"disconnect" );
    
    while ( true )
    {
        self waittill( "killed" );
        self.script_owner notify( #"hash_18faeaac" );
    }
}

// Namespace dogs/dogs
// Params 0
// Checksum 0x13809e95, Offset: 0x20e0
// Size: 0xd0
function function_e5624260()
{
    self endon( #"death" );
    interval = 0.5;
    regen_interval = int( self.health / 5 * interval );
    var_c5fb7989 = 2;
    
    for ( ;; )
    {
        waitresult = self waittill( "damage" );
        self trackattackerdamage( waitresult.attacker );
        self thread function_f7ae2e49( var_c5fb7989, interval, regen_interval );
    }
}

// Namespace dogs/dogs
// Params 1
// Checksum 0xaf6b18c3, Offset: 0x21b8
// Size: 0x11e
function trackattackerdamage( attacker )
{
    if ( !isdefined( attacker ) || !isplayer( attacker ) || !isdefined( self.script_owner ) )
    {
        return;
    }
    
    if ( level.teambased && attacker.team == self.script_owner.team || attacker == self )
    {
        return;
    }
    
    if ( !isdefined( self.attackerdata ) || !isdefined( self.attackers ) )
    {
        self.attackerdata = [];
        self.attackers = [];
    }
    
    if ( !isdefined( self.attackerdata[ attacker.clientid ] ) )
    {
        self.attackerclientid[ attacker.clientid ] = spawnstruct();
        self.attackers[ self.attackers.size ] = attacker;
    }
}

// Namespace dogs/dogs
// Params 0
// Checksum 0x67fce3f0, Offset: 0x22e0
// Size: 0x1c
function function_71fb32a8()
{
    self.attackerdata = [];
    self.attackers = [];
}

// Namespace dogs/dogs
// Params 3
// Checksum 0x16bbd16b, Offset: 0x2308
// Size: 0xcc
function function_f7ae2e49( delay, interval, regen_interval )
{
    self endon( #"death" );
    self endon( #"damage" );
    wait delay;
    step = 0;
    
    while ( step <= 5 )
    {
        if ( self.health >= 100 )
        {
            break;
        }
        
        self.health += regen_interval;
        wait interval;
        step += interval;
    }
    
    self function_71fb32a8();
    self.health = 100;
}

// Namespace dogs/dogs
// Params 0
// Checksum 0x3b533999, Offset: 0x23e0
// Size: 0x180
function function_67f34e48()
{
    waitresult = self waittill( "death" );
    attacker = waitresult.attacker;
    
    if ( isdefined( attacker ) && isplayer( attacker ) )
    {
        if ( isdefined( self.script_owner ) && self.script_owner == attacker )
        {
            return;
        }
        
        if ( level.teambased && isdefined( self.script_owner ) && self.script_owner.team == attacker.team )
        {
            return;
        }
        
        if ( isdefined( self.attackers ) )
        {
            foreach ( player in self.attackers )
            {
                if ( player != attacker )
                {
                    scoreevents::processscoreevent( "killed_dog_assist", player );
                }
            }
        }
        
        attacker notify( #"hash_f716f816" );
    }
}

// Namespace dogs/dogs
// Params 0
// Checksum 0xf33f6f0, Offset: 0x2568
// Size: 0x4a
function function_e5321612()
{
    exits = getnodearray( "exit", "script_noteworthy" );
    return arraygetclosest( self.origin, exits );
}

// Namespace dogs/dogs
// Params 1
// Checksum 0x24e214ab, Offset: 0x25c0
// Size: 0x1ea
function function_f436e711( area )
{
    self endon( #"disconnect" );
    dogs = dog_manager_get_dogs();
    
    foreach ( dog in dogs )
    {
        if ( !isalive( dog ) )
        {
            continue;
        }
        
        if ( dog istouching( area ) )
        {
            var_1e4494fd = 1;
            
            if ( isplayer( self ) )
            {
                if ( level.teambased && dog.team == self.team )
                {
                    var_1e4494fd = 0;
                }
                else if ( !level.teambased && isdefined( dog.script_owner ) && self == dog.script_owner )
                {
                    var_1e4494fd = 0;
                }
            }
            
            if ( isdefined( dog.var_3d2daafa ) && dog.var_3d2daafa + 1500 > gettime() )
            {
                var_1e4494fd = 0;
            }
            
            if ( var_1e4494fd )
            {
                dog setflashbanged( 1, 500 );
                dog.var_3d2daafa = gettime();
            }
        }
    }
}

/#

    // Namespace dogs/dogs
    // Params 0
    // Checksum 0xb87c0550, Offset: 0x27b8
    // Size: 0x2a0, Type: dev
    function function_cced6d39()
    {
        setdvar( "<dev string:xcf>", "<dev string:xda>" );
        debug_patrol = 0;
        
        for ( ;; )
        {
            cmd = getdvarstring( "<dev string:xcf>" );
            
            switch ( cmd )
            {
                case #"spawn_friendly":
                    player = util::gethostplayer();
                    devgui_dog_spawn( player.team );
                    break;
                case #"spawn_enemy":
                    player = util::gethostplayer();
                    
                    foreach ( team in level.teams )
                    {
                        if ( team == player.team )
                        {
                            continue;
                        }
                        
                        devgui_dog_spawn( team );
                    }
                    
                    break;
                case #"hash_2a26cf5e":
                    level function_fb1a25fe();
                    break;
                case #"hash_88b27fa5":
                    function_dd7ddc82();
                    break;
                case #"hash_7fc546e2":
                    function_649863ab();
                    break;
                case #"hash_c67bc647":
                    function_545a4b27();
                    break;
                case #"show_spawns":
                    function_a4d2dcc5();
                    break;
                case #"hash_8776834":
                    function_7cc16e06();
                    break;
                case #"hash_8dbede50":
                    devgui_debug_route();
                    break;
            }
            
            if ( cmd != "<dev string:xda>" )
            {
                setdvar( "<dev string:xcf>", "<dev string:xda>" );
            }
            
            wait 0.5;
        }
    }

    // Namespace dogs/dogs
    // Params 1
    // Checksum 0x580a9a4, Offset: 0x2a60
    // Size: 0x2ac, Type: dev
    function devgui_dog_spawn( team )
    {
        player = util::gethostplayer();
        dog_spawner = getent( "<dev string:x14a>", "<dev string:x156>" );
        level.var_fb1a25fe = 0;
        
        if ( !isdefined( dog_spawner ) )
        {
            iprintln( "<dev string:x93>" );
            return;
        }
        
        direction = player getplayerangles();
        direction_vec = anglestoforward( direction );
        eye = player geteye();
        scale = 8000;
        direction_vec = ( direction_vec[ 0 ] * scale, direction_vec[ 1 ] * scale, direction_vec[ 2 ] * scale );
        trace = bullettrace( eye, eye + direction_vec, 0, undefined );
        nodes = getnodesinradius( trace[ "<dev string:x161>" ], 256, 0, 128, "<dev string:x16a>", 8 );
        
        if ( !nodes.size )
        {
            iprintln( "<dev string:x16f>" );
            return;
        }
        
        iprintln( "<dev string:x196>" );
        node = arraygetclosest( trace[ "<dev string:x161>" ], nodes );
        dog = function_4b764fa6( player, player.team, node, 5 );
        
        if ( team != player.team )
        {
            dog.team = team;
            dog clearentityowner();
            dog notify( #"clear_owner" );
        }
    }

    // Namespace dogs/dogs
    // Params 0
    // Checksum 0x3c3c3c0f, Offset: 0x2d18
    // Size: 0x2cc, Type: dev
    function function_dd7ddc82()
    {
        player = util::gethostplayer();
        
        if ( !isdefined( level.var_dd7ddc82 ) )
        {
            level.var_dd7ddc82 = 0;
        }
        
        dog = undefined;
        dogs = dog_manager_get_dogs();
        
        if ( dogs.size <= 0 )
        {
            level.var_dd7ddc82 = undefined;
            player cameraactivate( 0 );
            return;
        }
        
        for ( i = 0; i < dogs.size ; i++ )
        {
            dog = dogs[ i ];
            
            if ( !isdefined( dog ) || !isalive( dog ) )
            {
                dog = undefined;
                continue;
            }
            
            if ( !isdefined( dog.cam ) )
            {
                forward = anglestoforward( dog.angles );
                dog.cam = spawn( "<dev string:x1be>", dog.origin + ( 0, 0, 50 ) + forward * -100 );
                dog.cam setmodel( "<dev string:x1cb>" );
                dog.cam linkto( dog );
            }
            
            if ( dog getentitynumber() <= level.var_dd7ddc82 )
            {
                dog = undefined;
                continue;
            }
            
            break;
        }
        
        if ( isdefined( dog ) )
        {
            level.var_dd7ddc82 = dog getentitynumber();
            player camerasetposition( dog.cam );
            player camerasetlookat( dog );
            player cameraactivate( 1 );
            return;
        }
        
        level.var_dd7ddc82 = undefined;
        player cameraactivate( 0 );
    }

    // Namespace dogs/dogs
    // Params 0
    // Checksum 0x45169710, Offset: 0x2ff0
    // Size: 0x184, Type: dev
    function function_649863ab()
    {
        player = util::gethostplayer();
        direction = player getplayerangles();
        direction_vec = anglestoforward( direction );
        eye = player geteye();
        scale = 8000;
        direction_vec = ( direction_vec[ 0 ] * scale, direction_vec[ 1 ] * scale, direction_vec[ 2 ] * scale );
        trace = bullettrace( eye, eye + direction_vec, 0, undefined );
        killcament = spawn( "<dev string:x1be>", player.origin );
        level thread supplydrop::dropcrate( trace[ "<dev string:x161>" ] + ( 0, 0, 25 ), direction, "<dev string:x1d6>", player, player.team, killcament );
    }

    // Namespace dogs/dogs
    // Params 0
    // Checksum 0xbebb7e65, Offset: 0x3180
    // Size: 0x7c, Type: dev
    function function_545a4b27()
    {
        if ( !isdefined( level.var_e840cd0a ) )
        {
            return;
        }
        
        for ( i = 0; i < level.var_e840cd0a.size ; i++ )
        {
            level.var_e840cd0a[ i ] delete();
        }
        
        level.var_e840cd0a = [];
    }

    // Namespace dogs/dogs
    // Params 0
    // Checksum 0xc5d6e944, Offset: 0x3208
    // Size: 0xee, Type: dev
    function function_a4d2dcc5()
    {
        if ( !isdefined( level.var_6eb95783 ) )
        {
            level.var_6eb95783 = 1;
        }
        else
        {
            level.var_6eb95783 = !level.var_6eb95783;
        }
        
        if ( !level.var_6eb95783 )
        {
            level notify( #"hash_a4038b1" );
            return;
        }
        
        spawns = level.var_a16d1f64;
        color = ( 0, 1, 0 );
        
        for ( i = 0; i < spawns.size ; i++ )
        {
            dev::showonespawnpoint( spawns[ i ], color, "<dev string:x1e1>", 32, "<dev string:x1f1>" );
        }
    }

    // Namespace dogs/dogs
    // Params 0
    // Checksum 0xe7c3e833, Offset: 0x3300
    // Size: 0xfe, Type: dev
    function function_7cc16e06()
    {
        if ( !isdefined( level.var_5d3f68b4 ) )
        {
            level.var_5d3f68b4 = 1;
        }
        else
        {
            level.var_5d3f68b4 = !level.var_5d3f68b4;
        }
        
        if ( !level.var_5d3f68b4 )
        {
            level notify( #"hash_92f820ac" );
            return;
        }
        
        exits = getnodearray( "<dev string:x1fb>", "<dev string:x200>" );
        color = ( 1, 0, 0 );
        
        for ( i = 0; i < exits.size ; i++ )
        {
            dev::showonespawnpoint( exits[ i ], color, "<dev string:x212>", 32, "<dev string:x221>" );
        }
    }

    // Namespace dogs/dogs
    // Params 2
    // Checksum 0x1be05667, Offset: 0x3408
    // Size: 0xa4, Type: dev
    function function_3c74d4e2( node1, node2 )
    {
        self endon( #"death" );
        self endon( #"debug_patrol" );
        
        for ( ;; )
        {
            self setgoal( node1 );
            self waittill( "<dev string:x22a>", "<dev string:x22f>" );
            wait 1;
            self setgoal( node2 );
            self waittill( "<dev string:x22a>", "<dev string:x22f>" );
            wait 1;
        }
    }

    // Namespace dogs/dogs
    // Params 0
    // Checksum 0xe41e67a3, Offset: 0x34b8
    // Size: 0xe4, Type: dev
    function devgui_debug_route()
    {
        iprintln( "<dev string:x238>" );
        nodes = dev::dev_get_node_pair();
        
        if ( !isdefined( nodes ) )
        {
            iprintln( "<dev string:x265>" );
            return;
        }
        
        iprintln( "<dev string:x27b>" );
        dogs = dog_manager_get_dogs();
        
        if ( isdefined( dogs[ 0 ] ) )
        {
            dogs[ 0 ] notify( #"debug_patrol" );
            dogs[ 0 ] thread function_3c74d4e2( nodes[ 0 ], nodes[ 1 ] );
        }
    }

#/
