#using script_2bdd098a8215ac9f;
#using script_311c446e3df6c3fa;
#using script_41e32418d719f2dd;
#using script_4ed01237ecbd380f;
#using script_538e87197f25d67;
#using script_5665e7d917abc3fc;
#using script_62c72c96978f9b04;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace namespace_73df937d;

// Namespace namespace_73df937d/namespace_73df937d
// Params 0, eflags: 0x6
// Checksum 0x5af3ad10, Offset: 0x1d0
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"hash_5ff56dba9074b0b4", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace namespace_73df937d/namespace_73df937d
// Params 0, eflags: 0x1 linked
// Checksum 0xf7db1999, Offset: 0x218
// Size: 0x16c
function function_70a657d8() {
    level clientfield::register("scriptmover", "safehouse_beam_fx", 1, 1, "int", &safehouse_beam_fx, 0, 0);
    level clientfield::register("scriptmover", "safehouse_claim_fx", 1, 1, "int", &safehouse_claim_fx, 0, 0);
    level clientfield::register("scriptmover", "safehouse_machine_spawn_rob", 1, 1, "int", &function_c30c297c, 0, 0);
    clientfield::register_clientuimodel("hudItems.survivalOverlayOpen", #"hash_6f4b11a0bee9b73d", #"hash_618f9d2299bee479", 1, 1, "int", &function_dfbfa0f4, 0, 0);
    level.var_37076fe8 = &function_a2a8f79e;
    level.var_38c7030b = &function_424dc557;
}

// Namespace namespace_73df937d/namespace_73df937d
// Params 7, eflags: 0x1 linked
// Checksum 0x2464b08a, Offset: 0x390
// Size: 0xac
function safehouse_beam_fx(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (isdefined(self)) {
        if (bwastimejump) {
            self.fxid = function_239993de(fieldname, "sr/fx9_safehouse_beacon_marker", self, "tag_origin");
            return;
        }
        if (isdefined(self.fxid)) {
            stopfx(fieldname, self.fxid);
        }
    }
}

// Namespace namespace_73df937d/namespace_73df937d
// Params 7, eflags: 0x1 linked
// Checksum 0x94939c5c, Offset: 0x448
// Size: 0x134
function safehouse_claim_fx(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump) {
        self.fxid = function_239993de(fieldname, "sr/fx9_safehouse_orb_idle", self, "tag_origin");
        if (!isdefined(self.var_94ebeb0a)) {
            self.var_94ebeb0a = self playloopsound(#"hash_b3efcac5ac8b4cd");
        }
        return;
    }
    if (isdefined(self.fxid)) {
        killfx(fieldname, self.fxid);
    }
    if (isdefined(self.var_94ebeb0a)) {
        self stoploopsound(self.var_94ebeb0a);
        self.var_94ebeb0a = undefined;
    }
    playfx(fieldname, "sr/fx9_safehouse_orb_activate", self.origin);
}

// Namespace namespace_73df937d/namespace_73df937d
// Params 7, eflags: 0x1 linked
// Checksum 0xe59f9aeb, Offset: 0x588
// Size: 0x64
function function_c30c297c(*localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (isdefined(self)) {
        self playrenderoverridebundle(#"hash_1528dae63f55fcde");
    }
}

// Namespace namespace_73df937d/namespace_73df937d
// Params 7, eflags: 0x1 linked
// Checksum 0x1bfa285e, Offset: 0x5f8
// Size: 0xb4
function function_dfbfa0f4(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *wasdemojump) {
    var_cb481d18 = 1;
    if (wasdemojump) {
        var_cb481d18 = 0;
    }
    inventoryuimodel = function_1df4c3b0(fieldname, #"hash_159966ba825013a2");
    setuimodelvalue(createuimodel(inventoryuimodel, "canUseQuickInventory"), var_cb481d18);
}

// Namespace namespace_73df937d/namespace_73df937d
// Params 1, eflags: 0x1 linked
// Checksum 0x8ddab7a5, Offset: 0x6b8
// Size: 0x2a
function function_a2a8f79e(player) {
    return player clientfield::get_player_uimodel("hudItems.survivalOverlayOpen");
}

// Namespace namespace_73df937d/namespace_73df937d
// Params 1, eflags: 0x1 linked
// Checksum 0x8fabb80c, Offset: 0x6f0
// Size: 0x4a
function function_424dc557(localclientnum) {
    player = function_27673a7(localclientnum);
    return player clientfield::get_player_uimodel("hudItems.survivalOverlayOpen");
}

