#using scripts/core_common/abilities/gadgets/gadget_camo;
#using scripts/core_common/array_shared;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/dialog_shared;
#using scripts/core_common/killstreaks_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/mp_common/gametypes/dev;
#using scripts/mp_common/gametypes/globallogic;
#using scripts/mp_common/gametypes/globallogic_audio;
#using scripts/mp_common/killstreaks/killstreaks;

#namespace battlechatter;

// Namespace battlechatter/battlechatter
// Params 0, eflags: 0x2
// Checksum 0x143eb258, Offset: 0x1028
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "battlechatter", &__init__, undefined, undefined );
}

// Namespace battlechatter/battlechatter
// Params 0
// Checksum 0x98b82e8c, Offset: 0x1068
// Size: 0x7a0
function __init__()
{
    /#
        level thread devgui_think();
    #/
    
    callback::on_joined_team( &on_joined_team );
    callback::on_spawned( &on_player_spawned );
    level.heroplaydialog = &play_dialog;
    level.playgadgetready = &play_gadget_ready;
    level.playgadgetactivate = &play_gadget_activate;
    level.playgadgetsuccess = &play_gadget_success;
    level.playpromotionreaction = &play_promotion_reaction;
    level.playthrowhatchet = &play_throw_hatchet;
    level.bcsounds = [];
    level.bcsounds[ "incoming_alert" ] = [];
    level.bcsounds[ "incoming_alert" ][ "frag_grenade" ] = "incomingFrag";
    level.bcsounds[ "incoming_alert" ][ "incendiary_grenade" ] = "incomingIncendiary";
    level.bcsounds[ "incoming_alert" ][ "sticky_grenade" ] = "incomingSemtex";
    level.bcsounds[ "incoming_alert" ][ "launcher_standard" ] = "threatRpg";
    level.bcsounds[ "incoming_delay" ] = [];
    level.bcsounds[ "incoming_delay" ][ "frag_grenade" ] = "fragGrenadeDelay";
    level.bcsounds[ "incoming_delay" ][ "incendiary_grenade" ] = "incendiaryGrenadeDelay";
    level.bcsounds[ "incoming_alert" ][ "sticky_grenade" ] = "semtexDelay";
    level.bcsounds[ "incoming_delay" ][ "launcher_standard" ] = "missileDelay";
    level.bcsounds[ "kill_dialog" ] = [];
    level.bcsounds[ "kill_dialog" ][ "assassin" ] = "killSpectre";
    level.bcsounds[ "kill_dialog" ][ "grenadier" ] = "killGrenadier";
    level.bcsounds[ "kill_dialog" ][ "outrider" ] = "killOutrider";
    level.bcsounds[ "kill_dialog" ][ "prophet" ] = "killTechnomancer";
    level.bcsounds[ "kill_dialog" ][ "pyro" ] = "killFirebreak";
    level.bcsounds[ "kill_dialog" ][ "reaper" ] = "killReaper";
    level.bcsounds[ "kill_dialog" ][ "ruin" ] = "killMercenary";
    level.bcsounds[ "kill_dialog" ][ "seraph" ] = "killEnforcer";
    level.bcsounds[ "kill_dialog" ][ "trapper" ] = "killTrapper";
    level.bcsounds[ "kill_dialog" ][ "blackjack" ] = "killBlackjack";
    
    if ( level.teambased && !isdefined( game.boostplayerspicked ) )
    {
        game.boostplayerspicked = [];
        
        foreach ( team in level.teams )
        {
            game.boostplayerspicked[ team ] = 0;
        }
    }
    
    level.allowbattlechatter = getgametypesetting( "allowBattleChatter" );
    level thread pick_boost_number();
    playerdialogbundles = struct::get_script_bundles( "mpdialog_player" );
    
    foreach ( bundle in playerdialogbundles )
    {
        count_keys( bundle, "killGeneric" );
        count_keys( bundle, "killSniper" );
        count_keys( bundle, "killSpectre" );
        count_keys( bundle, "killGrenadier" );
        count_keys( bundle, "killOutrider" );
        count_keys( bundle, "killTechnomancer" );
        count_keys( bundle, "killFirebreak" );
        count_keys( bundle, "killReaper" );
        count_keys( bundle, "killMercenary" );
        count_keys( bundle, "killEnforcer" );
        count_keys( bundle, "killTrapper" );
        count_keys( bundle, "killBlackjack" );
    }
    
    level.playerdialogbundles = playerdialogbundles;
    level.allowspecialistdialog = mpdialog_value( "enableHeroDialog", 0 ) && level.allowbattlechatter;
    level.playstartconversation = mpdialog_value( "enableConversation", 0 ) && level.allowbattlechatter;
}

// Namespace battlechatter/battlechatter
// Params 0
// Checksum 0x94730f7a, Offset: 0x1810
// Size: 0x3c
function pick_boost_number()
{
    wait 5;
    level clientfield::set( "boost_number", randomint( 4 ) );
}

