#using scripts/core_common/callbacks_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace beam;

// Namespace beam/beam_shared
// Params 5, eflags: 0x0
// Checksum 0x19969eb, Offset: 0x118
// Size: 0x1d4
function launch(ent_1, str_tag1, ent_2, str_tag2, str_beam_type) {
    s_beam = _get_beam(ent_1, str_tag1, ent_2, str_tag2, str_beam_type);
    if (!isdefined(s_beam)) {
        s_beam = _new_beam(ent_1, str_tag1, ent_2, str_tag2, str_beam_type);
    }
    if (self == level) {
        if (isdefined(level.localplayers)) {
            foreach (player in level.localplayers) {
                if (isdefined(player)) {
                    player launch(ent_1, str_tag1, ent_2, str_tag2, str_beam_type);
                }
            }
        }
        return;
    }
    if (isdefined(s_beam)) {
        s_beam.beam_id = beamlaunch(self.localclientnum, ent_1, str_tag1, ent_2, str_tag2, str_beam_type);
        self thread _kill_on_ent_death(s_beam, ent_1, ent_2);
        return s_beam.beam_id;
    }
}

// Namespace beam/beam_shared
// Params 5, eflags: 0x0
// Checksum 0xf0d1a7fe, Offset: 0x2f8
// Size: 0x19c
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
// Params 5, eflags: 0x4
// Checksum 0x1707a814, Offset: 0x4a0
// Size: 0x14e
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
// Checksum 0x3a5147ab, Offset: 0x5f8
// Size: 0x12c
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
// Params 3, eflags: 0x4
// Checksum 0xfbb99981, Offset: 0x730
// Size: 0xb4
function private _kill_on_ent_death(s_beam, ent_1, ent_2) {
    s_beam endon(#"kill");
    self endon(#"death");
    util::waittill_any_ents(ent_1, "death", ent_2, "death");
    if (isdefined(self)) {
        arrayremovevalue(self.active_beams, s_beam, 0);
        beamkill(self.localclientnum, s_beam.beam_id);
    }
}

