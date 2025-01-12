#using script_1f41849126bfc83d;
#using script_49e18fd5437112e;
#using script_50fe40f0d2eaa66c;
#using script_c8d806d2487b617;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace radiation;

// Namespace radiation/radiation
// Params 0, eflags: 0x6
// Checksum 0x7a2ed93a, Offset: 0xc8
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"radiation", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace radiation/radiation
// Params 0, eflags: 0x5 linked
// Checksum 0x873b091c, Offset: 0x110
// Size: 0x6c
function private function_70a657d8() {
    if (!namespace_956bd4dd::function_ab99e60c()) {
        return;
    }
    if (level.gametype === "fireteam_dirty_bomb") {
        return;
    }
    level thread function_1e3ac913();
    callback::on_spawned(&_on_player_spawned);
}

// Namespace radiation/radiation
// Params 0, eflags: 0x5 linked
// Checksum 0xd23800cc, Offset: 0x188
// Size: 0xfa
function private function_3c3e40b6() {
    if (!isdefined(level.radiation)) {
        assertmsg("<dev string:x38>");
        return;
    }
    if (level.radiation.levels.size <= 0) {
        assertmsg("<dev string:x6f>");
        return;
    }
    if (isdefined(self.radiation)) {
        function_770871f5(self);
    }
    self.radiation = {};
    self.radiation.var_abd7d46a = level.radiation.levels[0].maxhealth;
    self.radiation.var_32adf91d = 0;
    self.radiation.sickness = [];
    self.radiation.var_393e0e31 = 0;
}

// Namespace radiation/radiation
// Params 0, eflags: 0x5 linked
// Checksum 0xef6c37ca, Offset: 0x290
// Size: 0x5c
function private _on_player_spawned() {
    if (!namespace_956bd4dd::function_ab99e60c()) {
        return;
    }
    assert(isplayer(self));
    self function_3c3e40b6();
}

