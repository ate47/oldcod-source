#namespace namespace_679a22ba;

// Namespace namespace_679a22ba/namespace_519b3aaf
// Params 1, eflags: 0x1 linked
// Checksum 0x8cd29f69, Offset: 0x60
// Size: 0x1bc
function function_77be8a83(var_e98de867) {
    assert(isdefined(var_e98de867), "<dev string:x38>");
    bundle = getscriptbundle(var_e98de867);
    assert(isdefined(bundle), "<dev string:x73>" + (ishash(var_e98de867) ? function_9e72a96(var_e98de867) : var_e98de867));
    var_89592ba7 = {#var_7c88c117:[], #var_b0abb10e:isdefined(bundle.var_d961aeb3) ? bundle.var_d961aeb3 : 0};
    foreach (index, var_c1d870ac in bundle.var_210a8489) {
        var_89592ba7.var_7c88c117[index] = {#name:var_c1d870ac.entryname, #spawned:0, #var_cffbc08:var_c1d870ac.var_a949845f};
    }
    return var_89592ba7;
}

// Namespace namespace_679a22ba/namespace_519b3aaf
// Params 2, eflags: 0x1 linked
// Checksum 0x50f14862, Offset: 0x228
// Size: 0x10c
function function_ca209564(var_e98de867, var_ddb02c2b) {
    assert(isdefined(var_e98de867), "<dev string:xa8>");
    if (isdefined(var_e98de867)) {
        var_3561dd4b = getscriptbundle(var_e98de867);
        assert(isdefined(var_3561dd4b), "<dev string:xe6>" + (ishash(var_e98de867) ? function_9e72a96(var_e98de867) : var_e98de867));
        if (isdefined(var_ddb02c2b)) {
            return function_15541865(var_3561dd4b.var_210a8489, var_ddb02c2b.var_7c88c117, 1, var_ddb02c2b.var_b0abb10e);
        }
        return function_15541865(var_3561dd4b.var_210a8489, [], 0);
    }
}

// Namespace namespace_679a22ba/namespace_519b3aaf
// Params 2, eflags: 0x1 linked
// Checksum 0xe944044e, Offset: 0x340
// Size: 0xe8
function function_266ee075(var_8452bcb9, var_ddb02c2b) {
    foreach (entry in var_ddb02c2b.var_7c88c117) {
        var_cffbc08 = function_b9ea4226(entry.var_cffbc08, var_ddb02c2b.var_b0abb10e);
        if (entry.name === var_8452bcb9 && var_cffbc08 - entry.spawned > 0) {
            entry.spawned++;
            break;
        }
    }
}

// Namespace namespace_679a22ba/namespace_519b3aaf
// Params 2, eflags: 0x1 linked
// Checksum 0x23d08dc8, Offset: 0x430
// Size: 0xbc
function function_898aced0(var_8452bcb9, var_ddb02c2b) {
    foreach (entry in var_ddb02c2b.var_7c88c117) {
        if (entry.name === var_8452bcb9 && entry.var_cffbc08 > 0) {
            entry.spawned--;
            break;
        }
    }
}

// Namespace namespace_679a22ba/namespace_519b3aaf
// Params 1, eflags: 0x1 linked
// Checksum 0x62a9a67b, Offset: 0x4f8
// Size: 0x134
function function_ce65eab6(var_89592ba7) {
    spawned = 0;
    var_cffbc08 = 0;
    infinite = 0;
    foreach (entry in var_89592ba7.var_7c88c117) {
        if (entry.var_cffbc08 == -1) {
            infinite = 1;
        }
        spawned += entry.spawned;
        var_cffbc08 += function_b9ea4226(entry.var_cffbc08, var_89592ba7.var_b0abb10e);
    }
    return {#spawned:spawned, #var_cffbc08:infinite ? -1 : var_cffbc08};
}

// Namespace namespace_679a22ba/namespace_519b3aaf
// Params 1, eflags: 0x0
// Checksum 0xa140cc8, Offset: 0x638
// Size: 0x56
function function_f6a07949(var_89592ba7) {
    var_aeb18f6 = function_ce65eab6(var_89592ba7);
    return var_aeb18f6.var_cffbc08 == -1 || var_aeb18f6.spawned < var_aeb18f6.var_cffbc08;
}

// Namespace namespace_679a22ba/namespace_519b3aaf
// Params 4, eflags: 0x5 linked
// Checksum 0xc987175b, Offset: 0x698
// Size: 0x180
function private function_15541865(&var_8def964, &var_fcfdb752, var_e1be5b85 = 0, var_b0abb10e = 0) {
    var_8452bcb9 = function_622c131e(var_8def964, var_fcfdb752, var_e1be5b85, var_b0abb10e);
    if (!isdefined(var_8452bcb9)) {
        return undefined;
    }
    var_74142af1 = getscriptbundle(var_8452bcb9);
    if (var_74142af1.type === #"survivalailistentry") {
        return_struct = {#var_990b33df:var_74142af1.var_5fa96b51[randomint(var_74142af1.var_5fa96b51.size)].var_1b48d0fc};
        if (var_e1be5b85) {
            return_struct.list_name = var_8452bcb9;
        }
        return return_struct;
    }
    if (!isdefined(var_74142af1.var_210a8489) || var_74142af1.var_210a8489.size == 0) {
        return undefined;
    }
    return_struct = function_15541865(var_74142af1.var_210a8489, var_fcfdb752, 0);
    if (var_e1be5b85) {
        return_struct.list_name = var_8452bcb9;
    }
    return return_struct;
}

// Namespace namespace_679a22ba/namespace_519b3aaf
// Params 4, eflags: 0x5 linked
// Checksum 0xa9e43d07, Offset: 0x820
// Size: 0x1d4
function private function_622c131e(&var_5c120708, &var_fcfdb752, var_e1be5b85, var_b0abb10e) {
    var_d342621c = 0;
    var_5b34aaca = [];
    for (index = 0; index < var_5c120708.size; index++) {
        entry = var_5c120708[index];
        var_cffbc08 = function_b9ea4226(isdefined(var_fcfdb752[index].var_cffbc08) ? var_fcfdb752[index].var_cffbc08 : 0, var_b0abb10e);
        if (is_true(var_e1be5b85) && !function_9a90dff7(var_fcfdb752[index]) && var_cffbc08 - var_fcfdb752[index].spawned <= 0) {
            continue;
        }
        var_d342621c += isdefined(entry.var_857deb66) ? entry.var_857deb66 : 0;
        struct = {#weight:var_d342621c, #name:entry.entryname};
        var_5b34aaca[var_5b34aaca.size] = struct;
    }
    random_weight = randomintrangeinclusive(0, var_d342621c);
    for (index = 0; index < var_5b34aaca.size; index++) {
        if (random_weight <= var_5b34aaca[index].weight) {
            return var_5b34aaca[index].name;
        }
    }
}

// Namespace namespace_679a22ba/namespace_519b3aaf
// Params 2, eflags: 0x1 linked
// Checksum 0xa12ec038, Offset: 0xa00
// Size: 0xba
function function_b9ea4226(value, scale) {
    count = getplayers().size - 1;
    /#
        if (getdvarint(#"hash_4b8ad6985e0ad109", 0) > 0) {
            count = getdvarint(#"hash_4b8ad6985e0ad109", 0) - 1;
        }
    #/
    return int(value + value * (isdefined(scale) ? scale : 0) * count);
}

// Namespace namespace_679a22ba/namespace_519b3aaf
// Params 2, eflags: 0x0
// Checksum 0xa1484d4e, Offset: 0xac8
// Size: 0xe0
function function_c60389b6(var_e3c68634, var_b0abb10e) {
    count = getplayers().size - 1;
    /#
        if (getdvarint(#"hash_718bfcd5ab690a9c", 0) > 0) {
            count = getdvarint(#"hash_718bfcd5ab690a9c", 0) - 1;
        }
    #/
    scale = isdefined(var_b0abb10e) ? var_b0abb10e : 0;
    var_693db196 = var_e3c68634.var_cffbc08 + var_e3c68634.var_cffbc08 * scale * count;
    return var_693db196 - var_e3c68634.spawned;
}

// Namespace namespace_679a22ba/namespace_519b3aaf
// Params 1, eflags: 0x1 linked
// Checksum 0xa0a9fda5, Offset: 0xbb0
// Size: 0x1c
function function_9a90dff7(var_e3c68634) {
    return var_e3c68634.var_cffbc08 == -1;
}

