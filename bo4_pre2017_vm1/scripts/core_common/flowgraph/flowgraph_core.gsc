#using scripts/core_common/flowgraph/flowgraph_shared;
#using scripts/core_common/system_shared;

#namespace flowgraph;

// Namespace flowgraph/flowgraph_core
// Params 3, eflags: 0x4
// Checksum 0x9366c199, Offset: 0x198
// Size: 0x73e
function private call_func(func, arg_count, args) {
    switch (arg_count) {
    case 16:
        return self [[ func ]](args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7], args[8], args[9], args[10], args[11], args[12], args[13], args[14], args[15]);
    case 15:
        return self [[ func ]](args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7], args[8], args[9], args[10], args[11], args[12], args[13], args[14]);
    case 14:
        return self [[ func ]](args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7], args[8], args[9], args[10], args[11], args[12], args[13]);
    case 13:
        return self [[ func ]](args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7], args[8], args[9], args[10], args[11], args[12]);
    case 12:
        return self [[ func ]](args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7], args[8], args[9], args[10], args[11]);
    case 11:
        return self [[ func ]](args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7], args[8], args[9], args[10]);
    case 10:
        return self [[ func ]](args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7], args[8], args[9]);
    case 9:
        return self [[ func ]](args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7], args[8]);
    case 8:
        return self [[ func ]](args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7]);
    case 7:
        return self [[ func ]](args[0], args[1], args[2], args[3], args[4], args[5], args[6]);
    case 6:
        return self [[ func ]](args[0], args[1], args[2], args[3], args[4], args[5]);
    case 5:
        return self [[ func ]](args[0], args[1], args[2], args[3], args[4]);
    case 4:
        return self [[ func ]](args[0], args[1], args[2], args[3]);
    case 3:
        return self [[ func ]](args[0], args[1], args[2]);
    case 2:
        return self [[ func ]](args[0], args[1]);
    case 1:
        return self [[ func ]](args[0]);
    case 0:
        return self [[ func ]]();
    default:
        /#
            assertmsg("<dev string:x28>");
        #/
        break;
    }
}

// Namespace flowgraph/flowgraph_core
// Params 1, eflags: 0x4
// Checksum 0x24122706, Offset: 0x8e0
// Size: 0x366
function private evaluate_constant(input_def) {
    /#
        assert(isdefined(input_def.constvalue));
    #/
    val = input_def.constvalue;
    switch (input_def.type) {
    case #"array":
    case #"class":
    case #"exec":
    case #"struct":
    case #"variant":
        /#
            assertmsg("<dev string:x4d>");
        #/
        return undefined;
    case #"bool":
    case #"float":
    case #"fx":
    case #"int":
    case #"scriptbundle":
    case #"soundalias":
    case #"string":
    case #"vector":
    case #"weapon":
    case #"xanim":
    case #"xmodel":
        return val;
    case #"entityarray":
        /#
            assert(isstruct(val));
        #/
        /#
            assert(isdefined(val.value));
        #/
        /#
            assert(isdefined(val.key));
        #/
        return getentarray(val.value, val.key);
    case #"ai":
    case #"entity":
    case #"pathnode":
    case #"spawner":
    case #"vehicle":
        /#
            assert(isstruct(val) || isstring(val));
        #/
        if (isstruct(val)) {
            /#
                assert(isdefined(val.value));
            #/
            /#
                assert(isdefined(val.key));
            #/
            return getent(val.value, val.key);
        } else {
            /#
                assert(val == "<dev string:x63>" || val == "<dev string:x68>");
            #/
            if (val == "self") {
                return self.target;
            } else {
                return self.target.target;
            }
        }
        break;
    }
    /#
        assertmsg("<dev string:x74>" + input_def.type + "<dev string:x83>");
    #/
    return undefined;
}

// Namespace flowgraph/flowgraph_core
// Params 2, eflags: 0x4
// Checksum 0xd0b0764f, Offset: 0xc50
// Size: 0x98
function private get_node_output_param_index(node_def, param_name) {
    for (i = 0; i < node_def.outputs.size; i++) {
        if (node_def.outputs[i].name == param_name) {
            return i;
        }
    }
    /#
        assertmsg("<dev string:x85>");
    #/
    return -1;
}

