#using scripts/core_common/gameobjects_shared;
#using scripts/core_common/influencers_shared;
#using scripts/core_common/math_shared;
#using scripts/core_common/persistence_shared;
#using scripts/core_common/rank_shared;
#using scripts/core_common/scoreevents_shared;
#using scripts/core_common/spawning_shared;
#using scripts/core_common/weapons/weapon_utils;
#using scripts/mp_common/gametypes/globallogic;
#using scripts/mp_common/gametypes/globallogic_audio;
#using scripts/mp_common/gametypes/globallogic_score;
#using scripts/mp_common/gametypes/globallogic_utils;
#using scripts/mp_common/gametypes/loadout;
#using scripts/mp_common/util;

#namespace gun;

// Namespace gun/GameType_Init
// Params 1, eflags: 0x40
// Checksum 0x6b7aabec, Offset: 0x6e8
// Size: 0xa5c
function event_handler[GameType_Init] main( eventstruct )
{
    globallogic::init();
    level.onstartgametype = &onstartgametype;
    level.onspawnplayer = &onspawnplayer;
    level.onplayerkilled = &onplayerkilled;
    level.onendgame = &onendgame;
    globallogic_audio::set_leader_gametype_dialog( "startGunGame", "hcSstartGunGame", "", "" );
    level.givecustomloadout = &givecustomloadout;
    level.setbacksperdemotion = getgametypesetting( "setbacks" );
    level.inactivitykick = 60;
    gameobjects::register_allowed_gameobject( level.gametype );
    level.gunprogression = [];
    gunlist = getgametypesetting( "gunSelection" );
    
    if ( gunlist == 3 )
    {
        gunlist = randomintrange( 0, 3 );
    }
    
    switch ( gunlist )
    {
        case 0:
            addguntoprogression( "pistol_standard", "fastreload", "steadyaim" );
            addguntoprogression( "pistol_burst_dw" );
            addguntoprogression( "pistol_fullauto", "reflex" );
            addguntoprogression( "shotgun_pump", "extbarrel", "suppressed" );
            addguntoprogression( "shotgun_precision", "qucikdraw", "holo" );
            addguntoprogression( "shotgun_fullauto", "extclip" );
            addguntoprogression( "smg_versatile", "grip", "extbarrel" );
            addguntoprogression( "smg_burst", "suppressed" );
            addguntoprogression( "smg_longrange", "reflex" );
            addguntoprogression( "ar_cqb", "rf", "fastreload" );
            addguntoprogression( "ar_standard", "fmj", "damage" );
            addguntoprogression( "ar_longburst", "acog" );
            addguntoprogression( "ar_marksman", "ir" );
            addguntoprogression( "lmg_slowfire", "extclip" );
            addguntoprogression( "lmg_cqb", "quickdraw", "steadyaim" );
            addguntoprogression( "sniper_fastbolt", "swayreduc" );
            addguntoprogression( "sniper_powerbolt", "reddot" );
            addguntoprogression( "launcher_standard" );
            addguntoprogression( "knife_loadout" );
            addguntoprogression( "bare_hands" );
            break;
        case 1:
            addguntoprogression( "pistol_standard", "reddot" );
            addguntoprogression( "pistol_fullauto_dw", "reflex" );
            addguntoprogression( "pistol_standard_dw" );
            addguntoprogression( "pistol_burst_dw" );
            addguntoprogression( "pistol_fullauto_dw" );
            addguntoprogression( "shotgun_semiauto", "steadyaim" );
            addguntoprogression( "shotgun_fullauto", "suppressed" );
            addguntoprogression( "shotgun_pump", "quickdraw" );
            addguntoprogression( "shotgun_precision", "reddot" );
            addguntoprogression( "smg_fastfire", "holo" );
            addguntoprogression( "smg_standard", "quickdraw" );
            addguntoprogression( "smg_versatile", "suppressed" );
            addguntoprogression( "smg_capacity", "stalker" );
            addguntoprogression( "smg_longrange", "rf" );
            addguntoprogression( "smg_burst", "reddot" );
            addguntoprogression( "lmg_cqb", "quickdraw" );
            addguntoprogression( "launcher_standard" );
            addguntoprogression( "sniper_powerbolt", "reddot" );
            addguntoprogression( "knife_loadout" );
            addguntoprogression( "bare_hands" );
            break;
        case 2:
            addguntoprogression( "smg_capacity", "holo", "quickdraw" );
            addguntoprogression( "smg_longrange", "acog", "extclip" );
            addguntoprogression( "smg_burst", "acog", "extbarrel" );
            addguntoprogression( "ar_cqb", "acog" );
            addguntoprogression( "ar_standard", "reflex" );
            addguntoprogression( "ar_longburst", "extbarrel" );
            addguntoprogression( "ar_fastburst", "holo" );
            addguntoprogression( "ar_marksman", "acog" );
            addguntoprogression( "ar_damage", "reddot" );
            addguntoprogression( "ar_accurate", "ir", "extbarrel" );
            addguntoprogression( "lmg_light", "ir" );
            addguntoprogression( "lmg_cqb", "reflex" );
            addguntoprogression( "lmg_heavy", "acog" );
            addguntoprogression( "lmg_slowfire", "ir", "extclip" );
            addguntoprogression( "sniper_fastsemi", "swayreduc", "stalker" );
            addguntoprogression( "sniper_fastbolt", "ir", "rf" );
            addguntoprogression( "sniper_powerbolt", "swayreduc" );
            addguntoprogression( "launcher_standard" );
            addguntoprogression( "knife_loadout" );
            addguntoprogression( "bare_hands" );
            break;
    }
    
    util::registertimelimit( 0, 1440 );
    util::registerroundlimit( 0, 10 );
    util::registerroundwinlimit( 0, 10 );
    util::registernumlives( 0, 100 );
    
    if ( !sessionmodeissystemlink() && !sessionmodeisonlinegame() && issplitscreen() )
    {
        globallogic::setvisiblescoreboardcolumns( "pointstowin", "kills", "stabs", "humiliated", "deaths" );
        return;
    }
    
    globallogic::setvisiblescoreboardcolumns( "pointstowin", "kills", "deaths", "stabs", "humiliated" );
}

