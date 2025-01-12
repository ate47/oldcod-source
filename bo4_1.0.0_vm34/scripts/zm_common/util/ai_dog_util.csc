#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm;

#namespace zombie_dog_util;

// Namespace zombie_dog_util/ai_dog_util
// Params 0, eflags: 0x2
// Checksum 0xe2d6bbf7, Offset: 0x118
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zombie_dog_util", &__init__, undefined, undefined);
}

// Namespace zombie_dog_util/ai_dog_util
// Params 0, eflags: 0x0
// Checksum 0x72d29aea, Offset: 0x160
// Size: 0xec
function __init__() {
    init_dog_fx();
    clientfield::register("actor", "dog_fx", 1, 1, "int", &dog_fx, 0, 0);
    clientfield::register("actor", "dog_spawn_fx", 1, 1, "counter", &dog_spawn_fx, 0, 0);
    clientfield::register("world", "dog_round_fog_bank", 1, 1, "int", &dog_round_fog_bank, 0, 0);
}

// Namespace zombie_dog_util/ai_dog_util
// Params 0, eflags: 0x0
// Checksum 0x1812d197, Offset: 0x258
// Size: 0x182
function init_dog_fx() {
    level._effect[#"dog_eye_glow"] = #"hash_70696527ecb861ae";
    level._effect[#"hash_55d6ab2c7eecbad4"] = #"hash_249f091d13da3663";
    level._effect[#"hash_808a86715bfac90"] = #"hash_78f02617f4f71d8a";
    level._effect[#"hash_5e4d4083a69396b8"] = #"hash_36a9dd505e78a";
    level._effect[#"hash_33fd6545401e3622"] = #"hash_39b25de05718b20c";
    level._effect[#"hash_63f497890003547"] = #"hash_3055dc23ae9ca695";
    level._effect[#"dog_gib"] = #"zm_ai/fx8_dog_death_exp";
    level._effect[#"lightning_dog_spawn"] = #"zm_ai/fx8_dog_lightning_spawn";
}

// Namespace zombie_dog_util/ai_dog_util
// Params 7, eflags: 0x0
// Checksum 0x6b1ff4ac, Offset: 0x3e8
// Size: 0x3fc
function dog_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    util::waittill_dobj(localclientnum);
    if (!isdefined(self)) {
        return;
    }
    if (newval) {
        self._eyeglow_fx_override = level._effect[#"dog_eye_glow"];
        self zm::createzombieeyes(localclientnum);
        self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, zm::get_eyeball_on_luminance(), self zm::get_eyeball_color());
        if (!isdefined(self.var_8c039e1f)) {
            self.var_8c039e1f = [];
        }
        array::add(self.var_8c039e1f, util::playfxontag(localclientnum, level._effect[#"hash_808a86715bfac90"], self, "j_neck_end"));
        array::add(self.var_8c039e1f, util::playfxontag(localclientnum, level._effect[#"hash_5e4d4083a69396b8"], self, "j_tail0"));
        array::add(self.var_8c039e1f, util::playfxontag(localclientnum, level._effect[#"hash_5e4d4083a69396b8"], self, "j_tail1"));
        array::add(self.var_8c039e1f, util::playfxontag(localclientnum, level._effect[#"hash_33fd6545401e3622"], self, "j_spine2"));
        array::add(self.var_8c039e1f, util::playfxontag(localclientnum, level._effect[#"hash_63f497890003547"], self, "j_neck"));
        array::add(self.var_8c039e1f, util::playfxontag(localclientnum, level._effect[#"hash_55d6ab2c7eecbad4"], self, "tag_eye"));
        return;
    }
    self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, zm::get_eyeball_off_luminance(), self zm::get_eyeball_color());
    self zm::deletezombieeyes(localclientnum);
    if (isdefined(self.var_8c039e1f)) {
        foreach (fxhandle in self.var_8c039e1f) {
            deletefx(localclientnum, fxhandle);
        }
    }
    util::playfxontag(localclientnum, level._effect[#"dog_gib"], self, "j_spine2");
}

// Namespace zombie_dog_util/ai_dog_util
// Params 7, eflags: 0x0
// Checksum 0x5e09906, Offset: 0x7f0
// Size: 0x74
function dog_spawn_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    util::playfxontag(localclientnum, level._effect[#"lightning_dog_spawn"], self, "j_spine2");
}

// Namespace zombie_dog_util/ai_dog_util
// Params 7, eflags: 0x0
// Checksum 0x165d2676, Offset: 0x870
// Size: 0x94
function dog_round_fog_bank(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval == 1) {
        level thread function_71400119(localclientnum, 1, 2);
        return;
    }
    level thread function_71400119(localclientnum, 2, 1);
}

// Namespace zombie_dog_util/ai_dog_util
// Params 4, eflags: 0x4
// Checksum 0xa00daa8e, Offset: 0x910
// Size: 0x1a0
function private function_71400119(localclientnum, var_e6ace819, var_62b962de, n_time = 3) {
    level notify(#"hash_271a4f96b971ce17");
    level endon(#"hash_271a4f96b971ce17");
    n_blend = 0;
    n_increment = 1 / n_time / 0.05;
    if (var_e6ace819 == 1 && var_62b962de == 2) {
        while (n_blend < 1) {
            function_10d6e9c4(localclientnum, var_e6ace819 | var_62b962de, 1 - n_blend, n_blend, 0, 0);
            n_blend += n_increment;
            wait 0.05;
        }
        return;
    }
    if (var_e6ace819 == 2 && var_62b962de == 1) {
        while (n_blend < 1) {
            function_10d6e9c4(localclientnum, var_e6ace819 | var_62b962de, n_blend, 1 - n_blend, 0, 0);
            n_blend += n_increment;
            wait 0.05;
        }
    }
}

