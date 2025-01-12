#using scripts\core_common\bb_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;

#namespace bb;

// Namespace bb/bb
// Params 0, eflags: 0x6
// Checksum 0xf3fea2ee, Offset: 0x98
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"bb", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace bb/bb
// Params 0, eflags: 0x5 linked
// Checksum 0xc5e36f82, Offset: 0xe0
// Size: 0x14
function private function_70a657d8() {
    init_shared();
}

// Namespace bb/bb
// Params 8, eflags: 0x1 linked
// Checksum 0x52fc3095, Offset: 0x100
// Size: 0x44
function logdamage(*attacker, *victim, *weapon, *damage, *damagetype, *hitlocation, *victimkilled, *victimdowned) {
    
}

// Namespace bb/bb
// Params 2, eflags: 0x1 linked
// Checksum 0xa495980a, Offset: 0x150
// Size: 0x14
function logaispawn(*aient, *spawner) {
    
}

// Namespace bb/bb
// Params 2, eflags: 0x1 linked
// Checksum 0xaddcc9c1, Offset: 0x170
// Size: 0x1d4
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
    zmplayerevents.gametime = function_f8d53445();
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
    function_92d1707f(#"hash_5bd2a2e3f75111c8", zmplayerevents);
}

// Namespace bb/bb
// Params 1, eflags: 0x1 linked
// Checksum 0x6ecb1d54, Offset: 0x350
// Size: 0x128
function logroundevent(eventname) {
    zmroundevents = {#gametime:function_f8d53445(), #roundnumber:level.round_number, #eventname:eventname};
    function_92d1707f(#"hash_1f42d237e3407165", zmroundevents);
    if (isdefined(level.players)) {
        foreach (player in level.players) {
            logplayerevent(player, eventname);
        }
    }
}

// Namespace bb/bb
// Params 7, eflags: 0x1 linked
// Checksum 0x14571f6a, Offset: 0x480
// Size: 0x1cc
function logpurchaseevent(player, sellerent, cost, itemname, itemupgraded, itemtype, *eventname) {
    zmpurchases = {};
    zmpurchases.gametime = function_f8d53445();
    zmpurchases.roundnumber = level.round_number;
    zmpurchases.playerspawnid = getplayerspawnid(sellerent);
    zmpurchases.username = sellerent.name;
    zmpurchases.itemname = itemupgraded;
    zmpurchases.isupgraded = itemtype;
    zmpurchases.itemtype = eventname;
    zmpurchases.purchasecost = itemname;
    zmpurchases.playeroriginx = sellerent.origin[0];
    zmpurchases.playeroriginy = sellerent.origin[1];
    zmpurchases.playeroriginz = sellerent.origin[2];
    zmpurchases.selleroriginx = cost.origin[0];
    zmpurchases.selleroriginy = cost.origin[1];
    zmpurchases.selleroriginz = cost.origin[2];
    zmpurchases.playerkills = sellerent.kills;
    zmpurchases.playerhealth = sellerent.health;
    zmpurchases.playercurrentscore = sellerent.score;
    zmpurchases.playertotalscore = sellerent.score_total;
    zmpurchases.zone_name = sellerent.zone_name;
    function_92d1707f(#"hash_22cb254982ca97dc", zmpurchases);
}

// Namespace bb/bb
// Params 3, eflags: 0x1 linked
// Checksum 0xf0b2521b, Offset: 0x658
// Size: 0x200
function logpowerupevent(powerup, optplayer, eventname) {
    playerspawnid = -1;
    playername = "";
    if (isdefined(optplayer) && isplayer(optplayer)) {
        playerspawnid = getplayerspawnid(optplayer);
        playername = optplayer.name;
    }
    zmpowerups = {};
    zmpowerups.gametime = function_f8d53445();
    zmpowerups.roundnumber = level.round_number;
    zmpowerups.powerupname = powerup.powerup_name;
    zmpowerups.powerupx = powerup.origin[0];
    zmpowerups.powerupy = powerup.origin[1];
    zmpowerups.powerupz = powerup.origin[2];
    zmpowerups.eventname = eventname;
    zmpowerups.playerspawnid = playerspawnid;
    zmpowerups.playername = playername;
    function_92d1707f(#"hash_7edbd2a2dee992e9", zmpowerups);
    foreach (player in level.players) {
        logplayerevent(player, "powerup_" + powerup.powerup_name + "_" + eventname);
    }
}

