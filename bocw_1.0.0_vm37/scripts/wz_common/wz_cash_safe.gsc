#using script_1cd491b1807da8f7;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\item_drop;
#using scripts\core_common\item_inventory;
#using scripts\core_common\item_world;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\system_shared;
#using scripts\mp_common\gametypes\globallogic_score;

#namespace wz_cash_safe;

// Namespace wz_cash_safe/wz_cash_safe
// Params 0, eflags: 0x6
// Checksum 0xf78fe53e, Offset: 0xe0
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"wz_cash_safe", &preinit, undefined, undefined, undefined);
}

// Namespace wz_cash_safe/wz_cash_safe
// Params 0, eflags: 0x4
// Checksum 0x714deecf, Offset: 0x128
// Size: 0xc4
function private preinit() {
    level.var_a6a3e12a = [];
    if (getdvarint(#"hash_7074ed0f04816b75", 0)) {
        clientfield::register("allplayers", "wz_cash_carrying", 13000, 1, "int");
    }
    level thread setup_safes();
    callback::on_player_killed(&on_player_killed);
    /#
        callback::on_game_playing(&function_a6eac3b7);
    #/
}

// Namespace wz_cash_safe/wz_cash_safe
// Params 1, eflags: 0x4
// Checksum 0x35dcf21a, Offset: 0x1f8
// Size: 0xc
function private on_player_killed(*death_params) {
    
}

// Namespace wz_cash_safe/wz_cash_safe
// Params 2, eflags: 0x0
// Checksum 0x57546633, Offset: 0x210
// Size: 0x3c
function function_ed66923(targetname, count) {
    if (isdefined(level.var_a6a3e12a[targetname])) {
        return;
    }
    level.var_a6a3e12a[targetname] = count;
}

// Namespace wz_cash_safe/wz_cash_safe
// Params 0, eflags: 0x4
// Checksum 0xe3634572, Offset: 0x258
// Size: 0x170
function private setup_safes() {
    item_world::function_1b11e73c();
    if (getdvarint(#"hash_7074ed0f04816b75", 0)) {
        item_drop::function_f3f9788a(#"cash_item_500", 1);
        level.var_590e0497 = [];
        foreach (targetname, count in level.var_a6a3e12a) {
            activate_safes(targetname, count);
        }
        level thread function_fb346efb();
        return;
    }
    foreach (targetname, count in level.var_a6a3e12a) {
        function_189f45d2(targetname);
    }
}

// Namespace wz_cash_safe/wz_cash_safe
// Params 1, eflags: 0x4
// Checksum 0x62291fe2, Offset: 0x3d0
// Size: 0xb8
function private function_189f45d2(targetname) {
    safes = getdynentarray(targetname);
    foreach (safe in safes) {
        function_e2a06860(safe, 1);
    }
}

// Namespace wz_cash_safe/wz_cash_safe
// Params 2, eflags: 0x4
// Checksum 0x12d639c1, Offset: 0x490
// Size: 0x118
function private activate_safes(targetname, count) {
    safes = getdynentarray(targetname);
    while (safes.size > count) {
        i = randomint(safes.size);
        safes[i] hide_safe();
        arrayremoveindex(safes, i);
    }
    foreach (safe in safes) {
        safe activate_safe();
    }
}

// Namespace wz_cash_safe/wz_cash_safe
// Params 0, eflags: 0x4
// Checksum 0x6beb2540, Offset: 0x5b0
// Size: 0x120
function private function_fb346efb() {
    level flag::wait_till(#"hash_405e46788e83af41");
    lastcircleindex = level.deathcircles.size - 1;
    while (level.deathcircleindex < lastcircleindex) {
        wait 1;
    }
    finalcircle = level.deathcircles[level.deathcircleindex];
    level.var_590e0497 = [];
    foreach (targetname, count in level.var_a6a3e12a) {
        function_3387f756(targetname, finalcircle.origin, finalcircle.radius);
    }
}

// Namespace wz_cash_safe/wz_cash_safe
// Params 3, eflags: 0x4
// Checksum 0x26ea9085, Offset: 0x6d8
// Size: 0x110
function private function_3387f756(targetname, origin, radius) {
    safes = getdynentarray(targetname);
    radiussq = radius * radius;
    foreach (safe in safes) {
        if (distance2dsquared(origin, safe.origin) <= radiussq) {
            safe activate_safe();
            continue;
        }
        safe hide_safe();
    }
}

// Namespace wz_cash_safe/wz_cash_safe
// Params 0, eflags: 0x4
// Checksum 0xf605d987, Offset: 0x7f0
// Size: 0xbc
function private activate_safe() {
    function_e2a06860(self, 0);
    self.var_e7823894 = 1;
    self.canuse = &function_c92a5584;
    self.onbeginuse = &function_97eb71f0;
    self.var_263c4ded = &function_3d49217f;
    self.onuse = &function_7c5a1e82;
    self.onusecancel = &function_368adf4f;
    level.var_590e0497[level.var_590e0497.size] = self;
}

// Namespace wz_cash_safe/wz_cash_safe
// Params 0, eflags: 0x4
// Checksum 0xca7709cf, Offset: 0x8b8
// Size: 0x1c
function private hide_safe() {
    function_e2a06860(self, 2);
}

// Namespace wz_cash_safe/wz_cash_safe
// Params 1, eflags: 0x4
// Checksum 0x99ca8b39, Offset: 0x8e0
// Size: 0x13a
function private function_c92a5584(activator) {
    if (!isdefined(activator) || !isstruct(activator.inventory) || !isarray(activator.inventory.items)) {
        return false;
    }
    foreach (item in activator.inventory.items) {
        if (!isdefined(item) || !isstruct(item.itementry) || item.itementry.itemtype !== #"cash") {
            continue;
        }
        return true;
    }
    return false;
}

// Namespace wz_cash_safe/wz_cash_safe
// Params 1, eflags: 0x4
// Checksum 0x20887241, Offset: 0xa28
// Size: 0x44
function private function_97eb71f0(activator) {
    if (isdefined(activator.var_8a022726)) {
        activator.var_8a022726 sethintstring(#"");
    }
}

// Namespace wz_cash_safe/wz_cash_safe
// Params 1, eflags: 0x4
// Checksum 0x4e716309, Offset: 0xa78
// Size: 0x4a
function private function_3d49217f(activator) {
    var_22aec194 = activator function_2cef7d98();
    if (isdefined(var_22aec194)) {
        return var_22aec194.itementry.casttime;
    }
    return undefined;
}

// Namespace wz_cash_safe/wz_cash_safe
// Params 3, eflags: 0x4
// Checksum 0xdcc71ca4, Offset: 0xad0
// Size: 0x1dc
function private function_7c5a1e82(activator, *stateindex, *var_9bdcfcd8) {
    self clear_prompts(var_9bdcfcd8);
    if (!isdefined(var_9bdcfcd8) || !isstruct(var_9bdcfcd8.inventory) || !isarray(var_9bdcfcd8.inventory.items)) {
        return false;
    }
    var_22aec194 = var_9bdcfcd8 function_2cef7d98();
    if (isdefined(var_22aec194)) {
        scoreamount = var_22aec194.itementry.amount;
        initialcount = var_22aec194.count;
        var_9bdcfcd8 item_inventory::use_inventory_item(var_22aec194.networkid, 1);
        if (var_22aec194.count < initialcount) {
            [[ level._setteamscore ]](var_9bdcfcd8.team, [[ level._getteamscore ]](var_9bdcfcd8.team) + scoreamount);
            playsoundatposition(#"hash_2b58f77dbea4ade1", self.origin);
            globallogic_score::function_889ed975(var_9bdcfcd8, scoreamount, 0, 0);
            var_9bdcfcd8 stats::function_bb7eedf0(#"score", scoreamount);
            var_9bdcfcd8 stats::function_b7f80d87(#"score", scoreamount);
            return true;
        }
    }
    return false;
}

// Namespace wz_cash_safe/wz_cash_safe
// Params 0, eflags: 0x4
// Checksum 0x8de3c4db, Offset: 0xcb8
// Size: 0x122
function private function_2cef7d98() {
    var_22aec194 = undefined;
    foreach (item in self.inventory.items) {
        if (!isdefined(item) || !isstruct(item.itementry) || item.itementry.itemtype !== #"cash") {
            continue;
        }
        if (!isdefined(var_22aec194) || var_22aec194.itementry.amount < item.itementry.amount) {
            var_22aec194 = item;
        }
    }
    return var_22aec194;
}

// Namespace wz_cash_safe/wz_cash_safe
// Params 1, eflags: 0x4
// Checksum 0x78842b2f, Offset: 0xde8
// Size: 0x24
function private function_368adf4f(activator) {
    self clear_prompts(activator);
}

// Namespace wz_cash_safe/wz_cash_safe
// Params 1, eflags: 0x4
// Checksum 0x778b60f8, Offset: 0xe18
// Size: 0x6c
function private clear_prompts(activator) {
    bundle = function_489009c1(self);
    state = function_ffdbe8c2(self);
    activator.var_8a022726 dynent_use::function_836af3b3(bundle, state);
}

/#

    // Namespace wz_cash_safe/wz_cash_safe
    // Params 0, eflags: 0x4
    // Checksum 0xc0e20951, Offset: 0xe90
    // Size: 0x168
    function private function_a6eac3b7() {
        while (true) {
            wait 0.25;
            dvarstr = getdvarstring(#"scr_give_player_score", "<dev string:x38>");
            if (dvarstr == "<dev string:x38>") {
                continue;
            }
            setdvar(#"devgui_deathcircle", "<dev string:x38>");
            args = strtok(dvarstr, "<dev string:x3c>");
            if (args.size == 2) {
                player = getentbynum(int(args[0]));
                if (isplayer(player)) {
                    [[ level._setteamscore ]](player.team, [[ level._getteamscore ]](player.team) + int(args[1]));
                }
            }
        }
    }

#/
