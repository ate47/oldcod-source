#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/gameobjects_shared;
#using scripts/core_common/influencers_shared;
#using scripts/core_common/lui_shared;
#using scripts/core_common/math_shared;
#using scripts/core_common/popups_shared;
#using scripts/core_common/spawning_shared;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/mp_common/gametypes/globallogic;
#using scripts/mp_common/gametypes/globallogic_audio;
#using scripts/mp_common/gametypes/globallogic_score;
#using scripts/mp_common/pickup_items;
#using scripts/mp_common/util;

#namespace fr;

// Namespace fr/GameType_Init
// Params 1, eflags: 0x40
// Checksum 0x6763a785, Offset: 0xb10
// Size: 0x724
function event_handler[GameType_Init] main( eventstruct )
{
    level.trackweaponstats = 0;
    globallogic::init();
    clientfield::register( "world", "freerun_state", 1, 3, "int" );
    clientfield::register( "world", "freerun_retries", 1, 16, "int" );
    clientfield::register( "world", "freerun_faults", 1, 16, "int" );
    clientfield::register( "world", "freerun_startTime", 1, 31, "int" );
    clientfield::register( "world", "freerun_finishTime", 1, 31, "int" );
    clientfield::register( "world", "freerun_bestTime", 1, 31, "int" );
    clientfield::register( "world", "freerun_timeAdjustment", 1, 31, "int" );
    clientfield::register( "world", "freerun_timeAdjustmentNegative", 1, 1, "int" );
    clientfield::register( "world", "freerun_bulletPenalty", 1, 16, "int" );
    clientfield::register( "world", "freerun_pausedTime", 1, 31, "int" );
    clientfield::register( "world", "freerun_checkpointIndex", 1, 7, "int" );
    util::registertimelimit( 0, 1440 );
    util::registerscorelimit( 0, 50000 );
    util::registerroundlimit( 0, 10 );
    util::registerroundwinlimit( 0, 10 );
    util::registernumlives( 0, 100 );
    globallogic::registerfriendlyfiredelay( level.gametype, 0, 0, 1440 );
    level.scoreroundwinbased = getgametypesetting( "cumulativeRoundScores" ) == 0;
    level.teamscoreperkill = getgametypesetting( "teamScorePerKill" );
    level.teamscoreperdeath = getgametypesetting( "teamScorePerDeath" );
    level.teamscoreperheadshot = getgametypesetting( "teamScorePerHeadshot" );
    level.onstartgametype = &onstartgametype;
    level.onspawnplayer = &onspawnplayer;
    level.givecustomloadout = &givecustomloadout;
    level.postroundtime = 0.5;
    level.doendgamescoreboard = 0;
    callback::on_connect( &on_player_connect );
    gameobjects::register_allowed_gameobject( "dm" );
    gameobjects::register_allowed_gameobject( level.gametype );
    
    if ( !isdefined( level.var_eabce8a5 ) )
    {
        level.var_eabce8a5 = "ui/fx_fr_target_impact";
    }
    
    if ( !isdefined( level.var_f8e7e827 ) )
    {
        level.var_f8e7e827 = "ui/fx_fr_target_demat";
    }
    
    if ( !isdefined( level.var_8e44204e ) )
    {
        level.var_8e44204e = "wpn_grenade_explode_default";
    }
    
    level.var_25665cdb = spawnstruct();
    level.var_25665cdb.var_337010cc = 0;
    level.var_25665cdb.tracks = [];
    
    for ( i = 0; i < 1 ; i++ )
    {
        level.var_25665cdb.tracks[ i ] = spawnstruct();
        level.var_25665cdb.tracks[ i ].var_25839439 = getent( "fr_start_0" + i, "targetname" );
        assert( isdefined( level.var_25665cdb.tracks[ i ].var_25839439 ) );
        level.var_25665cdb.tracks[ i ].goaltrigger = getent( "fr_end_0" + i, "targetname" );
        assert( isdefined( level.var_25665cdb.tracks[ i ].goaltrigger ) );
        level.var_25665cdb.tracks[ i ].highscores = [];
    }
    
    level.var_25665cdb.var_fe1de148 = getentarray( "fr_checkpoint", "targetname" );
    assert( level.var_25665cdb.var_fe1de148.size );
    globallogic::setvisiblescoreboardcolumns( "pointstowin", "kills", "deaths", "headshots", "score" );
}

// Namespace fr/fr
// Params 1
// Checksum 0xc57bcd58, Offset: 0x1240
// Size: 0xb4
function setupteam( team )
{
    util::setobjectivetext( team, &"OBJECTIVES_FR" );
    
    if ( level.splitscreen )
    {
        util::setobjectivescoretext( team, &"OBJECTIVES_FR" );
    }
    else
    {
        util::setobjectivescoretext( team, &"OBJECTIVES_FR_SCORE" );
    }
    
    util::setobjectivehinttext( team, &"OBJECTIVES_FR_SCORE" );
    spawning::add_spawn_points( team, "mp_dm_spawn" );
}

// Namespace fr/fr
// Params 0
// Checksum 0x12b61e4a, Offset: 0x1300
// Size: 0x960
function onstartgametype()
{
    setclientnamemode( "auto_change" );
    level.usexcamsforendgame = 0;
    level.var_d1b7628a = 0;
    level.var_43b32a7 = 1;
    level.disablestattracking = 1;
    influencers::create_map_placed_influencers();
    level.spawnmins = ( 0, 0, 0 );
    level.spawnmaxs = ( 0, 0, 0 );
    
    foreach ( team in level.teams )
    {
        setupteam( team );
    }
    
    spawns = spawning::get_spawnpoint_array( "mp_dm_spawn" );
    spawning::updateallspawnpoints();
    
    foreach ( index, trigger in level.var_25665cdb.var_fe1de148 )
    {
        level.var_25665cdb.checkPointTimes[ index ] = 0;
        trigger.var_6ae4cd19 = index;
        trigger thread function_fcf737dc();
        closest = 99999999;
        
        foreach ( spawn in spawns )
        {
            dist = distancesquared( spawn.origin, trigger.origin );
            
            if ( dist < closest )
            {
                closest = dist;
                trigger.spawnpoint = spawn;
            }
        }
        
        assert( isdefined( trigger.spawnpoint ) );
    }
    
    var_2d05ef52 = spawning::get_spawnpoint_array( "info_player_start" );
    assert( var_2d05ef52.size );
    
    foreach ( track in level.var_25665cdb.tracks )
    {
        closest = 99999999;
        
        foreach ( start in var_2d05ef52 )
        {
            dist = distancesquared( start.origin, track.var_25839439.origin );
            
            if ( dist < closest )
            {
                closest = dist;
                track.var_cf6f6eda = start;
            }
        }
        
        assert( isdefined( track.var_cf6f6eda ) );
    }
    
    level.var_25665cdb.var_8f39bd5e = getentarray( "fr_die", "targetname" );
    assert( level.var_25665cdb.var_8f39bd5e.size );
    
    foreach ( trigger in level.var_25665cdb.var_8f39bd5e )
    {
        trigger thread function_543f1f48();
    }
    
    function_45fad1d5();
    
    if ( !isdefined( level.freerun ) )
    {
        level.freerun = 1;
    }
    
    level.mapcenter = math::find_box_center( level.spawnmins, level.spawnmaxs );
    setmapcenter( level.mapcenter );
    spawnpoint = spawning::get_random_intermission_point();
    setdemointermissionpoint( spawnpoint.origin, spawnpoint.angles );
    level.usestartspawns = 0;
    level.displayroundendtext = 0;
    
    if ( !util::isoneround() )
    {
        level.displayroundendtext = 1;
    }
    
    foreach ( item in level.pickup_items )
    {
        closest = 99999999;
        
        foreach ( trigger in level.var_25665cdb.var_fe1de148 )
        {
            dist = distancesquared( item.origin, trigger.origin );
            
            if ( dist < closest )
            {
                closest = dist;
                item.checkpoint = trigger;
            }
        }
        
        assert( isdefined( item.checkpoint ) );
        item.checkpoint.weapon = item.visuals[ 0 ].items[ 0 ].weapon;
        item.checkpoint.weaponobject = item;
        item.checkpoint function_c7cec620();
    }
    
    thread function_d9194505();
    level.var_25665cdb.trackindex = getfreeruntrackindex();
    level.var_25665cdb.mapUniqueId = getmissionuniqueid();
    level.var_25665cdb.mapversion = getmissionversion();
}