// Namespace gun/gun
// Params 0
// Checksum 0xd05fab43, Offset: 0x1150
// Size: 0x25c
function onstartgametype()
{
    level.gungamekillscore = rank::getscoreinfovalue( "kill_gun" );
    util::registerscorelimit( level.gunprogression.size * level.gungamekillscore, level.gunprogression.size * level.gungamekillscore );
    setdvar( "ui_weapon_tiers", level.gunprogression.size );
    setclientnamemode( "auto_change" );
    level.spawnmins = ( 0, 0, 0 );
    level.spawnmaxs = ( 0, 0, 0 );
    
    foreach ( team in level.teams )
    {
        setupteam( team );
    }
    
    level.usestartspawns = 1;
    level.spawn_start = spawning::get_spawnpoint_array( "mp_dm_spawn_start" );
    influencers::create_map_placed_influencers();
    spawning::updateallspawnpoints();
    level.mapcenter = math::find_box_center( level.spawnmins, level.spawnmaxs );
    setmapcenter( level.mapcenter );
    spawnpoint = spawning::get_random_intermission_point();
    setdemointermissionpoint( spawnpoint.origin, spawnpoint.angles );
    level.displayroundendtext = 0;
}

// Namespace gun/gun
// Params 0
// Checksum 0xd2d89e46, Offset: 0x13b8
// Size: 0x15c
function inactivitykick()
{
    self endon( #"disconnect" );
    self endon( #"death" );
    
    if ( sessionmodeisprivate() )
    {
        return;
    }
    
    if ( level.inactivitykick == 0 )
    {
        return;
    }
    
    while ( level.inactivitykick > self.timeplayed[ "total" ] )
    {
        wait 1;
    }
    
    if ( self.pers[ "participation" ] == 0 && self.pers[ "time_played_moving" ] < 1 )
    {
        globallogic::gamehistoryplayerkicked();
        kick( self getentitynumber(), "GAME_DROPPEDFORINACTIVITY" );
    }
    
    if ( self.pers[ "participation" ] == 0 && self.timeplayed[ "total" ] > 60 )
    {
        globallogic::gamehistoryplayerkicked();
        kick( self getentitynumber(), "GAME_DROPPEDFORINACTIVITY" );
    }
}

// Namespace gun/gun
// Params 1
// Checksum 0x177ca861, Offset: 0x1520
// Size: 0x6c
function onspawnplayer( predictedspawn )
{
    if ( !level.inprematchperiod )
    {
        level.usestartspawns = 0;
    }
    
    spawning::onspawnplayer( predictedspawn );
    self thread infiniteammo();
    self thread inactivitykick();
}

// Namespace gun/gun
// Params 9
// Checksum 0xc734bf63, Offset: 0x1598
// Size: 0x1e4
function onplayerkilled( einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration )
{
    level.usestartspawns = 0;
    
    if ( smeansofdeath == "MOD_SUICIDE" || smeansofdeath == "MOD_TRIGGER_HURT" )
    {
        self thread demoteplayer();
        return;
    }
    
    if ( isdefined( attacker ) && isplayer( attacker ) )
    {
        if ( attacker == self )
        {
            self thread demoteplayer( attacker );
            return;
        }
        
        if ( isdefined( attacker.lastpromotiontime ) && attacker.lastpromotiontime + 3000 > gettime() )
        {
            scoreevents::processscoreevent( "kill_in_3_seconds_gun", attacker, self, weapon );
        }
        
        if ( weapon_utils::ismeleemod( smeansofdeath ) )
        {
            scoreevents::processscoreevent( "humiliation_gun", attacker, self, weapon );
            
            if ( globallogic_score::gethighestscoringplayer() === self )
            {
                scoreevents::processscoreevent( "melee_leader_gun", attacker, self, weapon );
            }
            
            self thread demoteplayer( attacker );
        }
        
        if ( smeansofdeath != "MOD_MELEE_WEAPON_BUTT" )
        {
            attacker thread promoteplayer( weapon );
        }
    }
}

// Namespace gun/gun
// Params 1
// Checksum 0xf112a12b, Offset: 0x1788
// Size: 0x68
function onendgame( winningplayer )
{
    if ( isdefined( winningplayer ) && isplayer( winningplayer ) )
    {
        [[ level._setplayerscore ]]( winningplayer, [[ level._getplayerscore ]]( winningplayer ) + level.gungamekillscore );
    }
}

// Namespace gun/gun
// Params 9
// Checksum 0x59551497, Offset: 0x17f8
// Size: 0x17e
function addguntoprogression( weaponname, attachment1, attachment2, attachment3, attachment4, attachment5, attachment6, attachment7, attachment8 )
{
    attachments = [];
    
    if ( isdefined( attachment1 ) )
    {
        attachments[ attachments.size ] = attachment1;
    }
    
    if ( isdefined( attachment2 ) )
    {
        attachments[ attachments.size ] = attachment2;
    }
    
    if ( isdefined( attachment3 ) )
    {
        attachments[ attachments.size ] = attachment3;
    }
    
    if ( isdefined( attachment4 ) )
    {
        attachments[ attachments.size ] = attachment4;
    }
    
    if ( isdefined( attachment5 ) )
    {
        attachments[ attachments.size ] = attachment5;
    }
    
    if ( isdefined( attachment6 ) )
    {
        attachments[ attachments.size ] = attachment6;
    }
    
    if ( isdefined( attachment7 ) )
    {
        attachments[ attachments.size ] = attachment7;
    }
    
    if ( isdefined( attachment8 ) )
    {
        attachments[ attachments.size ] = attachment8;
    }
    
    weapon = getweapon( weaponname, attachments );
    level.gunprogression[ level.gunprogression.size ] = weapon;
}

// Namespace gun/gun
// Params 1
// Checksum 0x38898bba, Offset: 0x1980
// Size: 0xcc
function setupteam( team )
{
    util::setobjectivetext( team, &"OBJECTIVES_GUN" );
    
    if ( level.splitscreen )
    {
        util::setobjectivescoretext( team, &"OBJECTIVES_GUN" );
    }
    else
    {
        util::setobjectivescoretext( team, &"OBJECTIVES_GUN_SCORE" );
    }
    
    util::setobjectivehinttext( team, &"OBJECTIVES_GUN_HINT" );
    spawning::add_spawn_points( team, "mp_dm_spawn" );
    spawning::place_spawn_points( "mp_dm_spawn_start" );
}

// Namespace gun/gun
// Params 1
// Checksum 0x72f972c6, Offset: 0x1a58
// Size: 0x44
function takeoldweapon( oldweapon )
{
    self endon( #"death" );
    self endon( #"disconnect" );
    wait 1;
    self takeweapon( oldweapon );
}

// Namespace gun/gun
// Params 1
// Checksum 0x965e760, Offset: 0x1aa8
// Size: 0x208
function givecustomloadout( takeoldweapon )
{
    if ( !isdefined( takeoldweapon ) )
    {
        takeoldweapon = 0;
    }
    
    self loadout::function_79d05183( !takeoldweapon );
    self loadout::function_1d84af77( "CLASS_ASSAULT" );
    
    if ( takeoldweapon )
    {
        oldweapon = self getcurrentweapon();
        weapons = self getweaponslist();
        
        foreach ( weapon in weapons )
        {
            if ( weapon != oldweapon )
            {
                self takeweapon( weapon );
            }
        }
        
        self thread takeoldweapon( oldweapon );
    }
    
    if ( !isdefined( self.gunprogress ) )
    {
        self.gunprogress = 0;
    }
    
    currentweapon = level.gunprogression[ self.gunprogress ];
    self giveweapon( currentweapon );
    self switchtoweapon( currentweapon );
    self disableweaponcycling();
    
    if ( self.firstspawn !== 0 )
    {
        self setspawnweapon( currentweapon );
    }
    
    return currentweapon;
}

// Namespace gun/gun
// Params 1
// Checksum 0x8d0e2563, Offset: 0x1cb8
// Size: 0x1a8
function promoteplayer( weaponused )
{
    self endon( #"disconnect" );
    self endon( #"cancel_promotion" );
    level endon( #"game_ended" );
    waitframe( 1 );
    
    if ( isdefined( level.gunprogression[ self.gunprogress ].dualwieldweapon ) && ( weaponused.rootweapon == level.gunprogression[ self.gunprogress ].rootweapon || level.gunprogression[ self.gunprogress ].dualwieldweapon.rootweapon == weaponused.rootweapon ) )
    {
        if ( self.gunprogress < level.gunprogression.size - 1 )
        {
            self.gunprogress++;
            
            if ( isalive( self ) )
            {
                self thread givecustomloadout( 1 );
            }
        }
        
        pointstowin = self.pers[ "pointstowin" ];
        
        if ( pointstowin < level.scorelimit )
        {
            self globallogic_score::givepointstowin( level.gungamekillscore );
            scoreevents::processscoreevent( "kill_gun", self );
        }
        
        self.lastpromotiontime = gettime();
    }
}

// Namespace gun/gun
// Params 1
// Checksum 0x8da79c7f, Offset: 0x1e68
// Size: 0x1ec
function demoteplayer( attacker )
{
    self endon( #"disconnect" );
    self notify( #"cancel_promotion" );
    currentgunprogress = self.gunprogress;
    
    for ( i = 0; i < level.setbacksperdemotion ; i++ )
    {
        if ( self.gunprogress <= 0 )
        {
            break;
        }
        
        self globallogic_score::givepointstowin( level.gungamekillscore * -1 );
        self.gunprogress--;
    }
    
    if ( currentgunprogress != self.gunprogress && isalive( self ) )
    {
        self thread givecustomloadout( 1 );
    }
    
    if ( isdefined( attacker ) )
    {
        self addplayerstatwithgametype( "HUMILIATE_ATTACKER", 1 );
        attacker recordgameevent( "capture" );
    }
    
    self addplayerstatwithgametype( "HUMILIATE_VICTIM", 1 );
    self.pers[ "humiliated" ]++;
    self.humiliated = self.pers[ "humiliated" ];
    self recordgameevent( "return" );
    self playlocalsound( "mpl_wager_humiliate" );
    self globallogic_audio::leader_dialog_on_player( "humiliated" );
}

// Namespace gun/gun
// Params 0
// Checksum 0x52efdf87, Offset: 0x2060
// Size: 0x70
function infiniteammo()
{
    self endon( #"death" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        wait 0.1;
        weapon = self getcurrentweapon();
        self givemaxammo( weapon );
    }
}

