#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\mp_common\item_inventory;

#namespace character_unlock;

// Namespace character_unlock/character_unlock
// Params 0, eflags: 0x2
// Checksum 0xa5616b5d, Offset: 0x80
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"character_unlock", &__init__, undefined, undefined);
}

// Namespace character_unlock/character_unlock
// Params 0, eflags: 0x0
// Checksum 0xec7aacfb, Offset: 0xc8
// Size: 0x74
function __init__() {
    level.var_67ba1303 = [];
    callback::add_callback(#"on_player_killed", &on_player_killed);
    callback::add_callback(#"on_end_game", &on_end_game);
}

// Namespace character_unlock/character_unlock
// Params 5, eflags: 0x20 variadic
// Checksum 0x8d883f53, Offset: 0x148
// Size: 0x16a
function register_character_unlock(unlock_name, unlock_stat, item, var_c63a96c7, ...) {
    assert(vararg.size > 0, "<dev string:x30>");
    var_98e16668 = {#var_1cb85d40:unlock_stat, #required_item:item, #var_c63a96c7:var_c63a96c7, #var_6212376e:[]};
    for (i = 0; i < vararg.size; i++) {
        if (!isdefined(var_98e16668.var_6212376e)) {
            var_98e16668.var_6212376e = [];
        } else if (!isarray(var_98e16668.var_6212376e)) {
            var_98e16668.var_6212376e = array(var_98e16668.var_6212376e);
        }
        var_98e16668.var_6212376e[var_98e16668.var_6212376e.size] = vararg[i];
    }
    level.var_67ba1303[unlock_name] = var_98e16668;
}

// Namespace character_unlock/character_unlock
// Params 1, eflags: 0x0
// Checksum 0x1d7de63, Offset: 0x2c0
// Size: 0x84
function function_fc39af28(unlock_name) {
    var_98e16668 = level.var_67ba1303[unlock_name];
    assert(isdefined(var_98e16668), "<dev string:x72>" + function_15979fa9(unlock_name) + "<dev string:x88>");
    var_1cb85d40 = var_98e16668.var_1cb85d40;
    return false;
}

// Namespace character_unlock/character_unlock
// Params 1, eflags: 0x0
// Checksum 0x69ef792f, Offset: 0x350
// Size: 0xc6
function function_97763910(unlock_name) {
    var_98e16668 = level.var_67ba1303[unlock_name];
    assert(isdefined(var_98e16668), "<dev string:x72>" + function_15979fa9(unlock_name) + "<dev string:x88>");
    if (self function_fc39af28(unlock_name)) {
        return false;
    }
    required_item = var_98e16668.required_item;
    if (self item_inventory::function_8140faa6(required_item)) {
        return true;
    }
    return false;
}

// Namespace character_unlock/character_unlock
// Params 2, eflags: 0x0
// Checksum 0x9d30b7f3, Offset: 0x420
// Size: 0x22a
function function_4c582a05(unlock_name, var_7de25592) {
    var_98e16668 = level.var_67ba1303[unlock_name];
    /#
        assert(isdefined(var_98e16668), "<dev string:x72>" + function_15979fa9(unlock_name) + "<dev string:x88>");
        assert(isinarray(var_98e16668.var_6212376e, var_7de25592), "<dev string:x97>" + function_15979fa9(var_7de25592) + "<dev string:xa7>" + function_15979fa9(unlock_name));
    #/
    if (!self function_97763910(unlock_name)) {
        assertmsg("<dev string:xc2>" + unlock_name + "<dev string:xf1>");
        return;
    }
    if (!isdefined(self.var_c567abc7)) {
        self.var_c567abc7 = [];
    }
    if (!isdefined(self.var_c567abc7[unlock_name])) {
        var_2b8de0b3 = {#var_a6b5530d:[]};
        foreach (condition in var_98e16668.var_6212376e) {
            var_2b8de0b3.var_a6b5530d[condition] = 0;
        }
        self.var_c567abc7[unlock_name] = var_2b8de0b3;
    }
    self.var_c567abc7[unlock_name].var_a6b5530d[var_7de25592] = 1;
}

// Namespace character_unlock/character_unlock
// Params 0, eflags: 0x0
// Checksum 0x877e8762, Offset: 0x658
// Size: 0x1f8
function function_c3725f3() {
    if (!isdefined(self.var_c567abc7)) {
        return;
    }
    if (isdefined(self.var_28e956a4) && self.var_28e956a4) {
        return;
    }
    self.var_28e956a4 = 1;
    foreach (unlock_name, var_2b8de0b3 in self.var_c567abc7) {
        if (!self function_97763910(unlock_name)) {
            continue;
        }
        var_f7c887bd = 1;
        foreach (var_d7c56ec2 in var_2b8de0b3.var_a6b5530d) {
            if (!var_d7c56ec2) {
                var_f7c887bd = 0;
                break;
            }
        }
        if (!var_f7c887bd) {
            continue;
        }
        var_ac490ef5 = 1;
        var_98e16668 = level.var_67ba1303[unlock_name];
        var_c63a96c7 = var_98e16668.var_c63a96c7;
        if (isdefined(var_c63a96c7)) {
            var_ac490ef5 = self [[ var_c63a96c7 ]]();
        }
        if (!var_ac490ef5) {
            continue;
        }
        var_1cb85d40 = var_98e16668.var_1cb85d40;
        /#
            iprintlnbold("<dev string:x113>" + function_15979fa9(unlock_name));
        #/
    }
}

// Namespace character_unlock/character_unlock
// Params 0, eflags: 0x0
// Checksum 0x9bc8ab94, Offset: 0x858
// Size: 0x1c
function on_player_killed() {
    self function_c3725f3();
}

// Namespace character_unlock/character_unlock
// Params 0, eflags: 0x0
// Checksum 0x6a82adcd, Offset: 0x880
// Size: 0x90
function on_end_game() {
    players = getplayers();
    foreach (player in players) {
        player function_c3725f3();
    }
}

