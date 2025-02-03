#using script_5de8a8ac9320a0bf;
#using scripts\core_common\system_shared;

#namespace mp_devgui;

// Namespace mp_devgui/devgui
// Params 0, eflags: 0x6
// Checksum 0x80b9d364, Offset: 0x70
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"mp_devgui", &preinit, undefined, undefined, undefined);
}

// Namespace mp_devgui/devgui
// Params 0, eflags: 0x4
// Checksum 0x4938c2a2, Offset: 0xb8
// Size: 0x1c
function private preinit() {
    level.var_f9f04b00 = debug_center_screen::register();
}

/#

    // Namespace mp_devgui/devgui
    // Params 1, eflags: 0x0
    // Checksum 0xbbb96d11, Offset: 0xe0
    // Size: 0x4e
    function remove_mp_contracts_devgui(localclientnum) {
        if (level.mp_contracts_devgui_added === 1) {
            /#
                adddebugcommand(localclientnum, "<dev string:x38>");
            #/
            level.mp_contracts_devgui_added = undefined;
        }
    }

    // Namespace mp_devgui/devgui
    // Params 1, eflags: 0x0
    // Checksum 0x952c340f, Offset: 0x138
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
    // Checksum 0x8278009d, Offset: 0x258
    // Size: 0x3bc
    function add_blackjack_contract(localclientnum) {
        root = "<dev string:x59>";
        next_cmd = "<dev string:x83>";
        add_blackjack_contract_set_count(localclientnum, root, 0);
        add_blackjack_contract_set_count(localclientnum, root, 1);
        add_blackjack_contract_set_count(localclientnum, root, 5);
        add_blackjack_contract_set_count(localclientnum, root, 10);
        add_blackjack_contract_set_count(localclientnum, root, 200);
        add_blackjack_contract_set_count(localclientnum, root, 3420);
        root = "<dev string:x89>";
        stat_write = "<dev string:xad>";
        set_blackjack = "<dev string:xd6>";
        cmds = stat_write + "<dev string:xf3>";
        add_devgui_cmd(localclientnum, root + "<dev string:xff>", cmds);
        cmds = stat_write + "<dev string:xf3>";
        cmds += next_cmd;
        cmds += stat_write + "<dev string:x10d>";
        cmds += next_cmd;
        cmds += set_blackjack + "<dev string:x126>";
        cmds += next_cmd;
        cmds += set_blackjack + "<dev string:x134>";
        add_devgui_cmd(localclientnum, root + "<dev string:x144>", cmds);
        cmds = stat_write + "<dev string:x15c>";
        add_devgui_cmd(localclientnum, root + "<dev string:x168>", cmds);
        cmds = stat_write + "<dev string:x15c>";
        cmds += next_cmd;
        cmds += stat_write + "<dev string:x10d>";
        cmds += next_cmd;
        cmds += set_blackjack + "<dev string:x178>";
        cmds += next_cmd;
        cmds += set_blackjack + "<dev string:x134>";
        add_devgui_cmd(localclientnum, root + "<dev string:x189>", cmds);
        side_bet_root = "<dev string:x1a3>";
        stat_write_bjc = "<dev string:x1d1>";
        stat_write_bjc_master = "<dev string:x206>";
        for (i = 0; i <= 6; i++) {
            cmds = stat_write_bjc + "<dev string:x23e>" + i;
            cmds += next_cmd;
            cmds += stat_write_bjc + "<dev string:x24c>" + i;
            cmds += next_cmd;
            cmds += stat_write_bjc_master + "<dev string:x23e>" + (i == 6 ? 1 : 0);
            cmds += next_cmd;
            cmds += stat_write_bjc_master + "<dev string:x24c>" + (i == 6 ? 1 : 0);
            add_devgui_cmd(localclientnum, side_bet_root + "<dev string:x25f>" + i, cmds);
        }
    }

    // Namespace mp_devgui/devgui
    // Params 3, eflags: 0x0
    // Checksum 0x7ab338e3, Offset: 0x620
    // Size: 0xa4
    function add_blackjack_contract_set_count(localclientnum, root, contract_count) {
        cmds = "<dev string:x26f>" + contract_count;
        item_text = contract_count == 1 ? "<dev string:x299>" : "<dev string:x2a6>";
        add_devgui_cmd(localclientnum, root + "<dev string:x2b4>" + contract_count + item_text + "<dev string:x2bc>" + contract_count, cmds);
    }

    // Namespace mp_devgui/devgui
    // Params 2, eflags: 0x0
    // Checksum 0xf6ced4df, Offset: 0x6d0
    // Size: 0x584
    function add_contract_slot(localclientnum, slot) {
        root = "<dev string:x2c1>" + slot;
        add_weekly = 1;
        add_daily = 1;
        switch (slot) {
        case 0:
            root += "<dev string:x2de>";
            add_daily = 0;
            break;
        case 1:
            root += "<dev string:x2ed>";
            add_daily = 0;
            break;
        case 2:
            root += "<dev string:x2fc>";
            add_weekly = 0;
            break;
        default:
            root += "<dev string:x308>";
            break;
        }
        root += "<dev string:x2bc>" + slot + "<dev string:x319>";
        table = #"gamedata/tables/mp/mp_contracttable.csv";
        num_rows = tablelookuprowcount(table);
        stat_write = "<dev string:x31e>" + slot;
        next_cmd = "<dev string:x83>";
        max_title_width = 30;
        ellipsis = "<dev string:x339>";
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
                title_str = row_info[4].size < 0 ? row_info[3] : row_info[4];
                title = makelocalizedstring(#"contract_" + title_str);
                if (title.size > max_title_width) {
                    title = getsubstr(title, 0, truncated_title_end_index) + ellipsis;
                }
                submenu_name = title + "<dev string:x340>" + table_index + "<dev string:x346>";
                challenge_type = is_weekly_index ? "<dev string:x34b>" : "<dev string:x360>";
                cmds = stat_write + "<dev string:x374>" + table_index;
                cmds += next_cmd;
                cmds += stat_write + "<dev string:x37f>";
                cmds += next_cmd;
                cmds += stat_write + "<dev string:x38e>";
                cmds += next_cmd;
                cmds += stat_write + "<dev string:x39b>";
                cmds += next_cmd;
                cmds += "<dev string:x3ad>";
                cmds = wrap_dvarconfig_cmds(cmds);
                if (add_daily && add_weekly) {
                    by_index_name = "<dev string:x3d1>";
                } else if (add_daily) {
                    by_index_name = "<dev string:x3ea>";
                } else if (add_weekly) {
                    by_index_name = "<dev string:x405>";
                } else {
                    by_index_name = "<dev string:x421>";
                }
                index_submenu_name = submenu_name + "<dev string:x2bc>" + table_index;
                add_devgui_cmd(localclientnum, root + challenge_type + submenu_name, cmds);
                add_devgui_cmd(localclientnum, root + by_index_name + index_submenu_name, cmds);
                cmds_added++;
                if (cmds_added >= max_cmd_to_add) {
                    wait 0.1;
                    cmds_added = 0;
                }
            }
        }
        cmds = stat_write + "<dev string:x37f>";
        cmds += next_cmd;
        cmds += stat_write + "<dev string:x39b>";
        add_devgui_cmd(localclientnum, root + "<dev string:x436>", cmds);
    }

    // Namespace mp_devgui/devgui
    // Params 1, eflags: 0x0
    // Checksum 0x2e1d4, Offset: 0xc60
    // Size: 0x25c
    function add_devgui_scheduler(localclientnum) {
        root = "<dev string:x44a>";
        root_daily = root + "<dev string:x46d>";
        add_contract_scheduler_daily_duration(localclientnum, root_daily, "<dev string:x486>", 86400);
        add_contract_scheduler_daily_duration(localclientnum, root_daily, "<dev string:x49d>", 1);
        add_contract_scheduler_daily_duration(localclientnum, root_daily, "<dev string:x4ad>", 3);
        add_contract_scheduler_daily_duration(localclientnum, root_daily, "<dev string:x4c0>", 10);
        add_contract_scheduler_daily_duration(localclientnum, root_daily, "<dev string:x4d1>", 60);
        add_contract_scheduler_daily_duration(localclientnum, root_daily, "<dev string:x4e1>", 120);
        add_contract_scheduler_daily_duration(localclientnum, root_daily, "<dev string:x4f2>", 600);
        add_contract_scheduler_daily_duration(localclientnum, root_daily, "<dev string:x503>", 1800);
        add_contract_scheduler_daily_duration(localclientnum, root_daily, "<dev string:x512>", 3600);
        cmds = "<dev string:x520>";
        add_watched_devgui_cmd(localclientnum, root + "<dev string:x545>", cmds);
        cmds = "<dev string:x559>";
        add_watched_devgui_cmd(localclientnum, root + "<dev string:x582>", cmds);
        cmds = "<dev string:x591>";
        add_watched_devgui_cmd(localclientnum, root + "<dev string:x5b9>", cmds);
        cmds = "<dev string:x5c7>";
        add_watched_devgui_cmd(localclientnum, root + "<dev string:x5ef>", cmds);
        cmds = "<dev string:x601>";
        add_watched_devgui_cmd(localclientnum, root + "<dev string:x62a>", cmds);
    }

    // Namespace mp_devgui/devgui
    // Params 3, eflags: 0x0
    // Checksum 0x2a8e3582, Offset: 0xec8
    // Size: 0x64
    function add_watched_devgui_cmd(localclientnum, root, cmds) {
        next_cmd = "<dev string:x83>";
        cmds += next_cmd;
        cmds += "<dev string:x63d>";
        add_devgui_cmd(localclientnum, root, cmds);
    }

    // Namespace mp_devgui/devgui
    // Params 4, eflags: 0x0
    // Checksum 0x9caea672, Offset: 0xf38
    // Size: 0xa4
    function add_contract_scheduler_daily_duration(localclientnum, root, label, daily_duration) {
        next_cmd = "<dev string:x83>";
        cmds = "<dev string:x662>" + daily_duration;
        cmds += next_cmd;
        cmds += "<dev string:x683>";
        cmds = wrap_dvarconfig_cmds(cmds);
        add_devgui_cmd(localclientnum, root + label, cmds);
    }

    // Namespace mp_devgui/devgui
    // Params 1, eflags: 0x0
    // Checksum 0x18edaea4, Offset: 0xfe8
    // Size: 0x50
    function wrap_dvarconfig_cmds(cmds) {
        next_cmd = "<dev string:x83>";
        newcmds = "<dev string:x6a7>";
        newcmds += next_cmd;
        newcmds += cmds;
        return newcmds;
    }

    // Namespace mp_devgui/devgui
    // Params 3, eflags: 0x0
    // Checksum 0xe860def4, Offset: 0x1040
    // Size: 0x64
    function add_devgui_cmd(localclientnum, menu_path, cmds) {
        /#
            adddebugcommand(localclientnum, "<dev string:x6c2>" + menu_path + "<dev string:x6d2>" + cmds + "<dev string:x6d9>");
        #/
    }

    // Namespace mp_devgui/devgui
    // Params 1, eflags: 0x0
    // Checksum 0x9f2ab70, Offset: 0x10b0
    // Size: 0xdc
    function calculate_schedule_start_time(ref_time) {
        new_start_time = ref_time;
        daily_duration = getdvarint(#"contracts_daily_duration", 60);
        weekly_duration = daily_duration * 7;
        schedule_duration = weekly_duration * 8;
        max_multiple = int(ref_time / schedule_duration);
        half_max_multiple = int(max_multiple / 2);
        new_start_time -= half_max_multiple * schedule_duration;
        return new_start_time;
    }

    // Namespace mp_devgui/devgui
    // Params 0, eflags: 0x0
    // Checksum 0xd82dde38, Offset: 0x1198
    // Size: 0x2c0
    function watch_devgui() {
        level notify(#"watch_devgui_client_mp_singleton");
        level endon(#"watch_devgui_client_mp_singleton");
        while (true) {
            wait 0.1;
            if (!dvar_has_value("<dev string:x6df>")) {
                continue;
            }
            saved_dvarconfigenabled = getdvarint(#"dvarconfigenabled", 1);
            if (dvar_has_value("<dev string:x6fe>")) {
                setdvar(#"dvarconfigenabled", 0);
                now = getutc();
                setdvar(#"contracts_start_time", calculate_schedule_start_time(now));
                clear_dvar("<dev string:x6fe>");
            }
            if (dvar_has_value("<dev string:x71d>")) {
                update_contract_start_time(-1);
                clear_dvar("<dev string:x71d>");
            }
            if (dvar_has_value("<dev string:x73f>")) {
                update_contract_start_time(-7);
                clear_dvar("<dev string:x73f>");
            }
            if (dvar_has_value("<dev string:x762>")) {
                update_contract_start_time(1);
                clear_dvar("<dev string:x762>");
            }
            if (dvar_has_value("<dev string:x784>")) {
                update_contract_start_time(7);
                clear_dvar("<dev string:x784>");
            }
            if (saved_dvarconfigenabled != getdvarint(#"dvarconfigenabled", 1)) {
                setdvar(#"dvarconfigenabled", saved_dvarconfigenabled);
            }
            clear_dvar("<dev string:x6df>");
        }
    }

    // Namespace mp_devgui/devgui
    // Params 1, eflags: 0x0
    // Checksum 0xa877b432, Offset: 0x1460
    // Size: 0xac
    function update_contract_start_time(delta_days) {
        setdvar(#"dvarconfigenabled", 0);
        start_time = get_schedule_start_time();
        daily_duration = getdvarint(#"contracts_daily_duration", 60);
        setdvar(#"contracts_start_time", start_time + daily_duration * delta_days);
    }

    // Namespace mp_devgui/devgui
    // Params 1, eflags: 0x0
    // Checksum 0xdf5ae71e, Offset: 0x1518
    // Size: 0x30
    function dvar_has_value(dvar_name) {
        return getdvarint(dvar_name, 0) != 0;
    }

    // Namespace mp_devgui/devgui
    // Params 1, eflags: 0x0
    // Checksum 0xed10849c, Offset: 0x1550
    // Size: 0x2c
    function clear_dvar(dvar_name) {
        setdvar(dvar_name, 0);
    }

    // Namespace mp_devgui/devgui
    // Params 0, eflags: 0x0
    // Checksum 0x2273acc3, Offset: 0x1588
    // Size: 0x34
    function get_schedule_start_time() {
        return getdvarint(#"contracts_start_time", 1463418000);
    }

#/
