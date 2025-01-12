#using scripts\core_common\clientfield_shared;

#namespace hud;

// Namespace hud/hud
// Params 0, eflags: 0x1 linked
// Checksum 0xb462b9d4, Offset: 0x378
// Size: 0x77c
function function_9b9cecdf() {
    clientfield::function_5b7d846d("hudItems.warzone.reinsertionPassengerCount", #"hash_593f03dd48d5bc1f", #"reinsertionpassengercount", 1, 7, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("hudItems.alivePlayerCount", #"hash_6f4b11a0bee9b73d", #"aliveplayercount", 1, 7, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("hudItems.alivePlayerCountEnemy", #"hash_6f4b11a0bee9b73d", #"aliveplayercountenemy", 1, 7, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("hudItems.aliveTeammateCount", #"hash_6f4b11a0bee9b73d", #"aliveteammatecount", 1, 7, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("hudItems.spectatorsCount", #"hash_6f4b11a0bee9b73d", #"spectatorscount", 1, 7, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("hudItems.playerKills", #"hash_6f4b11a0bee9b73d", #"playerkills", 1, 7, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("hudItems.playerCleanUps", #"hash_6f4b11a0bee9b73d", #"playercleanups", 1, 7, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("presence.modeparam", #"hash_3645501c8ba141af", #"modeparam", 1, 7, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("hudItems.hasBackpack", #"hash_6f4b11a0bee9b73d", #"hasbackpack", 1, 1, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("hudItems.armorType", #"hash_6f4b11a0bee9b73d", #"armortype", 1, 2, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("hudItems.streamerLoadFraction", #"hash_6f4b11a0bee9b73d", #"streamerloadfraction", 1, 5, "float", undefined, 0, 0);
    clientfield::register_clientuimodel("hudItems.wzLoadFinished", #"hash_6f4b11a0bee9b73d", #"wzloadfinished", 1, 1, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("hudItems.showReinsertionPassengerCount", #"hash_6f4b11a0bee9b73d", #"showreinsertionpassengercount", 1, 1, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("hudItems.playerLivesRemaining", #"hash_6f4b11a0bee9b73d", #"playerlivesremaining", 15000, 3, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("hudItems.playerCanRedeploy", #"hash_6f4b11a0bee9b73d", #"playercanredeploy", 15000, 1, "int", undefined, 0, 0);
    clientfield::register("toplayer", "realtime_multiplay", 1, 1, "int", &function_a1b40aa4, 0, 0);
    clientfield::function_5b7d846d("hudItems.warzone.collapse", #"hash_593f03dd48d5bc1f", #"collapse", 11000, 21, "int", undefined, 0, 0);
    clientfield::function_5b7d846d("hudItems.warzone.waveRespawnTimer", #"hash_593f03dd48d5bc1f", #"waverespawntimer", 15000, 21, "int", undefined, 0, 0);
    clientfield::function_5b7d846d("hudItems.warzone.collapseIndex", #"hash_593f03dd48d5bc1f", #"collapseindex", 1, 3, "int", undefined, 0, 0);
    clientfield::function_5b7d846d("hudItems.warzone.collapseCount", #"hash_593f03dd48d5bc1f", #"collapsecount", 1, 3, "int", undefined, 0, 0);
    clientfield::function_5b7d846d("hudItems.warzone.reinsertionIndex", #"hash_593f03dd48d5bc1f", #"reinsertionindex", 1, 3, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("hudItems.skydiveAltimeterVisible", #"hash_6f4b11a0bee9b73d", #"hash_4546996cf93b1697", 1, 1, "int", undefined, 0, 0);
    clientfield::function_5b7d846d("hudItems.skydiveAltimeterHeight", #"hash_410fe12a68d6e801", #"hash_34e492b27fa3f3dc", 1, 16, "int", undefined, 0, 0);
    clientfield::function_5b7d846d("hudItems.skydiveAltimeterSeaHeight", #"hash_410fe12a68d6e801", #"hash_7f022c556fec0bf9", 1, 16, "int", undefined, 0, 0);
}

// Namespace hud/hud
// Params 7, eflags: 0x1 linked
// Checksum 0x91e0598e, Offset: 0xb00
// Size: 0xfc
function function_a1b40aa4(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, bwastimejump) {
    player = function_27673a7(binitialsnap);
    if (player != self) {
        return;
    }
    if (bwastimejump) {
        return;
    }
    if (!isplayer(player) || !isalive(player)) {
        function_3f258626(binitialsnap);
        return;
    }
    if (fieldname == 1) {
        function_9e9a0604(binitialsnap);
        return;
    }
    function_3f258626(binitialsnap);
}