// Namespace flowgraph/flowgraph_core
// Params 2, eflags: 0x4
// Checksum 0x3c5b9dcd, Offset: 0xcf0
// Size: 0x98
function private get_node_input_param_index(node_def, param_name) {
    for (i = 0; i < node_def.inputs.size; i++) {
        if (node_def.inputs[i].name == param_name) {
            return i;
        }
    }
    /#
        assertmsg("<dev string:x85>");
    #/
    return -1;
}

// Namespace flowgraph/flowgraph_core
// Params 1, eflags: 0x4
// Checksum 0xf0b9a397, Offset: 0xd90
// Size: 0x10e
function private is_auto_exec_node(node_def) {
    if (node_def.nodeclass == "event") {
        foreach (input_def in node_def.inputs) {
            if (input_def.type == "exec") {
                if (isdefined(input_def.connections) && input_def.connections.size > 0) {
                    return false;
                }
                continue;
            }
            if (!isdefined(input_def.constvalue)) {
                return false;
            }
        }
        return true;
    }
    return false;
}

// Namespace flowgraph/flowgraph_core
// Params 2, eflags: 0x4
// Checksum 0xacc1fb2e, Offset: 0xea8
// Size: 0x4fa
function private get_graph_def(graph_name, force_refresh) {
    if (!isdefined(force_refresh)) {
        force_refresh = 0;
    }
    if (!isdefined(level.flowgraphdefs)) {
        level.flowgraphdefs = [];
    }
    if (isdefined(level.flowgraphdefs[graph_name]) && !force_refresh) {
        return level.flowgraphdefs[graph_name];
    }
    graph_def = getflowgraphdef(graph_name);
    indexed_nodes = [];
    foreach (node in graph_def.nodes) {
        indexed_nodes[node.uuid] = node;
    }
    graph_def.nodes = indexed_nodes;
    foreach (wire_def in graph_def.wires) {
        output_node = graph_def.nodes[wire_def.outputnodeuuid];
        /#
            assert(isdefined(output_node), "<dev string:x9c>" + graph_name + "<dev string:x83>");
        #/
        input_node = graph_def.nodes[wire_def.inputnodeuuid];
        /#
            assert(isdefined(input_node), "<dev string:x9c>" + graph_name + "<dev string:x83>");
        #/
        output_param_index = get_node_output_param_index(output_node, wire_def.outputparamname);
        input_param_index = get_node_input_param_index(input_node, wire_def.inputparamname);
        output_param = output_node.outputs[output_param_index];
        input_param = input_node.inputs[input_param_index];
        if (!isdefined(output_param.connections)) {
            output_param.connections = [];
        }
        if (!isdefined(input_param.connections)) {
            input_param.connections = [];
        }
        output_link = spawnstruct();
        output_link.node = input_node;
        output_link.paramindex = input_param_index;
        output_param.connections[output_param.connections.size] = output_link;
        input_link = spawnstruct();
        input_link.node = output_node;
        input_link.paramindex = output_param_index;
        input_param.connections[input_param.connections.size] = input_link;
    }
    graph_def.wires = undefined;
    foreach (node in graph_def.nodes) {
        node.is_auto_exec = is_auto_exec_node(node);
    }
    level.flowgraphdefs[graph_name] = graph_def;
    return graph_def;
}

// Namespace flowgraph/flowgraph_core
// Params 0, eflags: 0x4
// Checksum 0x8629752c, Offset: 0x13b0
// Size: 0x82
function private collect_outputs() {
    if (self.def.nodeclass == "data" && self.evaluation_key != self.owner.evaluation_key) {
        self exec();
        self.evaluation_key = self.owner.evaluation_key;
    }
    return self.outputs;
}

