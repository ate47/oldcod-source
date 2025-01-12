#using scripts\abilities\gadgets\gadget_smart_cover;
#using scripts\core_common\array_shared;
#using scripts\core_common\battlechatter;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\system_shared;
#using scripts\killstreaks\killstreaks_util;

#namespace smart_cover;

// Namespace smart_cover/gadget_smart_cover
// Params 0, eflags: 0x6
// Checksum 0x175ca1a8, Offset: 0x98
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"gadget_smart_cover", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace smart_cover/gadget_smart_cover
// Params 0, eflags: 0x5 linked
// Checksum 0x29c4e8c4, Offset: 0xe0
// Size: 0x6c
function private function_70a657d8() {
    init_shared();
    function_649f8cbe(&onsmartcoverplaced);
    function_a9427b5c(&function_a430cceb);
    level.var_b57c1895 = &function_9a2b3318;
}

// Namespace smart_cover/gadget_smart_cover
// Params 1, eflags: 0x1 linked
// Checksum 0x6aff1a09, Offset: 0x158
// Size: 0x84
function onsmartcoverplaced(smartcover) {
    self battlechatter::function_fc82b10(smartcover.weapon, smartcover.origin, smartcover);
    self callback::callback(#"hash_70eeb7d813f149b2", {#owner:self, #cover:smartcover.smartcover});
}

// Namespace smart_cover/gadget_smart_cover
// Params 2, eflags: 0x1 linked
// Checksum 0xf80afb3e, Offset: 0x1e8
// Size: 0x114
function function_a430cceb(attacker, weapon) {
    concertinawire = self;
    if (isdefined(level.figure_out_attacker)) {
        attacker = self [[ level.figure_out_attacker ]](attacker);
    }
    if (isdefined(attacker) && isplayer(attacker) && concertinawire.owner !== attacker && isdefined(weapon)) {
        attacker stats::function_e24eec31(weapon, #"hash_1c9da51ed1906285", 1);
        killstreaks::function_e729ccee(attacker, weapon);
    }
    self callback::callback(#"hash_15858698313c5f32", {#owner:self.owner, #cover:self});
}

// Namespace smart_cover/gadget_smart_cover
// Params 3, eflags: 0x1 linked
// Checksum 0x554bd4ad, Offset: 0x308
// Size: 0x14a
function function_9a2b3318(origin, *angles, *player) {
    if (isdefined(level.smartcoversettings.bundle.var_bc78f60e)) {
        length2 = function_a3f6cdac(level.smartcoversettings.bundle.var_bc78f60e + level.smartcoversettings.bundle.maxwidth);
        foreach (protectedzone in level.smartcoversettings.var_d6a27a84) {
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

// Namespace smart_cover/gadget_smart_cover
// Params 1, eflags: 0x0
// Checksum 0x206520a9, Offset: 0x460
// Size: 0x34
function function_18f38647(zone) {
    array::add(level.smartcoversettings.var_d6a27a84, zone);
}

// Namespace smart_cover/gadget_smart_cover
// Params 1, eflags: 0x0
// Checksum 0xbc321b82, Offset: 0x4a0
// Size: 0x34
function function_60a53911(zone) {
    arrayremovevalue(level.smartcoversettings.var_d6a27a84, zone);
}

