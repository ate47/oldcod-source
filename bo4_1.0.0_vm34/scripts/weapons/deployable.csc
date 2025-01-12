#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;

#namespace deployable;

// Namespace deployable/deployable
// Params 0, eflags: 0x2
// Checksum 0x7753edf5, Offset: 0xf0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"deployable", &__init__, undefined, undefined);
}

// Namespace deployable/deployable
// Params 0, eflags: 0x0
// Checksum 0x135a4e22, Offset: 0x138
// Size: 0x54
function __init__() {
    if (!isdefined(level._deployable_weapons)) {
        level._deployable_weapons = [];
    }
    level.var_dc95ab2d = &function_fd0e4d7c;
    level thread function_b5c8de30();
}

// Namespace deployable/deployable
// Params 2, eflags: 0x0
// Checksum 0xae1466d1, Offset: 0x198
// Size: 0xaa
function register_deployable(weapon, var_1a6c2776) {
    if (weapon.name == "#none") {
        return;
    }
    assert(weapon.name != "<dev string:x30>");
    level._deployable_weapons[weapon.statindex] = spawnstruct();
    level._deployable_weapons[weapon.statindex].var_1a6c2776 = var_1a6c2776;
}

// Namespace deployable/deployable
// Params 1, eflags: 0x0
// Checksum 0xfaaa4c39, Offset: 0x250
// Size: 0x8c
function function_6a12de2f(previs_weapon) {
    previs_model = self;
    if (isdefined(previs_weapon.var_b611bcfa)) {
        previs_model setmodel(previs_weapon.var_b611bcfa);
    } else {
        previs_model setmodel(#"hash_7a80bed4a96537e6");
    }
    previs_model notsolid();
}

// Namespace deployable/deployable
// Params 3, eflags: 0x0
// Checksum 0x92ee6bc7, Offset: 0x2e8
// Size: 0x7c
function function_fd0e4d7c(player, localclientnum, weapon) {
    var_4330a486 = function_b2716a88(localclientnum, player, weapon);
    player function_d83e9f0e(var_4330a486.isvalid, var_4330a486.origin, var_4330a486.angles);
}

// Namespace deployable/deployable
// Params 3, eflags: 0x0
// Checksum 0x9e5d249e, Offset: 0x370
// Size: 0x152
function function_b2716a88(localclientnum, player, weapon) {
    var_8df2345e = player function_65c2da47(weapon);
    gameplay_allows_deploy = player clientfield::get_to_player("gameplay_allows_deploy");
    var_8f9cbb1d = var_8df2345e.isvalid || isdefined(level._deployable_weapons[weapon.statindex]) && (isdefined(level._deployable_weapons[weapon.statindex].var_1a6c2776) ? level._deployable_weapons[weapon.statindex].var_1a6c2776 : 0);
    var_1d1bbb3d = function_21e9427d(localclientnum) || isdefined(weapon.var_7460107b) && weapon.var_7460107b;
    var_8df2345e.isvalid = var_8f9cbb1d && gameplay_allows_deploy && var_1d1bbb3d;
    return var_8df2345e;
}

// Namespace deployable/deployable
// Params 1, eflags: 0x0
// Checksum 0xb4e08953, Offset: 0x4d0
// Size: 0x2d8
function function_b5c8de30(localclientnum = 0) {
    level notify("previs_deployable_" + localclientnum);
    level endon("previs_deployable_" + localclientnum);
    wait 10;
    previs_model = spawn(localclientnum, (0, 0, 0), "script_model");
    previs_weapon = getweapon(#"eq_alarm");
    var_3fa09372 = 0;
    var_bd210d81 = 0;
    var_14f53fe3 = 0;
    while (true) {
        var_19b215bb = previs_weapon;
        if (!var_3fa09372) {
            if (var_bd210d81 == 1) {
                previs_model stoprenderoverridebundle("rob_deployable_can_deploy");
            }
            if (var_14f53fe3 == 1) {
                previs_model stoprenderoverridebundle("rob_deployable_cannot_deploy");
            }
            var_bd210d81 = 0;
            var_14f53fe3 = 0;
            previs_model hide();
            wait 0.2;
        } else {
            waitframe(1);
        }
        var_3fa09372 = 0;
        if (getdvarint(#"hash_4df6a4cc1cfae912", 1) == 0) {
            continue;
        }
        player = function_f97e7787(localclientnum);
        if (!isdefined(player)) {
            continue;
        }
        if (!isalive(player)) {
            continue;
        }
        previs_weapon = undefined;
        if (function_426e193(localclientnum)) {
            previs_weapon = function_3a909b8c(localclientnum);
        } else {
            previs_weapon = player.weapon;
        }
        if (!previs_weapon.deployable || previs_weapon.var_49f876e1) {
            continue;
        }
        if (function_f678030f(localclientnum)) {
            var_3fa09372 = 1;
            continue;
        }
        var_4330a486 = function_b2716a88(localclientnum, player, previs_weapon);
        player function_d83e9f0e(var_4330a486.isvalid, var_4330a486.origin, var_4330a486.angles);
    }
}

