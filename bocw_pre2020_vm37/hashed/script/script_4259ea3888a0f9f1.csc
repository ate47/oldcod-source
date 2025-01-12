#using script_1103c28492840e5f;
#using script_11cc3a9267cf7ac7;
#using script_1c5cce12dd83e08;
#using script_202bf2aa3dbffa20;
#using script_2ae7c487149cc862;
#using script_2bdd098a8215ac9f;
#using script_311c446e3df6c3fa;
#using script_37ec43096fb284a3;
#using script_38dc72b5220a1a67;
#using script_391889b7ff93ef7e;
#using script_3a30122e78de2f6c;
#using script_3c0e0fe36a7ec024;
#using script_3dc7e0c7f9c90bdb;
#using script_41e32418d719f2dd;
#using script_44c87b4589ee1f93;
#using script_45ed9e2916a5d657;
#using script_461a5eb3081800a3;
#using script_4ed01237ecbd380f;
#using script_5665e7d917abc3fc;
#using script_581877678e31274c;
#using script_5ee86fb478309acf;
#using script_60793766a26de8df;
#using script_6243781aa5394e62;
#using script_62c40d9a3acec9b1;
#using script_62c72c96978f9b04;
#using script_71cdde87963901ec;
#using script_7ccd314d69366639;
#using script_9b45ee6e898be9;
#using script_b66278448e9c8ee;
#using script_d85a41a4c7247ce;
#using script_e20ccc2080746be;
#using script_eff00f787d80cdf;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\item_world;
#using scripts\core_common\map;
#using scripts\core_common\util_shared;

#namespace zsurvival;

