#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace dialog_table;

// Namespace dialog_table/dialog_table
// Params 0, eflags: 0x2
// Checksum 0xdddaa70c, Offset: 0xf0
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("dialog_table", &__init__, undefined, undefined);
}

// Namespace dialog_table/dialog_table
// Params 0, eflags: 0x0
// Checksum 0xf5d63203, Offset: 0x130
// Size: 0x24
function __init__() {
    if (!isdefined(level.var_1ba667da)) {
        level.var_1ba667da = [];
    }
}

// Namespace dialog_table/dialog_table
// Params 1, eflags: 0x0
// Checksum 0x54c07214, Offset: 0x160
// Size: 0xe4
function load(table) {
    rowindex = 1;
    for (row = tablelookuprow(table, rowindex); isdefined(row); row = tablelookuprow(table, rowindex)) {
        scriptkey = function_1b9ce9ff(row, 0);
        mask = function_1b9ce9ff(row, 1);
        add(scriptkey, mask);
        rowindex++;
    }
}

// Namespace dialog_table/dialog_table
// Params 1, eflags: 0x0
// Checksum 0x11377439, Offset: 0x250
// Size: 0x62
function function_649707de(scriptkey) {
    values = level.var_1ba667da[scriptkey];
    if (!isdefined(values) || !isdefined(values.mask)) {
        return "all";
    }
    return values.mask;
}

// Namespace dialog_table/dialog_table
// Params 2, eflags: 0x4
// Checksum 0x7e311e0, Offset: 0x2c0
// Size: 0x6a
function private add(scriptkey, mask) {
    if (!isdefined(mask)) {
        return;
    }
    values = spawnstruct();
    values.mask = mask;
    level.var_1ba667da[scriptkey] = values;
}

// Namespace dialog_table/dialog_table
// Params 2, eflags: 0x4
// Checksum 0xbf5a03e3, Offset: 0x338
// Size: 0x5a
function private function_1b9ce9ff(row, colindex) {
    val = tolower(row[colindex]);
    return val != "" ? val : undefined;
}

// Namespace dialog_table/dialog_table
// Params 2, eflags: 0x4
// Checksum 0xe4bdced0, Offset: 0x3a0
// Size: 0x7c
function private function_6f1f5838(row, colindex) {
    val = row[colindex];
    if (!isdefined(val)) {
        return undefined;
    }
    switch (tolower(val)) {
    case #"true":
        return 1;
    case #"false":
        return 0;
    }
    return undefined;
}

// Namespace dialog_table/dialog_table
// Params 2, eflags: 0x4
// Checksum 0x95181b43, Offset: 0x428
// Size: 0x32
function private function_e4148047(row, colindex) {
    return int(row[colindex]);
}