// Namespace battlechatter/battlechatter
// Params 0
// Checksum 0x8cc1a6a5, Offset: 0x1858
// Size: 0x1d2
function on_joined_team()
{
    self endon( #"disconnect" );
    
    if ( level.teambased )
    {
        if ( self.team == "allies" )
        {
            self set_blops_dialog();
        }
        else
        {
            self set_cdp_dialog();
        }
    }
    else if ( randomintrange( 0, 2 ) )
    {
        self set_blops_dialog();
    }
    else
    {
        self set_cdp_dialog();
    }
    
    self globallogic_audio::flush_dialog();
    
    if ( level.var_29d9f951 === 1 )
    {
        return;
    }
    
    if ( !( isdefined( level.inprematchperiod ) && level.inprematchperiod ) && !( isdefined( self.pers[ "playedGameMode" ] ) && self.pers[ "playedGameMode" ] ) && isdefined( level.leaderdialog ) )
    {
        if ( level.hardcoremode )
        {
            self globallogic_audio::leader_dialog_on_player( level.leaderdialog.starthcgamedialog, undefined, undefined, undefined, 1 );
        }
        else
        {
            self globallogic_audio::leader_dialog_on_player( level.leaderdialog.startgamedialog, undefined, undefined, undefined, 1 );
        }
        
        self.pers[ "playedGameMode" ] = 1;
    }
}

// Namespace battlechatter/battlechatter
// Params 0
// Checksum 0xc6061e05, Offset: 0x1a38
// Size: 0x3a
function set_blops_dialog()
{
    self.pers[ "mptaacom" ] = "blops_taacom";
    self.pers[ "mpcommander" ] = "blops_commander";
}

// Namespace battlechatter/battlechatter
// Params 0
// Checksum 0xa6b7c8d0, Offset: 0x1a80
// Size: 0x3a
function set_cdp_dialog()
{
    self.pers[ "mptaacom" ] = "cdp_taacom";
    self.pers[ "mpcommander" ] = "cdp_commander";
}

// Namespace battlechatter/battlechatter
// Params 0
// Checksum 0xdba89eab, Offset: 0x1ac8
// Size: 0x12c
function on_player_spawned()
{
    self.enemythreattime = 0;
    self.heartbeatsnd = 0;
    self.soundmod = "player";
    self.voxunderwatertime = 0;
    self.voxemergebreath = 0;
    self.voxdrowning = 0;
    self.pilotisspeaking = 0;
    self.playingdialog = 0;
    self.playinggadgetreadydialog = 0;
    self.playedgadgetsuccess = 1;
    
    if ( level.splitscreen )
    {
        return;
    }
    
    self thread water_vox();
    self thread grenade_tracking();
    self thread missile_tracking();
    self thread sticky_grenade_tracking();
    
    if ( level.teambased )
    {
        self thread enemy_threat();
        self thread check_boost_start_conversation();
    }
}

// Namespace battlechatter/battlechatter
// Params 1
// Checksum 0x4045ee27, Offset: 0x1c00
// Size: 0x80, Type: bool
function dialog_chance( chancekey )
{
    dialogchance = mpdialog_value( chancekey );
    
    if ( !isdefined( dialogchance ) || dialogchance <= 0 )
    {
        return false;
    }
    else if ( dialogchance >= 100 )
    {
        return true;
    }
    
    return randomint( 100 ) < dialogchance;
}

// Namespace battlechatter/battlechatter
// Params 2
// Checksum 0x8e3de23a, Offset: 0x1c88
// Size: 0x90
function mpdialog_value( mpdialogkey, defaultvalue )
{
    if ( !isdefined( mpdialogkey ) )
    {
        return defaultvalue;
    }
    
    mpdialog = struct::get_script_bundle( "mpdialog", "mpdialog_default" );
    
    if ( !isdefined( mpdialog ) )
    {
        return defaultvalue;
    }
    
    structvalue = mpdialog.( mpdialogkey );
    
    if ( !isdefined( structvalue ) )
    {
        return defaultvalue;
    }
    
    return structvalue;
}

// Namespace battlechatter/battlechatter
// Params 0
// Checksum 0x203b871b, Offset: 0x1d20
// Size: 0x214
function water_vox()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    interval = mpdialog_value( "underwaterInterval", 0.05 );
    
    if ( interval <= 0 )
    {
        assert( interval > 0, "<dev string:x28>" );
        return;
    }
    
    while ( true )
    {
        wait interval;
        
        if ( self isplayerunderwater() )
        {
            if ( !self.voxunderwatertime && !self.voxemergebreath )
            {
                self stopsounds();
                self.voxunderwatertime = gettime();
            }
            else if ( self.voxunderwatertime )
            {
                if ( gettime() > self.voxunderwatertime + mpdialog_value( "underwaterBreathTime", 0 ) * 1000 )
                {
                    self.voxunderwatertime = 0;
                    self.voxemergebreath = 1;
                }
            }
            
            continue;
        }
        
        if ( self.voxdrowning )
        {
            self thread play_dialog( "exertEmergeGasp", 20, mpdialog_value( "playerExertBuffer", 0 ) );
            self.voxdrowning = 0;
            self.voxemergebreath = 0;
            continue;
        }
        
        if ( self.voxemergebreath )
        {
            self thread play_dialog( "exertEmergeBreath", 20, mpdialog_value( "playerExertBuffer", 0 ) );
            self.voxemergebreath = 0;
        }
    }
}

// Namespace battlechatter/battlechatter
// Params 1
// Checksum 0xd6043d23, Offset: 0x1f40
// Size: 0xfc
function pain_vox( meansofdeath )
{
    if ( dialog_chance( "smallPainChance" ) )
    {
        if ( meansofdeath == "MOD_DROWN" )
        {
            dialogkey = "exertPainDrowning";
            self.voxdrowning = 1;
        }
        else if ( meansofdeath == "MOD_FALLING" )
        {
            dialogkey = "exertPainFalling";
        }
        else if ( self isplayerunderwater() )
        {
            dialogkey = "exertPainUnderwater";
        }
        else
        {
            dialogkey = "exertPain";
        }
        
        exertbuffer = mpdialog_value( "playerExertBuffer", 0 );
        self thread play_dialog( dialogkey, 30, exertbuffer );
    }
}

// Namespace battlechatter/battlechatter
// Params 2
// Checksum 0x483a9766, Offset: 0x2048
// Size: 0x40
function on_player_suicide_or_team_kill( player, type )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    waittillframeend();
    
    if ( !level.teambased )
    {
        return;
    }
}

