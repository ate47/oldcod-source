#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\load;
#using scripts\zm_common\zm_bgb_pack;

#namespace bgb;

// Namespace bgb/zm_bgb
// Params 0, eflags: 0x6
// Checksum 0xac82d97f, Offset: 0x1d0
// Size: 0x4c
function private autoexec __init__system__() {
    system::register(#"bgb", &function_70a657d8, &postinit, undefined, undefined);
}

// Namespace bgb/zm_bgb
// Params 0, eflags: 0x5 linked
// Checksum 0x12fcfc01, Offset: 0x228
// Size: 0x2dc
function private function_70a657d8() {
    if (!is_true(level.bgb_in_use)) {
        return;
    }
    level.weaponbgbgrab = getweapon(#"zombie_bgb_grab");
    callback::on_localclient_connect(&on_player_connect);
    level.bgb = [];
    level.bgb_pack = [];
    clientfield::register_clientuimodel("zmhud.bgb_current", #"zm_hud", #"bgb_current", 1, 8, "int", &function_d9afd5ee, 0, 0);
    clientfield::register_clientuimodel("zmhud.bgb_display", #"zm_hud", #"bgb_display", 1, 1, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("zmhud.bgb_timer", #"zm_hud", #"bgb_timer", 1, 8, "float", undefined, 0, 0);
    clientfield::register_clientuimodel("zmhud.bgb_activations_remaining", #"zm_hud", #"bgb_activations_remaining", 1, 3, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("zmhud.bgb_invalid_use", #"zm_hud", #"bgb_invalid_use", 1, 1, "counter", undefined, 0, 0);
    clientfield::register_clientuimodel("zmhud.bgb_one_shot_use", #"zm_hud", #"bgb_one_shot_use", 1, 1, "counter", undefined, 0, 0);
    clientfield::register("toplayer", "bgb_blow_bubble", 1, 1, "counter", &bgb_blow_bubble, 0, 0);
    level._effect[#"bgb_blow_bubble"] = "zombie/fx_bgb_bubble_blow_zmb";
}

// Namespace bgb/zm_bgb
// Params 0, eflags: 0x5 linked
// Checksum 0xef31a9b5, Offset: 0x510
// Size: 0x44
function private postinit() {
    if (!is_true(level.bgb_in_use)) {
        return;
    }
    force_stream();
    bgb_finalize();
}

// Namespace bgb/zm_bgb
// Params 0, eflags: 0x1 linked
// Checksum 0xe7ea2d38, Offset: 0x560
// Size: 0x1a0
function force_stream() {
    var_45c85698 = array(getweapon(#"hash_d0f29de78e218ad"), getweapon(#"hash_5e07292c519531e6"), getweapon(#"hash_305e5faa9ecb625a"), getweapon(#"hash_23cc1f9c16b375c3"), getweapon(#"hash_155cc0a9ba3c3260"), getweapon(#"hash_2394c41f048f7d2"), getweapon(#"hash_4565adf3abc61ea3"));
    foreach (weapon in var_45c85698) {
        forcestreamxmodel(weapon.viewmodel);
        forcestreamxmodel(weapon.worldmodel);
    }
}

// Namespace bgb/zm_bgb
// Params 1, eflags: 0x5 linked
// Checksum 0x1ed224e0, Offset: 0x708
// Size: 0x3c
function private on_player_connect(localclientnum) {
    if (!is_true(level.bgb_in_use)) {
        return;
    }
    self thread bgb_player_init(localclientnum);
}

// Namespace bgb/zm_bgb
// Params 1, eflags: 0x5 linked
// Checksum 0x8162775a, Offset: 0x750
// Size: 0x48
function private bgb_player_init(localclientnum) {
    if (isdefined(level.bgb_pack[localclientnum])) {
        return;
    }
    level.bgb_pack[localclientnum] = getbubblegumpack(localclientnum);
}

// Namespace bgb/zm_bgb
// Params 0, eflags: 0x5 linked
// Checksum 0xd02dd5a1, Offset: 0x7a0
// Size: 0x2c8
function private bgb_finalize() {
    level.var_afb8293c = [];
    level.var_afb8293c[0] = "base";
    level.var_afb8293c[1] = "pinwheel";
    level.var_afb8293c[2] = "speckled";
    level.var_afb8293c[3] = "shiny";
    level.var_afb8293c[5] = "swirl";
    level.var_afb8293c[4] = "swirl";
    level.var_afb8293c[6] = "swirl";
    level.bgb_item_index_to_name = [];
    foreach (v in level.bgb) {
        v.item_index = getitemindexfromref(v.name);
        var_ddcb67f4 = getunlockableiteminfofromindex(v.item_index, 2);
        var_5415dfb9 = function_b143666d(v.item_index, 2);
        if (!isdefined(var_ddcb67f4) || !isdefined(var_5415dfb9)) {
            println("<dev string:x38>" + v.name + "<dev string:x4a>");
            continue;
        }
        if (!isdefined(var_5415dfb9.bgbrarity)) {
            var_5415dfb9.bgbrarity = 0;
        }
        v.rarity = var_5415dfb9.bgbrarity;
        if (0 == v.rarity || 1 == v.rarity) {
            v.consumable = 0;
        } else {
            v.consumable = 1;
        }
        v.camo_index = var_5415dfb9.var_daefc551;
        v.flying_gumball_tag = "tag_gumball_" + v.limit_type;
        v.var_c0362ae9 = "tag_gumball_" + v.limit_type + "_" + level.var_afb8293c[v.rarity];
        level.bgb_item_index_to_name[v.item_index] = v.name;
    }
}

// Namespace bgb/zm_bgb
// Params 2, eflags: 0x1 linked
// Checksum 0xd86fd008, Offset: 0xa70
// Size: 0x142
function register(name, limit_type) {
    assert(isdefined(name), "<dev string:x7b>");
    assert(#"none" != name, "<dev string:xa4>" + #"none" + "<dev string:xc9>");
    assert(!isdefined(level.bgb[name]), "<dev string:x103>" + name + "<dev string:x11d>");
    assert(isdefined(limit_type), "<dev string:x103>" + name + "<dev string:x13e>");
    level.bgb[name] = spawnstruct();
    level.bgb[name].name = name;
    level.bgb[name].limit_type = limit_type;
}

// Namespace bgb/zm_bgb
// Params 2, eflags: 0x5 linked
// Checksum 0x193be4f2, Offset: 0xbc0
// Size: 0x19c
function private function_5e7b3f16(localclientnum, time) {
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
// Params 7, eflags: 0x5 linked
// Checksum 0x4eec416b, Offset: 0xd68
// Size: 0x74
function private function_d9afd5ee(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    self.bgb = level.bgb_item_index_to_name[bwastimejump];
    self thread function_5e7b3f16(fieldname, 3);
}

// Namespace bgb/zm_bgb
// Params 2, eflags: 0x5 linked
// Checksum 0xb146cd5, Offset: 0xde8
// Size: 0x6a
function private function_f4763ffe(localclientnum, fx) {
    if (isdefined(self.var_629940ea)) {
        deletefx(localclientnum, self.var_629940ea, 1);
    }
    if (isdefined(fx)) {
        self.var_629940ea = playfxoncamera(localclientnum, fx);
    }
}

// Namespace bgb/zm_bgb
// Params 7, eflags: 0x5 linked
// Checksum 0x7282ded, Offset: 0xe60
// Size: 0x8c
function private bgb_blow_bubble(localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    function_f4763ffe(bwastimejump, level._effect[#"bgb_blow_bubble"]);
    self thread function_5e7b3f16(bwastimejump, 0.5);
}