// Namespace radiation/radiation
// Params 0, eflags: 0x5 linked
// Checksum 0xde87e319, Offset: 0x2f8
// Size: 0x126
function private function_1e3ac913() {
    level endon(#"game_ended");
    var_1a1c0d86 = 0;
    while (true) {
        foreach (index, player in getplayers()) {
            if (index % 10 == var_1a1c0d86) {
                if (player.sessionstate != "playing" || !isalive(player)) {
                    continue;
                }
                player function_acb192d7();
            }
        }
        var_1a1c0d86 = (var_1a1c0d86 + 1) % 10;
        waitframe(1);
    }
}

// Namespace radiation/radiation
// Params 0, eflags: 0x5 linked
// Checksum 0x6d1895b5, Offset: 0x428
// Size: 0x1e4
function private function_acb192d7() {
    if (!isplayer(self)) {
        assert(0);
        return;
    }
    var_32adf91d = self.radiation.var_32adf91d;
    radiation = level.radiation.levels[var_32adf91d];
    if (!isdefined(radiation)) {
        return;
    }
    if (var_32adf91d == 0 && self.radiation.var_abd7d46a == radiation.maxhealth && self.radiation.sickness.size == 0) {
        return;
    }
    timems = gettime();
    foreach (sickness, var_46bdb64c in self.radiation.sickness) {
        var_79904d8d = radiation.sickness[sickness];
        if (timems - var_46bdb64c.var_3e39b26c > var_46bdb64c.var_f8804aa0) {
            function_f68871f2(self, sickness);
        }
    }
    var_bb2d7819 = timems - self.radiation.var_393e0e31 >= radiation.var_e8f27947;
    if (!var_bb2d7819) {
        return;
    }
    function_54031aad(self);
}

// Namespace radiation/radiation
// Params 1, eflags: 0x5 linked
// Checksum 0xb420b698, Offset: 0x618
// Size: 0xa0
function private function_770871f5(player) {
    foreach (sickness, var_46bdb64c in player.radiation.sickness) {
        function_f68871f2(player, sickness);
    }
}

// Namespace radiation/radiation
// Params 1, eflags: 0x5 linked
// Checksum 0x10fa4f6a, Offset: 0x6c0
// Size: 0x17c
function private function_54031aad(player) {
    var_32adf91d = player.radiation.var_32adf91d;
    radiation = level.radiation.levels[var_32adf91d];
    timems = gettime();
    player.radiation.var_393e0e31 = timems;
    var_62a95841 = radiation.var_9653dad7;
    if (radiation.var_9653dad7 < radiation.var_21a59205) {
        var_62a95841 = randomintrange(radiation.var_9653dad7, radiation.var_21a59205);
    }
    if (var_62a95841 <= 0) {
        return;
    }
    var_2ef8e686 = array::randomize(getarraykeys(radiation.sickness));
    for (var_f50d4e4a = 0; var_f50d4e4a < var_62a95841 && var_f50d4e4a < var_2ef8e686.size; var_f50d4e4a++) {
        var_f1869be0 = var_2ef8e686[var_f50d4e4a];
        if (isdefined(player.radiation.sickness[var_f1869be0])) {
            continue;
        }
        function_e2336716(player, var_32adf91d, var_f1869be0);
    }
}

// Namespace radiation/radiation
// Params 3, eflags: 0x1 linked
// Checksum 0xbc6e3585, Offset: 0x848
// Size: 0x174
function function_e2336716(player, radiationlevel, sickness) {
    if (!isplayer(player)) {
        assert(0);
        return;
    }
    if (!ishash(sickness)) {
        assert(0);
        return;
    }
    var_46bdb64c = level.radiation.levels[radiationlevel].sickness[sickness];
    var_2fbd0753 = level.radiation.sickness[sickness].var_25d1eac4;
    if (isdefined(var_2fbd0753)) {
        player [[ var_2fbd0753 ]]();
    }
    assert(!isdefined(player.radiation.sickness[sickness]));
    var_768b78bb = {};
    var_768b78bb.var_3e39b26c = gettime();
    var_768b78bb.var_f8804aa0 = var_46bdb64c.duration;
    player.radiation.sickness[sickness] = var_768b78bb;
    namespace_6615ea91::function_59621e3c(player, sickness);
}

// Namespace radiation/radiation
// Params 2, eflags: 0x5 linked
// Checksum 0x63cbec67, Offset: 0x9c8
// Size: 0x114
function private function_f68871f2(player, sickness) {
    if (!isplayer(player)) {
        assert(0);
        return;
    }
    if (!ishash(sickness)) {
        assert(0);
        return;
    }
    var_46bdb64c = level.radiation.sickness[sickness];
    if (isdefined(var_46bdb64c.var_dad6905e)) {
        player [[ var_46bdb64c.var_dad6905e ]]();
    }
    player.radiation.sickness[sickness] = undefined;
    arrayremovevalue(player.radiation.sickness, undefined, 1);
    namespace_6615ea91::function_5cf1c0a(player, sickness);
}

// Namespace radiation/radiation
// Params 3, eflags: 0x1 linked
// Checksum 0xe20fd71b, Offset: 0xae8
// Size: 0x16c
function function_d90ea0e7(sickness, var_25d1eac4 = undefined, var_dad6905e = undefined) {
    if (!namespace_956bd4dd::function_ab99e60c()) {
        return;
    }
    namespace_956bd4dd::function_f45ee99d();
    if (isdefined(level.radiation.sickness[sickness])) {
        assertmsg("<dev string:x9b>" + sickness + "<dev string:xc4>");
        return;
    }
    if (isdefined(var_25d1eac4) && !isfunctionptr(var_25d1eac4)) {
        assert(0);
        return;
    }
    if (isdefined(var_dad6905e) && !isfunctionptr(var_dad6905e)) {
        assert(0);
        return;
    }
    var_46bdb64c = {};
    var_46bdb64c.var_25d1eac4 = var_25d1eac4;
    var_46bdb64c.var_dad6905e = var_dad6905e;
    level.radiation.sickness[sickness] = var_46bdb64c;
}

// Namespace radiation/radiation
// Params 2, eflags: 0x0
// Checksum 0xe87306a3, Offset: 0xc60
// Size: 0xa6
function function_3ccea89c(player, count) {
    if (!namespace_956bd4dd::function_ab99e60c()) {
        return;
    }
    if (!isplayer(player)) {
        assert(0);
        return;
    }
    if (!isint(count) && !isfloat(count)) {
        assert(0);
        return;
    }
}

// Namespace radiation/radiation
// Params 1, eflags: 0x1 linked
// Checksum 0x874b82cc, Offset: 0xd10
// Size: 0x4e
function function_c9c6dda1(player) {
    if (!isplayer(player)) {
        assert(0);
        return;
    }
    return player.radiation.var_32adf91d;
}

// Namespace radiation/radiation
// Params 2, eflags: 0x0
// Checksum 0x5a180964, Offset: 0xd68
// Size: 0x3bc
function function_2f76803d(player, count) {
    if (!namespace_956bd4dd::function_ab99e60c()) {
        return;
    }
    if (!isplayer(player)) {
        assert(0);
        return;
    }
    if (!isint(count) && !isfloat(count)) {
        assert(0);
        return;
    }
    if (!isalive(player)) {
        return;
    }
    if (player util::function_88c74107()) {
        return;
    }
    namespace_6615ea91::function_36a2c924(player, count / 5);
    if (isdefined(level.var_c3a003ad)) {
        count = player [[ level.var_c3a003ad ]](count);
        if (!isint(count) && !isfloat(count)) {
            assert(0);
            return;
        }
    }
    if (count == 0) {
        return;
    }
    var_5a9583ae = player.radiation.var_abd7d46a - count;
    if (var_5a9583ae > 0) {
        player.radiation.var_abd7d46a = var_5a9583ae;
        var_32adf91d = player.radiation.var_32adf91d;
        namespace_6615ea91::function_835a6746(player, player.radiation.var_abd7d46a / level.radiation.levels[var_32adf91d].maxhealth);
        return;
    }
    player.radiation.var_32adf91d++;
    if (player.radiation.var_32adf91d > level.radiation.levels.size) {
        player.radiation.var_32adf91d--;
    }
    var_32adf91d = player.radiation.var_32adf91d;
    if (var_32adf91d >= level.radiation.levels.size) {
        namespace_6615ea91::function_835a6746(player, 1);
        player kill();
        return;
    }
    namespace_6615ea91::function_137e7814(player, player.radiation.var_32adf91d + 1);
    player.radiation.var_abd7d46a = level.radiation.levels[var_32adf91d].maxhealth - var_5a9583ae;
    namespace_6615ea91::function_835a6746(player, player.radiation.var_abd7d46a / level.radiation.levels[var_32adf91d].maxhealth);
    function_770871f5(player);
    function_54031aad(player);
}

