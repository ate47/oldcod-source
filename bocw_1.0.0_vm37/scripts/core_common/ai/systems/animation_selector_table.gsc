#namespace animationselectortable;

// Namespace animationselectortable/animation_selector_table
// Params 2, eflags: 0x0
// Checksum 0x70cf9048, Offset: 0x60
// Size: 0xa4
function registeranimationselectortableevaluator(functionname, functionptr) {
    if (!isdefined(level._astevaluatorscriptfunctions)) {
        level._astevaluatorscriptfunctions = [];
    }
    functionname = tolower(functionname);
    assert(isdefined(functionname) && isdefined(functionptr));
    assert(!isdefined(level._astevaluatorscriptfunctions[functionname]));
    level._astevaluatorscriptfunctions[functionname] = functionptr;
}

