#using scripts/core_common/callbacks_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;

#namespace mp_devgui;

// Namespace mp_devgui/devgui
// Params 0, eflags: 0x2
// Checksum 0x11e1b130, Offset: 0xf0
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("mp_devgui", &__init__, undefined, undefined);
}

// Namespace mp_devgui/devgui
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x130
// Size: 0x4
function __init__() {
    
}

/#

    // Namespace mp_devgui/devgui
    // Params 1, eflags: 0x0
    // Checksum 0x8dcef99e, Offset: 0x140
    // Size: 0x4e
    function remove_mp_contracts_devgui(localclientnum) {
        if (level.mp_contracts_devgui_added === 1) {
            /#
                adddebugcommand(localclientnum, "<dev string:x28>");
            #/
            level.mp_contracts_devgui_added = undefined;
        }
    }

    // Namespace mp_devgui/devgui
    // Params 1, eflags: 0x0
    // Checksum 0x61a236ba, Offset: 0x198
    // Size: 0x114
    function create_mp_contracts_devgui(localclientnum) {
        level notify(#"create_mp_contracts_devgui_singleton");
        level endon(#"create_mp_contracts_devgui_singleton");
        remove_mp_contracts_devgui(localclientnum);
        waitframe(1);
        if (false) {
            return;
        }
        frontend_slots = 3;
        for (slot = 0; slot < frontend_slots; slot++) {
            add_contract_slot(localclientnum, slot);
            wait 0.1;
        }
        wait 0.1;
        add_blackjack_contract(localclientnum);
        wait 0.1;
        add_devgui_scheduler(localclientnum);
        level thread watch_devgui();
        level.mp_contracts_devgui_added = 1;
    }

    // Namespace mp_devgui/devgui
    // Params 1, eflags: 0x0
    // Checksum 0xe87512d8, Offset: 0x2b8
    // Size: 0x476
    function add_blackjack_contract(localclientnum) {
        root = "<dev string:x46>";
        next_cmd = "<dev string:x6d>";
        add_blackjack_contract_set_count(localclientnum, root, 0);
        add_blackjack_contract_set_count(localclientnum, root, 1);
        add_blackjack_contract_set_count(localclientnum, root, 5);
        add_blackjack_contract_set_count(localclientnum, root, 10);
        add_blackjack_contract_set_count(localclientnum, root, 200);
        add_blackjack_contract_set_count(localclientnum, root, 3420);
        root = "<dev string:x70>";
        stat_write = "<dev string:x91>";
        set_blackjack = "<dev string:xb7>";
        cmds = stat_write + "<dev string:xd1>";
        add_devgui_cmd(localclientnum, root + "<dev string:xda>", cmds);
        cmds = stat_write + "<dev string:xd1>";
        cmds += next_cmd;
        cmds += stat_write + "<dev string:xe5>";
        cmds += next_cmd;
        cmds += set_blackjack + "<dev string:xfb>";
        cmds += next_cmd;
        cmds += set_blackjack + "<dev string:x106>";
        add_devgui_cmd(localclientnum, root + "<dev string:x113>", cmds);
        cmds = stat_write + "<dev string:x128>";
        add_devgui_cmd(localclientnum, root + "<dev string:x131>", cmds);
        cmds = stat_write + "<dev string:x128>";
        cmds += next_cmd;
        cmds += stat_write + "<dev string:xe5>";
        cmds += next_cmd;
        cmds += set_blackjack + "<dev string:x13e>";
        cmds += next_cmd;
        cmds += set_blackjack + "<dev string:x106>";
        add_devgui_cmd(localclientnum, root + "<dev string:x14c>", cmds);
        side_bet_root = "<dev string:x163>";
        stat_write_bjc = "<dev string:x18e>";
        stat_write_bjc_master = "<dev string:x1c0>";
        for (i = 0; i <= 6; i++) {
            cmds = stat_write_bjc + "<dev string:x1f5>" + i;
            cmds += next_cmd;
            cmds += stat_write_bjc + "<dev string:x200>" + i;
            cmds += next_cmd;
            cmds += stat_write_bjc_master + "<dev string:x1f5>" + (i == 6 ? 1 : 0);
            cmds += next_cmd;
            cmds += stat_write_bjc_master + "<dev string:x200>" + (i == 6 ? 1 : 0);
            add_devgui_cmd(localclientnum, side_bet_root + "<dev string:x210>" + i, cmds);
        }
    }

    // Namespace mp_devgui/devgui
    // Params 3, eflags: 0x0
    // Checksum 0xe24a410b, Offset: 0x738
    // Size: 0xac
    function add_blackjack_contract_set_count(localclientnum, root, contract_count) {
        cmds = "<dev string:x21d>" + contract_count;
        item_text = contract_count == 1 ? "<dev string:x244>" : "<dev string:x24e>";
        add_devgui_cmd(localclientnum, root + "<dev string:x259>" + contract_count + item_text + "<dev string:x25e>" + contract_count, cmds);
    }

    // Namespace mp_devgui/devgui
    // Params 2, eflags: 0x0
    // Checksum 0x3f81688a, Offset: 0x7f0
    // Size: 0x60c
    function add_contract_slot(localclientnum, slot) {
        root = "<dev string:x260>" + slot;
        add_weekly = 1;
        add_daily = 1;
        switch (slot) {
        case 0:
            root += "<dev string:x27a>";
            add_daily = 0;
            break;
        case 1:
            root += "<dev string:x286>";
            add_daily = 0;
            break;
        case 2:
            root += "<dev string:x292>";
            add_weekly = 0;
            break;
        default:
            root += "<dev string:x29b>";
            break;
        }
        root += "<dev string:x25e>" + slot + "<dev string:x2a9>";
        table = "<dev string:x2ab>";
        num_rows = tablelookuprowcount(table);
        stat_write = "<dev string:x2d3>" + slot;
        next_cmd = "<dev string:x6d>";
        max_title_width = 30;
        ellipsis = "<dev string:x2eb>";
        truncated_title_end_index = max_title_width - ellipsis.size - 1;
        cmds_added = 0;
        max_cmd_to_add = 5;
        for (row = 1; row < num_rows; row++) {
            row_info = tablelookuprow(table, row);
            if (strisnumber(row_info[0])) {
                table_index = int(row_info[0]);
                is_daily_index = table_index >= 1000;
                is_weekly_index = !is_daily_index;
                if (is_daily_index && !add_daily) {
                    continue;
                }
                if (is_weekly_index && !add_weekly) {
                    continue;
                }
                title_str = row_info[4].size > 0 ? row_info[4] : row_info[3];
                title = makelocalizedstring("<dev string:x2ef>" + title_str);
                if (title.size > max_title_width) {
                    title = getsubstr(title, 0, truncated_title_end_index) + ellipsis;
                }
                submenu_name = title + "<dev string:x2f9>" + table_index + "<dev string:x2fc>";
                challenge_type = is_weekly_index ? "<dev string:x2fe>" : "<dev string:x310>";
                cmds = stat_write + "<dev string:x321>" + table_index;
                cmds += next_cmd;
                cmds += stat_write + "<dev string:x329>";
                cmds += next_cmd;
                cmds += stat_write + "<dev string:x335>";
                cmds += next_cmd;
                cmds += stat_write + "<dev string:x33f>";
                cmds += next_cmd;
                cmds += "<dev string:x34e>";
                cmds = wrap_dvarconfig_cmds(cmds);
                if (add_daily && add_weekly) {
                    by_index_name = "<dev string:x36f>";
                } else if (add_daily) {
                    by_index_name = "<dev string:x385>";
                } else if (add_weekly) {
                    by_index_name = "<dev string:x39d>";
                } else {
                    by_index_name = "<dev string:x3b6>";
                }
                index_submenu_name = submenu_name + "<dev string:x25e>" + table_index;
                add_devgui_cmd(localclientnum, root + challenge_type + submenu_name, cmds);
                add_devgui_cmd(localclientnum, root + by_index_name + index_submenu_name, cmds);
                cmds_added++;
                if (cmds_added >= max_cmd_to_add) {
                    wait 0.1;
                    cmds_added = 0;
                }
            }
        }
        cmds = stat_write + "<dev string:x329>";
        cmds += next_cmd;
        cmds += stat_write + "<dev string:x33f>";
        add_devgui_cmd(localclientnum, root + "<dev string:x3c8>", cmds);
    }

    // Namespace mp_devgui/devgui
    // Params 1, eflags: 0x0
    // Checksum 0x49600d3d, Offset: 0xe08
    // Size: 0x2c4
    function add_devgui_scheduler(localclientnum) {
        root = "<dev string:x3d9>";
        root_daily = root + "<dev string:x3f9>";
        add_contract_scheduler_daily_duration(localclientnum, root_daily, "<dev string:x40f>", 86400);
        add_contract_scheduler_daily_duration(localclientnum, root_daily, "<dev string:x423>", 1);
        add_contract_scheduler_daily_duration(localclientnum, root_daily, "<dev string:x430>", 3);
        add_contract_scheduler_daily_duration(localclientnum, root_daily, "<dev string:x440>", 10);
        add_contract_scheduler_daily_duration(localclientnum, root_daily, "<dev string:x44e>", 60);
        add_contract_scheduler_daily_duration(localclientnum, root_daily, "<dev string:x45b>", 120);
        add_contract_scheduler_daily_duration(localclientnum, root_daily, "<dev string:x469>", 600);
        add_contract_scheduler_daily_duration(localclientnum, root_daily, "<dev string:x477>", 1800);
        add_contract_scheduler_daily_duration(localclientnum, root_daily, "<dev string:x483>", 3600);
        cmds = "<dev string:x48e>";
        add_watched_devgui_cmd(localclientnum, root + "<dev string:x4b0>", cmds);
        cmds = "<dev string:x4c1>";
        add_watched_devgui_cmd(localclientnum, root + "<dev string:x4e7>", cmds);
        cmds = "<dev string:x4f3>";
        add_watched_devgui_cmd(localclientnum, root + "<dev string:x518>", cmds);
        cmds = "<dev string:x523>";
        add_watched_devgui_cmd(localclientnum, root + "<dev string:x548>", cmds);
        cmds = "<dev string:x557>";
        add_watched_devgui_cmd(localclientnum, root + "<dev string:x57d>", cmds);
    }

    // Namespace mp_devgui/devgui
    // Params 3, eflags: 0x0
    // Checksum 0x672665f1, Offset: 0x10d8
    // Size: 0x74
    function add_watched_devgui_cmd(localclientnum, root, cmds) {
        next_cmd = "<dev string:x6d>";
        cmds += next_cmd;
        cmds += "<dev string:x58d>";
        add_devgui_cmd(localclientnum, root, cmds);
    }

    // Namespace mp_devgui/devgui
    // Params 4, eflags: 0x0
    // Checksum 0x5000a1c, Offset: 0x1158
    // Size: 0xbc
    function add_contract_scheduler_daily_duration(localclientnum, root, label, daily_duration) {
        next_cmd = "<dev string:x6d>";
        cmds = "<dev string:x5af>" + daily_duration;
        cmds += next_cmd;
        cmds += "<dev string:x5cd>";
        cmds = wrap_dvarconfig_cmds(cmds);
        add_devgui_cmd(localclientnum, root + label, cmds);
    }

    // Namespace mp_devgui/devgui
    // Params 1, eflags: 0x0
    // Checksum 0xf90193c0, Offset: 0x1220
    // Size: 0x5e
    function wrap_dvarconfig_cmds(cmds) {
        next_cmd = "<dev string:x6d>";
        newcmds = "<dev string:x5ee>";
        newcmds += next_cmd;
        newcmds += cmds;
        return newcmds;
    }

    // Namespace mp_devgui/devgui
    // Params 3, eflags: 0x0
    // Checksum 0x9633a810, Offset: 0x1288
    // Size: 0x64
    function add_devgui_cmd(localclientnum, menu_path, cmds) {
        /#
            adddebugcommand(localclientnum, "<dev string:x606>" + menu_path + "<dev string:x613>" + cmds + "<dev string:x617>");
        #/
    }

    // Namespace mp_devgui/devgui
    // Params 1, eflags: 0x0
    // Checksum 0x31cf2cd, Offset: 0x12f8
    // Size: 0xe4
    function calculate_schedule_start_time(ref_time) {
        new_start_time = ref_time;
        daily_duration = getdvarint("<dev string:x61a>", 60);
        weekly_duration = daily_duration * 7;
        schedule_duration = weekly_duration * 8;
        max_multiple = int(ref_time / schedule_duration);
        half_max_multiple = int(max_multiple / 2);
        new_start_time -= half_max_multiple * schedule_duration;
        return new_start_time;
    }

    // Namespace mp_devgui/devgui
    // Params 0, eflags: 0x0
    // Checksum 0x5ff57185, Offset: 0x13e8
    // Size: 0x2a0
    function watch_devgui() {
        level notify(#"watch_devgui_client_mp_singleton");
        level endon(#"watch_devgui_client_mp_singleton");
        while (true) {
            wait 0.1;
            if (!dvar_has_value("<dev string:x633>")) {
                continue;
            }
            saved_dvarconfigenabled = getdvarint("<dev string:x64f>", 1);
            if (dvar_has_value("<dev string:x661>")) {
                setdvar("<dev string:x64f>", 0);
                now = getutc();
                setdvar("<dev string:x67d>", calculate_schedule_start_time(now));
                clear_dvar("<dev string:x661>");
            }
            if (dvar_has_value("<dev string:x692>")) {
                update_contract_start_time(-1);
                clear_dvar("<dev string:x692>");
            }
            if (dvar_has_value("<dev string:x6b1>")) {
                update_contract_start_time(-7);
                clear_dvar("<dev string:x6b1>");
            }
            if (dvar_has_value("<dev string:x6d1>")) {
                update_contract_start_time(1);
                clear_dvar("<dev string:x6d1>");
            }
            if (dvar_has_value("<dev string:x6f0>")) {
                update_contract_start_time(7);
                clear_dvar("<dev string:x6f0>");
            }
            if (saved_dvarconfigenabled != getdvarint("<dev string:x64f>", 1)) {
                setdvar("<dev string:x64f>", saved_dvarconfigenabled);
            }
            clear_dvar("<dev string:x633>");
        }
    }

    // Namespace mp_devgui/devgui
    // Params 1, eflags: 0x0
    // Checksum 0xb2a8920e, Offset: 0x1690
    // Size: 0x9c
    function update_contract_start_time(delta_days) {
        setdvar("<dev string:x64f>", 0);
        start_time = get_schedule_start_time();
        daily_duration = getdvarint("<dev string:x61a>", 60);
        setdvar("<dev string:x67d>", start_time + daily_duration * delta_days);
    }

    // Namespace mp_devgui/devgui
    // Params 1, eflags: 0x0
    // Checksum 0xeddffca3, Offset: 0x1738
    // Size: 0x30
    function dvar_has_value(dvar_name) {
        return getdvarint(dvar_name, 0) != 0;
    }

    // Namespace mp_devgui/devgui
    // Params 1, eflags: 0x0
    // Checksum 0x802e08b0, Offset: 0x1770
    // Size: 0x2c
    function clear_dvar(dvar_name) {
        setdvar(dvar_name, 0);
    }

    // Namespace mp_devgui/devgui
    // Params 0, eflags: 0x0
    // Checksum 0xc231aad0, Offset: 0x17a8
    // Size: 0x2c
    function get_schedule_start_time() {
        return getdvarint("<dev string:x67d>", 1463418000);
    }

#/
