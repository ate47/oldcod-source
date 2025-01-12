#using script_113dd7f0ea2a1d4f;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_score;

#namespace namespace_7eea54d0;

// Namespace namespace_7eea54d0/namespace_7eea54d0
// Params 0, eflags: 0x0
// Checksum 0x51c3cac4, Offset: 0xb8
// Size: 0x84
function init() {
    callback::on_connect(&on_player_connect);
    callback::on_item_pickup(&on_item_pickup);
    callback::on_ai_damage(&on_ai_damage);
    callback::on_ai_killed(&on_ai_killed);
}

// Namespace namespace_7eea54d0/namespace_7eea54d0
// Params 0, eflags: 0x0
// Checksum 0x8b9a6dec, Offset: 0x148
// Size: 0xe
function on_player_connect() {
    self.var_47eb9d8e = 0;
}

// Namespace namespace_7eea54d0/namespace_7eea54d0
// Params 1, eflags: 0x0
// Checksum 0x8fa933c0, Offset: 0x160
// Size: 0xb4
function on_item_pickup(s_params) {
    var_a6762160 = s_params.item.var_a6762160;
    if (var_a6762160.itemtype === #"survival_essence") {
        if (isplayer(self)) {
            e_player = self;
        } else {
            e_player = s_params.player;
        }
        var_b25755cf = 50 * var_a6762160.amount;
        e_player thread function_d9365a20(var_b25755cf, 0);
    }
}

// Namespace namespace_7eea54d0/namespace_7eea54d0
// Params 1, eflags: 0x0
// Checksum 0xbc472dfc, Offset: 0x220
// Size: 0xc0
function on_ai_damage(s_params) {
    e_player = s_params.eattacker;
    if (!isplayer(e_player)) {
        return;
    }
    if (!isdefined(self.var_d7d6cced)) {
        self.var_d7d6cced = [];
    } else if (!isarray(self.var_d7d6cced)) {
        self.var_d7d6cced = array(self.var_d7d6cced);
    }
    if (!isinarray(self.var_d7d6cced, e_player)) {
        self.var_d7d6cced[self.var_d7d6cced.size] = e_player;
    }
}

// Namespace namespace_7eea54d0/namespace_7eea54d0
// Params 1, eflags: 0x0
// Checksum 0x8235aa18, Offset: 0x2e8
// Size: 0x21c
function on_ai_killed(s_params) {
    e_player = s_params.eattacker;
    if (!isplayer(e_player)) {
        return;
    }
    if (isdefined(level.var_138fad10)) {
        var_b25755cf = self [[ level.var_138fad10 ]](s_params);
    }
    if (!isdefined(var_b25755cf)) {
        var_b25755cf = 10;
        if (self.var_9fde8624 === #"hash_7a778318514578f7" || self.var_9fde8624 === #"hash_622e7c9cc7c06c7") {
            var_b25755cf = 20;
        } else {
            switch (self.archetype) {
            case #"avogadro":
                var_b25755cf = 50;
                break;
            case #"raz":
            case #"brutus":
                var_b25755cf = 100;
                break;
            case #"mechz":
            case #"blight_father":
                var_b25755cf = 250;
                break;
            }
        }
    }
    if (!isdefined(self.var_d7d6cced)) {
        self.var_d7d6cced = [];
    } else if (!isarray(self.var_d7d6cced)) {
        self.var_d7d6cced = array(self.var_d7d6cced);
    }
    if (!isinarray(self.var_d7d6cced, e_player)) {
        self.var_d7d6cced[self.var_d7d6cced.size] = e_player;
    }
    arrayremovevalue(self.var_d7d6cced, undefined);
    if (var_b25755cf > 0) {
        array::thread_all(self.var_d7d6cced, &function_d9365a20, var_b25755cf, 0);
    }
}

// Namespace namespace_7eea54d0/namespace_7eea54d0
// Params 0, eflags: 0x0
// Checksum 0x6c6022a8, Offset: 0x510
// Size: 0xa
function function_b121c9be() {
    return self.var_47eb9d8e;
}

