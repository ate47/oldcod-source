#using scripts\core_common\callbacks_shared;
#using scripts\core_common\serverfield_shared;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\system_shared;

#namespace status_effect_suppress;

// Namespace status_effect_suppress/status_effect_suppress
// Params 0, eflags: 0x2
// Checksum 0x477304e9, Offset: 0xb8
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"status_effect_suppress", &__init__, undefined, undefined);
}

// Namespace status_effect_suppress/status_effect_suppress
// Params 0, eflags: 0x0
// Checksum 0x3043f7d4, Offset: 0x100
// Size: 0xc4
function __init__() {
    status_effect::register_status_effect_callback_apply(4, &suppress_apply);
    status_effect::function_81221eab(4, &function_e4b6da6e);
    status_effect::function_5cf962b4(getstatuseffect("suppress"));
    serverfield::register("status_effect_suppress_field", 1, 5, "int", &function_bf0b6d3);
    callback::on_spawned(&onplayerspawned);
}

// Namespace status_effect_suppress/status_effect_suppress
// Params 3, eflags: 0x0
// Checksum 0x42b4327d, Offset: 0x1d0
// Size: 0x1c
function suppress_apply(var_adce82d2, weapon, applicant) {
    
}

// Namespace status_effect_suppress/status_effect_suppress
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x1f8
// Size: 0x4
function function_e4b6da6e() {
    
}

// Namespace status_effect_suppress/status_effect_suppress
// Params 2, eflags: 0x4
// Checksum 0xa71847db, Offset: 0x208
// Size: 0x2b6
function private function_bf0b6d3(oldval, newval) {
    if (oldval != newval) {
        if (newval) {
            self.var_efef3d66 = 1;
            if (newval > 1) {
                var_91e6399f = newval - 2;
                foreach (player in level.players) {
                    if (!isdefined(player)) {
                        continue;
                    }
                    if (player getentitynumber() == var_91e6399f) {
                        self.var_25db07c1 = player;
                        break;
                    }
                }
            }
            var_8f05d61a = function_73b8c15(#"suppress");
            self.var_64496ac5 = {};
            if (isdefined(var_8f05d61a.var_cc40a478)) {
                self playlocalsound(var_8f05d61a.var_cc40a478);
            }
            if (isdefined(var_8f05d61a.var_bd10ce36)) {
                self playloopsound(var_8f05d61a.var_bd10ce36);
                self.var_64496ac5.var_bd10ce36 = var_8f05d61a.var_bd10ce36;
            }
            if (isdefined(var_8f05d61a.var_eb2f858d)) {
                self.var_64496ac5.var_eb2f858d = var_8f05d61a.var_eb2f858d;
            }
            return;
        }
        self.var_efef3d66 = 0;
        self.var_25db07c1 = undefined;
        if (isdefined(self.var_64496ac5) && isdefined(self.var_64496ac5.var_eb2f858d)) {
            if (isplayer(self)) {
                self playlocalsound(self.var_64496ac5.var_eb2f858d);
            }
        }
        if (isdefined(self.var_64496ac5) && isdefined(self.var_64496ac5.var_bd10ce36)) {
            if (isplayer(self)) {
                self stoploopsound(0.5);
            }
        }
        self.var_64496ac5 = undefined;
    }
}

// Namespace status_effect_suppress/status_effect_suppress
// Params 0, eflags: 0x4
// Checksum 0x209f9cd5, Offset: 0x4c8
// Size: 0xe
function private onplayerspawned() {
    self.var_efef3d66 = 0;
}

