#using script_353c2d42431cf2f6;
#using script_3ce7838ac16eed29;
#using script_442d20a19d1e8890;
#using script_713f934fea43e1fc;
#using script_78825cbb1ab9f493;

#namespace incursion;

// Namespace incursion/gametype_init
// Params 1, eflags: 0x40
// Checksum 0xcf7b97d0, Offset: 0x88
// Size: 0x3c
function event_handler[gametype_init] main(*eventstruct) {
    namespace_17baa64d::init();
    incursion_infiltrationtitlecards::register();
    namespace_85b8212e::function_dd83b835();
}