// Namespace fr/fr
// Params 0
// Checksum 0x8e980dab, Offset: 0x1c68
// Size: 0x7c
function function_d9194505()
{
    level waittill( "game_ended" );
    
    if ( !function_5e3571bb() )
    {
        level clientfield::set( "freerun_finishTime", 0 );
    }
    
    self function_e7717344();
    level clientfield::set( "freerun_state", 4 );
}

// Namespace fr/fr
// Params 0
// Checksum 0xb790b3bd, Offset: 0x1cf0
// Size: 0x1c
function on_player_connect()
{
    self thread on_menu_response();
}

// Namespace fr/fr
// Params 0
// Checksum 0x79eb43a3, Offset: 0x1d18
// Size: 0xd0
function on_menu_response()
{
    self endon( #"disconnect" );
    
    for ( ;; )
    {
        waitresult = self waittill( "menuresponse" );
        menu = waitresult.menu;
        response = waitresult.response;
        
        if ( response == "fr_restart" )
        {
            self playsoundtoplayer( "uin_freerun_reset", self );
            self thread function_b7a29f53();
            function_53fb4d3b( level.var_25665cdb.var_337010cc );
        }
    }
}

// Namespace fr/fr
// Params 1
// Checksum 0x9db9afc9, Offset: 0x1df0
// Size: 0x144
function onspawnplayer( predictedspawn )
{
    spawning::onspawnplayer( predictedspawn );
    
    if ( predictedspawn )
    {
        return;
    }
    
    if ( isdefined( self.var_98201a24 ) )
    {
        self.body hide();
        function_8f0e1bf3();
        return;
    }
    
    self.var_98201a24 = 1;
    self thread function_3568abeb();
    self thread function_53fb4d3b( level.var_25665cdb.var_337010cc );
    self thread function_a17ae473();
    self thread function_f32cd29e();
    self thread function_b7a29f53();
    self thread function_2e46bb();
    level.var_25665cdb.var_6656a4f2 = 0;
    self disableweaponcycling();
}

// Namespace fr/fr
// Params 11
// Checksum 0x193701a5, Offset: 0x1f40
// Size: 0xa4
function on_player_damage( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, modelindex, psoffsettime )
{
    if ( idamage >= self.health )
    {
        self.health = self.maxhealth + 1;
        function_8f0e1bf3();
        return 0;
    }
    
    return idamage;
}

// Namespace fr/fr
// Params 0
// Checksum 0x3516e3ab, Offset: 0x1ff0
// Size: 0x44
function function_2e46bb()
{
    self endon( #"disconnect" );
    
    while ( true )
    {
        self.prev_origin = self.origin;
        self.prev_time = gettime();
        waitframe( 1 );
        waittillframeend();
    }
}

// Namespace fr/fr
// Params 0
// Checksum 0xb6e6d24, Offset: 0x2040
// Size: 0x24
function function_f0870580()
{
    function_70f1fe07();
    function_64134457();
}

// Namespace fr/fr
// Params 0
// Checksum 0x85328fa5, Offset: 0x2070
// Size: 0xe4
function function_64134457()
{
    self freerunsethighscores( level.var_25665cdb.var_b05f45d8.highscores[ 0 ].time, level.var_25665cdb.var_b05f45d8.highscores[ 1 ].time, level.var_25665cdb.var_b05f45d8.highscores[ 2 ].time );
    level clientfield::set( "freerun_bestTime", level.var_25665cdb.var_b05f45d8.highscores[ 0 ].time );
}

// Namespace fr/fr
// Params 1
// Checksum 0xd2899808, Offset: 0x2160
// Size: 0x514
function function_53fb4d3b( trackindex )
{
    level notify( #"activate_track" );
    
    /#
        if ( level.var_25665cdb.tracks.size > 1 )
        {
            iprintln( "<dev string:x28>" + trackindex );
        }
    #/
    
    if ( !isdefined( level.var_25665cdb.tutorials ) || !level.var_25665cdb.tutorials )
    {
        self playlocalsound( "vox_tuto_tutorial_sequence_27" );
    }
    
    level.var_25665cdb.var_945241ef = -1;
    level.var_25665cdb.var_337010cc = trackindex;
    level.var_25665cdb.var_b05f45d8 = level.var_25665cdb.tracks[ trackindex ];
    level.var_25665cdb.var_a73ed5e6 = level.var_25665cdb.var_b05f45d8.var_cf6f6eda;
    level.var_25665cdb.var_8c06ec31 = level.var_25665cdb.var_b05f45d8.var_cf6f6eda.origin;
    level.var_25665cdb.var_bda200c4 = level.var_25665cdb.var_b05f45d8.var_cf6f6eda.angles;
    level.var_25665cdb.var_b05f45d8.goaltrigger thread function_1d665b6d();
    level.var_25665cdb.var_a73ed5e6.var_6ae4cd19 = 0;
    level.var_25665cdb.faults = 0;
    level.var_25665cdb.var_31833820 = 0;
    level.var_25665cdb.checkPointTimes = [];
    
    foreach ( index, trigger in level.var_25665cdb.var_fe1de148 )
    {
        level.var_25665cdb.checkPointTimes[ index ] = 0;
    }
    
    level clientfield::set( "freerun_faults", 0 );
    level clientfield::set( "freerun_retries", 0 );
    level clientfield::set( "freerun_state", 0 );
    level clientfield::set( "freerun_bulletPenalty", 0 );
    level clientfield::set( "freerun_pausedTime", 0 );
    level clientfield::set( "freerun_checkpointIndex", 0 );
    self function_f0870580();
    self givecustomloadout();
    self setorigin( level.var_25665cdb.var_b05f45d8.var_cf6f6eda.origin );
    self setplayerangles( level.var_25665cdb.var_b05f45d8.var_cf6f6eda.angles );
    self setvelocity( ( 0, 0, 0 ) );
    self recordgameevent( "start" );
    resetglass();
    function_913ea0f5();
    pickup_items::respawn_all_pickups();
    self unfreeze();
    self.respawn_position = undefined;
    function_d79de9c3();
    function_6a8c051b();
    level.var_25665cdb.var_b05f45d8.var_25839439 thread function_4161e0ad( self );
}

// Namespace fr/fr
// Params 0
// Checksum 0xc6baf6c1, Offset: 0x2680
// Size: 0x134
function function_a802497e()
{
    level.var_25665cdb.var_d6bf230 = 0;
    level.var_25665cdb.var_8aca8717 = 0;
    level.var_25665cdb.bulletPenalty = 0;
    level.var_25665cdb.var_e918cacf = 0;
    level.var_25665cdb.var_de1118a5 = 0;
    level.var_25665cdb.var_de1118a5 = function_22b5bb47( self );
    level clientfield::set( "freerun_startTime", level.var_25665cdb.var_de1118a5 );
    level clientfield::set( "freerun_state", 1 );
    self playsoundtoplayer( "uin_freerun_start", self );
    self thread function_5a8897c9();
}

// Namespace fr/fr
// Params 2
// Checksum 0x32d674f3, Offset: 0x27c0
// Size: 0xfc
function function_44f42c50( player, endonstring )
{
    self endon( endonstring );
    level.var_25665cdb.var_8c06ec31 = function_41e3cbf7( player.origin );
    level.var_25665cdb.var_bda200c4 = player.angles;
    
    if ( level.var_25665cdb.var_a73ed5e6 != self )
    {
        level.var_25665cdb.var_a73ed5e6 = self;
        player function_5d8cefb2( 0, 0 );
        
        if ( isdefined( self.weaponobject ) )
        {
            self.weaponobject function_8215cc4d();
            self.weaponobject pickup_items::respawn_pickup();
        }
    }
}

// Namespace fr/fr
// Params 1
// Checksum 0xc15379c, Offset: 0x28c8
// Size: 0x24
function function_4d6542e0( player )
{
    self thread function_fcf737dc();
}

// Namespace fr/fr
// Params 1
// Checksum 0xb0f6c366, Offset: 0x28f8
// Size: 0x11a
function function_22b5bb47( player )
{
    curtime = gettime();
    dt = curtime - player.prev_time;
    frac = getfirsttouchfraction( player, self, player.prev_origin, player.origin );
    current_time = curtime - level.var_25665cdb.var_de1118a5 + level.var_25665cdb.bulletPenalty * 1000 + level.var_25665cdb.var_31833820 * 5000 - level.var_25665cdb.var_d6bf230;
    return int( current_time - dt * ( 1 - frac ) );
}

// Namespace fr/fr
// Params 0
// Checksum 0xe2c92d4b, Offset: 0x2a20
// Size: 0x2bc
function function_fcf737dc()
{
    waitresult = self waittill( "trigger" );
    player = waitresult.activator;
    
    if ( isplayer( player ) )
    {
        if ( level.var_25665cdb.var_a73ed5e6 != self )
        {
            checkpoint_index = self.var_6ae4cd19;
            current_time = function_22b5bb47( player );
            first_time = 0;
            
            if ( !isdefined( level.var_25665cdb.checkPointTimes[ checkpoint_index ] ) || level.var_25665cdb.checkPointTimes[ checkpoint_index ] == 0 )
            {
                level.var_25665cdb.checkPointTimes[ checkpoint_index ] = current_time;
                first_time = 1;
            }
            
            if ( first_time )
            {
                if ( isdefined( level.var_25665cdb.var_b05f45d8.var_7edcb0d0 ) )
                {
                    if ( isdefined( level.var_25665cdb.var_b05f45d8.var_7edcb0d0[ checkpoint_index ] ) && level.var_25665cdb.var_b05f45d8.var_7edcb0d0[ checkpoint_index ] )
                    {
                        delta_time = current_time - level.var_25665cdb.var_b05f45d8.var_7edcb0d0[ checkpoint_index ];
                        
                        if ( delta_time < 0 )
                        {
                            delta_time *= -1;
                            sign = 1;
                        }
                        else
                        {
                            sign = 0;
                        }
                        
                        level clientfield::set( "freerun_timeAdjustment", delta_time );
                        level clientfield::set( "freerun_timeAdjustmentNegative", sign );
                    }
                }
                
                level clientfield::set( "freerun_checkpointIndex", checkpoint_index + 1 );
                player playsoundtoplayer( "uin_freerun_checkpoint", player );
            }
        }
        
        self thread util::trigger_thread( player, &function_44f42c50, &function_4d6542e0 );
    }
}

// Namespace fr/fr
// Params 0
// Checksum 0xdb859bd, Offset: 0x2ce8
// Size: 0x70
function function_543f1f48()
{
    while ( true )
    {
        waitresult = self waittill( "trigger" );
        player = waitresult.activator;
        
        if ( isplayer( player ) )
        {
            player function_8f0e1bf3();
        }
    }
}

// Namespace fr/fr
// Params 1
// Checksum 0x73c6b0be, Offset: 0x2d60
// Size: 0x268
function function_60fab53d( player )
{
    var_d140ccdb = level.var_25665cdb.var_b05f45d8;
    var_28e7910f = function_df23f635( function_22b5bb47( player ), level.var_25665cdb.faults, level.var_25665cdb.var_31833820, level.var_25665cdb.bulletPenalty );
    var_c1d18792 = 1;
    var_8561c8cf = 0;
    
    if ( var_d140ccdb.highscores.size > 0 )
    {
        for ( i = 0; i < var_d140ccdb.highscores.size ; i++ )
        {
            if ( var_28e7910f.time < var_d140ccdb.highscores[ i ].time || var_d140ccdb.highscores[ i ].time == 0 )
            {
                var_c1d18792 = 0;
                arrayinsert( var_d140ccdb.highscores, var_28e7910f, i );
                
                if ( i == 0 )
                {
                    var_8561c8cf = 1;
                }
                
                if ( i < 3 )
                {
                    player function_bc412e49( i );
                }
                
                break;
            }
        }
    }
    else
    {
        var_8561c8cf = 1;
    }
    
    if ( var_c1d18792 )
    {
        arrayinsert( var_d140ccdb.highscores, var_28e7910f, var_d140ccdb.highscores.size );
        player function_bc412e49( var_d140ccdb.highscores.size - 1 );
    }
    
    if ( var_8561c8cf )
    {
        player function_43fcd204();
    }
    
    return var_8561c8cf;
}

// Namespace fr/fr
// Params 0
// Checksum 0xac0b0518, Offset: 0x2fd0
// Size: 0x36c
function function_1d665b6d()
{
    level notify( #"hash_32735085" );
    level endon( #"hash_32735085" );
    waitresult = self waittill( "trigger" );
    player = waitresult.activator;
    
    if ( isplayer( player ) )
    {
        player playsoundtoplayer( "uin_freerun_finish", player );
        player function_5d8cefb2( 1, 0 );
        var_8561c8cf = function_60fab53d( player );
        var_abe01f70 = player getdstat( "freerunTracksCompleted" );
        
        if ( var_abe01f70 < level.var_25665cdb.trackindex )
        {
            player setdstat( "freerunTracksCompleted", level.var_25665cdb.trackindex );
        }
        
        player recordgameevent( "completion" );
        player.respawn_position = self.origin;
        player thread freeze();
        player thread function_b7a29f53( 0 );
        player function_64134457();
        level clientfield::set( "freerun_finishTime", function_22b5bb47( player ) );
        level clientfield::set( "freerun_state", 2 );
        level notify( #"hash_eb4adcc3" );
        
        if ( player ishost() )
        {
            level notify( #"hash_79aa8b11" );
            function_6a8c051b();
            level.var_25665cdb.tutorials = 0;
            setlocalprofilevar( "com_firsttime_freerun", 1 );
            var_a6f3447 = getlocalprofileint( "freerunHighestTrack" );
            
            if ( var_a6f3447 < level.var_25665cdb.trackindex )
            {
                setlocalprofilevar( "freerunHighestTrack", level.var_25665cdb.trackindex );
            }
        }
        
        /#
            function_afa06c32();
        #/
        
        wait 1.5;
        uploadstats();
        player uploadleaderboards();
        level clientfield::set( "freerun_state", 5 );
    }
}

// Namespace fr/fr
// Params 0
// Checksum 0x5e199de0, Offset: 0x3348
// Size: 0x1c
function freeze()
{
    self util::freeze_player_controls( 1 );
}

// Namespace fr/fr
// Params 0
// Checksum 0xa21932b4, Offset: 0x3370
// Size: 0x1c
function unfreeze()
{
    self util::freeze_player_controls( 0 );
}

// Namespace fr/fr
// Params 0
// Checksum 0x2cc83a4b, Offset: 0x3398
// Size: 0x432
function function_c7cec620()
{
    target_name = self.weaponobject.visuals[ 0 ].target;
    
    if ( !isdefined( target_name ) )
    {
        return;
    }
    
    self.weaponobject.var_c2417581 = 0;
    self.weaponobject.targets = [];
    self.weaponobject.var_f1970748 = [];
    targets = getentarray( target_name, "targetname" );
    
    foreach ( target in targets )
    {
        if ( target.script_noteworthy == "fr_target" )
        {
            self.weaponobject.targets[ self.weaponobject.targets.size ] = target;
        }
        
        if ( target.script_noteworthy == "fr_target_visual" )
        {
            self.weaponobject.var_f1970748[ self.weaponobject.var_f1970748.size ] = target;
        }
    }
    
    foreach ( target in self.weaponobject.targets )
    {
        foreach ( visual in self.weaponobject.var_f1970748 )
        {
            if ( target.origin == visual.origin )
            {
                target.visual = visual;
            }
        }
    }
    
    foreach ( target in self.weaponobject.targets )
    {
        target.blocker = getent( target.target, "targetname" );
        
        if ( isdefined( target.blocker ) )
        {
            if ( !isdefined( target.blocker.targetcount ) )
            {
                target.blocker.targetcount = 0;
                target.blocker.var_5fb39fa1 = 0;
            }
            
            target.blocker.targetcount++;
            target.blocker.var_5fb39fa1++;
            target.checkpoint = self;
            target.disabled = 0;
            target thread function_1d349946( self.weaponobject );
        }
    }
}

// Namespace fr/fr
// Params 1
// Checksum 0x5af2011e, Offset: 0x37d8
// Size: 0x108
function function_1d349946( weaponobject )
{
    self endon( #"death" );
    
    while ( true )
    {
        waitresult = self waittill( "damage" );
        
        if ( level.var_25665cdb.var_a73ed5e6 != self.checkpoint )
        {
            continue;
        }
        
        if ( waitresult.weapon == level.weaponbasemeleeheld )
        {
            continue;
        }
        
        if ( self.disabled )
        {
            continue;
        }
        
        self function_e4cf3652( waitresult.weapon );
        playfx( level.var_eabce8a5, waitresult.position, waitresult.direction );
        weaponobject.var_c2417581 = gettime();
    }
}

// Namespace fr/fr
// Params 1
// Checksum 0xe30c8547, Offset: 0x38e8
// Size: 0xb4
function function_e4cf3652( weapon )
{
    self.disabled = 1;
    self.visual ghost();
    self.visual notsolid();
    self.blocker function_5ddde12c();
    playfx( level.var_f8e7e827, self.origin );
    playsoundatposition( level.var_8e44204e, self.origin );
}

// Namespace fr/fr
// Params 0
// Checksum 0x7763d6bd, Offset: 0x39a8
// Size: 0x54
function function_67743d5()
{
    self.var_5fb39fa1 = self.targetcount;
    self.disabled = 0;
    self show();
    self solid();
}

// Namespace fr/fr
// Params 0
// Checksum 0x654741a1, Offset: 0x3a08
// Size: 0x5c
function function_5ddde12c()
{
    self.var_5fb39fa1--;
    
    if ( self.var_5fb39fa1 == 0 )
    {
        self.disabled = 1;
        self ghost();
        self notsolid();
    }
}

// Namespace fr/fr
// Params 0
// Checksum 0x54b956f3, Offset: 0x3a70
// Size: 0xea
function function_8215cc4d()
{
    foreach ( target in self.targets )
    {
        target.blocker function_67743d5();
        target.visual show();
        target.visual solid();
        target.disabled = 0;
    }
}

// Namespace fr/fr
// Params 0
// Checksum 0x9f2e0cb, Offset: 0x3b68
// Size: 0xb2
function function_913ea0f5()
{
    foreach ( trigger in level.var_25665cdb.var_fe1de148 )
    {
        if ( isdefined( trigger.weaponobject ) )
        {
            trigger.weaponobject function_8215cc4d();
        }
    }
}

/#

    // Namespace fr/fr
    // Params 0
    // Checksum 0xd8d04c76, Offset: 0x3c28
    // Size: 0x130, Type: dev
    function function_afa06c32()
    {
        for ( i = 0; i < level.var_25665cdb.var_b05f45d8.highscores.size ; i++ )
        {
            println( i + 1 + "<dev string:x2f>" + level.var_25665cdb.var_b05f45d8.highscores[ i ].time );
            
            if ( i == 0 )
            {
                for ( j = 0; j < level.var_25665cdb.var_b05f45d8.var_7edcb0d0.size ; j++ )
                {
                    println( "<dev string:x32>" + j + "<dev string:x2f>" + level.var_25665cdb.var_b05f45d8.var_7edcb0d0[ j ] );
                }
            }
        }
    }

#/

// Namespace fr/fr
// Params 0
// Checksum 0xfdb5941c, Offset: 0x3d60
// Size: 0xfc
function function_f0b248d4()
{
    current_time = gettime();
    var_b921f105 = 20000;
    
    if ( current_time - level.var_25665cdb.var_6656a4f2 < var_b921f105 )
    {
        return;
    }
    
    if ( isdefined( self.var_245080db ) )
    {
        return;
    }
    
    if ( level.var_25665cdb.var_945241ef == level.var_25665cdb.var_a73ed5e6.var_6ae4cd19 )
    {
        return;
    }
    
    level.var_25665cdb.var_945241ef = level.var_25665cdb.var_a73ed5e6.var_6ae4cd19;
    level.var_25665cdb.var_6656a4f2 = current_time;
    self playlocalsound( "vox_tuto_tutorial_fail" );
}

// Namespace fr/fr
// Params 0
// Checksum 0xb60e4f29, Offset: 0x3e68
// Size: 0xb4
function function_8f0e1bf3()
{
    self function_f0b248d4();
    level.var_25665cdb.faults++;
    self recordgameevent( "fault" );
    level clientfield::set( "freerun_faults", level.var_25665cdb.faults );
    self playsoundtoplayer( "uin_freerun_reset", self );
    self function_3c68059c();
}

// Namespace fr/fr
// Params 0
// Checksum 0x817f59dd, Offset: 0x3f28
// Size: 0x1a
function function_3922fe1()
{
    return self actionslotonebuttonpressed();
}

// Namespace fr/fr
// Params 0
// Checksum 0x84e134bf, Offset: 0x3f50
// Size: 0x1a
function function_a817770a()
{
    return self actionslottwobuttonpressed();
}

// Namespace fr/fr
// Params 0
// Checksum 0x883d6d99, Offset: 0x3f78
// Size: 0x1a
function function_3c844102()
{
    return self actionslotfourbuttonpressed();
}

// Namespace fr/fr
// Params 0
// Checksum 0x36590cb6, Offset: 0x3fa0
// Size: 0x1a
function dpad_left_pressed()
{
    return self actionslotthreebuttonpressed();
}

// Namespace fr/fr
// Params 0
// Checksum 0x9dada241, Offset: 0x3fc8
// Size: 0x62, Type: bool
function function_5e3571bb()
{
    state = level clientfield::get( "freerun_state" );
    
    if ( state == 2 || state == 4 || state == 5 )
    {
        return true;
    }
    
    return false;
}

// Namespace fr/fr
// Params 0
// Checksum 0x289b49e0, Offset: 0x4038
// Size: 0x22a
function function_a17ae473()
{
    var_3c1396d6 = level.var_25665cdb.tracks.size;
    
    while ( true )
    {
        waitframe( 1 );
        var_378f58b5 = 0;
        
        if ( function_5e3571bb() )
        {
            continue;
        }
        
        /#
            if ( self function_3c844102() && var_3c1396d6 > 1 )
            {
                var_378f58b5 = 1;
                var_efab0e88 = level.var_25665cdb.var_337010cc;
                var_efab0e88++;
            }
            else if ( self dpad_left_pressed() && var_3c1396d6 > 1 )
            {
                var_378f58b5 = 1;
                var_efab0e88 = level.var_25665cdb.var_337010cc;
                var_efab0e88--;
            }
        #/
        
        if ( !var_378f58b5 && self function_3922fe1() )
        {
            var_378f58b5 = 1;
            var_efab0e88 = level.var_25665cdb.var_337010cc;
            self thread function_b7a29f53();
        }
        
        if ( var_378f58b5 )
        {
            if ( var_efab0e88 == 1 )
            {
                var_efab0e88 = 0;
            }
            else if ( var_efab0e88 < 0 )
            {
                var_efab0e88 = 0;
            }
            
            self playsoundtoplayer( "uin_freerun_reset", self );
            function_53fb4d3b( var_efab0e88 );
            
            while ( true )
            {
                waitframe( 1 );
                
                if ( !( self function_3c844102() || self dpad_left_pressed() || self function_3922fe1() ) )
                {
                    break;
                }
            }
        }
    }
}

// Namespace fr/fr
// Params 0
// Checksum 0x89928f3, Offset: 0x4270
// Size: 0x19a
function function_5a8897c9()
{
    level endon( #"activate_track" );
    level endon( #"hash_eb4adcc3" );
    
    /#
        var_10a5a3be = 0;
    #/
    
    while ( true )
    {
        waitframe( 1 );
        
        if ( function_5e3571bb() )
        {
            continue;
        }
        
        /#
            if ( self isinmovemode( "<dev string:x35>" ) )
            {
                var_10a5a3be = 1;
                continue;
            }
            
            if ( var_10a5a3be && self function_a817770a() )
            {
                continue;
            }
            
            var_10a5a3be = 0;
        #/
        
        if ( self function_a817770a() )
        {
            level.var_25665cdb.var_31833820++;
            self recordgameevent( "retry" );
            level clientfield::set( "freerun_retries", level.var_25665cdb.var_31833820 );
            self playsoundtoplayer( "uin_freerun_reset", self );
            self function_3c68059c();
            
            while ( true )
            {
                waitframe( 1 );
                
                if ( !self function_a817770a() )
                {
                    break;
                }
            }
        }
    }
}

// Namespace fr/fr
// Params 1
// Checksum 0x6702bfc2, Offset: 0x4418
// Size: 0x150, Type: bool
function function_8f77a706( weapon )
{
    if ( !isdefined( level.var_25665cdb.var_a73ed5e6 ) )
    {
        return false;
    }
    
    if ( !isdefined( level.var_25665cdb.var_a73ed5e6.weaponobject ) )
    {
        return false;
    }
    
    grace_period = weapon.firetime * 4 * 1000;
    
    if ( level.var_25665cdb.var_a73ed5e6.weaponobject.var_c2417581 + grace_period >= gettime() )
    {
        return true;
    }
    
    foreach ( target in level.var_25665cdb.var_a73ed5e6.weaponobject.targets )
    {
        if ( !target.disabled )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace fr/fr
// Params 0
// Checksum 0xafd63421, Offset: 0x4570
// Size: 0xc8
function function_f32cd29e()
{
    self endon( #"disconnect" );
    
    while ( true )
    {
        waitresult = self waittill( "weapon_fired" );
        
        if ( waitresult.weapon == level.weaponbasemeleeheld )
        {
            continue;
        }
        
        if ( function_8f77a706( waitresult.weapon ) )
        {
            continue;
        }
        
        level.var_25665cdb.bulletPenalty++;
        level clientfield::set( "freerun_bulletPenalty", level.var_25665cdb.bulletPenalty );
    }
}

// Namespace fr/fr
// Params 1
// Checksum 0x1e185394, Offset: 0x4640
// Size: 0x64
function function_41e3cbf7( position )
{
    trace = bullettrace( position + ( 0, 0, 10 ), position - ( 0, 0, 1000 ), 0, undefined );
    return trace[ "position" ];
}

// Namespace fr/fr
// Params 1
// Checksum 0x9ea2be5d, Offset: 0x46b0
// Size: 0x64
function function_4161e0ad( player )
{
    level endon( #"activate_track" );
    waitresult = self waittill( "trigger" );
    
    if ( waitresult.activator == player )
    {
        player function_a802497e();
    }
}

// Namespace fr/fr
// Params 0
// Checksum 0x7612f4a9, Offset: 0x4720
// Size: 0x234
function function_3c68059c()
{
    resetglass();
    function_913ea0f5();
    pickup_items::respawn_all_pickups();
    function_6a8c051b();
    self playsoundtoplayer( "evt_freerun_respawn", self );
    
    if ( isdefined( self.respawn_position ) )
    {
        self setorigin( self.respawn_position );
        self setvelocity( ( 0, 0, 0 ) );
    }
    else if ( isdefined( level.var_25665cdb.var_a73ed5e6.spawnpoint ) )
    {
        self setorigin( level.var_25665cdb.var_a73ed5e6.spawnpoint.origin );
        self setplayerangles( level.var_25665cdb.var_a73ed5e6.spawnpoint.angles );
        self setvelocity( ( 0, 0, 0 ) );
    }
    else
    {
        spawn_origin = level.var_25665cdb.var_8c06ec31;
        spawn_origin += ( 0, 0, 5 );
        self setorigin( spawn_origin );
        self setplayerangles( level.var_25665cdb.var_bda200c4 );
        self setvelocity( ( 0, 0, 0 ) );
    }
    
    self setdoublejumpenergy( 1 );
    self function_5d8cefb2( 1, 1 );
}

// Namespace fr/fr
// Params 0
// Checksum 0xeb605717, Offset: 0x4960
// Size: 0x9e
function givecustomloadout()
{
    self takeallweapons();
    self clearperks();
    self setperk( "specialty_fallheight" );
    self giveweapon( level.weaponbasemeleeheld );
    self setspawnweapon( level.weaponbasemeleeheld );
    return level.weaponbasemeleeheld;
}

// Namespace fr/fr
// Params 4
// Checksum 0xf0d5611, Offset: 0x4a08
// Size: 0x64
function function_3e05d0a6( trackindex, slot, stat, value )
{
    self setdstat( "freerunTrackTimes", "track", trackindex, "topTimes", slot, stat, value );
}

// Namespace fr/fr
// Params 1
// Checksum 0xcf18f37b, Offset: 0x4a78
// Size: 0x246
function function_bc412e49( start_index )
{
    var_d140ccdb = level.var_25665cdb.var_b05f45d8;
    self setdstat( "freerunTrackTimes", "track", level.var_25665cdb.trackindex, "mapUniqueId", level.var_25665cdb.mapUniqueId );
    self setdstat( "freerunTrackTimes", "track", level.var_25665cdb.trackindex, "mapVersion", level.var_25665cdb.mapversion );
    
    for ( slot = start_index; slot < 3 ; slot++ )
    {
        function_3e05d0a6( level.var_25665cdb.trackindex, slot, "time", var_d140ccdb.highscores[ slot ].time );
        function_3e05d0a6( level.var_25665cdb.trackindex, slot, "faults", var_d140ccdb.highscores[ slot ].faults );
        function_3e05d0a6( level.var_25665cdb.trackindex, slot, "retries", var_d140ccdb.highscores[ slot ].retries );
        function_3e05d0a6( level.var_25665cdb.trackindex, slot, "bulletPenalty", var_d140ccdb.highscores[ slot ].bulletPenalty );
    }
}

// Namespace fr/fr
// Params 0
// Checksum 0xfce20e48, Offset: 0x4cc8
// Size: 0xce
function function_43fcd204()
{
    level.var_25665cdb.var_b05f45d8.var_7edcb0d0 = level.var_25665cdb.checkPointTimes;
    
    for ( i = 0; i < level.var_25665cdb.var_fe1de148.size ; i++ )
    {
        self setdstat( "freerunTrackTimes", "track", level.var_25665cdb.trackindex, "checkPointTimes", "time", i, level.var_25665cdb.checkPointTimes[ i ] );
    }
}

// Namespace fr/fr
// Params 3
// Checksum 0x486c7bb4, Offset: 0x4da0
// Size: 0x52
function function_bd426152( trackindex, slot, stat )
{
    return self getdstat( "freerunTrackTimes", "track", trackindex, "topTimes", slot, stat );
}

// Namespace fr/fr
// Params 4
// Checksum 0x9f092a12, Offset: 0x4e00
// Size: 0x94
function function_df23f635( time, faults, retries, bulletPenalty )
{
    var_d2980694 = spawnstruct();
    var_d2980694.time = time;
    var_d2980694.faults = faults;
    var_d2980694.retries = retries;
    var_d2980694.bulletPenalty = bulletPenalty;
    return var_d2980694;
}

// Namespace fr/fr
// Params 2
// Checksum 0x82dde946, Offset: 0x4ea0
// Size: 0xfa
function function_f4a85cb3( trackindex, slot )
{
    time = self function_bd426152( trackindex, slot, "time" );
    faults = self function_bd426152( trackindex, slot, "faults" );
    retries = self function_bd426152( trackindex, slot, "retries" );
    bulletPenalty = self function_bd426152( trackindex, slot, "bulletPenalty" );
    return function_df23f635( time, faults, retries, bulletPenalty );
}

// Namespace fr/fr
// Params 1
// Checksum 0x45b1324c, Offset: 0x4fa8
// Size: 0xa0
function function_a32e3363( trackindex )
{
    for ( i = 0; i < level.var_25665cdb.var_fe1de148.size ; i++ )
    {
        level.var_25665cdb.var_b05f45d8.var_7edcb0d0[ i ] = self getdstat( "freerunTrackTimes", "track", trackindex, "checkPointTimes", "time", i );
    }
}

// Namespace fr/fr
// Params 0
// Checksum 0x8386d45f, Offset: 0x5050
// Size: 0x264
function function_70f1fe07()
{
    if ( isdefined( level.var_25665cdb.var_b05f45d8.var_c41383e ) )
    {
        return;
    }
    
    mapid = self getdstat( "freerunTrackTimes", "track", level.var_25665cdb.trackindex, "mapUniqueId" );
    mapversion = self getdstat( "freerunTrackTimes", "track", level.var_25665cdb.trackindex, "mapVersion" );
    
    if ( level.var_25665cdb.mapUniqueId != mapid || level.var_25665cdb.mapversion != mapversion )
    {
        for ( i = 0; i < 3 ; i++ )
        {
            level.var_25665cdb.var_b05f45d8.highscores[ i ] = function_df23f635( 0, 0, 0, 0 );
        }
        
        for ( i = 0; i < level.var_25665cdb.var_fe1de148.size ; i++ )
        {
            level.var_25665cdb.var_b05f45d8.var_7edcb0d0[ i ] = 0;
        }
    }
    else
    {
        for ( i = 0; i < 3 ; i++ )
        {
            level.var_25665cdb.var_b05f45d8.highscores[ i ] = function_f4a85cb3( level.var_25665cdb.trackindex, i );
        }
        
        function_a32e3363( level.var_25665cdb.trackindex );
    }
    
    level.var_25665cdb.var_b05f45d8.var_c41383e = 1;
}

// Namespace fr/fr
// Params 2
// Checksum 0x3fa94e7a, Offset: 0x52c0
// Size: 0x242
function function_5d8cefb2( var_18c6a955, immediate )
{
    self endon( #"disconnect" );
    self endon( #"death" );
    var_a52112e9 = level.weaponnone;
    
    if ( isdefined( level.var_25665cdb.var_a73ed5e6.weapon ) && !var_18c6a955 )
    {
        var_a52112e9 = level.var_25665cdb.var_a73ed5e6.weapon;
    }
    
    if ( immediate )
    {
        self switchtoweaponimmediate( level.weaponbasemeleeheld );
    }
    else
    {
        while ( self isswitchingweapons() )
        {
            waitframe( 1 );
        }
        
        current_weapon = self getcurrentweapon();
        
        if ( current_weapon != level.weaponbasemeleeheld && var_a52112e9 != current_weapon )
        {
            self switchtoweapon( level.weaponbasemeleeheld );
            
            while ( self getcurrentweapon() != level.weaponbasemeleeheld )
            {
                waitframe( 1 );
            }
        }
    }
    
    weaponslist = self getweaponslist();
    
    foreach ( weapon in weaponslist )
    {
        if ( weapon != level.weaponbasemeleeheld && var_a52112e9 != weapon )
        {
            self takeweapon( weapon );
        }
    }
}

// Namespace fr/fr
// Params 1
// Checksum 0x4a074be9, Offset: 0x5510
// Size: 0xf4
function function_b7a29f53( start )
{
    if ( !isdefined( start ) )
    {
        start = 1;
    }
    
    player = self;
    
    if ( start && !( isdefined( player.var_ec90ebbe ) && player.var_ec90ebbe ) )
    {
        mapname = getdvarstring( "mapname" );
        player globallogic_audio::set_music_on_player( mapname );
        player.var_ec90ebbe = 1;
        return;
    }
    
    if ( !start )
    {
        player globallogic_audio::set_music_on_player( "mp_freerun_finish" );
        player.var_ec90ebbe = 0;
    }
}

// Namespace fr/fr
// Params 1
// Checksum 0x6b613e41, Offset: 0x5610
// Size: 0xc
function function_6853b180( var_1d08f968 )
{
    
}

// Namespace fr/fr
// Params 0
// Checksum 0xeea6af71, Offset: 0x5628
// Size: 0xca
function function_6a8c051b()
{
    if ( level.var_25665cdb.tutorials )
    {
        if ( level clientfield::get( "freerun_state" ) == 3 )
        {
        }
        
        foreach ( player in level.players )
        {
            player function_6853b180( 0 );
        }
    }
}

// Namespace fr/fr
// Params 0
// Checksum 0xfe640c63, Offset: 0x5700
// Size: 0xca
function function_5f56393a()
{
    if ( level.var_25665cdb.tutorials )
    {
        if ( level clientfield::get( "freerun_state" ) == 1 )
        {
        }
        
        foreach ( player in level.players )
        {
            player function_6853b180( 1 );
        }
    }
}

// Namespace fr/fr
// Params 0
// Checksum 0xed5c93b6, Offset: 0x57d8
// Size: 0xb2
function function_d79de9c3()
{
    if ( level.var_25665cdb.tutorials )
    {
        foreach ( trigger in level.var_25665cdb.var_d98df83c )
        {
            trigger triggerenable( 1 );
        }
    }
}

// Namespace fr/fr
// Params 0
// Checksum 0x948a7cb, Offset: 0x5898
// Size: 0x112
function function_3568abeb()
{
    if ( ( !self ishost() || getlocalprofileint( "com_firsttime_freerun" ) ) && !getdvarint( "freerun_tutorial" ) )
    {
        return;
    }
    
    level.var_25665cdb.tutorials = 1;
    wait 1;
    
    foreach ( trigger in level.var_25665cdb.var_d98df83c )
    {
        trigger thread function_b2a3d954();
    }
}

// Namespace fr/fr
// Params 0
// Checksum 0x61ac183c, Offset: 0x59b8
// Size: 0x7c
function function_45fad1d5()
{
    level.var_25665cdb.tutorials = 0;
    level.var_25665cdb.var_d98df83c = getentarray( "fr_tutorial", "targetname" );
    level.var_25665cdb.var_9be3d60e = [];
    function_cb9f70f2();
}

// Namespace fr/fr
// Params 0
// Checksum 0x6cd22011, Offset: 0x5a40
// Size: 0xa0
function function_b2a3d954()
{
    level endon( #"hash_79aa8b11" );
    
    while ( true )
    {
        waitresult = self waittill( "trigger" );
        player = waitresult.activator;
        
        if ( isplayer( player ) )
        {
            player thread function_ef3ed1a8( self.script_noteworthy );
            self triggerenable( 0 );
        }
    }
}

// Namespace fr/fr
// Params 0
// Checksum 0x4bdf5a9c, Offset: 0x5ae8
// Size: 0x8c
function stop_tutorial_when_restarting_track()
{
    self notify( #"stop_tutorial_when_restarting_track" );
    self waittill( "stop_tutorial_when_restarting_track" );
    level waittill( "activate_track" );
    function_6a8c051b();
    self util::hide_hint_text( 0 );
    self function_e7717344();
    self stopsounds();
}

// Namespace fr/fr
// Params 1
// Checksum 0x11fe5ed0, Offset: 0x5b80
// Size: 0xe4
function function_ef3ed1a8( tutorial )
{
    self endon( #"death" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    level endon( #"activate_track" );
    
    if ( !isdefined( level.var_25665cdb.var_9be3d60e[ tutorial ] ) )
    {
        return;
    }
    
    level notify( #"hash_582e32ca" );
    level endon( #"hash_582e32ca" );
    self thread stop_tutorial_when_restarting_track();
    function_5f56393a();
    wait 0.5;
    [[ level.var_25665cdb.var_9be3d60e[ tutorial ] ]]();
    function_6a8c051b();
}

// Namespace fr/fr
// Params 0
// Checksum 0x5a4417c, Offset: 0x5c70
// Size: 0x3e
function function_e7717344()
{
    if ( isdefined( self.var_245080db ) )
    {
        self stopsound( self.var_245080db );
        self.var_245080db = undefined;
    }
}

// Namespace fr/fr
// Params 1
// Checksum 0xd56f88e6, Offset: 0x5cb8
// Size: 0x6c
function function_6edc6e5e( aliasstring )
{
    self function_e7717344();
    self.var_245080db = aliasstring;
    self playsoundwithnotify( aliasstring, "sounddone" );
    self waittill( "sounddone" );
    wait 1;
}

// Namespace fr/fr
// Params 2
// Checksum 0xc0be999f, Offset: 0x5d30
// Size: 0x8c
function function_81ca9cf3( aliasstring, text )
{
    self function_e7717344();
    self thread function_80337ef( text );
    self.var_245080db = aliasstring;
    self playsoundwithnotify( aliasstring, "sounddone" );
    self waittill( "sounddone" );
    wait 1;
}

// Namespace fr/fr
// Params 3
// Checksum 0xa4cd12ba, Offset: 0x5dc8
// Size: 0x44
function function_80337ef( text, time, var_f1cb7647 )
{
    wait 0.5;
    function_20d4b0e5( text, time, var_f1cb7647 );
}

// Namespace fr/fr
// Params 3
// Checksum 0x7bacbf63, Offset: 0x5e18
// Size: 0x84
function function_20d4b0e5( text, time, var_f1cb7647 )
{
    if ( isdefined( var_f1cb7647 ) )
    {
        function_6a8c051b();
    }
    
    if ( !isdefined( time ) )
    {
        time = 4;
    }
    
    self util::show_hint_text( text, 0, "activate_track", 4 );
    wait 4.5;
}

// Namespace fr/fr
// Params 2
// Checksum 0xea0adb55, Offset: 0x5ea8
// Size: 0x34
function function_b3bea47c( text, time )
{
    function_20d4b0e5( text, time, 1 );
}

// Namespace fr/fr
// Params 0
// Checksum 0x52583ff7, Offset: 0x5ee8
// Size: 0x392
function function_cb9f70f2()
{
    level.var_25665cdb.var_9be3d60e[ "tutorial_01" ] = &tutorial_01;
    level.var_25665cdb.var_9be3d60e[ "tutorial_02" ] = &tutorial_02;
    level.var_25665cdb.var_9be3d60e[ "tutorial_03" ] = &tutorial_03;
    level.var_25665cdb.var_9be3d60e[ "tutorial_06" ] = &tutorial_06;
    level.var_25665cdb.var_9be3d60e[ "tutorial_08" ] = &tutorial_08;
    level.var_25665cdb.var_9be3d60e[ "tutorial_09" ] = &tutorial_09;
    level.var_25665cdb.var_9be3d60e[ "tutorial_10" ] = &tutorial_10;
    level.var_25665cdb.var_9be3d60e[ "tutorial_10a" ] = &tutorial_10a;
    level.var_25665cdb.var_9be3d60e[ "tutorial_12" ] = &tutorial_12;
    level.var_25665cdb.var_9be3d60e[ "tutorial_12a" ] = &tutorial_12a;
    level.var_25665cdb.var_9be3d60e[ "tutorial_13" ] = &tutorial_13;
    level.var_25665cdb.var_9be3d60e[ "tutorial_14" ] = &tutorial_14;
    level.var_25665cdb.var_9be3d60e[ "tutorial_15" ] = &tutorial_15;
    level.var_25665cdb.var_9be3d60e[ "tutorial_16" ] = &tutorial_16;
    level.var_25665cdb.var_9be3d60e[ "tutorial_17" ] = &tutorial_17;
    level.var_25665cdb.var_9be3d60e[ "tutorial_17a" ] = &tutorial_17a;
    level.var_25665cdb.var_9be3d60e[ "tutorial_18" ] = &tutorial_18;
    level.var_25665cdb.var_9be3d60e[ "tutorial_19" ] = &tutorial_19;
    level.var_25665cdb.var_9be3d60e[ "tutorial_20" ] = &tutorial_20;
}

// Namespace fr/fr
// Params 0
// Checksum 0x71bd45be, Offset: 0x6288
// Size: 0x64
function tutorial_01()
{
    self function_6edc6e5e( "vox_tuto_tutorial_sequence_1" );
    self function_6edc6e5e( "vox_tuto_tutorial_sequence_2" );
    self function_6edc6e5e( "vox_tuto_tutorial_sequence_6" );
}

// Namespace fr/fr
// Params 0
// Checksum 0x5656c0a, Offset: 0x62f8
// Size: 0x24
function tutorial_02()
{
    self function_b3bea47c( &"FREERUN_TUTORIAL_02" );
}

// Namespace fr/fr
// Params 0
// Checksum 0x868587e2, Offset: 0x6328
// Size: 0x24
function tutorial_03()
{
    self function_b3bea47c( &"FREERUN_TUTORIAL_03" );
}

// Namespace fr/fr
// Params 0
// Checksum 0xff8a2884, Offset: 0x6358
// Size: 0x44
function tutorial_06()
{
    self thread function_6edc6e5e( "vox_tuto_tutorial_sequence_11" );
    self function_b3bea47c( &"FREERUN_TUTORIAL_09" );
}

// Namespace fr/fr
// Params 0
// Checksum 0x2f45469a, Offset: 0x63a8
// Size: 0x24
function tutorial_08()
{
    self function_b3bea47c( &"FREERUN_TUTORIAL_11" );
}

// Namespace fr/fr
// Params 0
// Checksum 0x3dc741f3, Offset: 0x63d8
// Size: 0x2c
function tutorial_09()
{
    self function_81ca9cf3( "vox_tuto_tutorial_sequence_28", &"FREERUN_TUTORIAL_12" );
}

// Namespace fr/fr
// Params 0
// Checksum 0x8ea19740, Offset: 0x6410
// Size: 0x24
function tutorial_10()
{
    self function_6edc6e5e( "vox_tuto_tutorial_sequence_10" );
}

// Namespace fr/fr
// Params 0
// Checksum 0xc3f1366a, Offset: 0x6440
// Size: 0x24
function tutorial_10a()
{
    self function_b3bea47c( &"FREERUN_TUTORIAL_13" );
}

// Namespace fr/fr
// Params 0
// Checksum 0x57293f28, Offset: 0x6470
// Size: 0x24
function tutorial_12()
{
    self function_6edc6e5e( "vox_tuto_tutorial_sequence_16" );
}

// Namespace fr/fr
// Params 0
// Checksum 0x60fbd8b8, Offset: 0x64a0
// Size: 0x24
function tutorial_12a()
{
    self function_b3bea47c( &"FREERUN_TUTORIAL_14" );
}

// Namespace fr/fr
// Params 0
// Checksum 0x8d6cfa45, Offset: 0x64d0
// Size: 0x6c
function tutorial_13()
{
    self function_81ca9cf3( "vox_tuto_tutorial_sequence_17", &"FREERUN_TUTORIAL_14a" );
    self function_6edc6e5e( "vox_tuto_tutorial_sequence_18" );
    self function_b3bea47c( &"FREERUN_TUTORIAL_16" );
}

// Namespace fr/fr
// Params 0
// Checksum 0x38cce1ac, Offset: 0x6548
// Size: 0x44
function tutorial_14()
{
    self function_6edc6e5e( "vox_tuto_tutorial_sequence_19" );
    self function_b3bea47c( &"FREERUN_TUTORIAL_18" );
}

// Namespace fr/fr
// Params 0
// Checksum 0x6001be99, Offset: 0x6598
// Size: 0x24
function tutorial_15()
{
    self function_6edc6e5e( "vox_tuto_tutorial_sequence_20" );
}

// Namespace fr/fr
// Params 0
// Checksum 0x9e2fec47, Offset: 0x65c8
// Size: 0x24
function tutorial_16()
{
    self function_6edc6e5e( "vox_tuto_tutorial_sequence_29" );
}

// Namespace fr/fr
// Params 0
// Checksum 0x399dc48b, Offset: 0x65f8
// Size: 0x24
function tutorial_17()
{
    self function_6edc6e5e( "vox_tuto_tutorial_sequence_21" );
}

// Namespace fr/fr
// Params 0
// Checksum 0xc3d76ab6, Offset: 0x6628
// Size: 0x24
function tutorial_17a()
{
    self function_b3bea47c( &"FREERUN_TUTORIAL_22" );
}

// Namespace fr/fr
// Params 0
// Checksum 0x58fe787b, Offset: 0x6658
// Size: 0x4c
function tutorial_18()
{
    self function_81ca9cf3( "vox_tuto_tutorial_sequence_23", &"FREERUN_TUTORIAL_23" );
    self function_b3bea47c( &"FREERUN_TUTORIAL_22a" );
}

// Namespace fr/fr
// Params 0
// Checksum 0xe10e0ffb, Offset: 0x66b0
// Size: 0x24
function tutorial_19()
{
    self function_6edc6e5e( "vox_tuto_tutorial_sequence_25" );
}

// Namespace fr/fr
// Params 0
// Checksum 0x93efb4f9, Offset: 0x66e0
// Size: 0x24
function tutorial_20()
{
    self function_6edc6e5e( "vox_tuto_tutorial_sequence_26" );
}

