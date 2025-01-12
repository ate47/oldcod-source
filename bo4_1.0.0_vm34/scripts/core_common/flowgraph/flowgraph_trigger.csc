#using scripts\core_common\flowgraph\flowgraph_core;

#namespace flowgraph_trigger;

// Namespace flowgraph_trigger/flowgraph_trigger
// Params 2, eflags: 0x0
// Checksum 0xa8060a30, Offset: 0x70
// Size: 0xa0
function ontriggerentered(x, e_trigger) {
    e_trigger endon(#"death");
    while (true) {
        waitresult = e_trigger waittill(#"trigger");
        e_entity = waitresult.activator;
        self flowgraph::kick(array(1, e_entity));
    }
}

