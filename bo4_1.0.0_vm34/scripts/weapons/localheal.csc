#using script_2f1f2c10d854244;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\system_shared;

#namespace localheal;

// Namespace localheal/localheal
// Params 0, eflags: 0x2
// Checksum 0x48ac3aba, Offset: 0xd8
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"localheal", &init_shared, undefined, undefined);
}

// Namespace localheal/localheal
// Params 1, eflags: 0x0
// Checksum 0x44878240, Offset: 0x120
// Size: 0x8c
function init_shared(localclientnum) {
    clientfield::register("clientuimodel", "hudItems.localHealActive", 1, 1, "int", undefined, 0, 0);
    clientfield::register("allplayers", "tak_5_heal", 1, 1, "counter", &function_644a1488, 0, 0);
}

// Namespace localheal/localheal
// Params 7, eflags: 0x0
// Checksum 0xb57ad650, Offset: 0x1b8
// Size: 0x202
function function_76535b08(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    ent = getentbynum(localclientnum, newval);
    if (newval != oldval || isdefined(ent) && !(isdefined(ent.var_51a88271) && ent.var_51a88271)) {
        robname = #"hash_aa2ba3bf66e25d2";
        oldent = getentbynum(localclientnum, oldval);
        if (isdefined(oldent) && isdefined(oldent.var_51a88271) && oldent.var_51a88271) {
            oldent function_1a0542cd(0);
            oldent stoprenderoverridebundle(robname);
            oldent.var_51a88271 = undefined;
        }
        entnum = self getentitynumber();
        if (newval != entnum) {
            if (isdefined(ent) && !(isdefined(ent.var_51a88271) && ent.var_51a88271)) {
                ent function_1a0542cd(1);
                ent playrenderoverridebundle(robname);
                ent function_98a01e4c(robname, "Alpha", 1);
                ent.var_51a88271 = 1;
            }
        }
    }
}

// Namespace localheal/localheal
// Params 7, eflags: 0x0
// Checksum 0x2dcf5118, Offset: 0x3c8
// Size: 0x7c
function function_644a1488(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval != oldval) {
        if (self function_60dbc438()) {
            postfx::playpostfxbundle(#"hash_2ac1d3d8a26022e1");
        }
    }
}