// Namespace battlechatter/battlechatter
// Params 2
// Checksum 0xf03a7670, Offset: 0x2090
// Size: 0x2e
function on_player_near_explodable( object, type )
{
    self endon( #"death" );
    level endon( #"game_ended" );
}

// Namespace battlechatter/battlechatter
// Params 0
// Checksum 0x2491e397, Offset: 0x20c8
// Size: 0x28c
function enemy_threat()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( "weapon_ads" );
        
        if ( self hasperk( "specialty_quieter" ) )
        {
            continue;
        }
        
        if ( self.enemythreattime + mpdialog_value( "enemyContactInterval", 0 ) * 1000 >= gettime() )
        {
            continue;
        }
        
        closest_ally = self get_closest_player_ally( 1 );
        
        if ( !isdefined( closest_ally ) )
        {
            continue;
        }
        
        allyradius = mpdialog_value( "enemyContactAllyRadius", 0 );
        
        if ( distancesquared( self.origin, closest_ally.origin ) < allyradius * allyradius )
        {
            eyepoint = self geteye();
            dir = anglestoforward( self getplayerangles() );
            dir *= mpdialog_value( "enemyContactDistance", 0 );
            endpoint = eyepoint + dir;
            traceresult = bullettrace( eyepoint, endpoint, 1, self );
            
            if ( isdefined( traceresult[ "entity" ] ) && traceresult[ "entity" ].classname == "player" && traceresult[ "entity" ].team != self.team )
            {
                if ( dialog_chance( "enemyContactChance" ) )
                {
                    self thread play_dialog( "threatInfantry", 1 );
                    level notify( #"level_enemy_spotted", self.team );
                    self.enemythreattime = gettime();
                }
            }
        }
    }
}

// Namespace battlechatter/battlechatter
// Params 1
// Checksum 0xf8e644e8, Offset: 0x2360
// Size: 0x280
function killed_by_sniper( sniper )
{
    self endon( #"disconnect" );
    sniper endon( #"disconnect" );
    level endon( #"game_ended" );
    
    if ( !level.teambased )
    {
        return 0;
    }
    
    waittillframeend();
    
    if ( dialog_chance( "sniperKillChance" ) )
    {
        closest_ally = self get_closest_player_ally();
        allyradius = mpdialog_value( "sniperKillAllyRadius", 0 );
        
        if ( isdefined( closest_ally ) && distancesquared( self.origin, closest_ally.origin ) < allyradius * allyradius )
        {
            closest_ally thread play_dialog( "threatSniper", 1 );
            sniper.spottedtime = gettime();
            sniper.spottedby = [];
            players = self get_friendly_players();
            players = arraysort( players, self.origin );
            voiceradius = mpdialog_value( "playerVoiceRadius", 0 );
            voiceradiussq = voiceradius * voiceradius;
            
            foreach ( player in players )
            {
                if ( distancesquared( closest_ally.origin, player.origin ) <= voiceradiussq )
                {
                    sniper.spottedby[ sniper.spottedby.size ] = player;
                }
            }
        }
    }
}

// Namespace battlechatter/battlechatter
// Params 2
// Checksum 0x3a0c8f13, Offset: 0x25e8
// Size: 0x164
function player_killed( attacker, killstreaktype )
{
    if ( !level.teambased )
    {
        return;
    }
    
    if ( self === attacker )
    {
        return;
    }
    
    waittillframeend();
    
    if ( isdefined( killstreaktype ) )
    {
        if ( !isdefined( level.killstreaks[ killstreaktype ] ) || !isdefined( level.killstreaks[ killstreaktype ].threatonkill ) || !level.killstreaks[ killstreaktype ].threatonkill || !dialog_chance( "killstreakKillChance" ) )
        {
            return;
        }
        
        ally = get_closest_player_ally( 1 );
        allyradius = mpdialog_value( "killstreakKillAllyRadius", 0 );
        
        if ( isdefined( ally ) && distancesquared( self.origin, ally.origin ) < allyradius * allyradius )
        {
            ally play_killstreak_threat( killstreaktype );
        }
    }
}

// Namespace battlechatter/battlechatter
// Params 4
// Checksum 0x1967957f, Offset: 0x2758
// Size: 0x554
function say_kill_battle_chatter( attacker, weapon, victim, inflictor )
{
    if ( weapon.skipbattlechatterkill || !isdefined( attacker ) || !isplayer( attacker ) || !isalive( attacker ) || attacker isremotecontrolling() || attacker isinvehicle() || attacker isweaponviewonlylinked() || !isdefined( victim ) || !isplayer( victim ) )
    {
        return;
    }
    
    if ( isdefined( inflictor ) && !isplayer( inflictor ) && inflictor.birthtime < attacker.spawntime )
    {
        return;
    }
    
    if ( weapon.isheavyweapon )
    {
        if ( !isdefined( attacker.heavyweaponkillcount ) )
        {
            attacker.heavyweaponkillcount = 0;
        }
        
        attacker.heavyweaponkillcount++;
        
        if ( !( isdefined( attacker.playedgadgetsuccess ) && attacker.playedgadgetsuccess ) && attacker.heavyweaponkillcount === mpdialog_value( "heroWeaponKillCount", 0 ) )
        {
            attacker thread play_gadget_success( weapon, "enemyKillDelay", victim );
            attacker thread heavy_weapon_success_reaction();
        }
    }
    else if ( isdefined( attacker.speedburston ) && attacker.speedburston )
    {
        if ( !( isdefined( attacker.speedburstkill ) && attacker.speedburstkill ) )
        {
            speedburstkilldist = mpdialog_value( "speedBurstKillDistance", 0 );
            
            if ( distancesquared( attacker.origin, victim.origin ) < speedburstkilldist * speedburstkilldist )
            {
                attacker.speedburstkill = 1;
            }
        }
    }
    else if ( isdefined( attacker.gadget_camo_off_time ) && ( attacker gadget_camo::camo_is_inuse() || attacker.gadget_camo_off_time + mpdialog_value( "camoKillTime", 0 ) * 1000 >= gettime() ) )
    {
        if ( !( isdefined( attacker.playedgadgetsuccess ) && attacker.playedgadgetsuccess ) )
        {
            attacker thread play_gadget_success( getweapon( "gadget_camo" ), "enemyKillDelay", victim );
        }
    }
    else if ( dialog_chance( "enemyKillChance" ) )
    {
        if ( isdefined( victim.spottedtime ) && victim.spottedtime + mpdialog_value( "enemySniperKillTime", 0 ) >= gettime() && array::contains( victim.spottedby, attacker ) && dialog_chance( "enemySniperKillChance" ) )
        {
            killdialog = attacker get_random_key( "killSniper" );
        }
        else if ( dialog_chance( "enemyHeroKillChance" ) )
        {
            victimdialogname = victim getmpdialogname();
            killdialog = attacker get_random_key( level.bcsounds[ "kill_dialog" ][ victimdialogname ] );
        }
        else
        {
            killdialog = attacker get_random_key( "killGeneric" );
        }
    }
    
    victim.spottedtime = undefined;
    victim.spottedby = undefined;
    
    if ( !isdefined( killdialog ) )
    {
        return;
    }
    
    attacker thread wait_play_dialog( mpdialog_value( "enemyKillDelay", 0 ), killdialog, 1, undefined, victim, "cancel_kill_dialog" );
}

// Namespace battlechatter/battlechatter
// Params 0
// Checksum 0xd1d94dd9, Offset: 0x2cb8
// Size: 0x198
function grenade_tracking()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        waitresult = self waittill( "grenade_fire" );
        grenade = waitresult.projectile;
        weapon = waitresult.weapon;
        
        if ( !isdefined( grenade.weapon ) || !isdefined( grenade.weapon.rootweapon ) || !dialog_chance( "incomingProjectileChance" ) )
        {
            continue;
        }
        
        dialogkey = level.bcsounds[ "incoming_alert" ][ grenade.weapon.rootweapon.name ];
        
        if ( isdefined( dialogkey ) )
        {
            waittime = mpdialog_value( level.bcsounds[ "incoming_delay" ][ grenade.weapon.rootweapon.name ], 0.05 );
            level thread incoming_projectile_alert( self, grenade, dialogkey, waittime );
        }
    }
}

// Namespace battlechatter/battlechatter
// Params 0
// Checksum 0x12b0bcef, Offset: 0x2e58
// Size: 0x198
function missile_tracking()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        waitresult = self waittill( "missile_fire" );
        missile = waitresult.projectile;
        weapon = waitresult.weapon;
        
        if ( !isdefined( missile.item ) || !isdefined( missile.item.rootweapon ) || !dialog_chance( "incomingProjectileChance" ) )
        {
            continue;
        }
        
        dialogkey = level.bcsounds[ "incoming_alert" ][ missile.item.rootweapon.name ];
        
        if ( isdefined( dialogkey ) )
        {
            waittime = mpdialog_value( level.bcsounds[ "incoming_delay" ][ missile.item.rootweapon.name ], 0.05 );
            level thread incoming_projectile_alert( self, missile, dialogkey, waittime );
        }
    }
}

