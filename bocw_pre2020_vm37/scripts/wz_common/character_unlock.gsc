#using script_54f593f5beb1464a;
#using script_69514c4c056c768;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\item_inventory;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\system_shared;

#namespace character_unlock;

// Namespace character_unlock/character_unlock
// Params 0, eflags: 0x6
// Checksum 0xdc10ac8a, Offset: 0x90
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"character_unlock", &function_70a657d8, undefined, undefined, #"character_unlock_fixup");
}

// Namespace character_unlock/character_unlock
// Params 0, eflags: 0x5 linked
// Checksum 0x141bdba8, Offset: 0xe0
// Size: 0xfc
function private function_70a657d8() {
    level.var_b3681acb = isdefined(getgametypesetting(#"hash_50b1121aee76a7e4")) ? getgametypesetting(#"hash_50b1121aee76a7e4") : 1;
    callback::on_item_pickup(&function_6e8037ca);
    callback::add_callback(#"on_drop_inventory", &on_drop_inventory);
    callback::add_callback(#"on_end_game", &on_end_game);
    callback::on_disconnect(&on_player_disconnect);
}

// Namespace character_unlock/character_unlock
// Params 0, eflags: 0x1 linked
// Checksum 0xe27e441b, Offset: 0x1e8
// Size: 0x84
function function_b3681acb() {
    /#
        if (getdvar(#"hash_62fbe70d500712c1", 0) == 1) {
            return true;
        }
    #/
    return level.var_b3681acb && is_true(level.onlinegame) && is_true(level.rankedmatch);
}

// Namespace character_unlock/character_unlock
// Params 1, eflags: 0x1 linked
// Checksum 0xae928610, Offset: 0x278
// Size: 0xde
function function_d7e6fa92(unlock_name) {
    var_9ba1646c = level.var_7d8da246[unlock_name];
    assert(isdefined(var_9ba1646c), "<dev string:x38>" + function_9e72a96(unlock_name) + "<dev string:x51>");
    if (!isdefined(var_9ba1646c)) {
        return false;
    }
    var_2b469a7d = var_9ba1646c.var_2b469a7d;
    if (is_true(stats::get_stat(#"characters", var_2b469a7d, #"unlocked"))) {
        return true;
    }
    return false;
}

// Namespace character_unlock/character_unlock
// Params 1, eflags: 0x1 linked
// Checksum 0x8288eb3f, Offset: 0x360
// Size: 0xde
function function_f0406288(unlock_name) {
    if (!level function_b3681acb()) {
        return false;
    }
    if (self function_d7e6fa92(unlock_name)) {
        return false;
    }
    if (isdefined(self.var_474dff5e) && is_true(self.var_474dff5e[unlock_name])) {
        return true;
    }
    var_9ba1646c = level.var_7d8da246[unlock_name];
    item_name = var_9ba1646c.required_item;
    required_item = self item_inventory::function_7fe4ce88(item_name);
    if (isdefined(required_item)) {
        return true;
    }
    return false;
}

// Namespace character_unlock/character_unlock
// Params 1, eflags: 0x1 linked
// Checksum 0xad237e41, Offset: 0x448
// Size: 0x7a
function function_c70bcc7a(unlock_name) {
    if (!level function_b3681acb()) {
        return false;
    }
    if (self function_d7e6fa92(unlock_name)) {
        return false;
    }
    if (!isdefined(self.var_c53589da) || !isdefined(self.var_c53589da[unlock_name])) {
        return false;
    }
    return true;
}

// Namespace character_unlock/character_unlock
// Params 1, eflags: 0x1 linked
// Checksum 0x2dfff433, Offset: 0x4d0
// Size: 0x2dc
function function_6e8037ca(params) {
    if (!level function_b3681acb()) {
        return;
    }
    if (level.inprematchperiod) {
        return;
    }
    var_a6762160 = params.item.var_a6762160;
    if (!isdefined(var_a6762160)) {
        return;
    }
    if (!isdefined(var_a6762160.unlockableitemref)) {
        return;
    }
    foreach (unlock_name, var_9ba1646c in level.var_7d8da246) {
        if (self function_d7e6fa92(unlock_name)) {
            itembundle = getscriptbundle(var_9ba1646c.required_item);
            if (!isdefined(itembundle) || !isdefined(itembundle.unlockableitemref)) {
                continue;
            }
            itemindex = getitemindexfromref(itembundle.unlockableitemref);
            if (itemindex == 0) {
                continue;
            }
            self luinotifyevent(#"character_unlock_update", 2, 1, itemindex);
            continue;
        }
        item_name = var_9ba1646c.required_item;
        if (var_a6762160.name === item_name) {
            if (!isdefined(self.var_c53589da)) {
                self.var_c53589da = [];
            }
            if (!isdefined(self.var_c53589da[unlock_name])) {
                var_c5c8fd39 = {#var_e7e238a4:[]};
                foreach (condition in var_9ba1646c.var_3845495) {
                    var_c5c8fd39.var_e7e238a4[condition] = 0;
                }
                self.var_c53589da[unlock_name] = var_c5c8fd39;
            }
            break;
        }
    }
    self callback::callback(#"hash_48bcdfea6f43fecb", params.item);
}

// Namespace character_unlock/character_unlock
// Params 3, eflags: 0x1 linked
// Checksum 0xbf97fa01, Offset: 0x7b8
// Size: 0x2ac
function function_c8beca5e(unlock_name, var_1d208aea, state) {
    if (!level function_b3681acb()) {
        return;
    }
    if (level.inprematchperiod) {
        return;
    }
    var_9ba1646c = level.var_7d8da246[unlock_name];
    /#
        assert(isdefined(var_9ba1646c), "<dev string:x38>" + function_9e72a96(unlock_name) + "<dev string:x51>");
        assert(isinarray(var_9ba1646c.var_3845495, var_1d208aea), "<dev string:x63>" + function_9e72a96(var_1d208aea) + "<dev string:x76>" + function_9e72a96(unlock_name));
        assert(isinarray(array(0, 1, 2), state), "<dev string:x94>" + function_9e72a96(var_1d208aea) + "<dev string:xc9>" + function_9e72a96(unlock_name));
    #/
    if (!self function_c70bcc7a(unlock_name)) {
        assertmsg("<dev string:xd9>" + unlock_name + "<dev string:x10a>");
        return;
    }
    current_state = self.var_c53589da[unlock_name].var_e7e238a4[var_1d208aea];
    if (current_state == 2) {
        return;
    }
    self.var_c53589da[unlock_name].var_e7e238a4[var_1d208aea] = state;
    self function_20b0ca2e(unlock_name);
    if (var_1d208aea != #"hash_3f07579f66b464e8") {
        if (!isalive(self) || is_true(level.gameended)) {
            self function_fb689837();
        }
    }
}

// Namespace character_unlock/character_unlock
// Params 1, eflags: 0x1 linked
// Checksum 0x9e6f24d, Offset: 0xa70
// Size: 0x43a
function function_20b0ca2e(unlock_name) {
    var_9ba1646c = level.var_7d8da246[unlock_name];
    assert(isdefined(var_9ba1646c), "<dev string:x38>" + function_9e72a96(unlock_name) + "<dev string:x51>");
    itembundle = getscriptbundle(var_9ba1646c.required_item);
    if (!isdefined(itembundle.unlockableitemref)) {
        return;
    }
    itemindex = getitemindexfromref(itembundle.unlockableitemref);
    if (itemindex == 0) {
        return;
    }
    var_93e871fc = var_9ba1646c.var_3845495;
    switch (var_9ba1646c.var_3845495.size) {
    case 1:
        self luinotifyevent(#"character_unlock_update", var_9ba1646c.var_3845495.size + 2, 0, itemindex, self.var_c53589da[unlock_name].var_e7e238a4[var_93e871fc[0]]);
        break;
    case 2:
        self luinotifyevent(#"character_unlock_update", var_9ba1646c.var_3845495.size + 2, 0, itemindex, self.var_c53589da[unlock_name].var_e7e238a4[var_93e871fc[0]], self.var_c53589da[unlock_name].var_e7e238a4[var_93e871fc[1]]);
        break;
    case 3:
        self luinotifyevent(#"character_unlock_update", var_9ba1646c.var_3845495.size + 2, 0, itemindex, self.var_c53589da[unlock_name].var_e7e238a4[var_93e871fc[0]], self.var_c53589da[unlock_name].var_e7e238a4[var_93e871fc[1]], self.var_c53589da[unlock_name].var_e7e238a4[var_93e871fc[2]]);
        break;
    case 4:
        self luinotifyevent(#"character_unlock_update", var_9ba1646c.var_3845495.size + 2, 0, itemindex, self.var_c53589da[unlock_name].var_e7e238a4[var_93e871fc[0]], self.var_c53589da[unlock_name].var_e7e238a4[var_93e871fc[1]], self.var_c53589da[unlock_name].var_e7e238a4[var_93e871fc[2]], self.var_c53589da[unlock_name].var_e7e238a4[var_93e871fc[3]]);
        break;
    case 5:
        self luinotifyevent(#"character_unlock_update", var_9ba1646c.var_3845495.size + 2, 0, itemindex, self.var_c53589da[unlock_name].var_e7e238a4[var_93e871fc[0]], self.var_c53589da[unlock_name].var_e7e238a4[var_93e871fc[1]], self.var_c53589da[unlock_name].var_e7e238a4[var_93e871fc[2]], self.var_c53589da[unlock_name].var_e7e238a4[var_93e871fc[3]], self.var_c53589da[unlock_name].var_e7e238a4[var_93e871fc[4]]);
        break;
    default:
        break;
    }
}

// Namespace character_unlock/character_unlock
// Params 2, eflags: 0x1 linked
// Checksum 0x5cbeb970, Offset: 0xeb8
// Size: 0xfc
function function_54fc60f5(player, character) {
    if (isdefined(player) && isplayer(player) && isdefined(character)) {
        player_xuid = player getxuid(1);
        if (isdefined(player_xuid)) {
            data = {#game_time:function_f8d53445(), #player_xuid:int(player_xuid), #character:character};
            function_92d1707f(#"hash_17e83c78e2a73ed1", data);
        }
    }
}

// Namespace character_unlock/character_unlock
// Params 0, eflags: 0x1 linked
// Checksum 0x567e791e, Offset: 0xfc0
// Size: 0x288
function function_fb689837() {
    if (!isdefined(self.var_c53589da)) {
        return;
    }
    foreach (unlock_name, var_c5c8fd39 in self.var_c53589da) {
        if (!self function_f0406288(unlock_name)) {
            continue;
        }
        var_b3895a2 = 1;
        foreach (var_1d208aea, var_b7ed23ab in var_c5c8fd39.var_e7e238a4) {
            if (var_1d208aea != #"hash_3f07579f66b464e8" && var_b7ed23ab != 1) {
                var_b3895a2 = 0;
                break;
            }
        }
        if (!var_b3895a2) {
            continue;
        }
        self function_c8beca5e(unlock_name, #"hash_3f07579f66b464e8", 1);
        var_9ba1646c = level.var_7d8da246[unlock_name];
        if (isdefined(var_9ba1646c)) {
            var_2b469a7d = var_9ba1646c.var_2b469a7d;
        }
        if (isdefined(var_2b469a7d)) {
            self stats::set_stat(#"characters", var_2b469a7d, #"unlocked", 1);
            self stats::function_d40764f3(#"character_quests_completed", 1);
            function_54fc60f5(self, var_2b469a7d);
            var_ade8d0e9 = {#character:var_2b469a7d};
            self callback::callback(#"on_character_unlock", var_ade8d0e9);
        }
    }
}

// Namespace character_unlock/character_unlock
// Params 1, eflags: 0x1 linked
// Checksum 0xd66e7f38, Offset: 0x1250
// Size: 0x134
function on_drop_inventory(player) {
    if (!isplayer(player)) {
        return;
    }
    if (!isdefined(player.var_474dff5e)) {
        player.var_474dff5e = [];
    }
    foreach (unlock_name, var_9ba1646c in level.var_7d8da246) {
        item_name = var_9ba1646c.required_item;
        required_item = player item_inventory::function_7fe4ce88(item_name);
        if (isdefined(required_item)) {
            player.var_474dff5e[unlock_name] = 1;
        }
    }
    if (!isalive(player)) {
        player function_fb689837();
    }
}

// Namespace character_unlock/character_unlock
// Params 0, eflags: 0x1 linked
// Checksum 0xc34a6db2, Offset: 0x1390
// Size: 0x34
function on_player_disconnect() {
    if (!isplayer(self)) {
        return;
    }
    self function_fb689837();
}

// Namespace character_unlock/character_unlock
// Params 0, eflags: 0x1 linked
// Checksum 0x54b63557, Offset: 0x13d0
// Size: 0xa0
function on_end_game() {
    players = getplayers();
    foreach (player in players) {
        player function_fb689837();
    }
}

// Namespace character_unlock/character_unlock
// Params 3, eflags: 0x0
// Checksum 0xebb07791, Offset: 0x1478
// Size: 0x6c
function function_d2294476(var_2ab9d3bd, replacementcount, var_3afaa57b) {
    if (is_true(getgametypesetting(#"hash_17f17e92c2654659"))) {
        replacementcount = 1;
    }
    namespace_3d2704b3::function_f0297225(var_2ab9d3bd, replacementcount, var_3afaa57b);
}
