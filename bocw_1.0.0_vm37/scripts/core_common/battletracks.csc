#using scripts\core_common\clientfield_shared;
#using scripts\core_common\serverfield_shared;
#using scripts\core_common\system_shared;

#namespace battletracks;

// Namespace battletracks/battletracks
// Params 0, eflags: 0x6
// Checksum 0x5216e730, Offset: 0xe0
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"battletracks", &preinit, undefined, undefined, undefined);
}

// Namespace battletracks/battletracks
// Params 0, eflags: 0x4
// Checksum 0xceac0dac, Offset: 0x128
// Size: 0x80
function private preinit() {
    serverfield::register("battletrack_command", 1, 8, "int");
    clientfield::register("toplayer", "battletrack_query", 1, 1, "counter", &battletrack_query, 0, 0);
    level.var_e61d4116 = 0;
}

// Namespace battletracks/battletracks
// Params 7, eflags: 0x4
// Checksum 0xdcf610bb, Offset: 0x1b0
// Size: 0x54
function private battletrack_query(local_client_num, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    self function_afb0648d(bwastimejump);
}

// Namespace battletracks/event_647adea6
// Params 1, eflags: 0x44
// Checksum 0xfc5a070c, Offset: 0x210
// Size: 0xac
function private event_handler[event_647adea6] function_f5ce1afe(eventstruct) {
    if (eventstruct.localclient === 0 && eventstruct.setting_name === "battletrack_enabled") {
        localplayer = function_5c10bd79(eventstruct.localclientnum);
        if (eventstruct.value == 0) {
            localplayer serverfield::set("battletrack_command", 0);
            return;
        }
        localplayer function_afb0648d(eventstruct.localclientnum);
    }
}

// Namespace battletracks/battletracks
// Params 1, eflags: 0x4
// Checksum 0x64380ec9, Offset: 0x2c8
// Size: 0x96
function private function_19cc7a34(local_client_num) {
    var_8209552a = function_ab88dbd2(local_client_num, #"hash_5e14da8a6b550200");
    if (isdefined(var_8209552a)) {
        self.var_9dfb65ba++;
        while (var_8209552a[self.var_9dfb65ba % var_8209552a.size] != 1) {
            self.var_9dfb65ba++;
        }
        self.var_9dfb65ba %= var_8209552a.size;
    }
    self.var_9dfb65ba = 1;
}

// Namespace battletracks/battletracks
// Params 1, eflags: 0x4
// Checksum 0x3c521c49, Offset: 0x368
// Size: 0x9c
function private function_afb0648d(local_client_num) {
    if (!isdefined(self.var_9dfb65ba)) {
        self function_19cc7a34(local_client_num);
    }
    if (isdefined(self.var_9dfb65ba)) {
        serverfield::set("battletrack_command", (self.var_9dfb65ba << 1) + level.var_e61d4116);
        level.var_e61d4116 ^= 1;
    }
    self function_19cc7a34(local_client_num);
}

