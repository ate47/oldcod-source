#using script_152c3f4ffef9e588;
#using script_c8d806d2487b617;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;

#namespace radiation_ui;

// Namespace radiation_ui/radiation_ui
// Params 0, eflags: 0x6
// Checksum 0x987fe69b, Offset: 0x128
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"radiation_ui", &preinit, undefined, undefined, #"radiation");
}

// Namespace radiation_ui/radiation_ui
// Params 0, eflags: 0x4
// Checksum 0x4f7a9241, Offset: 0x178
// Size: 0xe4
function private preinit() {
    if (!namespace_956bd4dd::function_ab99e60c()) {
        return;
    }
    callback::on_spawned(&_on_player_spawned);
    clientfield::register_clientuimodel("hudItems.incursion.radiationDamage", 1, 5, "float");
    clientfield::register_clientuimodel("hudItems.incursion.radiationProtection", 1, 5, "float");
    clientfield::register_clientuimodel("hudItems.incursion.radiationHealth", 1, 5, "float");
    clientfield::register("toplayer", "radiation", 1, 10, "int");
}

// Namespace radiation_ui/radiation_ui
// Params 0, eflags: 0x4
// Checksum 0x5d8e4928, Offset: 0x268
// Size: 0x34
function private _on_player_spawned() {
    if (!namespace_956bd4dd::function_ab99e60c()) {
        return;
    }
    self function_137e7814(self, 0);
}

// Namespace radiation_ui/radiation_ui
// Params 2, eflags: 0x0
// Checksum 0xa478cfa9, Offset: 0x2a8
// Size: 0x13c
function function_59621e3c(player, sickness) {
    if (!namespace_956bd4dd::function_ab99e60c()) {
        return;
    }
    radiationlevel = radiation::function_c9c6dda1(player);
    if (!isdefined(radiationlevel)) {
        assert(0);
        return;
    }
    var_2ba8769e = namespace_956bd4dd::function_6b384c0f(radiationlevel, sickness);
    if (!isdefined(var_2ba8769e)) {
        assert(0);
        return;
    }
    var_d4393988 = player clientfield::get_to_player("radiation");
    var_4e56b794 = var_d4393988 >> 3;
    var_4e56b794 |= 1 << var_2ba8769e;
    var_66bba724 = radiationlevel;
    var_d4393988 = var_4e56b794 << 3 | var_66bba724;
    player clientfield::set_to_player("radiation", var_d4393988);
}

// Namespace radiation_ui/radiation_ui
// Params 2, eflags: 0x0
// Checksum 0x7288cba2, Offset: 0x3f0
// Size: 0x7c
function function_cca7424d(player, percentage) {
    if (!namespace_956bd4dd::function_ab99e60c()) {
        return;
    }
    percentage = max(min(5, percentage), 0);
    player clientfield::set_player_uimodel("hudItems.incursion.radiationProtection", percentage / 5);
}

// Namespace radiation_ui/radiation_ui
// Params 2, eflags: 0x0
// Checksum 0xabe5ea38, Offset: 0x478
// Size: 0x13c
function function_5cf1c0a(player, sickness) {
    if (!namespace_956bd4dd::function_ab99e60c()) {
        return;
    }
    radiationlevel = radiation::function_c9c6dda1(player);
    var_66bba724 = radiationlevel;
    if (!isdefined(radiationlevel)) {
        assert(0);
        return;
    }
    var_2ba8769e = namespace_956bd4dd::function_6b384c0f(radiationlevel, sickness);
    if (!isdefined(var_2ba8769e)) {
        assert(0);
        return;
    }
    var_d4393988 = player clientfield::get_to_player("radiation");
    var_4e56b794 = var_d4393988 >> 3;
    var_4e56b794 &= ~(1 << var_2ba8769e);
    var_d4393988 = var_4e56b794 << 3 | var_66bba724;
    player clientfield::set_to_player("radiation", var_d4393988);
}

// Namespace radiation_ui/radiation_ui
// Params 2, eflags: 0x0
// Checksum 0xb986018b, Offset: 0x5c0
// Size: 0x44
function function_36a2c924(player, var_c49d0215) {
    if (!namespace_956bd4dd::function_ab99e60c()) {
        return;
    }
    player clientfield::set_player_uimodel("hudItems.incursion.radiationDamage", var_c49d0215);
}

// Namespace radiation_ui/radiation_ui
// Params 2, eflags: 0x0
// Checksum 0x25bba67e, Offset: 0x610
// Size: 0xec
function function_137e7814(player, radiationlevel) {
    if (!namespace_956bd4dd::function_ab99e60c()) {
        return;
    }
    var_d4393988 = player clientfield::get_to_player("radiation");
    assert(radiationlevel >= 0);
    assert(radiationlevel < pow(2, 3));
    var_842e1a12 = var_d4393988 >> 3 << 3 | radiationlevel & 8 - 1;
    player clientfield::set_to_player("radiation", var_842e1a12);
}

// Namespace radiation_ui/radiation_ui
// Params 2, eflags: 0x0
// Checksum 0xb608e93, Offset: 0x708
// Size: 0x4c
function function_835a6746(player, var_ac3a86ea) {
    if (!namespace_956bd4dd::function_ab99e60c()) {
        return;
    }
    player clientfield::set_player_uimodel("hudItems.incursion.radiationHealth", 1 - var_ac3a86ea);
}

