#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\ai\zombie_utility;

#namespace zm_towers_util;

// Namespace zm_towers_util/zm_towers_util
// Params 3, eflags: 0x0
// Checksum 0xf305e66a, Offset: 0x78
// Size: 0x1ec
function function_ebdff9e5(var_999c9434 = 75, var_a7df3d1d = 75, var_ad5e202b = 75) {
    if (isdefined(self.no_gib) && self.no_gib) {
        return;
    }
    val = randomint(100);
    if (val > 100 - var_999c9434) {
        self zombie_utility::zombie_head_gib();
    }
    val = randomint(100);
    if (val > 100 - var_a7df3d1d) {
        if (!gibserverutils::isgibbed(self, 32)) {
            gibserverutils::gibrightarm(self);
        }
    }
    val = randomint(100);
    if (val > 100 - var_a7df3d1d) {
        if (!gibserverutils::isgibbed(self, 16)) {
            gibserverutils::gibleftarm(self);
        }
    }
    val = randomint(100);
    if (val > 100 - var_ad5e202b) {
        gibserverutils::gibrightleg(self);
    }
    val = randomint(100);
    if (val > 100 - var_ad5e202b) {
        gibserverutils::gibleftleg(self);
    }
}

// Namespace zm_towers_util/zm_towers_util
// Params 0, eflags: 0x0
// Checksum 0x3a987fb2, Offset: 0x270
// Size: 0x178
function function_9f66d3bc() {
    while (isdefined(self)) {
        waittime = randomfloatrange(2.5, 5);
        yaw = randomint(360);
        if (yaw > 300) {
            yaw = 300;
        } else if (yaw < 60) {
            yaw = 60;
        }
        yaw = self.angles[1] + yaw;
        new_angles = (-60 + randomint(120), yaw, -45 + randomint(90));
        self rotateto(new_angles, waittime, waittime * 0.5, waittime * 0.5);
        if (isdefined(self.worldgundw)) {
            self.worldgundw rotateto(new_angles, waittime, waittime * 0.5, waittime * 0.5);
        }
        wait randomfloat(waittime - 0.1);
    }
}

