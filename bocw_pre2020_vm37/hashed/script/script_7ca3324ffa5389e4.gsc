#namespace namespace_eb06e24d;

// Namespace namespace_eb06e24d/namespace_eb06e24d
// Params 0, eflags: 0x1 linked
// Checksum 0x828fc161, Offset: 0x60
// Size: 0x86
function get_jumpkits() {
    if (!isdefined(level.var_aadba305)) {
        level.var_aadba305 = isdefined(getscriptbundlelist(#"jumpkits")) ? getscriptbundlelist(#"jumpkits") : array();
    }
    return level.var_aadba305;
}

// Namespace namespace_eb06e24d/namespace_eb06e24d
// Params 0, eflags: 0x1 linked
// Checksum 0x6ab3026f, Offset: 0xf0
// Size: 0x14
function function_3045dd71() {
    return get_jumpkits().size;
}

// Namespace namespace_eb06e24d/namespace_eb06e24d
// Params 1, eflags: 0x1 linked
// Checksum 0x56154440, Offset: 0x110
// Size: 0xaa
function function_550c6257(var_ff60755f) {
    jumpkits = get_jumpkits();
    assert(jumpkits.size > 0);
    assert(isdefined(jumpkits[0]));
    if (var_ff60755f < 0 || var_ff60755f >= jumpkits.size || !isdefined(jumpkits[var_ff60755f])) {
        var_ff60755f = 0;
    }
    return getscriptbundle(jumpkits[var_ff60755f]);
}

// Namespace namespace_eb06e24d/namespace_eb06e24d
// Params 1, eflags: 0x1 linked
// Checksum 0x359558c5, Offset: 0x1c8
// Size: 0x4a
function function_83a2cad4(index) {
    kit = function_550c6257(index);
    return getscriptbundle(kit.parachute);
}

// Namespace namespace_eb06e24d/namespace_eb06e24d
// Params 1, eflags: 0x1 linked
// Checksum 0x4eb58381, Offset: 0x220
// Size: 0x4a
function function_aa3a05b1(index) {
    kit = function_550c6257(index);
    return getscriptbundle(kit.wingsuit);
}

// Namespace namespace_eb06e24d/namespace_eb06e24d
// Params 1, eflags: 0x1 linked
// Checksum 0xeece6b86, Offset: 0x278
// Size: 0x4a
function function_6452f9c5(index) {
    kit = function_550c6257(index);
    return getscriptbundle(kit.var_4fa85a25);
}

// Namespace namespace_eb06e24d/namespace_eb06e24d
// Params 0, eflags: 0x5 linked
// Checksum 0xb6d0e355, Offset: 0x2d0
// Size: 0x7a
function private function_c72eb508() {
    if (isdefined(self.var_9f20891)) {
        return self.var_9f20891;
    }
    count = function_3045dd71();
    self.var_9f20891 = function_d59c2d03(count, level.item_spawn_seed + self getentitynumber());
    return self.var_9f20891;
}

// Namespace namespace_eb06e24d/namespace_eb06e24d
// Params 1, eflags: 0x5 linked
// Checksum 0xa7b0c250, Offset: 0x358
// Size: 0x152
function private function_37ae175b(type) {
    /#
        if (getdvarint(#"hash_9003cbb3abd93b7", 0) != 0) {
            count = function_3045dd71();
            return int(max(0, min(count, getdvarint(#"hash_9003cbb3abd93b7", 0) - 1)));
        }
        if (getdvarint(#"hash_6c79f9280f28fabe", 0) != 0) {
            return self function_c72eb508();
        }
    #/
    if (isbot(self)) {
        return self function_c72eb508();
    }
    var_5c27e968 = self function_7d5a3c48(currentsessionmode(), type);
    return var_5c27e968;
}

// Namespace namespace_eb06e24d/namespace_eb06e24d
// Params 0, eflags: 0x1 linked
// Checksum 0xdb9480f4, Offset: 0x4b8
// Size: 0x2a
function get_parachute() {
    return function_83a2cad4(self function_37ae175b(0));
}

// Namespace namespace_eb06e24d/namespace_eb06e24d
// Params 0, eflags: 0x0
// Checksum 0x6e78a3b8, Offset: 0x4f0
// Size: 0x2a
function get_parachute_kit() {
    return function_550c6257(self function_37ae175b(0));
}

// Namespace namespace_eb06e24d/namespace_eb06e24d
// Params 0, eflags: 0x0
// Checksum 0x667f6506, Offset: 0x528
// Size: 0x2a
function get_wingsuit() {
    return function_aa3a05b1(self function_37ae175b(2));
}

// Namespace namespace_eb06e24d/namespace_eb06e24d
// Params 0, eflags: 0x0
// Checksum 0xa379a6df, Offset: 0x560
// Size: 0x2a
function get_wingsuit_kit() {
    return function_550c6257(self function_37ae175b(2));
}

// Namespace namespace_eb06e24d/namespace_eb06e24d
// Params 0, eflags: 0x1 linked
// Checksum 0xa0ac74dc, Offset: 0x598
// Size: 0x2a
function get_trailfx() {
    return function_6452f9c5(self function_37ae175b(1));
}

// Namespace namespace_eb06e24d/namespace_eb06e24d
// Params 0, eflags: 0x0
// Checksum 0x33fa42ce, Offset: 0x5d0
// Size: 0x2a
function function_4a39b434() {
    return function_550c6257(self function_37ae175b(1));
}

