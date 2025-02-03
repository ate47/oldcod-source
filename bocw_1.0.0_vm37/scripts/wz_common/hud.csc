#using scripts\core_common\clientfield_shared;

#namespace hud;

// Namespace hud/hud
// Params 0, eflags: 0x0
// Checksum 0x1fb5b7a5, Offset: 0x378
// Size: 0x77c
function function_9b9cecdf() {
    clientfield::function_5b7d846d("hudItems.warzone.reinsertionPassengerCount", #"warzone_global", #"reinsertionpassengercount", 1, 7, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("hudItems.alivePlayerCount", #"hud_items", #"aliveplayercount", 1, 7, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("hudItems.alivePlayerCountEnemy", #"hud_items", #"aliveplayercountenemy", 1, 7, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("hudItems.aliveTeammateCount", #"hud_items", #"aliveteammatecount", 1, 7, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("hudItems.spectatorsCount", #"hud_items", #"spectatorscount", 1, 7, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("hudItems.playerKills", #"hud_items", #"playerkills", 1, 7, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("hudItems.playerCleanUps", #"hud_items", #"playercleanups", 1, 7, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("presence.modeparam", #"hash_3645501c8ba141af", #"modeparam", 1, 7, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("hudItems.hasBackpack", #"hud_items", #"hasbackpack", 1, 1, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("hudItems.armorType", #"hud_items", #"armortype", 1, 2, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("hudItems.streamerLoadFraction", #"hud_items", #"streamerloadfraction", 1, 5, "float", undefined, 0, 0);
    clientfield::register_clientuimodel("hudItems.wzLoadFinished", #"hud_items", #"wzloadfinished", 1, 1, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("hudItems.showReinsertionPassengerCount", #"hud_items", #"showreinsertionpassengercount", 1, 1, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("hudItems.playerLivesRemaining", #"hud_items", #"playerlivesremaining", 15000, 3, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("hudItems.playerCanRedeploy", #"hud_items", #"playercanredeploy", 15000, 1, "int", undefined, 0, 0);
    clientfield::register("toplayer", "realtime_multiplay", 1, 1, "int", &function_a1b40aa4, 0, 0);
    clientfield::function_5b7d846d("hudItems.warzone.collapse", #"warzone_global", #"collapse", 11000, 21, "int", undefined, 0, 0);
    clientfield::function_5b7d846d("hudItems.warzone.waveRespawnTimer", #"warzone_global", #"waverespawntimer", 15000, 21, "int", undefined, 0, 0);
    clientfield::function_5b7d846d("hudItems.warzone.collapseIndex", #"warzone_global", #"collapseindex", 1, 3, "int", undefined, 0, 0);
    clientfield::function_5b7d846d("hudItems.warzone.collapseCount", #"warzone_global", #"collapsecount", 1, 3, "int", undefined, 0, 0);
    clientfield::function_5b7d846d("hudItems.warzone.reinsertionIndex", #"warzone_global", #"reinsertionindex", 1, 3, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("hudItems.skydiveAltimeterVisible", #"hud_items", #"hash_4546996cf93b1697", 1, 1, "int", undefined, 0, 0);
    clientfield::function_5b7d846d("hudItems.skydiveAltimeterHeight", #"hash_410fe12a68d6e801", #"hash_34e492b27fa3f3dc", 1, 16, "int", undefined, 0, 0);
    clientfield::function_5b7d846d("hudItems.skydiveAltimeterSeaHeight", #"hash_410fe12a68d6e801", #"hash_7f022c556fec0bf9", 1, 16, "int", undefined, 0, 0);
}

// Namespace hud/hud
// Params 7, eflags: 0x0
// Checksum 0xd0fc218f, Offset: 0xb00
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