// Namespace battlechatter/battlechatter
// Params 4
// Checksum 0x3f61f74c, Offset: 0x2ff8
// Size: 0x19a
function incoming_projectile_alert( thrower, projectile, dialogkey, waittime )
{
    level endon( #"game_ended" );
    
    if ( waittime <= 0 )
    {
        assert( waittime > 0, "<dev string:x6e>" );
        return;
    }
    
    while ( true )
    {
        wait waittime;
        
        if ( waittime > 0.2 )
        {
            waittime /= 2;
        }
        
        if ( !isdefined( projectile ) )
        {
            return;
        }
        
        if ( !isdefined( thrower ) || thrower.team == "spectator" )
        {
            return;
        }
        
        if ( level.players.size )
        {
            closest_enemy = thrower get_closest_player_enemy( projectile.origin );
            incomingprojectileradius = mpdialog_value( "incomingProjectileRadius", 0 );
            
            if ( isdefined( closest_enemy ) && distancesquared( projectile.origin, closest_enemy.origin ) < incomingprojectileradius * incomingprojectileradius )
            {
                closest_enemy thread play_dialog( dialogkey, 6 );
                return;
            }
        }
    }
}

// Namespace battlechatter/battlechatter
// Params 0
// Checksum 0xe2954f5a, Offset: 0x31a0
// Size: 0xe8
function sticky_grenade_tracking()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        waitresult = self waittill( "grenade_stuck" );
        grenade = waitresult.projectile;
        
        if ( isalive( self ) && isdefined( grenade ) && isdefined( grenade.weapon ) )
        {
            if ( grenade.weapon.rootweapon.name == "sticky_grenade" )
            {
                self thread play_dialog( "stuckSticky", 6 );
            }
        }
    }
}

// Namespace battlechatter/battlechatter
// Params 0
// Checksum 0xcefd902a, Offset: 0x3290
// Size: 0x386
function heavy_weapon_success_reaction()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    
    if ( !level.teambased )
    {
        return;
    }
    
    allies = [];
    allyradiussq = mpdialog_value( "playerVoiceRadius", 0 );
    allyradiussq *= allyradiussq;
    
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) || !isalive( player ) || player.sessionstate != "playing" || player == self || player.team != self.team )
        {
            continue;
        }
        
        distsq = distancesquared( self.origin, player.origin );
        
        if ( distsq > allyradiussq )
        {
            continue;
        }
        
        allies[ allies.size ] = player;
    }
    
    wait mpdialog_value( "enemyKillDelay", 0 ) + 0.1;
    
    while ( self.playingdialog )
    {
        wait 0.5;
    }
    
    allies = arraysort( allies, self.origin );
    
    foreach ( player in allies )
    {
        if ( !isalive( player ) || player.sessionstate != "playing" || player.playingdialog || player isplayerunderwater() || player isremotecontrolling() || player isinvehicle() || player isweaponviewonlylinked() )
        {
            continue;
        }
        
        distsq = distancesquared( self.origin, player.origin );
        
        if ( distsq > allyradiussq )
        {
            break;
        }
        
        player play_dialog( "heroWeaponSuccessReaction", 1 );
        break;
    }
}

// Namespace battlechatter/battlechatter
// Params 0
// Checksum 0xd1816011, Offset: 0x3620
// Size: 0x26c
function play_promotion_reaction()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    
    if ( !level.teambased )
    {
        return;
    }
    
    wait 9;
    players = self get_friendly_players();
    players = arraysort( players, self.origin );
    selfdialog = self getmpdialogname();
    voiceradius = mpdialog_value( "playerVoiceRadius", 0 );
    voiceradiussq = voiceradius * voiceradius;
    
    foreach ( player in players )
    {
        if ( player == self || player getmpdialogname() == selfdialog || !player can_play_dialog( 1 ) || distancesquared( self.origin, player.origin ) >= voiceradiussq )
        {
            continue;
        }
        
        dialogalias = player get_player_dialog_alias( "promotionReaction" );
        
        if ( !isdefined( dialogalias ) )
        {
            continue;
        }
        
        ally = player;
        break;
    }
    
    if ( isdefined( ally ) )
    {
        ally playsoundontag( dialogalias, "J_Head", undefined, self );
        ally thread wait_dialog_buffer( mpdialog_value( "playerDialogBuffer", 0 ) );
    }
}

