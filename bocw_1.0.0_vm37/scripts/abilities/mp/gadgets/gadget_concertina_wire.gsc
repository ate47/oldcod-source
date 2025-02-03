#using scripts\abilities\gadgets\gadget_concertina_wire;
#using scripts\core_common\array_shared;
#using scripts\core_common\battlechatter;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\system_shared;

#namespace concertina_wire;

// Namespace concertina_wire/gadget_concertina_wire
// Params 0, eflags: 0x6
// Checksum 0x1383965f, Offset: 0xd0
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"gadget_concertina_wire", &preinit, undefined, undefined, undefined);
}

// Namespace concertina_wire/gadget_concertina_wire
// Params 0, eflags: 0x4
// Checksum 0xd14d0438, Offset: 0x118
// Size: 0xc4
function private preinit() {
    if (getgametypesetting(#"competitivesettings") === 1) {
        init_shared("concertina_wire_custom_settings_comp");
    } else {
        init_shared("concertina_wire_settings");
    }
    function_c5f0b9e7(&onconcertinawireplaced);
    function_d700c081(&function_806b0f85);
    level.var_cbec7a45 = 0;
    level.var_d1ae43e3 = &function_6190ae9e;
}

// Namespace concertina_wire/gadget_concertina_wire
// Params 1, eflags: 0x0
// Checksum 0x476bc7b4, Offset: 0x1e8
// Size: 0x3c
function onconcertinawireplaced(concertinawire) {
    self battlechatter::function_bd715920(concertinawire.weapon, undefined, concertinawire.origin, concertinawire);
}

// Namespace concertina_wire/gadget_concertina_wire
// Params 2, eflags: 0x0
// Checksum 0x1e696af, Offset: 0x230
// Size: 0xac
function function_806b0f85(attacker, weapon) {
    concertinawire = self;
    if (isdefined(level.figure_out_attacker)) {
        attacker = self [[ level.figure_out_attacker ]](attacker);
    }
    if (isdefined(attacker) && isplayer(attacker) && concertinawire.owner !== attacker && isdefined(weapon)) {
        attacker stats::function_e24eec31(weapon, #"hash_1c9da51ed1906285", 1);
    }
}

// Namespace concertina_wire/gadget_concertina_wire
// Params 3, eflags: 0x0
// Checksum 0x3af83981, Offset: 0x2e8
// Size: 0x14a
function function_6190ae9e(origin, *angles, *player) {
    if (isdefined(level.var_87226c31.bundle.var_bc78f60e)) {
        length2 = sqr(level.var_87226c31.bundle.var_bc78f60e + level.var_87226c31.bundle.maxwidth);
        foreach (protectedzone in level.var_87226c31.objectivezones) {
            if (isdefined(protectedzone)) {
                dist2 = distance2dsquared(player, protectedzone.origin);
                if (dist2 < length2) {
                    return false;
                }
            }
        }
    }
    return true;
}

// Namespace concertina_wire/gadget_concertina_wire
// Params 1, eflags: 0x0
// Checksum 0x862e4c91, Offset: 0x440
// Size: 0x34
function addprotectedzone(zone) {
    array::add(level.var_87226c31.objectivezones, zone);
}

// Namespace concertina_wire/gadget_concertina_wire
// Params 1, eflags: 0x0
// Checksum 0x1103f4, Offset: 0x480
// Size: 0x34
function removeprotectedzone(zone) {
    arrayremovevalue(level.var_87226c31.objectivezones, zone);
}