// Namespace flowgraph/flowgraph_core
// Params 0, eflags: 0x4
// Checksum 0xb026ada8, Offset: 0x1440
// Size: 0xdc
function private exec() {
    /#
        level endon(#"flowgraph_mychanges");
    #/
    if (self.def.nodeclass != "thread") {
        self notify(#"kill_previous_exec");
        self endon(#"kill_previous_exec");
    }
    inputs = self collect_inputs();
    outputs = self call_func(self.def.func, self.def.inputs.size, inputs);
    if (isdefined(outputs)) {
        self kick(outputs);
    }
}

/#

    // Namespace flowgraph/flowgraph_core
    // Params 0, eflags: 0x4
    // Checksum 0xae5228ca, Offset: 0x1528
    // Size: 0xb4
    function private mychanges_watcher() {
        if (self.target != level) {
            self.target endon(#"death");
            self.target endon(#"delete");
        }
        level waittill("<dev string:xb5>");
        get_graph_def(self.def.name, 1);
        self.target run({#flowgraph_asset:self.def.name});
    }

#/

// Namespace flowgraph/flowgraph_core
// Params 2, eflags: 0x0
// Checksum 0xa08d9669, Offset: 0x15e8
// Size: 0x2cc
function kick(outputs, block) {
    if (!isdefined(block)) {
        block = 0;
    }
    if (!isdefined(outputs)) {
        outputs = [];
    }
    if (!isarray(outputs)) {
        outputs = array(outputs);
    }
    /#
        assert(isarray(outputs), "<dev string:xc9>" + self.def.uuid + "<dev string:xd0>");
    #/
    /#
        assert(outputs.size == self.def.outputs.size, "<dev string:xc9>" + self.def.uuid + "<dev string:xee>" + self.def.outputs.size + "<dev string:x121>");
    #/
    self.outputs = outputs;
    for (i = 0; i < self.def.outputs.size; i++) {
        output_def = self.def.outputs[i];
        if (output_def.type == "exec" && self.outputs[i] && isdefined(output_def.connections)) {
            foreach (connection_def in output_def.connections) {
                self.owner.evaluation_key++;
                node_inst = self.owner.nodes[connection_def.node.uuid];
                if (block) {
                    node_inst exec();
                    continue;
                }
                node_inst thread exec();
            }
        }
    }
}

// Namespace flowgraph/flowgraph_core
// Params 0, eflags: 0x0
// Checksum 0x93218aa2, Offset: 0x18c0
// Size: 0x344
function collect_inputs() {
    inputs = [];
    input_index = 0;
    foreach (input_def in self.def.inputs) {
        if (isdefined(input_def.constvalue)) {
            inputs[input_index] = self evaluate_constant(input_def);
        } else if (isdefined(input_def.connections)) {
            if (input_def.type == "exec") {
                result = 0;
                foreach (connection_def in input_def.connections) {
                    node_inst = self.owner.nodes[connection_def.node.uuid];
                    outputs = node_inst collect_outputs();
                    result = result || outputs[connection_def.paramindex];
                }
                inputs[input_index] = result;
            } else {
                /#
                    assert(input_def.connections.size == 1, "<dev string:x123>" + input_def.name + "<dev string:x134>");
                #/
                connection_def = input_def.connections[0];
                node_inst = self.owner.nodes[connection_def.node.uuid];
                outputs = node_inst collect_outputs();
                result = outputs[connection_def.paramindex];
                inputs[input_index] = result;
            }
        } else if (input_def.type == "exec" && self.def.is_auto_exec) {
            inputs[input_index] = 1;
        } else {
            inputs[input_index] = undefined;
        }
        input_index++;
    }
    return inputs;
}

// Namespace flowgraph/flowgraph_run
// Params 1, eflags: 0x40
// Checksum 0xe9a6025c, Offset: 0x1c10
// Size: 0x2d4
function event_handler[flowgraph_run] run(eventstruct) {
    graph_def = get_graph_def(eventstruct.flowgraph_asset);
    /#
        assert(isdefined(graph_def), "<dev string:x153>" + eventstruct.flowgraph_asset + "<dev string:x83>");
    #/
    graph_inst = spawnstruct();
    graph_inst.def = graph_def;
    graph_inst.nodes = [];
    if (isdefined(self)) {
        graph_inst.target = self;
    } else {
        graph_inst.target = level;
    }
    graph_inst.evaluation_key = 0;
    foreach (node_def in graph_def.nodes) {
        node_inst = spawnstruct();
        node_inst.owner = graph_inst;
        node_inst.def = node_def;
        node_inst.target = graph_inst.target;
        node_inst.evaluation_key = 0;
        graph_inst.nodes[node_inst.def.uuid] = node_inst;
    }
    foreach (node_inst in graph_inst.nodes) {
        if (node_inst.def.is_auto_exec) {
            node_inst thread exec();
        }
    }
    /#
        graph_inst thread mychanges_watcher();
    #/
    graph_inst notify(#"flowgraph_run");
}

