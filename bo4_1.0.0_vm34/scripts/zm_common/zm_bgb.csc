#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\load;
#using scripts\zm_common\zm_bgb_pack;

#namespace bgb;

// Namespace bgb/zm_bgb
// Params 0, eflags: 0x2
// Checksum 0xa8d723d6, Offset: 0x1b0
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"bgb", &__init__, &__main__, undefined);
}

// Namespace bgb/zm_bgb
// Params 0, eflags: 0x0
// Checksum 0xde31dc86, Offset: 0x200
// Size: 0x252
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    level.weaponbgbgrab = getweapon(#"zombie_bgb_grab");
    callback::on_localclient_connect(&on_player_connect);
    level.bgb = [];
    level.bgb_pack = [];
    clientfield::register("clientuimodel", "zmhud.bgb_current", 1, 8, "int", &function_cec2dbda, 0, 0);
    clientfield::register("clientuimodel", "zmhud.bgb_display", 1, 1, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "zmhud.bgb_timer", 1, 8, "float", undefined, 0, 0);
    clientfield::register("clientuimodel", "zmhud.bgb_activations_remaining", 1, 3, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "zmhud.bgb_invalid_use", 1, 1, "counter", undefined, 0, 0);
    clientfield::register("clientuimodel", "zmhud.bgb_one_shot_use", 1, 1, "counter", undefined, 0, 0);
    clientfield::register("toplayer", "bgb_blow_bubble", 1, 1, "counter", &bgb_blow_bubble, 0, 0);
    level._effect[#"bgb_blow_bubble"] = "zombie/fx_bgb_bubble_blow_zmb";
}

// Namespace bgb/zm_bgb
// Params 0, eflags: 0x4
// Checksum 0x1ad90764, Offset: 0x460
// Size: 0x3c
function private __main__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb_finalize();
}

// Namespace bgb/zm_bgb
// Params 1, eflags: 0x4
// Checksum 0x1ea00462, Offset: 0x4a8
// Size: 0x44
function private on_player_connect(localclientnum) {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    self thread bgb_player_init(localclientnum);
}

// Namespace bgb/zm_bgb
// Params 1, eflags: 0x4
// Checksum 0x771e7fb5, Offset: 0x4f8
// Size: 0x4e
function private bgb_player_init(localclientnum) {
    if (isdefined(level.bgb_pack[localclientnum])) {
        return;
    }
    level.bgb_pack[localclientnum] = getbubblegumpack(localclientnum);
}

// Namespace bgb/zm_bgb
// Params 0, eflags: 0x4
// Checksum 0xdf3513c6, Offset: 0x550
// Size: 0x322
function private bgb_finalize() {
    level.var_f3c83828 = [];
    level.var_f3c83828[0] = "base";
    level.var_f3c83828[1] = "pinwheel";
    level.var_f3c83828[2] = "speckled";
    level.var_f3c83828[3] = "shiny";
    level.var_f3c83828[4] = "swirl";
    level.var_f3c83828[5] = "swirl";
    level.var_f3c83828[6] = "swirl";
    level.bgb_item_index_to_name = [];
    foreach (v in level.bgb) {
        v.item_index = getitemindexfromref(v.name);
        var_d5b592f2 = getunlockableiteminfofromindex(v.item_index, 2);
        var_692bb69 = function_b679234(v.item_index, 2);
        if (!isdefined(var_d5b592f2) || !isdefined(var_692bb69)) {
            println("<dev string:x30>" + v.name + "<dev string:x3f>");
            continue;
        }
        if (!isdefined(var_692bb69.bgbrarity)) {
            var_692bb69.bgbrarity = 0;
        }
        v.rarity = var_692bb69.bgbrarity;
        if (0 == v.rarity || 1 == v.rarity) {
            v.consumable = 0;
        } else {
            v.consumable = 1;
        }
        v.camo_index = var_692bb69.var_1e35fe46;
        v.flying_gumball_tag = "tag_gumball_" + v.limit_type;
        v.var_ece14434 = "tag_gumball_" + v.limit_type + "_" + level.var_f3c83828[v.rarity];
        level.bgb_item_index_to_name[v.item_index] = v.name;
    }
}

// Namespace bgb/zm_bgb
// Params 2, eflags: 0x0
// Checksum 0xa23c7e75, Offset: 0x880
// Size: 0x14e
function register(name, limit_type) {
    assert(isdefined(name), "<dev string:x6d>");
    assert(#"none" != name, "<dev string:x93>" + #"none" + "<dev string:xb5>");
    assert(!isdefined(level.bgb[name]), "<dev string:xec>" + name + "<dev string:x103>");
    assert(isdefined(limit_type), "<dev string:xec>" + name + "<dev string:x121>");
    level.bgb[name] = spawnstruct();
    level.bgb[name].name = name;
    level.bgb[name].limit_type = limit_type;
}

// Namespace bgb/zm_bgb
// Params 2, eflags: 0x4
// Checksum 0xdb364a79, Offset: 0x9d8
// Size: 0x19c
function private function_78c4bfa(localclientnum, time) {
    self endon(#"death");
    if (isdemoplaying()) {
        return;
    }
    if (!isdefined(self.bgb) || !isdefined(level.bgb[self.bgb])) {
        return;
    }
    switch (level.bgb[self.bgb].limit_type) {
    case #"activated":
        color = (25, 0, 50) / 255;
        break;
    case #"event":
        color = (100, 50, 0) / 255;
        break;
    case #"rounds":
        color = (1, 149, 244) / 255;
        break;
    case #"time":
        color = (19, 244, 20) / 255;
        break;
    default:
        return;
    }
    self setcontrollerlightbarcolor(localclientnum, color);
    wait time;
    if (isdefined(self)) {
        self setcontrollerlightbarcolor(localclientnum);
    }
}

// Namespace bgb/zm_bgb
// Params 7, eflags: 0x4
// Checksum 0x16273038, Offset: 0xb80
// Size: 0x74
function private function_cec2dbda(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self.bgb = level.bgb_item_index_to_name[newval];
    self thread function_78c4bfa(localclientnum, 3);
}

// Namespace bgb/zm_bgb
// Params 2, eflags: 0x4
// Checksum 0x8480540b, Offset: 0xc00
// Size: 0x6a
function private function_c8a1c86(localclientnum, fx) {
    if (isdefined(self.var_d7197e33)) {
        deletefx(localclientnum, self.var_d7197e33, 1);
    }
    if (isdefined(fx)) {
        self.var_d7197e33 = playfxoncamera(localclientnum, fx);
    }
}

// Namespace bgb/zm_bgb
// Params 7, eflags: 0x4
// Checksum 0x718fbc89, Offset: 0xc78
// Size: 0x8c
function private bgb_blow_bubble(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    function_c8a1c86(localclientnum, level._effect[#"bgb_blow_bubble"]);
    self thread function_78c4bfa(localclientnum, 0.5);
}

