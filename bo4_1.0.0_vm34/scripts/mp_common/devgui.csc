#using scripts\core_common\system_shared;

#namespace mp_devgui;

// Namespace mp_devgui/devgui
// Params 0, eflags: 0x2
// Checksum 0x6642ff6a, Offset: 0x70
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"mp_devgui", &__init__, undefined, undefined);
}

// Namespace mp_devgui/devgui
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0xb8
// Size: 0x4
function __init__() {
    
}

/#

    // Namespace mp_devgui/devgui
    // Params 1, eflags: 0x0
    // Checksum 0x2b64dd5f, Offset: 0xc8
    // Size: 0x4e
    function remove_mp_contracts_devgui(localclientnum) {
        if (level.mp_contracts_devgui_added === 1) {
            /#
                adddebugcommand(localclientnum, "<dev string:x30>");
            #/
            level.mp_contracts_devgui_added = undefined;
        }
    }

    // Namespace mp_devgui/devgui
    // Params 1, eflags: 0x0
    // Checksum 0x33971c6d, Offset: 0x120
    // Size: 0x112
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
    // Checksum 0x9d23d710, Offset: 0x240
    // Size: 0x436
    function add_blackjack_contract(localclientnum) {
        root = "<dev string:x4e>";
        next_cmd = "<dev string:x75>";
        add_blackjack_contract_set_count(localclientnum, root, 0);
        add_blackjack_contract_set_count(localclientnum, root, 1);
        add_blackjack_contract_set_count(localclientnum, root, 5);
        add_blackjack_contract_set_count(localclientnum, root, 10);
        add_blackjack_contract_set_count(localclientnum, root, 200);
        add_blackjack_contract_set_count(localclientnum, root, 3420);
        root = "<dev string:x78>";
        stat_write = "<dev string:x99>";
        set_blackjack = "<dev string:xbf>";
        cmds = stat_write + "<dev string:xd9>";
        add_devgui_cmd(localclientnum, root + "<dev string:xe2>", cmds);
        cmds = stat_write + "<dev string:xd9>";
        cmds += next_cmd;
        cmds += stat_write + "<dev string:xed>";
        cmds += next_cmd;
        cmds += set_blackjack + "<dev string:x103>";
        cmds += next_cmd;
        cmds += set_blackjack + "<dev string:x10e>";
        add_devgui_cmd(localclientnum, root + "<dev string:x11b>", cmds);
        cmds = stat_write + "<dev string:x130>";
        add_devgui_cmd(localclientnum, root + "<dev string:x139>", cmds);
        cmds = stat_write + "<dev string:x130>";
        cmds += next_cmd;
        cmds += stat_write + "<dev string:xed>";
        cmds += next_cmd;
        cmds += set_blackjack + "<dev string:x146>";
        cmds += next_cmd;
        cmds += set_blackjack + "<dev string:x10e>";
        add_devgui_cmd(localclientnum, root + "<dev string:x154>", cmds);
        side_bet_root = "<dev string:x16b>";
        stat_write_bjc = "<dev string:x196>";
        stat_write_bjc_master = "<dev string:x1c8>";
        for (i = 0; i <= 6; i++) {
            cmds = stat_write_bjc + "<dev string:x1fd>" + i;
            cmds += next_cmd;
            cmds += stat_write_bjc + "<dev string:x208>" + i;
            cmds += next_cmd;
            cmds += stat_write_bjc_master + "<dev string:x1fd>" + (i == 6 ? 1 : 0);
            cmds += next_cmd;
            cmds += stat_write_bjc_master + "<dev string:x208>" + (i == 6 ? 1 : 0);
            add_devgui_cmd(localclientnum, side_bet_root + "<dev string:x218>" + i, cmds);
        }
    }

    // Namespace mp_devgui/devgui
    // Params 3, eflags: 0x0
    // Checksum 0xbd400fce, Offset: 0x680
    // Size: 0xa4
    function add_blackjack_contract_set_count(localclientnum, root, contract_count) {
        cmds = "<dev string:x225>" + contract_count;
        item_text = contract_count == 1 ? "<dev string:x24c>" : "<dev string:x256>";
        add_devgui_cmd(localclientnum, root + "<dev string:x261>" + contract_count + item_text + "<dev string:x266>" + contract_count, cmds);
    }

    // Namespace mp_devgui/devgui
    // Params 2, eflags: 0x0
    // Checksum 0xaa0d03f6, Offset: 0x730
    // Size: 0x5d4
    function add_contract_slot(localclientnum, slot) {
        root = "<dev string:x268>" + slot;
        add_weekly = 1;
        add_daily = 1;
        switch (slot) {
        case 0:
            root += "<dev string:x282>";
            add_daily = 0;
            break;
        case 1:
            root += "<dev string:x28e>";
            add_daily = 0;
            break;
        case 2:
            root += "<dev string:x29a>";
            add_weekly = 0;
            break;
        default:
            root += "<dev string:x2a3>";
            break;
        }
        root += "<dev string:x266>" + slot + "<dev string:x2b1>";
        table = #"gamedata/tables/mp/mp_contracttable.csv";
        num_rows = tablelookuprowcount(table);
        stat_write = "<dev string:x2b3>" + slot;
        next_cmd = "<dev string:x75>";
        max_title_width = 30;
        ellipsis = "<dev string:x2cb>";
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
                submenu_name = title + "<dev string:x2cf>" + table_index + "<dev string:x2d2>";
                challenge_type = is_weekly_index ? "<dev string:x2d4>" : "<dev string:x2e6>";
                cmds = stat_write + "<dev string:x2f7>" + table_index;
                cmds += next_cmd;
                cmds += stat_write + "<dev string:x2ff>";
                cmds += next_cmd;
                cmds += stat_write + "<dev string:x30b>";
                cmds += next_cmd;
                cmds += stat_write + "<dev string:x315>";
                cmds += next_cmd;
                cmds += "<dev string:x324>";
                cmds = wrap_dvarconfig_cmds(cmds);
                if (add_daily && add_weekly) {
                    by_index_name = "<dev string:x345>";
                } else if (add_daily) {
                    by_index_name = "<dev string:x35b>";
                } else if (add_weekly) {
                    by_index_name = "<dev string:x373>";
                } else {
                    by_index_name = "<dev string:x38c>";
                }
                index_submenu_name = submenu_name + "<dev string:x266>" + table_index;
                add_devgui_cmd(localclientnum, root + challenge_type + submenu_name, cmds);
                add_devgui_cmd(localclientnum, root + by_index_name + index_submenu_name, cmds);
                cmds_added++;
                if (cmds_added >= max_cmd_to_add) {
                    wait 0.1;
                    cmds_added = 0;
                }
            }
        }
        cmds = stat_write + "<dev string:x2ff>";
        cmds += next_cmd;
        cmds += stat_write + "<dev string:x315>";
        add_devgui_cmd(localclientnum, root + "<dev string:x39e>", cmds);
    }

    // Namespace mp_devgui/devgui
    // Params 1, eflags: 0x0
    // Checksum 0x843b0a17, Offset: 0xd10
    // Size: 0x29c
    function add_devgui_scheduler(localclientnum) {
        root = "<dev string:x3af>";
        root_daily = root + "<dev string:x3cf>";
        add_contract_scheduler_daily_duration(localclientnum, root_daily, "<dev string:x3e5>", 86400);
        add_contract_scheduler_daily_duration(localclientnum, root_daily, "<dev string:x3f9>", 1);
        add_contract_scheduler_daily_duration(localclientnum, root_daily, "<dev string:x406>", 3);
        add_contract_scheduler_daily_duration(localclientnum, root_daily, "<dev string:x416>", 10);
        add_contract_scheduler_daily_duration(localclientnum, root_daily, "<dev string:x424>", 60);
        add_contract_scheduler_daily_duration(localclientnum, root_daily, "<dev string:x431>", 120);
        add_contract_scheduler_daily_duration(localclientnum, root_daily, "<dev string:x43f>", 600);
        add_contract_scheduler_daily_duration(localclientnum, root_daily, "<dev string:x44d>", 1800);
        add_contract_scheduler_daily_duration(localclientnum, root_daily, "<dev string:x459>", 3600);
        cmds = "<dev string:x464>";
        add_watched_devgui_cmd(localclientnum, root + "<dev string:x486>", cmds);
        cmds = "<dev string:x497>";
        add_watched_devgui_cmd(localclientnum, root + "<dev string:x4bd>", cmds);
        cmds = "<dev string:x4c9>";
        add_watched_devgui_cmd(localclientnum, root + "<dev string:x4ee>", cmds);
        cmds = "<dev string:x4f9>";
        add_watched_devgui_cmd(localclientnum, root + "<dev string:x51e>", cmds);
        cmds = "<dev string:x52d>";
        add_watched_devgui_cmd(localclientnum, root + "<dev string:x553>", cmds);
    }

    // Namespace mp_devgui/devgui
    // Params 3, eflags: 0x0
    // Checksum 0xd9bc5233, Offset: 0xfb8
    // Size: 0x6c
    function add_watched_devgui_cmd(localclientnum, root, cmds) {
        next_cmd = "<dev string:x75>";
        cmds += next_cmd;
        cmds += "<dev string:x563>";
        add_devgui_cmd(localclientnum, root, cmds);
    }

    // Namespace mp_devgui/devgui
    // Params 4, eflags: 0x0
    // Checksum 0x4197ba88, Offset: 0x1030
    // Size: 0xb4
    function add_contract_scheduler_daily_duration(localclientnum, root, label, daily_duration) {
        next_cmd = "<dev string:x75>";
        cmds = "<dev string:x585>" + daily_duration;
        cmds += next_cmd;
        cmds += "<dev string:x5a3>";
        cmds = wrap_dvarconfig_cmds(cmds);
        add_devgui_cmd(localclientnum, root + label, cmds);
    }

    // Namespace mp_devgui/devgui
    // Params 1, eflags: 0x0
    // Checksum 0x920cf731, Offset: 0x10f0
    // Size: 0x58
    function wrap_dvarconfig_cmds(cmds) {
        next_cmd = "<dev string:x75>";
        newcmds = "<dev string:x5c4>";
        newcmds += next_cmd;
        newcmds += cmds;
        return newcmds;
    }

    // Namespace mp_devgui/devgui
    // Params 3, eflags: 0x0
    // Checksum 0xc2900b07, Offset: 0x1150
    // Size: 0x64
    function add_devgui_cmd(localclientnum, menu_path, cmds) {
        /#
            adddebugcommand(localclientnum, "<dev string:x5dc>" + menu_path + "<dev string:x5e9>" + cmds + "<dev string:x5ed>");
        #/
    }

    // Namespace mp_devgui/devgui
    // Params 1, eflags: 0x0
    // Checksum 0xa0a42784, Offset: 0x11c0
    // Size: 0xe0
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
    // Checksum 0x6920a004, Offset: 0x12a8
    // Size: 0x2c0
    function watch_devgui() {
        level notify(#"watch_devgui_client_mp_singleton");
        level endon(#"watch_devgui_client_mp_singleton");
        while (true) {
            wait 0.1;
            if (!dvar_has_value("<dev string:x5f0>")) {
                continue;
            }
            saved_dvarconfigenabled = getdvarint(#"dvarconfigenabled", 1);
            if (dvar_has_value("<dev string:x60c>")) {
                setdvar(#"dvarconfigenabled", 0);
                now = getutc();
                setdvar(#"contracts_start_time", calculate_schedule_start_time(now));
                clear_dvar("<dev string:x60c>");
            }
            if (dvar_has_value("<dev string:x628>")) {
                update_contract_start_time(-1);
                clear_dvar("<dev string:x628>");
            }
            if (dvar_has_value("<dev string:x647>")) {
                update_contract_start_time(-7);
                clear_dvar("<dev string:x647>");
            }
            if (dvar_has_value("<dev string:x667>")) {
                update_contract_start_time(1);
                clear_dvar("<dev string:x667>");
            }
            if (dvar_has_value("<dev string:x686>")) {
                update_contract_start_time(7);
                clear_dvar("<dev string:x686>");
            }
            if (saved_dvarconfigenabled != getdvarint(#"dvarconfigenabled", 1)) {
                setdvar(#"dvarconfigenabled", saved_dvarconfigenabled);
            }
            clear_dvar("<dev string:x5f0>");
        }
    }

    // Namespace mp_devgui/devgui
    // Params 1, eflags: 0x0
    // Checksum 0xcb5ba53, Offset: 0x1570
    // Size: 0xac
    function update_contract_start_time(delta_days) {
        setdvar(#"dvarconfigenabled", 0);
        start_time = get_schedule_start_time();
        daily_duration = getdvarint(#"contracts_daily_duration", 60);
        setdvar(#"contracts_start_time", start_time + daily_duration * delta_days);
    }

    // Namespace mp_devgui/devgui
    // Params 1, eflags: 0x0
    // Checksum 0xc4565b26, Offset: 0x1628
    // Size: 0x30
    function dvar_has_value(dvar_name) {
        return getdvarint(dvar_name, 0) != 0;
    }

    // Namespace mp_devgui/devgui
    // Params 1, eflags: 0x0
    // Checksum 0x141d991a, Offset: 0x1660
    // Size: 0x2c
    function clear_dvar(dvar_name) {
        setdvar(dvar_name, 0);
    }

    // Namespace mp_devgui/devgui
    // Params 0, eflags: 0x0
    // Checksum 0xb31affcd, Offset: 0x1698
    // Size: 0x34
    function get_schedule_start_time() {
        return getdvarint(#"contracts_start_time", 1463418000);
    }

#/