// Namespace namespace_7eea54d0/namespace_7eea54d0
// Params 2, eflags: 0x0
// Checksum 0xa576b5dd, Offset: 0x528
// Size: 0x7c
function function_d9365a20(var_b25755cf, var_86756f69) {
    if (isdefined(self.var_47eb9d8e)) {
        self.var_47eb9d8e = int(self.var_47eb9d8e + var_b25755cf);
        self thread function_eed73f68(var_b25755cf, var_86756f69);
    }
    zm_score::add_to_player_score(var_b25755cf);
}

// Namespace namespace_7eea54d0/namespace_7eea54d0
// Params 1, eflags: 0x0
// Checksum 0x2484fd7d, Offset: 0x5b0
// Size: 0x6c
function function_1efdfa9d(var_b25755cf) {
    var_47eb9d8e = self.var_47eb9d8e - var_b25755cf;
    var_47eb9d8e = max(var_47eb9d8e, 0);
    self.var_47eb9d8e = int(var_47eb9d8e);
    self thread function_e30c539f();
}

// Namespace namespace_7eea54d0/namespace_7eea54d0
// Params 2, eflags: 0x0
// Checksum 0xa9c715c1, Offset: 0x628
// Size: 0x116
function function_f2a9498e(var_f99b07a5, *var_86756f69) {
    switch (var_86756f69) {
    case 10:
        id = 1;
        break;
    case 20:
        id = 2;
        break;
    case 50:
        id = 3;
        break;
    case 100:
        id = 4;
        break;
    case 250:
        id = 5;
        break;
    case 500:
        id = 6;
        break;
    case 1000:
        id = 7;
        break;
    case 5000:
        id = 8;
        break;
    }
    return id;
}

// Namespace namespace_7eea54d0/namespace_7eea54d0
// Params 2, eflags: 0x0
// Checksum 0x8ce2ccb3, Offset: 0x748
// Size: 0x162
function function_eed73f68(var_b25755cf, var_86756f69) {
    self notify("7e13d361e4ed9c46");
    self endon("7e13d361e4ed9c46");
    self endon(#"disconnect");
    if (!isdefined(level.var_31028c5d)) {
        return;
    }
    self thread function_e30c539f();
    if (!isdefined(self.var_4dd55d49)) {
        self.var_4dd55d49 = 0;
    }
    self.var_4dd55d49 = int(self.var_4dd55d49 + var_b25755cf);
    var_bc7a2972 = function_f2a9498e(var_b25755cf, var_86756f69);
    level.var_31028c5d prototype_hud::function_42b2f8b4(self, var_bc7a2972);
    if (!is_true(self.var_eabad10c)) {
        level.var_31028c5d prototype_hud::function_887deed4(self, 1);
        self.var_eabad10c = 1;
    }
    wait 1;
    level.var_31028c5d prototype_hud::function_887deed4(self, 0);
    self.var_4dd55d49 = 0;
    self.var_eabad10c = 0;
}

// Namespace namespace_7eea54d0/namespace_7eea54d0
// Params 1, eflags: 0x0
// Checksum 0x93c99c48, Offset: 0x8b8
// Size: 0x54
function function_ccc93f57(cost) {
    var_d6766517 = self function_b121c9be();
    var_ee2422c5 = var_d6766517 - cost;
    if (var_ee2422c5 >= 0) {
        return true;
    }
    return false;
}

// Namespace namespace_7eea54d0/namespace_7eea54d0
// Params 0, eflags: 0x0
// Checksum 0x3d06493e, Offset: 0x918
// Size: 0x6e
function function_e30c539f() {
    if (!isalive(self)) {
        return;
    }
    self thread function_fd1eb350();
    var_15eff430 = int((isdefined(self.var_47eb9d8e) ? self.var_47eb9d8e : 0) / 10);
}

// Namespace namespace_7eea54d0/namespace_7eea54d0
// Params 0, eflags: 0x0
// Checksum 0x4bec07f4, Offset: 0x990
// Size: 0x8c
function function_fd1eb350() {
    self notify("f67619f3658f0ca");
    self endon("f67619f3658f0ca");
    self endon(#"death");
    var_863f2651 = level.var_31028c5d prototype_hud::is_open(self);
    if (!is_true(var_863f2651)) {
        level.var_31028c5d prototype_hud::open(self, 0);
    }
}