// Namespace zsurvival/gametype_init
// Params 1, eflags: 0x40
// Checksum 0x232d5390, Offset: 0x488
// Size: 0x864
function event_handler[gametype_init] main(*eventstruct) {
    level.is_survival = 1;
    level.aat_in_use = 1;
    setdvar(#"st_grass", 1);
    setdvar(#"hash_11a23659adb39e95", 0);
    callback::on_localclient_connect(&on_player_connect);
    callback::on_gameplay_started(&on_gameplay_started);
    level.var_13339abf = array(#"ammo_small_caliber_item_t9_sr", #"ammo_ar_item_t9_sr", #"ammo_large_caliber_item_t9_sr", #"ammo_sniper_item_t9_sr", #"ammo_shotgun_item_t9_sr", #"ammo_special_item_t9_sr");
    function_6b4d4a88();
    clientfield::register_clientuimodel("hudItems.streamerLoadFraction", #"hash_6f4b11a0bee9b73d", #"streamerloadfraction", 1, 5, "float", undefined, 0, 0);
    clientfield::register_clientuimodel("hudItems.wzLoadFinished", #"hash_6f4b11a0bee9b73d", #"wzloadfinished", 1, 1, "int", undefined, 0, 0);
    clientfield::function_5b7d846d("hudItems.warzone.reinsertionPassengerCount", #"hash_593f03dd48d5bc1f", #"reinsertionpassengercount", 1, 7, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("hudItems.alivePlayerCount", #"hash_6f4b11a0bee9b73d", #"aliveplayercount", 1, 7, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("hudItems.alivePlayerCountEnemy", #"hash_6f4b11a0bee9b73d", #"aliveplayercountenemy", 1, 7, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("hudItems.aliveTeammateCount", #"hash_6f4b11a0bee9b73d", #"aliveteammatecount", 1, 7, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("hudItems.spectatorsCount", #"hash_6f4b11a0bee9b73d", #"spectatorscount", 1, 7, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("hudItems.playerKills", #"hash_6f4b11a0bee9b73d", #"playerkills", 1, 9, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("hudItems.playerCleanUps", #"hash_6f4b11a0bee9b73d", #"playercleanups", 1, 7, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("presence.modeparam", #"hash_3645501c8ba141af", #"modeparam", 1, 7, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("hudItems.showReinsertionPassengerCount", #"hash_6f4b11a0bee9b73d", #"showreinsertionpassengercount", 1, 1, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("hudItems.playerLivesRemaining", #"hash_6f4b11a0bee9b73d", #"playerlivesremaining", 1, 3, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("hudItems.playerCanRedeploy", #"hash_6f4b11a0bee9b73d", #"playercanredeploy", 1, 1, "int", undefined, 0, 0);
    clientfield::function_5b7d846d("hudItems.warzone.collapse", #"hash_593f03dd48d5bc1f", #"collapse", 1, 21, "int", undefined, 0, 0);
    clientfield::function_5b7d846d("hudItems.warzone.waveRespawnTimer", #"hash_593f03dd48d5bc1f", #"waverespawntimer", 1, 21, "int", undefined, 0, 0);
    clientfield::function_5b7d846d("hudItems.warzone.collapseIndex", #"hash_593f03dd48d5bc1f", #"collapseindex", 1, 3, "int", undefined, 0, 0);
    clientfield::function_5b7d846d("hudItems.warzone.collapseCount", #"hash_593f03dd48d5bc1f", #"collapsecount", 1, 3, "int", undefined, 0, 0);
    clientfield::function_5b7d846d("hudItems.warzone.reinsertionIndex", #"hash_593f03dd48d5bc1f", #"reinsertionindex", 1, 3, "int", undefined, 0, 0);
    clientfield::register("world", "set_objective_fog", 1, 2, "int", &set_objective_fog, 0, 0);
    clientfield::function_5b7d846d("hudItems.team1.roundsWon", #"hash_410fe12a68d6e801", [#"team1", #"roundswon"], 1, 4, "int", undefined, 0, 0);
    clientfield::function_5b7d846d("hudItems.team2.roundsWon", #"hash_410fe12a68d6e801", [#"team2", #"roundswon"], 1, 4, "int", undefined, 0, 0);
    level.progress_bar = luielembar::register();
    level.var_8e86256f = luielembar::register();
    level.var_478e1780 = luielembar::register();
    level.var_b108ea74 = luielembar::register();
}

// Namespace zsurvival/zsurvival
// Params 1, eflags: 0x0
// Checksum 0x97af5bae, Offset: 0xcf8
// Size: 0x64
function on_player_connect(localclientnum) {
    setpbgactivebank(localclientnum, 2);
    setexposureactivebank(localclientnum, 2);
    function_be93487f(localclientnum, 2, 0, 1, 0, 0);
}

// Namespace zsurvival/zsurvival
// Params 7, eflags: 0x0
// Checksum 0x6e006da4, Offset: 0xd68
// Size: 0x1b4
function set_objective_fog(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *wasdemojump) {
    switch (wasdemojump) {
    case 0:
        var_92d85419 = level.var_6465f02d;
        var_312d65d1 = level.var_68f7ce2e;
        level.var_68f7ce2e = 2;
        n_time = 3;
        break;
    case 1:
        var_92d85419 = 1;
        var_312d65d1 = 2;
        level.var_68f7ce2e = 4;
        n_time = 10;
        break;
    case 2:
        var_92d85419 = 1;
        var_312d65d1 = 2;
        level.var_68f7ce2e = 8;
        n_time = 10;
        break;
    }
    setpbgactivebank(fieldname, level.var_68f7ce2e);
    setexposureactivebank(fieldname, level.var_68f7ce2e);
    e_player = getlocalplayers()[fieldname];
    e_player thread function_33593a44(fieldname, var_312d65d1, level.var_68f7ce2e, n_time, var_92d85419);
}

// Namespace zsurvival/zsurvival
// Params 5, eflags: 0x4
// Checksum 0x4af8249d, Offset: 0xf28
// Size: 0x188
function private function_33593a44(localclientnum, var_312d65d1, var_68f7ce2e, n_time = 3, var_92d85419 = 1) {
    self notify("4f3f58694cf93d58");
    self endon("4f3f58694cf93d58");
    n_blend = 0;
    var_8a727807 = 1;
    n_increment = 1 / n_time / 0.016;
    if (var_312d65d1 == 2) {
        level.var_6465f02d = var_92d85419;
        while (n_blend < var_92d85419) {
            function_be93487f(localclientnum, var_312d65d1 | var_68f7ce2e, 0, var_8a727807 - n_blend, n_blend, 0);
            n_blend += n_increment;
            waitframe(1);
        }
        return;
    }
    if (var_312d65d1 == 4 || var_312d65d1 == 8) {
        while (n_blend < var_8a727807) {
            function_be93487f(localclientnum, var_312d65d1 | var_68f7ce2e, 0, n_blend, var_92d85419 - n_blend, 0);
            n_blend += n_increment;
            waitframe(1);
        }
    }
}

// Namespace zsurvival/zsurvival
// Params 0, eflags: 0x0
// Checksum 0x994f390b, Offset: 0x10b8
// Size: 0x1fa
function function_6b4d4a88() {
    localclientnum = 0;
    var_65792f8b = map::get_script_bundle();
    var_4e59607a = [];
    if (isdefined(var_65792f8b) && isdefined(var_65792f8b.destinationlabellist)) {
        foreach (destinationlabel in var_65792f8b.destinationlabellist) {
            var_4e59607a[destinationlabel.targetname] = destinationlabel.displayname;
        }
    }
    if (isarray(level.struct)) {
        foreach (struct in level.struct) {
            if (isdefined(struct.targetname) && isdefined(var_4e59607a[struct.targetname])) {
                function_4b8a09b(localclientnum, var_4e59607a[hash(struct.targetname)], struct.origin);
                var_4e59607a[struct.targetname] = undefined;
            }
            if (struct.classname === "script_struct") {
                struct.classname = undefined;
            }
        }
    }
}

// Namespace zsurvival/zsurvival
// Params 1, eflags: 0x4
// Checksum 0x1ab38784, Offset: 0x12c0
// Size: 0x3c
function private _on_localplayer_spawned(localclientnum) {
    if (self function_da43934d()) {
        self thread function_13a420b1(localclientnum);
    }
}

// Namespace zsurvival/zsurvival
// Params 1, eflags: 0x4
// Checksum 0xbf11bc77, Offset: 0x1308
// Size: 0x8a
function private function_491c852e(item) {
    switch (item) {
    case #"trip_wire_wz_item":
        return 1;
    case #"concertina_wire_wz_item":
        return 2;
    case #"cymbal_monkey_wz_item":
        return 3;
    case #"ultimate_turret_wz_item":
        return 4;
    }
}

// Namespace zsurvival/zsurvival
// Params 1, eflags: 0x4
// Checksum 0x850b7089, Offset: 0x13a0
// Size: 0x120
function private function_13a420b1(localclientnum) {
    self endon(#"shutdown", #"death");
    self notify("3f34c56301ee18de");
    self endon("3f34c56301ee18de");
    clientdata = item_world::function_a7e98a1a(localclientnum);
    var_6e77adc6 = "inventory_craft" + localclientnum;
    while (true) {
        waitresult = level waittill(var_6e77adc6);
        if (waitresult._notify === var_6e77adc6) {
            item = waitresult.item;
            cost = waitresult.cost;
            item = function_491c852e(item);
            function_97fedb0d(localclientnum, 13, item, cost);
        }
    }
}

// Namespace zsurvival/zsurvival
// Params 1, eflags: 0x0
// Checksum 0x45195f53, Offset: 0x14c8
// Size: 0x34
function on_gameplay_started(*localclientnum) {
    waitframe(1);
    util::function_8eb5d4b0(3500, 2.5);
}

