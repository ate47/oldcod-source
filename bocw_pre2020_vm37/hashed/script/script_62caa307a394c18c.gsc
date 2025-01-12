#using script_5f261a5d57de5f7c;
#using scripts\core_common\aat_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_weapons;

#namespace namespace_42457a0;

// Namespace namespace_42457a0/namespace_42457a0
// Params 4, eflags: 0x1 linked
// Checksum 0x95a89e05, Offset: 0x98
// Size: 0x132
function function_d6863a3(inflictor, attacker, meansofdeath, weapon) {
    element = self.var_8126f3c8;
    player = attacker;
    if (!isplayer(player) && isplayer(inflictor)) {
        player = inflictor;
    }
    if (!isdefined(element) && isdefined(weapon) && isplayer(player) && (meansofdeath != "MOD_MELEE" || weapon.type === "melee")) {
        aat = player aat::getaatonweapon(weapon);
        if (isdefined(aat)) {
            element = aat.element;
        }
    }
    if (!isdefined(element)) {
        element = zm_weapons::function_f066796f(weapon);
    }
    return element;
}

// Namespace namespace_42457a0/namespace_42457a0
// Params 1, eflags: 0x0
// Checksum 0x82420f8c, Offset: 0x1d8
// Size: 0x34
function function_38a17509(weapon) {
    if (isdefined(level.zombie_weapons)) {
        return level.zombie_weapons[weapon].element;
    }
}

// Namespace namespace_42457a0/namespace_42457a0
// Params 1, eflags: 0x1 linked
// Checksum 0x705c0f73, Offset: 0x218
// Size: 0xdc
function function_9caeb2f3(var_a4a310f7) {
    var_2bce48e0 = [];
    if (!isdefined(var_a4a310f7)) {
        return var_2bce48e0;
    }
    foreach (entry in var_a4a310f7) {
        if (isdefined(entry.type) && is_true(entry.weakness)) {
            var_2bce48e0[entry.type] = 1;
        }
    }
    return var_2bce48e0;
}

// Namespace namespace_42457a0/namespace_42457a0
// Params 2, eflags: 0x1 linked
// Checksum 0x71772872, Offset: 0x300
// Size: 0x44
function function_5c57c8c1(entity, type) {
    return isdefined(entity.var_19f5037) && is_true(entity.var_19f5037[type]);
}

// Namespace namespace_42457a0/namespace_42457a0
// Params 0, eflags: 0x1 linked
// Checksum 0xd35c5dcb, Offset: 0x350
// Size: 0xa
function function_9a5cfef3() {
    return 1.5;
}

// Namespace namespace_42457a0/namespace_42457a0
// Params 13, eflags: 0x1 linked
// Checksum 0x530071f5, Offset: 0x368
// Size: 0x200
function function_9fbcd067(element, inflictor, attacker, damage, *flags, *meansofdeath, *weapon, *vpoint, *vdir, *shitloc, *psoffsettime, *boneindex, *surfacetype) {
    if (!isdefined(shitloc)) {
        return;
    }
    var_68ceb6c4 = surfacetype;
    if (function_5c57c8c1(self, shitloc)) {
        var_68ceb6c4 = surfacetype * function_9a5cfef3();
        if (isplayer(boneindex) && boneindex namespace_e86ffa8::function_cd6787b(4)) {
            var_68ceb6c4 += (var_68ceb6c4 - surfacetype) * 0.5;
        }
        level.var_d921ba10 = 1;
        /#
            if (is_true(level.var_a12b24d0)) {
                function_8666eb93(surfacetype, var_68ceb6c4, shitloc, isplayer(psoffsettime) ? psoffsettime : boneindex, self);
            }
        #/
    } else {
        /#
            if (is_true(level.var_a12b24d0) && !is_true(level.var_98e71360)) {
                function_8666eb93(surfacetype, var_68ceb6c4, shitloc, isplayer(psoffsettime) ? psoffsettime : boneindex, self);
            }
        #/
    }
    return var_68ceb6c4;
}

// Namespace namespace_42457a0/namespace_42457a0
// Params 11, eflags: 0x1 linked
// Checksum 0xdf9fbab4, Offset: 0x570
// Size: 0xce
function function_601fabe9(element, amount, pos, attacker, inflictor, hitloc, mod, dflags, weapon, var_65c05877, var_9473a4eb) {
    self.var_8126f3c8 = element;
    self dodamage(amount, pos, attacker, inflictor, hitloc, mod, dflags, weapon, var_65c05877, is_true(var_9473a4eb));
    if (isalive(self)) {
        self.var_8126f3c8 = undefined;
    }
}

