#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace sensor_dart;

// Namespace sensor_dart/sensor_dart
// Params 0, eflags: 0x2
// Checksum 0x68cef3b8, Offset: 0x1b0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"sensor_dart", &init_shared, undefined, undefined);
}

// Namespace sensor_dart/sensor_dart
// Params 1, eflags: 0x0
// Checksum 0xcbafe32, Offset: 0x1f8
// Size: 0xd4
function init_shared(localclientnum) {
    clientfield::register("missile", "sensor_dart_state", 1, 1, "int", &function_f2f73936, 0, 1);
    clientfield::register("clientuimodel", "hudItems.sensorDartCount", 1, 3, "int", undefined, 0, 0);
    callback::on_localclient_connect(&player_init);
    callback::add_weapon_type("eq_sensor", &arrow_spawned);
}

// Namespace sensor_dart/sensor_dart
// Params 1, eflags: 0x0
// Checksum 0xeed827a5, Offset: 0x2d8
// Size: 0x1a
function arrow_spawned(localclientnum) {
    self.var_519dd23d = 1;
}

// Namespace sensor_dart/sensor_dart
// Params 1, eflags: 0x0
// Checksum 0x4a24d06a, Offset: 0x300
// Size: 0x24
function player_init(localclientnum) {
    self thread on_game_ended(localclientnum);
}

// Namespace sensor_dart/sensor_dart
// Params 7, eflags: 0x4
// Checksum 0xb4d7f457, Offset: 0x330
// Size: 0x12a
function private function_f2f73936(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"death");
    self util::waittill_dobj(localclientnum);
    if (!isdefined(self)) {
        return;
    }
    self function_f7c35f0();
    switch (newval) {
    case 0:
    default:
        self disablevisioncircle(localclientnum);
        break;
    case 1:
        self thread function_fb404fbf(localclientnum);
        self thread function_951e795e(localclientnum);
        self hideunseencompassicon();
        break;
    }
}

// Namespace sensor_dart/sensor_dart
// Params 1, eflags: 0x4
// Checksum 0xacbbffb6, Offset: 0x468
// Size: 0x84
function private function_fb404fbf(localclientnum) {
    var_e14cea2 = self getentitynumber();
    self waittill(#"death");
    if (isdefined(self.var_4c83d9f3)) {
        self.var_4c83d9f3 delete();
    }
    disablevisioncirclebyentnum(localclientnum, var_e14cea2);
}

// Namespace sensor_dart/sensor_dart
// Params 1, eflags: 0x4
// Checksum 0x5c4834f0, Offset: 0x4f8
// Size: 0x534
function private function_951e795e(localclientnum) {
    self setcompassicon("minimap_sensor_dart_flying");
    self function_f7c35f0();
    self function_7e82a7e7(#"neutral");
    self thread function_bd77a3b7(localclientnum, "o_recon_sensor_gun_projectile_closed_idle");
    var_e14cea2 = self getentitynumber();
    self endon(#"death");
    flystarttime = getservertime(localclientnum);
    startorigin = self.origin;
    var_6214e21a = startorigin;
    var_6ba67aef = 0;
    localplayer = function_f97e7787(localclientnum);
    self.var_4c83d9f3 = spawn(localclientnum, self.origin, "script_model", localplayer getentitynumber(), self.team);
    self.var_4c83d9f3 setmodel(#"tag_origin");
    self.var_4c83d9f3 linkto(self);
    self.var_4c83d9f3 setcompassicon("minimap_sensor_dart_pip");
    self.var_4c83d9f3 function_f7c35f0();
    self.var_4c83d9f3 function_ac5d3a50(0.25);
    self.var_4c83d9f3 function_7e82a7e7(#"neutral");
    while (var_6ba67aef < 250) {
        var_6214e21a = self.origin;
        var_4b248252 = getservertime(localclientnum);
        elapsedtime = var_4b248252 - flystarttime;
        if (true) {
            var_100dc6fc = math::clamp(elapsedtime / 500, 0, 1);
            radius = lerpfloat(200, 600, var_100dc6fc);
            distance = distance2d(self.origin, startorigin);
            if (distance > 200) {
                self.angles = vectortoangles(self.origin - startorigin);
                var_6c4bc2af = atan(radius / distance);
                if (var_6ba67aef > 0) {
                    var_6c4bc2af *= (250 - var_6ba67aef) / 250;
                    self function_ac5d3a50(0);
                } else {
                    self function_ac5d3a50(radius / 200 * 0.6);
                }
                self enablevisioncircle(localclientnum, distance, 1, var_6c4bc2af * 2);
            }
        }
        waitframe(1);
        if (var_6214e21a == self.origin) {
            var_6ba67aef = var_6ba67aef + getservertime(localclientnum) - var_4b248252;
            continue;
        }
        var_6ba67aef = 0;
    }
    if (isdefined(self.var_4c83d9f3)) {
        self.var_4c83d9f3 delete();
    }
    self setcompassicon("minimap_sensor_dart");
    self function_f7c35f0();
    self function_ac5d3a50(0.62);
    self enablevisioncircle(localclientnum, sessionmodeiswarzonegame() ? 2400 : 800, 1);
    self thread function_bd77a3b7(localclientnum, "o_recon_sensor_gun_projectile_open", "o_recon_sensor_gun_projectile_closed_idle");
    self thread function_a6b3feb(localclientnum);
}

// Namespace sensor_dart/sensor_dart
// Params 1, eflags: 0x4
// Checksum 0x864a04cd, Offset: 0xa38
// Size: 0x3c
function private on_game_ended(localclientnum) {
    level waittill(#"game_ended");
    disableallvisioncircles(localclientnum);
}

// Namespace sensor_dart/sensor_dart
// Params 3, eflags: 0x0
// Checksum 0x58ca288f, Offset: 0xa80
// Size: 0xcc
function function_bd77a3b7(localclientnum, animname, prevanim) {
    self endon(#"death");
    self util::waittill_dobj(localclientnum);
    self useanimtree("generic");
    self setanimrestart(animname, 1, 0, 1);
    if (isdefined(prevanim)) {
        self setanimrestart(prevanim, 0, 0, 1);
    }
}

// Namespace sensor_dart/sensor_dart
// Params 1, eflags: 0x0
// Checksum 0xa2b14190, Offset: 0xb58
// Size: 0x54
function function_a6b3feb(localclientnum) {
    self endon(#"death");
    self waittill(#"finished_opening");
    self thread function_bd77a3b7(localclientnum, "o_recon_sensor_gun_projectile_open_idle");
}

