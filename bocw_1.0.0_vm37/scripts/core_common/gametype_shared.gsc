#namespace gametype;

// Namespace gametype/gametype_shared
// Params 0, eflags: 0x0
// Checksum 0xc0998b19, Offset: 0xa0
// Size: 0x9c
function init() {
    bundle = function_302bd0b9();
    level.var_d1455682 = bundle;
    if (!isdefined(bundle)) {
        return;
    }
    setvisiblescoreboardcolumns(bundle.scoreboard_1, bundle.scoreboard_2, bundle.scoreboard_3, bundle.scoreboard_4, bundle.scoreboard_5, bundle.var_d4259e74, bundle.var_54dd9ff6, bundle.var_5ee7b40a, bundle.var_6d3350a1, bundle.var_26d52900);
}

// Namespace gametype/gametype_shared
// Params 1, eflags: 0x4
// Checksum 0x8ed6e844, Offset: 0x148
// Size: 0x20
function private function_788fb510(value) {
    if (!isdefined(value)) {
        return "";
    }
    return value;
}

// Namespace gametype/gametype_shared
// Params 10, eflags: 0x0
// Checksum 0x49830d81, Offset: 0x170
// Size: 0x1c4
function setvisiblescoreboardcolumns(col1, col2, col3, col4, col5, col6, col7, col8, col9, col10) {
    col1 = function_788fb510(col1);
    col2 = function_788fb510(col2);
    col3 = function_788fb510(col3);
    col4 = function_788fb510(col4);
    col5 = function_788fb510(col5);
    col6 = function_788fb510(col6);
    col7 = function_788fb510(col7);
    col8 = function_788fb510(col8);
    col9 = function_788fb510(col9);
    col10 = function_788fb510(col10);
    if (!level.rankedmatch) {
        setscoreboardcolumns(col1, col2, col3, col4, col5, col6, col7, col8, col9, col10, "sbtimeplayed", "shotshit", "shotsmissed", "victory");
        return;
    }
    setscoreboardcolumns(col1, col2, col3, col4, col5, col6, col7, col8, col9, col10);
}

