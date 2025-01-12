#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\item_world;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace wz_cash_safe;

// Namespace wz_cash_safe/wz_cash_safe
// Params 0, eflags: 0x6
// Checksum 0xd5a4cf2, Offset: 0xe0
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"wz_cash_safe", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace wz_cash_safe/wz_cash_safe
// Params 0, eflags: 0x5 linked
// Checksum 0x2d7c1e22, Offset: 0x128
// Size: 0xb4
function private function_70a657d8() {
    if (getdvarint(#"hash_7074ed0f04816b75", 0)) {
        clientfield::register("allplayers", "wz_cash_carrying", 13000, 1, "int", &function_3d113bfb, 0, 1);
        level.var_f042433 = [];
        level.var_e245bbc5 = [];
        level.var_7cce82bd = [];
        callback::on_localclient_connect(&on_localclient_connect);
    }
}

// Namespace wz_cash_safe/wz_cash_safe
// Params 1, eflags: 0x5 linked
// Checksum 0x7e1c6ce2, Offset: 0x1e8
// Size: 0x154
function private on_localclient_connect(localclientnum) {
    if (getdvarint(#"hash_7074ed0f04816b75", 0)) {
        level.var_f042433[localclientnum] = [];
        for (i = 0; i < 1; i++) {
            objid = util::getnextobjid(localclientnum);
            level.var_f042433[localclientnum][i] = objid;
            objective_add(localclientnum, objid, "invisible", #"wz_cash_safe");
        }
        level.var_7cce82bd[localclientnum] = [];
        for (i = 0; i < 12; i++) {
            objid = util::getnextobjid(localclientnum);
            level.var_7cce82bd[localclientnum][i] = objid;
            objective_add(localclientnum, objid, "invisible", #"wz_cash_held");
        }
        level thread function_93b89303(localclientnum);
    }
}

// Namespace wz_cash_safe/wz_cash_safe
// Params 1, eflags: 0x0
// Checksum 0xf8f83a26, Offset: 0x348
// Size: 0x44
function function_ed66923(targetname) {
    if (!isarray(level.var_e245bbc5)) {
        return;
    }
    level.var_e245bbc5[level.var_e245bbc5.size] = targetname;
}

// Namespace wz_cash_safe/wz_cash_safe
// Params 1, eflags: 0x5 linked
// Checksum 0x79b46a22, Offset: 0x398
// Size: 0x8b6
function private function_93b89303(localclientnum) {
    player = function_27673a7(localclientnum);
    player endon(#"disconnect");
    while (true) {
        if (!isdefined(player)) {
            player = function_27673a7(localclientnum);
        }
        for (i = 0; i < 1; i++) {
            if (isdefined(level.var_f042433[localclientnum][i])) {
                objective_setstate(localclientnum, level.var_f042433[localclientnum][i], "invisible");
            }
        }
        carryingcash = 0;
        var_59a2b21b = [];
        if (isdefined(player) && isalive(player)) {
            clientdata = item_world::function_a7e98a1a(localclientnum);
            foreach (item in clientdata.inventory.items) {
                if (item.id != 32767) {
                    point = function_b1702735(item.id);
                    if (isdefined(point) && isdefined(point.var_a6762160) && point.var_a6762160.itemtype == #"cash") {
                        carryingcash = 1;
                        break;
                    }
                }
            }
        }
        if (carryingcash) {
            dynents = [];
            foreach (targetname in level.var_e245bbc5) {
                var_1ec402d4 = getdynentarray(targetname);
                foreach (safe in var_1ec402d4) {
                    if (function_ffdbe8c2(safe) == 0) {
                        dynents[dynents.size] = safe;
                    }
                }
            }
            if (dynents.size > 0) {
                dynents = arraysortclosest(dynents, player.origin, 10, 0, 5000);
                if (dynents.size > 0) {
                    for (i = 0; i < 1; i++) {
                        var_59a2b21b[i] = dynents[i];
                    }
                }
            }
        }
        if (var_59a2b21b.size) {
            for (i = 0; i < 1; i++) {
                if (isdefined(level.var_f042433[localclientnum][i])) {
                    if (isdefined(var_59a2b21b[i])) {
                        objective_setposition(localclientnum, level.var_f042433[localclientnum][i], var_59a2b21b[i].origin);
                        objective_setstate(localclientnum, level.var_f042433[localclientnum][i], "active");
                        continue;
                    }
                    objective_setstate(localclientnum, level.var_f042433[localclientnum][i], "invisible");
                }
            }
        } else {
            for (i = 0; i < 1; i++) {
                if (isdefined(level.var_f042433[localclientnum][i])) {
                    objective_setstate(localclientnum, level.var_f042433[localclientnum][i], "invisible");
                }
            }
        }
        vehicle = getplayervehicle(player);
        if (isdefined(vehicle) && isdefined(vehicle.scriptbundlesettings)) {
            var_165435de = getscriptbundle(vehicle.scriptbundlesettings);
            if (isdefined(var_165435de) && is_true(var_165435de.var_2627e80a)) {
                var_ea44983e = [];
                var_81279b22 = [];
                all_players = getplayers(localclientnum);
                foreach (enemy_player in all_players) {
                    if (enemy_player.team === player.team) {
                        continue;
                    }
                    if (!is_true(enemy_player.wz_carrying_cash)) {
                        continue;
                    }
                    if (distancesquared(enemy_player.origin, player.origin) < 25000000) {
                        if (isdefined(enemy_player.var_7c34933) && enemy_player.var_7c34933 + 1500 > gettime()) {
                            var_81279b22[enemy_player.var_cbe9b5b4] = enemy_player.var_cbe9b5b4;
                            continue;
                        }
                        if (!isdefined(var_ea44983e)) {
                            var_ea44983e = [];
                        } else if (!isarray(var_ea44983e)) {
                            var_ea44983e = array(var_ea44983e);
                        }
                        if (!isinarray(var_ea44983e, enemy_player)) {
                            var_ea44983e[var_ea44983e.size] = enemy_player;
                        }
                    }
                }
                for (i = 0; i < 12; i++) {
                    if (var_81279b22[i] === i) {
                        continue;
                    }
                    if (isdefined(level.var_7cce82bd[localclientnum][i])) {
                        if (!isdefined(var_ea44983e[i])) {
                            objective_setstate(localclientnum, level.var_7cce82bd[localclientnum][i], "invisible");
                            continue;
                        }
                        objective_setposition(localclientnum, level.var_7cce82bd[localclientnum][i], var_ea44983e[i].origin);
                        objective_setstate(localclientnum, level.var_7cce82bd[localclientnum][i], "active");
                        var_ea44983e[i].var_7c34933 = gettime();
                        var_ea44983e[i].var_cbe9b5b4 = i;
                    }
                }
            }
        } else {
            for (i = 0; i < 12; i++) {
                if (isdefined(level.var_7cce82bd[localclientnum][i])) {
                    objective_setstate(localclientnum, level.var_7cce82bd[localclientnum][i], "invisible");
                }
            }
        }
        waitframe(1);
    }
}

// Namespace wz_cash_safe/wz_cash_safe
// Params 2, eflags: 0x1 linked
// Checksum 0x7e03aa9d, Offset: 0xc58
// Size: 0x9c
function function_4fec33b5(clientnum, value) {
    var_45d5c75f = getuimodel(getuimodel(function_5f72e972(#"hash_4bc18fe053c569ef"), isdefined(clientnum) ? "" + clientnum : ""), "hasCash");
    setuimodelvalue(var_45d5c75f, value);
}

// Namespace wz_cash_safe/wz_cash_safe
// Params 7, eflags: 0x1 linked
// Checksum 0xee76cd96, Offset: 0xd00
// Size: 0xb4
function function_3d113bfb(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    self.wz_carrying_cash = bwastimejump;
    localplayer = function_5c10bd79(fieldname);
    if (self != localplayer && self.team == localplayer.team) {
        function_4fec33b5(self getentitynumber(), bwastimejump);
    }
}

