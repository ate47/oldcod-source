#using scripts\core_common\util_shared;

#namespace beam;

// Namespace beam/beam_shared
// Params 6, eflags: 0x0
// Checksum 0x30929f02, Offset: 0x78
// Size: 0x1c0
function launch(ent_1, str_tag1, ent_2, str_tag2, str_beam_type, var_ee0708f0) {
    s_beam = _get_beam(ent_1, str_tag1, ent_2, str_tag2, str_beam_type);
    if (!isdefined(s_beam)) {
        s_beam = _new_beam(ent_1, str_tag1, ent_2, str_tag2, str_beam_type);
    }
    if (self == level) {
        if (isdefined(level.localplayers)) {
            foreach (player in level.localplayers) {
                if (isdefined(player)) {
                    beam_id = player launch(ent_1, str_tag1, ent_2, str_tag2, str_beam_type);
                    if (!is_true(var_ee0708f0)) {
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
// Checksum 0xbf1a0b5a, Offset: 0x240
// Size: 0xe4
function function_cfb2f62a(localclientnum, ent_1, str_tag1, ent_2, str_tag2, str_beam_type) {
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
// Checksum 0xed69e68f, Offset: 0x330
// Size: 0x174
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
// Checksum 0x41e9e524, Offset: 0x4b0
// Size: 0x9c
function function_47deed80(localclientnum, beam_id) {
    if (isdefined(level.active_beams)) {
        s_beam = function_1c0feeb0(beam_id);
        arrayremovevalue(level.active_beams, s_beam, 0);
    }
    if (isdefined(s_beam)) {
        s_beam notify(#"kill");
        beamkill(localclientnum, s_beam.beam_id);
    }
}

// Namespace beam/beam_shared
// Params 5, eflags: 0x4
// Checksum 0x925a02e7, Offset: 0x558
// Size: 0x108
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
// Checksum 0x635ab3f1, Offset: 0x668
// Size: 0x110
function private _get_beam(ent_1, str_tag1, ent_2, str_tag2, str_beam_type) {
    if (isdefined(self.active_beams)) {
        foreach (s_beam in self.active_beams) {
            if (s_beam.ent_1 === ent_1 && s_beam.str_tag1 === str_tag1 && s_beam.ent_2 === ent_2 && s_beam.str_tag2 === str_tag2 && s_beam.str_beam_type === str_beam_type) {
                return s_beam;
            }
        }
    }
}

// Namespace beam/beam_shared
// Params 1, eflags: 0x4
// Checksum 0x4419d82f, Offset: 0x780
// Size: 0xa6
function private function_1c0feeb0(beam_id) {
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
// Checksum 0xd5108f01, Offset: 0x830
// Size: 0xac
function private _kill_on_ent_death(localclientnum, s_beam, ent_1, ent_2) {
    s_beam endon(#"kill");
    util::waittill_any_ents(ent_1, "death", ent_2, "death");
    if (isdefined(self)) {
        arrayremovevalue(self.active_beams, s_beam, 0);
        beamkill(localclientnum, s_beam.beam_id);
    }
}

