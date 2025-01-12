#using scripts\core_common\util_shared;

#namespace beam;

// Namespace beam/beam_shared
// Params 6, eflags: 0x0
// Checksum 0xd3a796de, Offset: 0x78
// Size: 0x1e0
function launch(ent_1, str_tag1, ent_2, str_tag2, str_beam_type, var_8812436f) {
    s_beam = _get_beam(ent_1, str_tag1, ent_2, str_tag2, str_beam_type);
    if (!isdefined(s_beam)) {
        s_beam = _new_beam(ent_1, str_tag1, ent_2, str_tag2, str_beam_type);
    }
    if (self == level) {
        if (isdefined(level.localplayers)) {
            foreach (player in level.localplayers) {
                if (isdefined(player)) {
                    beam_id = player launch(ent_1, str_tag1, ent_2, str_tag2, str_beam_type);
                    if (!(isdefined(var_8812436f) && var_8812436f)) {
                        return beam_id;
                    }
                }
            }
        }
        return;
    }
    if (isdefined(s_beam)) {
        s_beam.beam_id = beamlaunch(self.localclientnum, ent_1, str_tag1, ent_2, str_tag2, str_beam_type);
        self thread _kill_on_ent_death(self.localclientnum, s_beam, ent_1, ent_2);
        return s_beam.beam_id;
    }
}

// Namespace beam/beam_shared
// Params 6, eflags: 0x0
// Checksum 0x9017000c, Offset: 0x260
// Size: 0x104
function function_31f5fd50(localclientnum, ent_1, str_tag1, ent_2, str_tag2, str_beam_type) {
    s_beam = _get_beam(ent_1, str_tag1, ent_2, str_tag2, str_beam_type);
    if (!isdefined(s_beam)) {
        s_beam = _new_beam(ent_1, str_tag1, ent_2, str_tag2, str_beam_type);
    }
    if (isdefined(s_beam)) {
        s_beam.beam_id = beamlaunch(localclientnum, ent_1, str_tag1, ent_2, str_tag2, str_beam_type);
        self thread _kill_on_ent_death(localclientnum, s_beam, ent_1, ent_2);
        return s_beam.beam_id;
    }
    return -1;
}

// Namespace beam/beam_shared
// Params 5, eflags: 0x0
// Checksum 0xdcc68e6c, Offset: 0x370
// Size: 0x17c
function kill(ent_1, str_tag1, ent_2, str_tag2, str_beam_type) {
    if (isdefined(self.active_beams)) {
        s_beam = _get_beam(ent_1, str_tag1, ent_2, str_tag2, str_beam_type);
        arrayremovevalue(self.active_beams, s_beam, 0);
    }
    if (self == level) {
        if (isdefined(level.localplayers)) {
            foreach (player in level.localplayers) {
                if (isdefined(player)) {
                    player kill(ent_1, str_tag1, ent_2, str_tag2, str_beam_type);
                }
            }
        }
        return;
    }
    if (isdefined(s_beam)) {
        s_beam notify(#"kill");
        beamkill(self.localclientnum, s_beam.beam_id);
    }
}

// Namespace beam/beam_shared
// Params 2, eflags: 0x0
// Checksum 0xdadca417, Offset: 0x4f8
// Size: 0x9c
function function_9bf5daf5(localclientnum, beam_id) {
    if (isdefined(level.active_beams)) {
        s_beam = function_3c6840a(beam_id);
        arrayremovevalue(level.active_beams, s_beam, 0);
    }
    if (isdefined(s_beam)) {
        s_beam notify(#"kill");
        beamkill(localclientnum, s_beam.beam_id);
    }
}

// Namespace beam/beam_shared
// Params 5, eflags: 0x4
// Checksum 0x819cea86, Offset: 0x5a0
// Size: 0x122
function private _new_beam(ent_1, str_tag1, ent_2, str_tag2, str_beam_type) {
    if (!isdefined(self.active_beams)) {
        self.active_beams = [];
    }
    s_beam = spawnstruct();
    s_beam.ent_1 = ent_1;
    s_beam.str_tag1 = str_tag1;
    s_beam.ent_2 = ent_2;
    s_beam.str_tag2 = str_tag2;
    s_beam.str_beam_type = str_beam_type;
    if (!isdefined(self.active_beams)) {
        self.active_beams = [];
    } else if (!isarray(self.active_beams)) {
        self.active_beams = array(self.active_beams);
    }
    self.active_beams[self.active_beams.size] = s_beam;
    return s_beam;
}

// Namespace beam/beam_shared
// Params 5, eflags: 0x4
// Checksum 0x4378f037, Offset: 0x6d0
// Size: 0x110
function private _get_beam(ent_1, str_tag1, ent_2, str_tag2, str_beam_type) {
    if (isdefined(self.active_beams)) {
        foreach (s_beam in self.active_beams) {
            if (s_beam.ent_1 == ent_1 && s_beam.str_tag1 == str_tag1 && s_beam.ent_2 == ent_2 && s_beam.str_tag2 == str_tag2 && s_beam.str_beam_type == str_beam_type) {
                return s_beam;
            }
        }
    }
}

// Namespace beam/beam_shared
// Params 1, eflags: 0x4
// Checksum 0x8e5f694c, Offset: 0x7e8
// Size: 0x9a
function private function_3c6840a(beam_id) {
    if (isdefined(level.active_beams)) {
        foreach (s_beam in level.active_beams) {
            if (s_beam.beam_id === beam_id) {
                return s_beam;
            }
        }
    }
}

// Namespace beam/beam_shared
// Params 4, eflags: 0x4
// Checksum 0x3389c578, Offset: 0x890
// Size: 0xac
function private _kill_on_ent_death(localclientnum, s_beam, ent_1, ent_2) {
    s_beam endon(#"kill");
    util::waittill_any_ents(ent_1, "death", ent_2, "death");
    if (isdefined(self)) {
        arrayremovevalue(self.active_beams, s_beam, 0);
        beamkill(localclientnum, s_beam.beam_id);
    }
}