// Namespace battlechatter/battlechatter
// Params 2
// Checksum 0x53597d49, Offset: 0x3898
// Size: 0x2e
function gametype_specific_battle_chatter( event, team )
{
    self endon( #"death" );
    level endon( #"game_ended" );
}

// Namespace battlechatter/battlechatter
// Params 4
// Checksum 0x6c2484c8, Offset: 0x38d0
// Size: 0xa4
function play_death_vox( body, attacker, weapon, meansofdeath )
{
    dialogkey = self get_death_vox( weapon, meansofdeath );
    dialogalias = self get_player_dialog_alias( dialogkey );
    
    if ( isdefined( dialogalias ) )
    {
        body playsoundontag( dialogalias, "J_Head" );
    }
}

// Namespace battlechatter/battlechatter
// Params 2
// Checksum 0xe37e4b2e, Offset: 0x3980
// Size: 0xfe
function get_death_vox( weapon, meansofdeath )
{
    if ( self isplayerunderwater() )
    {
        return "exertDeathDrowned";
    }
    
    if ( isdefined( meansofdeath ) )
    {
        switch ( meansofdeath )
        {
            case #"mod_burned":
                return "exertDeathBurned";
            case #"mod_drown":
                return "exertDeathDrowned";
        }
    }
    
    if ( isdefined( weapon ) && meansofdeath !== "MOD_MELEE_WEAPON_BUTT" )
    {
        switch ( weapon.rootweapon.name )
        {
            case #"hatchet":
            case #"hero_armblade":
            case #"knife_loadout":
                return "exertDeathStabbed";
            case #"hero_firefly_swarm":
                return "exertDeathBurned";
            case #"hero_lightninggun_arc":
                return "exertDeathElectrocuted";
        }
    }
    
    return "exertDeath";
}

// Namespace battlechatter/battlechatter
// Params 1
// Checksum 0x8566f294, Offset: 0x3a88
// Size: 0x64
function play_killstreak_threat( killstreaktype )
{
    if ( !isdefined( killstreaktype ) || !isdefined( level.killstreaks[ killstreaktype ] ) )
    {
        return;
    }
    
    self thread play_dialog( level.killstreaks[ killstreaktype ].threatdialogkey, 1 );
}

// Namespace battlechatter/battlechatter
// Params 6
// Checksum 0xd3a5695b, Offset: 0x3af8
// Size: 0xa4
function wait_play_dialog( waittime, dialogkey, dialogflags, dialogbuffer, enemy, endnotify )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    
    if ( isdefined( waittime ) && waittime > 0 )
    {
        if ( isdefined( endnotify ) )
        {
            self endon( endnotify );
        }
        
        wait waittime;
    }
    
    self thread play_dialog( dialogkey, dialogflags, dialogbuffer, enemy );
}

// Namespace battlechatter/battlechatter
// Params 4
// Checksum 0xda6219fb, Offset: 0x3ba8
// Size: 0x2fc
function play_dialog( dialogkey, dialogflags, dialogbuffer, enemy )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    
    if ( !isdefined( dialogkey ) || !isplayer( self ) || !isalive( self ) || level.gameended )
    {
        return;
    }
    
    if ( !isdefined( dialogflags ) )
    {
        dialogflags = 0;
    }
    
    if ( !level.allowspecialistdialog && ( dialogflags & 16 ) == 0 )
    {
        return;
    }
    
    if ( !isdefined( dialogbuffer ) )
    {
        dialogbuffer = mpdialog_value( "playerDialogBuffer", 0 );
    }
    
    dialogalias = self get_player_dialog_alias( dialogkey );
    
    if ( !isdefined( dialogalias ) )
    {
        return;
    }
    
    if ( self isplayerunderwater() && !( dialogflags & 8 ) )
    {
        return;
    }
    
    if ( self.playingdialog )
    {
        if ( !( dialogflags & 4 ) )
        {
            return;
        }
        
        self stopsounds();
        waitframe( 1 );
    }
    
    if ( dialogflags & 32 )
    {
        self.playinggadgetreadydialog = 1;
    }
    
    if ( dialogflags & 64 )
    {
        if ( !isdefined( self.stolendialogindex ) )
        {
            self.stolendialogindex = 0;
        }
        
        dialogalias = dialogalias + "_0" + self.stolendialogindex;
        self.stolendialogindex++;
        self.stolendialogindex %= 4;
    }
    
    if ( dialogflags & 2 )
    {
        self playsoundontag( dialogalias, "J_Head" );
    }
    else if ( dialogflags & 1 )
    {
        if ( isdefined( enemy ) )
        {
            self playsoundontag( dialogalias, "J_Head", self.team, enemy );
        }
        else
        {
            self playsoundontag( dialogalias, "J_Head", self.team );
        }
    }
    else
    {
        self playlocalsound( dialogalias );
    }
    
    self notify( #"played_dialog" );
    self thread wait_dialog_buffer( dialogbuffer );
}

// Namespace battlechatter/battlechatter
// Params 1
// Checksum 0x556611a6, Offset: 0x3eb0
// Size: 0x80
function wait_dialog_buffer( dialogbuffer )
{
    self endon( #"death" );
    self endon( #"played_dialog" );
    self endon( #"stop_dialog" );
    level endon( #"game_ended" );
    self.playingdialog = 1;
    
    if ( isdefined( dialogbuffer ) && dialogbuffer > 0 )
    {
        wait dialogbuffer;
    }
    
    self.playingdialog = 0;
    self.playinggadgetreadydialog = 0;
}

// Namespace battlechatter/battlechatter
// Params 0
// Checksum 0xc88d27b6, Offset: 0x3f38
// Size: 0x3c
function stop_dialog()
{
    self notify( #"stop_dialog" );
    self stopsounds();
    self.playingdialog = 0;
    self.playinggadgetreadydialog = 0;
}

// Namespace battlechatter/battlechatter
// Params 1
// Checksum 0xb25b842c, Offset: 0x3f80
// Size: 0xc
function wait_playback_time( soundalias )
{
    
}

// Namespace battlechatter/battlechatter
// Params 1
// Checksum 0x91a5c6e7, Offset: 0x3f98
// Size: 0xaa
function get_player_dialog_alias( dialogkey )
{
    if ( !isplayer( self ) )
    {
        return undefined;
    }
    
    bundlename = self getmpdialogname();
    
    if ( !isdefined( bundlename ) )
    {
        return undefined;
    }
    
    playerbundle = struct::get_script_bundle( "mpdialog_player", bundlename );
    
    if ( !isdefined( playerbundle ) )
    {
        return undefined;
    }
    
    return globallogic_audio::get_dialog_bundle_alias( playerbundle, dialogkey );
}

// Namespace battlechatter/battlechatter
// Params 2
// Checksum 0x92c230f4, Offset: 0x4050
// Size: 0xe6
function count_keys( bundle, dialogkey )
{
    i = 0;
    field = dialogkey + i;
    
    for ( fieldvalue = bundle.( field ); isdefined( fieldvalue ) ; fieldvalue = bundle.( field ) )
    {
        aliasarray[ i ] = fieldvalue;
        i++;
        field = dialogkey + i;
    }
    
    if ( !isdefined( bundle.keycounts ) )
    {
        bundle.keycounts = [];
    }
    
    bundle.keycounts[ dialogkey ] = i;
}

// Namespace battlechatter/battlechatter
// Params 1
// Checksum 0xc4fcffcc, Offset: 0x4140
// Size: 0xd4
function get_random_key( dialogkey )
{
    bundlename = self getmpdialogname();
    
    if ( !isdefined( bundlename ) )
    {
        return undefined;
    }
    
    playerbundle = struct::get_script_bundle( "mpdialog_player", bundlename );
    
    if ( !isdefined( playerbundle ) || !isdefined( playerbundle.keycounts ) || !isdefined( playerbundle.keycounts[ dialogkey ] ) )
    {
        return dialogkey;
    }
    
    return dialogkey + randomint( playerbundle.keycounts[ dialogkey ] );
}

// Namespace battlechatter/battlechatter
// Params 2
// Checksum 0x6e472cdc, Offset: 0x4220
// Size: 0x53c
function play_gadget_ready( weapon, userflip )
{
    if ( !isdefined( userflip ) )
    {
        userflip = 0;
    }
    
    if ( !isdefined( weapon ) )
    {
        return;
    }
    
    dialogkey = undefined;
    
    switch ( weapon.name )
    {
        case #"hero_gravityspikes":
            dialogkey = "gravspikesWeaponReady";
            break;
        case #"gadget_speed_burst":
            dialogkey = "overdriveAbilityReady";
            break;
        case #"hero_bowlauncher":
        case #"hero_bowlauncher2":
        case #"hero_bowlauncher3":
        case #"hero_bowlauncher4":
            dialogkey = "sparrowWeaponReady";
            break;
        case #"gadget_vision_pulse":
            dialogkey = "visionpulseAbilityReady";
            break;
        case #"hero_lightninggun":
        case #"hero_lightninggun_arc":
            dialogkey = "tempestWeaponReady";
            break;
        case #"gadget_flashback":
            dialogkey = "glitchAbilityReady";
            break;
        case #"hero_pineapplegun":
            dialogkey = "warmachineWeaponREady";
            break;
        case #"gadget_armor":
            dialogkey = "kineticArmorAbilityReady";
            break;
        case #"hero_annihilator":
            dialogkey = "annihilatorWeaponReady";
            break;
        case #"gadget_combat_efficiency":
            dialogkey = "combatfocusAbilityReady";
            break;
        case #"hero_chemicalgelgun":
            dialogkey = "hiveWeaponReady";
            break;
        case #"gadget_resurrect":
            dialogkey = "rejackAbilityReady";
            break;
        case #"hero_minigun":
            dialogkey = "scytheWeaponReady";
            break;
        case #"gadget_clone":
            dialogkey = "psychosisAbilityReady";
            break;
        case #"hero_armblade":
            dialogkey = "ripperWeaponReady";
            break;
        case #"gadget_camo":
            dialogkey = "activeCamoAbilityReady";
            break;
        case #"hero_flamethrower":
            dialogkey = "purifierWeaponReady";
            break;
        case #"gadget_heat_wave":
            dialogkey = "heatwaveAbilityReady";
            break;
        default:
            return;
    }
    
    if ( !( isdefined( self.isthief ) && self.isthief ) && !( isdefined( self.isroulette ) && self.isroulette ) )
    {
        self thread play_dialog( dialogkey );
        return;
    }
    
    waittime = 0;
    dialogflags = 32;
    
    if ( userflip )
    {
        minwaittime = 0;
        
        if ( self.playinggadgetreadydialog )
        {
            self stop_dialog();
            minwaittime = 0.05;
        }
        
        if ( isdefined( self.isthief ) && self.isthief )
        {
            delaykey = "thiefFlipDelay";
        }
        else
        {
            delaykey = "rouletteFlipDelay";
        }
        
        waittime = mpdialog_value( delaykey, minwaittime );
        dialogflags += 64;
    }
    else
    {
        if ( isdefined( self.isthief ) && self.isthief )
        {
            generickey = "thiefWeaponReady";
            repeatkey = "thiefWeaponRepeat";
            repeatthresholdkey = "thiefRepeatThreshold";
            chancekey = "thiefReadyChance";
            delaykey = "thiefRevealDelay";
        }
        else
        {
            generickey = "rouletteAbilityReady";
            repeatkey = "rouletteAbilityRepeat";
            repeatthresholdkey = "rouletteRepeatThreshold";
            chancekey = "rouletteReadyChance";
            delaykey = "rouletteRevealDelay";
        }
        
        if ( randomint( 100 ) < mpdialog_value( chancekey, 0 ) )
        {
            dialogkey = generickey;
        }
        else
        {
            waittime = mpdialog_value( delaykey, 0 );
            
            if ( self.laststolengadget === weapon && self.laststolengadgettime + mpdialog_value( repeatthresholdkey, 0 ) * 1000 > gettime() )
            {
                dialogkey = repeatkey;
            }
            else
            {
                dialogflags += 64;
            }
        }
    }
    
    self.laststolengadget = weapon;
    self.laststolengadgettime = gettime();
    
    if ( waittime )
    {
        self notify( #"cancel_kill_dialog" );
    }
    
    self thread wait_play_dialog( waittime, dialogkey, dialogflags );
}

// Namespace battlechatter/battlechatter
// Params 1
// Checksum 0x62137a58, Offset: 0x4768
// Size: 0x26c
function play_gadget_activate( weapon )
{
    if ( !isdefined( weapon ) )
    {
        return;
    }
    
    dialogkey = undefined;
    
    switch ( weapon.name )
    {
        case #"hero_gravityspikes":
            dialogkey = "gravspikesWeaponUse";
            dialogflags = 22;
            dialogbuffer = 0.05;
            break;
        case #"gadget_speed_burst":
            dialogkey = "overdriveAbilityUse";
            break;
        case #"hero_bowlauncher":
        case #"hero_bowlauncher2":
        case #"hero_bowlauncher3":
        case #"hero_bowlauncher4":
            dialogkey = "sparrowWeaponUse";
            break;
        case #"gadget_vision_pulse":
            dialogkey = "visionpulseAbilityUse";
            break;
        case #"hero_lightninggun":
        case #"hero_lightninggun_arc":
            dialogkey = "tempestWeaponUse";
            break;
        case #"gadget_flashback":
            dialogkey = "glitchAbilityUse";
            break;
        case #"hero_pineapplegun":
            dialogkey = "warmachineWeaponUse";
            break;
        case #"gadget_armor":
            dialogkey = "kineticArmorAbilityUse";
            break;
        case #"hero_annihilator":
            dialogkey = "annihilatorWeaponUse";
            break;
        case #"gadget_combat_efficiency":
            dialogkey = "combatfocusAbilityUse";
            break;
        case #"hero_chemicalgelgun":
            dialogkey = "hiveWeaponUse";
            break;
        case #"gadget_resurrect":
            dialogkey = "rejackAbilityUse";
            break;
        case #"hero_minigun":
            dialogkey = "scytheWeaponUse";
            break;
        case #"gadget_clone":
            dialogkey = "psychosisAbilityUse";
            break;
        case #"hero_armblade":
            dialogkey = "ripperWeaponUse";
            break;
        case #"gadget_camo":
            dialogkey = "activeCamoAbilityUse";
            break;
        case #"hero_flamethrower":
            dialogkey = "purifierWeaponUse";
            break;
        case #"gadget_heat_wave":
            dialogkey = "heatwaveAbilityUse";
            break;
        default:
            return;
    }
    
    self thread play_dialog( dialogkey, dialogflags, dialogbuffer );
}

// Namespace battlechatter/battlechatter
// Params 3
// Checksum 0x7d29dad4, Offset: 0x49e0
// Size: 0x2a4
function play_gadget_success( weapon, waitkey, victim )
{
    if ( !isdefined( weapon ) )
    {
        return;
    }
    
    dialogkey = undefined;
    
    switch ( weapon.name )
    {
        case #"hero_gravityspikes":
            dialogkey = "gravspikesWeaponSuccess";
            break;
        case #"gadget_speed_burst":
            dialogkey = "overdriveAbilitySuccess";
            break;
        case #"hero_bowlauncher":
        case #"hero_bowlauncher2":
        case #"hero_bowlauncher3":
        case #"hero_bowlauncher4":
            dialogkey = "sparrowWeaponSuccess";
            break;
        case #"gadget_vision_pulse":
            dialogkey = "visionpulseAbilitySuccess";
            break;
        case #"hero_lightninggun":
        case #"hero_lightninggun_arc":
            dialogkey = "tempestWeaponSuccess";
            break;
        case #"gadget_flashback":
            dialogkey = "glitchAbilitySuccess";
            break;
        case #"hero_pineapplegun":
            dialogkey = "warmachineWeaponSuccess";
            break;
        case #"gadget_armor":
            dialogkey = "kineticArmorAbilitySuccess";
            break;
        case #"hero_annihilator":
            dialogkey = "annihilatorWeaponSuccess";
            break;
        case #"gadget_combat_efficiency":
            dialogkey = "combatfocusAbilitySuccess";
            break;
        case #"hero_chemicalgelgun":
            dialogkey = "hiveWeaponSuccess";
            break;
        case #"gadget_resurrect":
            dialogkey = "rejackAbilitySuccess";
            break;
        case #"hero_minigun":
            dialogkey = "scytheWeaponSuccess";
            break;
        case #"gadget_clone":
            dialogkey = "psychosisAbilitySuccess";
            break;
        case #"hero_armblade":
            dialogkey = "ripperWeaponSuccess";
            break;
        case #"gadget_camo":
            dialogkey = "activeCamoAbilitySuccess";
            break;
        case #"hero_flamethrower":
            dialogkey = "purifierWeaponSuccess";
            break;
        case #"gadget_heat_wave":
            dialogkey = "heatwaveAbilitySuccess";
            break;
        default:
            return;
    }
    
    if ( isdefined( waitkey ) )
    {
        waittime = mpdialog_value( waitkey, 0 );
    }
    
    dialogkey += "0";
    self.playedgadgetsuccess = 1;
    self thread wait_play_dialog( waittime, dialogkey, 1, undefined, victim );
}

// Namespace battlechatter/battlechatter
// Params 0
// Checksum 0x320c9322, Offset: 0x4c90
// Size: 0x44
function play_throw_hatchet()
{
    self thread play_dialog( "exertAxeThrow", 21, mpdialog_value( "playerExertBuffer", 0 ) );
}

// Namespace battlechatter/battlechatter
// Params 0
// Checksum 0x9c2cedd5, Offset: 0x4ce0
// Size: 0x1ce
function get_enemy_players()
{
    players = [];
    
    if ( level.teambased )
    {
        foreach ( team in level.teams )
        {
            if ( team == self.team )
            {
                continue;
            }
            
            foreach ( player in level.aliveplayers[ team ] )
            {
                players[ players.size ] = player;
            }
        }
    }
    else
    {
        foreach ( player in level.activeplayers )
        {
            if ( player != self )
            {
                players[ players.size ] = player;
            }
        }
    }
    
    return players;
}

// Namespace battlechatter/battlechatter
// Params 0
// Checksum 0xbb13885d, Offset: 0x4eb8
// Size: 0xc8
function get_friendly_players()
{
    players = [];
    
    if ( level.teambased )
    {
        foreach ( player in level.aliveplayers[ self.team ] )
        {
            players[ players.size ] = player;
        }
    }
    else
    {
        players[ 0 ] = self;
    }
    
    return players;
}

// Namespace battlechatter/battlechatter
// Params 1
// Checksum 0x4304ecc3, Offset: 0x4f88
// Size: 0xf6, Type: bool
function can_play_dialog( teamonly )
{
    if ( !isplayer( self ) || !isalive( self ) || self.playingdialog === 1 || self isplayerunderwater() || self isremotecontrolling() || self isinvehicle() || self isweaponviewonlylinked() )
    {
        return false;
    }
    
    if ( isdefined( teamonly ) && !teamonly && self hasperk( "specialty_quieter" ) )
    {
        return false;
    }
    
    return true;
}

// Namespace battlechatter/battlechatter
// Params 2
// Checksum 0x639c8ff7, Offset: 0x5088
// Size: 0x108
function get_closest_player_enemy( origin, teamonly )
{
    if ( !isdefined( origin ) )
    {
        origin = self.origin;
    }
    
    players = self get_enemy_players();
    players = arraysort( players, origin );
    
    foreach ( player in players )
    {
        if ( !player can_play_dialog( teamonly ) )
        {
            continue;
        }
        
        return player;
    }
    
    return undefined;
}

// Namespace battlechatter/battlechatter
// Params 1
// Checksum 0xc7bb5ca2, Offset: 0x5198
// Size: 0x102
function get_closest_player_ally( teamonly )
{
    if ( !level.teambased )
    {
        return undefined;
    }
    
    players = self get_friendly_players();
    players = arraysort( players, self.origin );
    
    foreach ( player in players )
    {
        if ( player == self || !player can_play_dialog( teamonly ) )
        {
            continue;
        }
        
        return player;
    }
    
    return undefined;
}

// Namespace battlechatter/battlechatter
// Params 0
// Checksum 0xc8c3381f, Offset: 0x52a8
// Size: 0x1d4
function check_boost_start_conversation()
{
    if ( !level.playstartconversation )
    {
        return;
    }
    
    if ( !level.inprematchperiod || !level.teambased || game.boostplayerspicked[ self.team ] )
    {
        return;
    }
    
    players = self get_friendly_players();
    array::add( players, self, 0 );
    players = array::randomize( players );
    playerindex = 1;
    
    foreach ( player in players )
    {
        playerdialog = player getmpdialogname();
        
        for ( i = playerindex; i < players.size ; i++ )
        {
            playeri = players[ i ];
            
            if ( playerdialog != playeri getmpdialogname() )
            {
                pick_boost_players( player, playeri );
                return;
            }
        }
        
        playerindex++;
    }
}

// Namespace battlechatter/battlechatter
// Params 2
// Checksum 0xc6b2c143, Offset: 0x5488
// Size: 0x76
function pick_boost_players( player1, player2 )
{
    player1 clientfield::set( "play_boost", 1 );
    player2 clientfield::set( "play_boost", 2 );
    game.boostplayerspicked[ player1.team ] = 1;
}

// Namespace battlechatter/battlechatter
// Params 1
// Checksum 0x1e1ac4dc, Offset: 0x5508
// Size: 0x1da
function game_end_vox( winner )
{
    if ( !level.allowspecialistdialog )
    {
        return;
    }
    
    var_71859219 = level.teambased && ( !isdefined( winner ) || winner == "tie" );
    
    foreach ( player in level.players )
    {
        if ( player issplitscreen() )
        {
            continue;
        }
        
        if ( var_71859219 )
        {
            dialogkey = "boostDraw";
        }
        else if ( !level.teambased && ( level.teambased && isdefined( level.teams[ winner ] ) && player.pers[ "team" ] == winner || player == winner ) )
        {
            dialogkey = "boostWin";
        }
        else
        {
            dialogkey = "boostLoss";
        }
        
        dialogalias = player get_player_dialog_alias( dialogkey );
        
        if ( isdefined( dialogalias ) )
        {
            player playlocalsound( dialogalias );
        }
    }
}

/#

    // Namespace battlechatter/battlechatter
    // Params 0
    // Checksum 0x5048811c, Offset: 0x56f0
    // Size: 0x380, Type: dev
    function devgui_think()
    {
        setdvar( "<dev string:xa8>", "<dev string:xb8>" );
        setdvar( "<dev string:xb9>", "<dev string:xca>" );
        setdvar( "<dev string:xe5>", "<dev string:xf6>" );
        setdvar( "<dev string:x110>", "<dev string:x124>" );
        
        while ( true )
        {
            wait 1;
            player = util::gethostplayer();
            
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            spacing = getdvarfloat( "<dev string:x145>", 0.25 );
            
            switch ( getdvarstring( "<dev string:xa8>", "<dev string:xb8>" ) )
            {
                case #"hash_a44caacc":
                    player thread test_player_dialog( 0 );
                    player thread test_taacom_dialog( spacing );
                    player thread test_commander_dialog( 2 * spacing );
                    break;
                case #"hash_ccef9d3a":
                    player thread test_player_dialog( 0 );
                    player thread test_commander_dialog( spacing );
                    break;
                case #"hash_fc2d2a30":
                    player thread test_other_dialog( 0 );
                    player thread test_commander_dialog( spacing );
                    break;
                case #"hash_94c50ce9":
                    player thread test_taacom_dialog( 0 );
                    player thread test_commander_dialog( spacing );
                    break;
                case #"hash_e1beeaa5":
                    player thread test_player_dialog( 0 );
                    player thread test_taacom_dialog( spacing );
                    break;
                case #"hash_e6de4bbf":
                    player thread test_other_dialog( 0 );
                    player thread test_taacom_dialog( spacing );
                    break;
                case #"hash_733722ac":
                    player thread test_other_dialog( 0 );
                    player thread test_player_dialog( spacing );
                    break;
                case #"hash_d6bbad13":
                    player thread play_conv_self_other();
                    break;
                case #"hash_f9d78311":
                    player thread play_conv_other_self();
                    break;
                case #"hash_2f69d023":
                    player thread play_conv_other_other();
                    break;
            }
            
            setdvar( "<dev string:xa8>", "<dev string:xb8>" );
        }
    }

    // Namespace battlechatter/battlechatter
    // Params 1
    // Checksum 0xec2c83a7, Offset: 0x5a78
    // Size: 0xf4, Type: dev
    function test_other_dialog( delay )
    {
        players = arraysort( level.players, self.origin );
        
        foreach ( player in players )
        {
            if ( player != self && isalive( player ) )
            {
                player thread test_player_dialog( delay );
                return;
            }
        }
    }

    // Namespace battlechatter/battlechatter
    // Params 1
    // Checksum 0xb385d87d, Offset: 0x5b78
    // Size: 0x64, Type: dev
    function test_player_dialog( delay )
    {
        if ( !isdefined( delay ) )
        {
            delay = 0;
        }
        
        wait delay;
        self playsoundontag( getdvarstring( "<dev string:xb9>", "<dev string:xb8>" ), "<dev string:x1f3>" );
    }

    // Namespace battlechatter/battlechatter
    // Params 1
    // Checksum 0x8b43a8a3, Offset: 0x5be8
    // Size: 0x5c, Type: dev
    function test_taacom_dialog( delay )
    {
        if ( !isdefined( delay ) )
        {
            delay = 0;
        }
        
        wait delay;
        self playlocalsound( getdvarstring( "<dev string:xe5>", "<dev string:xb8>" ) );
    }

    // Namespace battlechatter/battlechatter
    // Params 1
    // Checksum 0x32192f20, Offset: 0x5c50
    // Size: 0x5c, Type: dev
    function test_commander_dialog( delay )
    {
        if ( !isdefined( delay ) )
        {
            delay = 0;
        }
        
        wait delay;
        self playlocalsound( getdvarstring( "<dev string:x110>", "<dev string:xb8>" ) );
    }

    // Namespace battlechatter/battlechatter
    // Params 1
    // Checksum 0x65c2c66a, Offset: 0x5cb8
    // Size: 0x5c, Type: dev
    function play_test_dialog( dialogkey )
    {
        dialogalias = self get_player_dialog_alias( dialogkey );
        self playsoundontag( dialogalias, "<dev string:x1f3>" );
    }

    // Namespace battlechatter/battlechatter
    // Params 0
    // Checksum 0x1e0cf5e8, Offset: 0x5d20
    // Size: 0xc4, Type: dev
    function response_key()
    {
        switch ( self getmpdialogname() )
        {
            case #"assassin":
                return "<dev string:x203>";
            case #"grenadier":
                return "<dev string:x215>";
            case #"outrider":
                return "<dev string:x228>";
            case #"prophet":
                return "<dev string:x239>";
            case #"pyro":
                return "<dev string:x24b>";
            case #"reaper":
                return "<dev string:x25c>";
            case #"ruin":
                return "<dev string:x268>";
            case #"seraph":
                return "<dev string:x279>";
            case #"trapper":
                return "<dev string:x28a>";
        }
        
        return "<dev string:xb8>";
    }

    // Namespace battlechatter/battlechatter
    // Params 0
    // Checksum 0x7cb62ccc, Offset: 0x5df0
    // Size: 0x15e, Type: dev
    function play_conv_self_other()
    {
        num = randomintrange( 0, 4 );
        self play_test_dialog( "<dev string:x292>" + num );
        wait 4;
        players = arraysort( level.players, self.origin );
        
        foreach ( player in players )
        {
            if ( player != self && isalive( player ) )
            {
                player play_test_dialog( "<dev string:x29d>" + self response_key() + num );
                break;
            }
        }
    }

    // Namespace battlechatter/battlechatter
    // Params 0
    // Checksum 0xdaee9d7, Offset: 0x5f58
    // Size: 0x15c, Type: dev
    function play_conv_other_self()
    {
        num = randomintrange( 0, 4 );
        players = arraysort( level.players, self.origin );
        
        foreach ( player in players )
        {
            if ( player != self && isalive( player ) )
            {
                player play_test_dialog( "<dev string:x292>" + num );
                break;
            }
        }
        
        wait 4;
        self play_test_dialog( "<dev string:x29d>" + player response_key() + num );
    }

    // Namespace battlechatter/battlechatter
    // Params 0
    // Checksum 0xa23a3634, Offset: 0x60c0
    // Size: 0x206, Type: dev
    function play_conv_other_other()
    {
        num = randomintrange( 0, 4 );
        players = arraysort( level.players, self.origin );
        
        foreach ( player in players )
        {
            if ( player != self && isalive( player ) )
            {
                player play_test_dialog( "<dev string:x292>" + num );
                firstplayer = player;
                break;
            }
        }
        
        wait 4;
        
        foreach ( player in players )
        {
            if ( player != self && player !== firstplayer && isalive( player ) )
            {
                player play_test_dialog( "<dev string:x29d>" + firstplayer response_key() + num );
                break;
            }
        }
    }

#/