/#

    // Namespace namespace_42457a0/namespace_42457a0
    // Params 0, eflags: 0x0
    // Checksum 0x40bb80d9, Offset: 0x648
    // Size: 0x11c
    function function_5dbd7c2a() {
        level.var_bb60d9c = 1;
        util::waittill_can_add_debug_command();
        function_5ac4dc99("<dev string:x38>", "<dev string:x50>");
        function_cd140ee9("<dev string:x38>", &function_977b852e);
        adddebugcommand("<dev string:x54>");
        adddebugcommand("<dev string:xb7>");
        adddebugcommand("<dev string:x124>");
        adddebugcommand("<dev string:x18e>");
        adddebugcommand("<dev string:x1f8>");
        adddebugcommand("<dev string:x26e>");
        adddebugcommand("<dev string:x2da>");
    }

    // Namespace namespace_42457a0/namespace_42457a0
    // Params 1, eflags: 0x0
    // Checksum 0x9cde82af, Offset: 0x770
    // Size: 0x17c
    function function_977b852e(dvar) {
        if (dvar.value === "<dev string:x50>") {
            return;
        }
        tokens = strtok(dvar.value, "<dev string:x34e>");
        switch (tokens[0]) {
        case #"toggle_debug":
            level.var_a12b24d0 = !is_true(level.var_a12b24d0);
            if (!is_true(level.var_a12b24d0)) {
                level notify(#"hash_7417360c17579602");
            } else {
                level thread function_793d38f();
            }
            break;
        case #"hash_8c3f5aa0d2959b8":
            level.var_98e71360 = !is_true(level.var_98e71360);
            break;
        case #"hash_2ba0f54a8ae24152":
            function_11c1d3c(tokens[1]);
            break;
        }
        setdvar(dvar.name, "<dev string:x50>");
    }

    // Namespace namespace_42457a0/namespace_42457a0
    // Params 0, eflags: 0x0
    // Checksum 0x91be9650, Offset: 0x8f8
    // Size: 0x36e
    function function_793d38f() {
        level endon(#"game_ended", #"hash_7417360c17579602");
        level.var_cc43c151 = [];
        level.var_536f1a3 = 0;
        var_92abc4e4 = [#"fire":"<dev string:x353>", #"explosive":"<dev string:x359>", #"toxic":"<dev string:x35f>", #"electrical":"<dev string:x365>", #"cold":"<dev string:x36b>"];
        while (true) {
            waitframe(1);
            offset = 75 + 22 * 11;
            if (is_true(level.var_98e71360)) {
                debug2dtext((105, offset * 0.85, 0), "<dev string:x365>" + "<dev string:x371>", (1, 1, 1), undefined, (0.1, 0.1, 0.1), 0.9, 0.85);
                offset -= 22;
            } else {
                offset -= 22;
            }
            for (i = 0; i < level.var_cc43c151.size; i++) {
                index = (level.var_536f1a3 - i + level.var_cc43c151.size - 1) % level.var_cc43c151.size;
                debug_struct = level.var_cc43c151[index];
                string = debug_struct.timestamp + "<dev string:x384>" + "<dev string:x35f>" + debug_struct.attacker + "<dev string:x38b>" + "<dev string:x391>" + "<dev string:x365>" + debug_struct.damage + "<dev string:x39c>" + debug_struct.var_d036befe + "<dev string:x38b>" + "<dev string:x3a2>" + var_92abc4e4[debug_struct.element] + function_9e72a96(debug_struct.element) + "<dev string:x38b>" + "<dev string:x3a7>" + "<dev string:x36b>" + debug_struct.entity;
                debug2dtext((105, offset * 0.85, 0), string, (1, 1, 1), undefined, i == 0 ? (0.2, 0.2, 0.2) : (0.1, 0.1, 0.1), 0.9, 0.85);
                offset -= 22;
            }
        }
    }

    // Namespace namespace_42457a0/namespace_42457a0
    // Params 5, eflags: 0x0
    // Checksum 0x91c69871, Offset: 0xc70
    // Size: 0x228
    function function_8666eb93(damage, var_d036befe, element, attacker, entity) {
        level.var_cc43c151[level.var_536f1a3] = {#damage:damage, #var_d036befe:var_d036befe, #element:element, #attacker:isdefined(attacker) ? isplayer(attacker) ? "<dev string:x3b6>" + attacker getentitynumber() : isactor(attacker) ? function_9e72a96(isdefined(attacker.var_9fde8624) ? attacker.var_9fde8624 : attacker.archetype) : attacker getentitynumber() : "<dev string:x3c0>", #entity:isdefined(entity) ? isplayer(entity) ? "<dev string:x3b6>" + entity getentitynumber() : isactor(entity) ? function_9e72a96(isdefined(entity.var_9fde8624) ? entity.var_9fde8624 : entity.archetype) : entity getentitynumber() : "<dev string:x3c0>", #timestamp:gettime()};
        level.var_536f1a3 = (level.var_536f1a3 + 1) % 10;
    }

    // Namespace namespace_42457a0/namespace_42457a0
    // Params 1, eflags: 0x0
    // Checksum 0xb11b0fe9, Offset: 0xea0
    // Size: 0x108
    function function_11c1d3c(type) {
        var_f8ca59a8 = getentitiesinradius(level.players[0].origin, 512, 15);
        foreach (ai in var_f8ca59a8) {
            ai function_601fabe9(type, 1, level.players[0].origin, level.players[0], level.players[0], "<dev string:x3cd>", "<dev string:x3d5>", 0);
        }
    }

#/
