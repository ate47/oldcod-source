#using scripts\core_common\ai\archetype_damage_utility;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\damage;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\util_shared;

#namespace arc;

// Namespace arc/arc
// Params 2, eflags: 0x0
// Checksum 0xdd9d3530, Offset: 0x98
// Size: 0x9c
function init_arc(weapon, var_3c0b4194) {
    /#
        level thread update_dvars();
    #/
    if (!setup_arc(weapon, var_3c0b4194)) {
        return;
    }
    var_3c0b4194 = level.var_f8bec0dd[weapon];
    if (!isdefined(var_3c0b4194.var_c7741e5)) {
        var_3c0b4194.var_c7741e5 = &function_c7741e5;
    }
    function_73f1bce6(var_3c0b4194);
}

/#

    // Namespace arc/arc
    // Params 0, eflags: 0x0
    // Checksum 0xd27d5f4f, Offset: 0x140
    // Size: 0x4a
    function update_dvars() {
        while (true) {
            wait 1;
            level.var_a60338e0 = getdvarint(#"hash_6e465f7410cc100f", 0);
        }
    }

#/

// Namespace arc/arc
// Params 2, eflags: 0x0
// Checksum 0xe3fe5849, Offset: 0x198
// Size: 0xaa
function setup_arc(weapon, var_3c0b4194) {
    assert(isdefined(weapon));
    if (!isdefined(level.var_f8bec0dd)) {
        level.var_f8bec0dd = [];
    }
    if (!isdefined(var_3c0b4194)) {
        var_3c0b4194 = spawnstruct();
    }
    if (isdefined(level.var_f8bec0dd[weapon])) {
        return false;
    }
    level.var_f8bec0dd[weapon] = var_3c0b4194;
    var_3c0b4194.weapon = weapon;
    return true;
}

// Namespace arc/arc
// Params 1, eflags: 0x0
// Checksum 0xa5fa7df5, Offset: 0x250
// Size: 0x7c
function function_73f1bce6(var_3c0b4194) {
    var_3c0b4194.range_sqr = var_3c0b4194.range * var_3c0b4194.range;
    var_3c0b4194.var_6a990a88 = var_3c0b4194.max_range * var_3c0b4194.max_range;
    callback::add_weapon_damage(var_3c0b4194.weapon, var_3c0b4194.var_c7741e5);
}

// Namespace arc/arc
// Params 5, eflags: 0x0
// Checksum 0xa994c72c, Offset: 0x2d8
// Size: 0x8c
function function_c7741e5(eattacker, einflictor, weapon, meansofdeath, damage) {
    var_3c0b4194 = level.var_f8bec0dd[weapon];
    assert(isdefined(var_3c0b4194));
    self thread function_bfcb1e45(eattacker, einflictor, weapon, meansofdeath, damage, var_3c0b4194);
}

// Namespace arc/arc
// Params 6, eflags: 0x0
// Checksum 0xf3ef4f40, Offset: 0x370
// Size: 0x114
function function_bfcb1e45(eattacker, einflictor, weapon, meansofdeath, damage, var_3c0b4194) {
    arc_source = self;
    arc_source_origin = self.origin;
    arc_source_pos = self gettagorigin(var_3c0b4194.fx_tag);
    if (isdefined(self.var_6d47bbe8)) {
        self [[ self.var_6d47bbe8 ]](var_3c0b4194, arc_source, 0);
    }
    if (isdefined(self.body)) {
        arc_source_origin = self.body.origin;
        arc_source_pos = self.body gettagorigin(var_3c0b4194.fx_tag);
    }
    self find_arc_targets(var_3c0b4194, eattacker, arc_source, arc_source_origin, 0);
}

/#

    // Namespace arc/arc
    // Params 2, eflags: 0x0
    // Checksum 0xe596248e, Offset: 0x490
    // Size: 0x4c
    function function_c30cfc86(arc_source_origin, max_range) {
        circle(arc_source_origin, max_range, (1, 0.5, 0), 0, 1, 2);
    }

    // Namespace arc/arc
    // Params 4, eflags: 0x0
    // Checksum 0xb66ff74f, Offset: 0x4e8
    // Size: 0x7c
    function function_e2264c39(var_fc8ecaa4, range, depth, var_247be477) {
        var_5f1c05ea = depth / (var_247be477 - 1);
        circle(var_fc8ecaa4, range, (0, 1 - var_5f1c05ea, var_5f1c05ea), 0, 1, 500);
    }

#/

// Namespace arc/arc
// Params 4, eflags: 0x0
// Checksum 0x8307cedd, Offset: 0x570
// Size: 0xa2
function distancecheck(var_3c0b4194, target, arc_source_pos, arc_source_origin) {
    distancesq = distancesquared(target.origin, arc_source_pos);
    if (distancesq > var_3c0b4194.range_sqr) {
        return false;
    }
    distancesq = distancesquared(target.origin, arc_source_origin);
    if (distancesq > var_3c0b4194.var_6a990a88) {
        return false;
    }
    return true;
}

// Namespace arc/arc
// Params 6, eflags: 0x0
// Checksum 0x1204d6e7, Offset: 0x620
// Size: 0x1c2
function function_921683f4(var_3c0b4194, eattacker, arc_source, arc_source_origin, depth, target) {
    if (target player::is_spawn_protected()) {
        return false;
    }
    if (!isalive(target)) {
        return false;
    }
    if (isdefined(arc_source) && isdefined(arc_source.var_1a880ac7)) {
        if (![[ arc_source.var_1a880ac7 ]](target)) {
            return false;
        }
    }
    if (isdefined(arc_source) && target == arc_source) {
        return false;
    }
    if (eattacker == target) {
        return false;
    }
    if (isdefined(target.arc_source) && target.arc_source == arc_source) {
        return false;
    }
    if (target function_1bd5f0a7(arc_source)) {
        return false;
    }
    if (!distancecheck(var_3c0b4194, target, self.origin, arc_source_origin)) {
        return false;
    }
    if (!damage::friendlyfirecheck(eattacker, target)) {
        return false;
    }
    if (!target damageconetrace(self.origin + (0, 0, 10), self) && isdefined(var_3c0b4194.var_341b7688) && var_3c0b4194.var_341b7688) {
        return false;
    }
    return true;
}

// Namespace arc/arc
// Params 5, eflags: 0x0
// Checksum 0xd7333f4c, Offset: 0x7f0
// Size: 0x1d6
function find_arc_targets(var_3c0b4194, eattacker, arc_source, arc_source_origin, depth) {
    /#
        if (level.var_a60338e0) {
            function_c30cfc86(arc_source_origin, var_3c0b4194.max_range);
            function_e2264c39(self.origin, var_3c0b4194.range, depth, var_3c0b4194.depth);
        }
    #/
    delay = var_3c0b4194.delay;
    if (!isdefined(delay)) {
        delay = 0;
    }
    allplayers = util::get_active_players();
    closesttargets = arraysort(allplayers, arc_source_origin, 1);
    for (i = 0; i < var_3c0b4194.var_3d0c8d1d && i < closesttargets.size; i++) {
        target = closesttargets[i];
        if (!function_921683f4(var_3c0b4194, eattacker, arc_source, arc_source_origin, depth, target)) {
            continue;
        }
        level thread function_cfdb1b3b(var_3c0b4194, delay, eattacker, arc_source, self, arc_source_origin, self.origin, target, target gettagorigin(var_3c0b4194.fx_tag), depth);
    }
}

// Namespace arc/arc
// Params 10, eflags: 0x0
// Checksum 0xc523b6d5, Offset: 0x9d0
// Size: 0x1d6
function function_cfdb1b3b(var_3c0b4194, delay, eattacker, arc_source, var_931f82b, arc_source_origin, arc_source_pos, arc_target, arc_target_pos, depth) {
    if (delay) {
        wait float(delay) / 1000;
        if (!function_921683f4(var_3c0b4194, eattacker, arc_source, arc_source_origin, depth, arc_target)) {
            return;
        }
    }
    function_6602df88(arc_source, arc_target);
    if (depth < (isdefined(var_3c0b4194.depth) ? var_3c0b4194.depth : 0) && isdefined(arc_source)) {
        arc_target find_arc_targets(level.var_f8bec0dd[arc_source.arcweapon], arc_source.owner, arc_source, arc_source_origin, depth + 1);
    }
    if (isdefined(arc_source) && isdefined(arc_source.var_6eca641d)) {
        arc_source [[ arc_source.var_6eca641d ]](arc_target);
    }
    if (isdefined(arc_source)) {
        var_6e8759d = 0;
        if (isdefined(arc_source.var_6d47bbe8)) {
            var_6e8759d = arc_target [[ arc_source.var_6d47bbe8 ]](var_3c0b4194, arc_source, depth);
        }
        arc_source.var_222f3f2 = gettime() + var_6e8759d;
    }
}

// Namespace arc/arc
// Params 1, eflags: 0x0
// Checksum 0x48482ce9, Offset: 0xbb0
// Size: 0xa4
function function_1bd5f0a7(arc_source) {
    if (isdefined(self.var_55255964) && isdefined(arc_source)) {
        foreach (source in self.var_55255964) {
            if (isdefined(source) && source == arc_source) {
                return true;
            }
        }
    }
    return false;
}

// Namespace arc/arc
// Params 2, eflags: 0x0
// Checksum 0x676ee817, Offset: 0xc60
// Size: 0xaa
function function_6602df88(arc_source, arc_target) {
    arc_target.arc_source = arc_source;
    if (!isdefined(arc_target.var_55255964)) {
        arc_target.var_55255964 = [];
    }
    arc_target.var_55255964[arc_target.var_55255964.size] = arc_source;
    if (isdefined(arc_source)) {
        if (!isdefined(arc_source.var_8d124203)) {
            arc_source.var_8d124203 = [];
        }
        arc_source.var_8d124203[arc_source.var_8d124203.size] = arc_target;
    }
}

// Namespace arc/arc
// Params 1, eflags: 0x0
// Checksum 0xf442fec8, Offset: 0xd18
// Size: 0xe8
function function_d3f13e8(var_3c0b4194) {
    if (isdefined(self.var_8d124203)) {
        foreach (target in self.var_8d124203) {
            if (isdefined(target) && isalive(target) && isdefined(target.arc_source) && target.arc_source == self) {
                if (isdefined(self.var_3582f3a5)) {
                    self [[ self.var_3582f3a5 ]](target, var_3c0b4194);
                }
            }
        }
    }
}

