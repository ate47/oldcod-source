#using scripts\core_common\bb_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;

#namespace bb;

// Namespace bb/bb
// Params 0, eflags: 0x2
// Checksum 0x4f887e04, Offset: 0x98
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"bb", &__init__, undefined, undefined);
}

// Namespace bb/bb
// Params 0, eflags: 0x0
// Checksum 0xe8c793a4, Offset: 0xe0
// Size: 0x14
function __init__() {
    init_shared();
}

// Namespace bb/bb
// Params 8, eflags: 0x0
// Checksum 0xe14cb53, Offset: 0x100
// Size: 0x44
function logdamage(attacker, victim, weapon, damage, damagetype, hitlocation, victimkilled, victimdowned) {
    
}

// Namespace bb/bb
// Params 2, eflags: 0x0
// Checksum 0x1fbce053, Offset: 0x150
// Size: 0x14
function logaispawn(aient, spawner) {
    
}

// Namespace bb/bb
// Params 2, eflags: 0x0
// Checksum 0x1a858d5b, Offset: 0x170
// Size: 0x23c
function logplayerevent(player, eventname) {
    currentweapon = "";
    beastmodeactive = 0;
    if (isdefined(player.currentweapon)) {
        currentweapon = player.currentweapon.name;
    }
    if (isdefined(player.beastmode)) {
        beastmodeactive = player.beastmode;
    }
    zmplayerevents = {};
    zmplayerevents.gametime = function_25e96038();
    zmplayerevents.roundnumber = level.round_number;
    zmplayerevents.eventname = eventname;
    zmplayerevents.spawnid = getplayerspawnid(player);
    zmplayerevents.username = player.name;
    zmplayerevents.originx = player.origin[0];
    zmplayerevents.originy = player.origin[1];
    zmplayerevents.originz = player.origin[2];
    zmplayerevents.health = player.health;
    zmplayerevents.beastlives = player.beastlives;
    zmplayerevents.currentweapon = currentweapon;
    zmplayerevents.kills = player.kills;
    zmplayerevents.zone_name = player.zone_name;
    zmplayerevents.sessionstate = player.sessionstate;
    zmplayerevents.currentscore = player.score;
    zmplayerevents.totalscore = player.score_total;
    zmplayerevents.beastmodeon = beastmodeactive;
    function_b1f6086c(#"hash_5bd2a2e3f75111c8", zmplayerevents);
}

// Namespace bb/bb
// Params 1, eflags: 0x0
// Checksum 0x801ca976, Offset: 0x3b8
// Size: 0x118
function logroundevent(eventname) {
    zmroundevents = {#gametime:function_25e96038(), #roundnumber:level.round_number, #eventname:eventname};
    function_b1f6086c(#"hash_1f42d237e3407165", zmroundevents);
    if (isdefined(level.players)) {
        foreach (player in level.players) {
            logplayerevent(player, eventname);
        }
    }
}

// Namespace bb/bb
// Params 7, eflags: 0x0
// Checksum 0xa7fa444c, Offset: 0x4d8
// Size: 0x22c
function logpurchaseevent(player, sellerent, cost, itemname, itemupgraded, itemtype, eventname) {
    zmpurchases = {};
    zmpurchases.gametime = function_25e96038();
    zmpurchases.roundnumber = level.round_number;
    zmpurchases.playerspawnid = getplayerspawnid(player);
    zmpurchases.username = player.name;
    zmpurchases.itemname = itemname;
    zmpurchases.isupgraded = itemupgraded;
    zmpurchases.itemtype = itemtype;
    zmpurchases.purchasecost = cost;
    zmpurchases.playeroriginx = player.origin[0];
    zmpurchases.playeroriginy = player.origin[1];
    zmpurchases.playeroriginz = player.origin[2];
    zmpurchases.selleroriginx = sellerent.origin[0];
    zmpurchases.selleroriginy = sellerent.origin[1];
    zmpurchases.selleroriginz = sellerent.origin[2];
    zmpurchases.playerkills = player.kills;
    zmpurchases.playerhealth = player.health;
    zmpurchases.playercurrentscore = player.score;
    zmpurchases.playertotalscore = player.score_total;
    zmpurchases.zone_name = player.zone_name;
    function_b1f6086c(#"hash_22cb254982ca97dc", zmpurchases);
}

// Namespace bb/bb
// Params 3, eflags: 0x0
// Checksum 0xaf7500a8, Offset: 0x710
// Size: 0x218
function logpowerupevent(powerup, optplayer, eventname) {
    playerspawnid = -1;
    playername = "";
    if (isdefined(optplayer) && isplayer(optplayer)) {
        playerspawnid = getplayerspawnid(optplayer);
        playername = optplayer.name;
    }
    zmpowerups = {};
    zmpowerups.gametime = function_25e96038();
    zmpowerups.roundnumber = level.round_number;
    zmpowerups.powerupname = powerup.powerup_name;
    zmpowerups.powerupx = powerup.origin[0];
    zmpowerups.powerupy = powerup.origin[1];
    zmpowerups.powerupz = powerup.origin[2];
    zmpowerups.eventname = eventname;
    zmpowerups.playerspawnid = playerspawnid;
    zmpowerups.playername = playername;
    function_b1f6086c(#"hash_7edbd2a2dee992e9", zmpowerups);
    foreach (player in level.players) {
        logplayerevent(player, "powerup_" + powerup.powerup_name + "_" + eventname);
    }
}

