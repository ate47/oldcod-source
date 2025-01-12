#using scripts/core_common/array_shared;
#using scripts/core_common/flag_shared;
#using scripts/core_common/flagsys_shared;
#using scripts/core_common/struct;
#using scripts/core_common/util_shared;

#namespace array;

// Namespace array/array_shared
// Params 4, eflags: 0x20 variadic
// Checksum 0x54315465, Offset: 0x160
// Size: 0x1a6
function filter(&array, b_keep_keys, func_filter, ...) {
    a_new = [];
    foreach (key, val in array) {
        a_args = arraycombine(array(val), vararg, 1, 0);
        if (util::single_func_argarray(undefined, func_filter, a_args)) {
            if (isstring(key) || isweapon(key)) {
                if (isdefined(b_keep_keys) && !b_keep_keys) {
                    a_new[a_new.size] = val;
                } else {
                    a_new[key] = val;
                }
                continue;
            }
            if (isdefined(b_keep_keys) && b_keep_keys) {
                a_new[key] = val;
                continue;
            }
            a_new[a_new.size] = val;
        }
    }
    return a_new;
}

// Namespace array/array_shared
// Params 2, eflags: 0x0
// Checksum 0xb5b914e, Offset: 0x310
// Size: 0x3a
function remove_dead(&array, b_keep_keys) {
    return filter(array, b_keep_keys, &_filter_dead);
}

// Namespace array/array_shared
// Params 2, eflags: 0x0
// Checksum 0xd47ae539, Offset: 0x358
// Size: 0x3a
function remove_undefined(&array, b_keep_keys) {
    return filter(array, b_keep_keys, &_filter_undefined);
}

// Namespace array/array_shared
// Params 2, eflags: 0x0
// Checksum 0xf7f011b2, Offset: 0x3a0
// Size: 0x14e
function cleanup(&array, var_ec434b96) {
    if (!isdefined(var_ec434b96)) {
        var_ec434b96 = 0;
    }
    a_keys = getarraykeys(array);
    for (i = a_keys.size - 1; i >= 0; i--) {
        key = a_keys[i];
        if (isarray(array[key]) && array[key].size) {
            cleanup(array[key], var_ec434b96);
            continue;
        }
        if (!var_ec434b96 && isarray(array[key]) && (!isdefined(array[key]) || !array[key].size)) {
            arrayremoveindex(array, key);
        }
    }
}

// Namespace array/array_shared
// Params 3, eflags: 0x0
// Checksum 0xc8e19fe8, Offset: 0x4f8
// Size: 0x4a
function filter_classname(&array, b_keep_keys, str_classname) {
    return filter(array, b_keep_keys, &_filter_classname, str_classname);
}

// Namespace array/array_shared
// Params 3, eflags: 0x0
// Checksum 0x7650d41e, Offset: 0x550
// Size: 0x4a
function function_b0432d33(&array, b_keep_keys, str_classname) {
    return filter(array, b_keep_keys, &function_3274b192, str_classname);
}

// Namespace array/array_shared
// Params 2, eflags: 0x0
// Checksum 0x5a9d28a9, Offset: 0x5a8
// Size: 0x3a
function get_touching(&array, b_keep_keys) {
    return filter(array, b_keep_keys, &istouching);
}

// Namespace array/array_shared
// Params 3, eflags: 0x0
// Checksum 0x68423868, Offset: 0x5f0
// Size: 0xec
function remove_index(array, index, b_keep_keys) {
    a_new = [];
    foreach (key, val in array) {
        if (key == index) {
            continue;
        }
        if (isdefined(b_keep_keys) && b_keep_keys) {
            a_new[key] = val;
            continue;
        }
        a_new[a_new.size] = val;
    }
    return a_new;
}

// Namespace array/array_shared
// Params 2, eflags: 0x0
// Checksum 0xc673c170, Offset: 0x6e8
// Size: 0x112
function delete_all(&array, is_struct) {
    foreach (ent in array) {
        if (isdefined(ent)) {
            if (isdefined(is_struct) && is_struct) {
                ent struct::delete();
                continue;
            }
            if (isdefined(ent.__vtable)) {
                ent._deleted = 1;
                ent notify(#"death");
                ent = undefined;
                continue;
            }
            ent delete();
        }
    }
}

// Namespace array/array_shared
// Params 2, eflags: 0x0
// Checksum 0xb09536ab, Offset: 0x808
// Size: 0x8e
function notify_all(&array, str_notify) {
    foreach (elem in array) {
        elem notify(str_notify);
    }
}

// Namespace array/array_shared
// Params 8, eflags: 0x0
// Checksum 0x7be6b969, Offset: 0x8a0
// Size: 0x18c
function thread_all(&entities, func, arg1, arg2, arg3, arg4, arg5, arg6) {
    /#
        assert(isdefined(entities), "<dev string:x28>");
    #/
    /#
        assert(isdefined(func), "<dev string:x5b>");
    #/
    if (isarray(entities)) {
        foreach (ent in entities) {
            util::single_thread(ent, func, arg1, arg2, arg3, arg4, arg5, arg6);
        }
        return;
    }
    util::single_thread(entities, func, arg1, arg2, arg3, arg4, arg5, arg6);
}

// Namespace array/array_shared
// Params 7, eflags: 0x0
// Checksum 0x4f31d578, Offset: 0xa38
// Size: 0x16c
function thread_all_ents(&entities, func, arg1, arg2, arg3, arg4, arg5) {
    /#
        assert(isdefined(entities), "<dev string:x8a>");
    #/
    /#
        assert(isdefined(func), "<dev string:xc2>");
    #/
    if (isarray(entities)) {
        if (entities.size) {
            keys = getarraykeys(entities);
            for (i = 0; i < keys.size; i++) {
                util::single_thread(self, func, entities[keys[i]], arg1, arg2, arg3, arg4, arg5);
            }
        }
        return;
    }
    util::single_thread(self, func, entities, arg1, arg2, arg3, arg4, arg5);
}

// Namespace array/array_shared
// Params 8, eflags: 0x0
// Checksum 0xcdcd6d8c, Offset: 0xbb0
// Size: 0x18c
function run_all(&entities, func, arg1, arg2, arg3, arg4, arg5, arg6) {
    /#
        assert(isdefined(entities), "<dev string:xf6>");
    #/
    /#
        assert(isdefined(func), "<dev string:x126>");
    #/
    if (isarray(entities)) {
        foreach (ent in entities) {
            util::single_func(ent, func, arg1, arg2, arg3, arg4, arg5, arg6);
        }
        return;
    }
    util::single_func(entities, func, arg1, arg2, arg3, arg4, arg5, arg6);
}

// Namespace array/array_shared
// Params 2, eflags: 0x0
// Checksum 0xf8bbc40f, Offset: 0xd48
// Size: 0xf0
function exclude(array, array_exclude) {
    newarray = array;
    if (isarray(array_exclude)) {
        foreach (exclude_item in array_exclude) {
            arrayremovevalue(newarray, exclude_item);
        }
    } else {
        arrayremovevalue(newarray, array_exclude);
    }
    return newarray;
}

// Namespace array/array_shared
// Params 3, eflags: 0x0
// Checksum 0x3a76b64d, Offset: 0xe40
// Size: 0x72
function add(&array, item, allow_dupes) {
    if (!isdefined(allow_dupes)) {
        allow_dupes = 1;
    }
    if (isdefined(item)) {
        if (allow_dupes || !isinarray(array, item)) {
            array[array.size] = item;
        }
    }
}

// Namespace array/array_shared
// Params 3, eflags: 0x0
// Checksum 0x64e49666, Offset: 0xec0
// Size: 0xd2
function add_sorted(&array, item, allow_dupes) {
    if (!isdefined(allow_dupes)) {
        allow_dupes = 1;
    }
    if (isdefined(item)) {
        if (allow_dupes || !isinarray(array, item)) {
            for (i = 0; i <= array.size; i++) {
                if (i == array.size || item <= array[i]) {
                    arrayinsert(array, item, i);
                    break;
                }
            }
        }
    }
}

// Namespace array/array_shared
// Params 3, eflags: 0x0
// Checksum 0x5a7a7f05, Offset: 0xfa0
// Size: 0x170
function wait_till(&array, notifies, n_timeout) {
    if (isdefined(n_timeout)) {
        __s = spawnstruct();
        __s endon(#"timeout");
        __s util::delay_notify(n_timeout, "timeout");
    }
    s_tracker = spawnstruct();
    s_tracker._wait_count = 0;
    foreach (ent in array) {
        if (isdefined(ent)) {
            ent thread util::timeout(n_timeout, &util::_waitlogic, s_tracker, notifies);
        }
    }
    if (s_tracker._wait_count > 0) {
        s_tracker waittill("waitlogic_finished");
    }
}

// Namespace array/array_shared
// Params 4, eflags: 0x0
// Checksum 0xf350fcd3, Offset: 0x1118
// Size: 0x1b8
function wait_till_match(&array, str_notify, str_match, n_timeout) {
    if (isdefined(n_timeout)) {
        __s = spawnstruct();
        __s endon(#"timeout");
        __s util::delay_notify(n_timeout, "timeout");
    }
    s_tracker = spawnstruct();
    s_tracker._array_wait_count = 0;
    foreach (ent in array) {
        if (isdefined(ent)) {
            s_tracker._array_wait_count++;
            ent thread util::timeout(n_timeout, &_waitlogic_match, s_tracker, str_notify, str_match);
            ent thread util::timeout(n_timeout, &_waitlogic_death, s_tracker);
        }
    }
    if (s_tracker._array_wait_count > 0) {
        s_tracker waittill("array_wait");
    }
}

// Namespace array/array_shared
// Params 3, eflags: 0x0
// Checksum 0x613eb175, Offset: 0x12d8
// Size: 0x4c
function _waitlogic_match(s_tracker, str_notify, str_match) {
    self endon(#"death");
    self waittillmatch(str_match, str_notify);
    update_waitlogic_tracker(s_tracker);
}

// Namespace array/array_shared
// Params 1, eflags: 0x0
// Checksum 0x1233449d, Offset: 0x1330
// Size: 0x34
function _waitlogic_death(s_tracker) {
    self waittill("death");
    update_waitlogic_tracker(s_tracker);
}

// Namespace array/array_shared
// Params 1, eflags: 0x0
// Checksum 0x2dabab1, Offset: 0x1370
// Size: 0x40
function update_waitlogic_tracker(s_tracker) {
    s_tracker._array_wait_count--;
    if (s_tracker._array_wait_count == 0) {
        s_tracker notify(#"array_wait");
    }
}

// Namespace array/array_shared
// Params 2, eflags: 0x0
// Checksum 0xe5c1ab80, Offset: 0x13b8
// Size: 0xb0
function flag_wait(&array, str_flag) {
    for (i = 0; i < array.size; i++) {
        ent = array[i];
        if (isdefined(ent) && !ent flag::get(str_flag)) {
            ent util::waittill_either("death", str_flag);
            i = -1;
        }
    }
}

// Namespace array/array_shared
// Params 2, eflags: 0x0
// Checksum 0xbebe99f2, Offset: 0x1470
// Size: 0xb0
function flagsys_wait(&array, str_flag) {
    for (i = 0; i < array.size; i++) {
        ent = array[i];
        if (isdefined(ent) && !ent flagsys::get(str_flag)) {
            ent util::waittill_either("death", str_flag);
            i = -1;
        }
    }
}

// Namespace array/array_shared
// Params 2, eflags: 0x20 variadic
// Checksum 0x84d61724, Offset: 0x1528
// Size: 0x12c
function flagsys_wait_any_flag(&array, ...) {
    for (i = 0; i < array.size; i++) {
        ent = array[i];
        if (isdefined(ent)) {
            b_flag_set = 0;
            foreach (str_flag in vararg) {
                if (ent flagsys::get(str_flag)) {
                    b_flag_set = 1;
                    break;
                }
            }
            if (!b_flag_set) {
                ent waittill(vararg);
                i = -1;
            }
        }
    }
}

// Namespace array/array_shared
// Params 2, eflags: 0x0
// Checksum 0xedae8d5a, Offset: 0x1660
// Size: 0xbc
function flagsys_wait_any(&array, str_flag) {
    foreach (ent in array) {
        if (ent flagsys::get(str_flag)) {
            return ent;
        }
    }
    wait_any(array, str_flag);
}

// Namespace array/array_shared
// Params 2, eflags: 0x0
// Checksum 0x3593a2be, Offset: 0x1728
// Size: 0xa0
function flag_wait_clear(&array, str_flag) {
    do {
        var_51b0e732 = 0;
        for (i = 0; i < array.size; i++) {
            ent = array[i];
            if (ent flag::get(str_flag)) {
                ent waittill(str_flag);
                var_51b0e732 = 1;
            }
        }
    } while (var_51b0e732);
}

// Namespace array/array_shared
// Params 3, eflags: 0x0
// Checksum 0x7ba3ad23, Offset: 0x17d0
// Size: 0x108
function flagsys_wait_clear(&array, str_flag, n_timeout) {
    if (isdefined(n_timeout)) {
        __s = spawnstruct();
        __s endon(#"timeout");
        __s util::delay_notify(n_timeout, "timeout");
    }
    for (i = 0; i < array.size; i++) {
        ent = array[i];
        if (isdefined(ent) && ent flagsys::get(str_flag)) {
            ent util::waittill_either("death", str_flag);
            i = -1;
        }
    }
}

// Namespace array/array_shared
// Params 3, eflags: 0x0
// Checksum 0xce2952f9, Offset: 0x18e0
// Size: 0x164
function wait_any(array, msg, n_timeout) {
    if (isdefined(n_timeout)) {
        __s = spawnstruct();
        __s endon(#"timeout");
        __s util::delay_notify(n_timeout, "timeout");
    }
    s_tracker = spawnstruct();
    foreach (ent in array) {
        if (isdefined(ent)) {
            level thread util::timeout(n_timeout, &_waitlogic2, s_tracker, ent, msg);
        }
    }
    s_tracker endon(#"array_wait");
    wait_till(array, "death");
}

// Namespace array/array_shared
// Params 3, eflags: 0x0
// Checksum 0xe3307924, Offset: 0x1a50
// Size: 0x68
function _waitlogic2(s_tracker, ent, msg) {
    s_tracker endon(#"array_wait");
    if (msg != "death") {
        ent endon(#"death");
    }
    ent waittill(msg);
    s_tracker notify(#"array_wait");
}

// Namespace array/array_shared
// Params 2, eflags: 0x0
// Checksum 0x346a3426, Offset: 0x1ac0
// Size: 0xcc
function flag_wait_any(array, str_flag) {
    self endon(#"death");
    foreach (ent in array) {
        if (ent flag::get(str_flag)) {
            return ent;
        }
    }
    wait_any(array, str_flag);
}

// Namespace array/array_shared
// Params 2, eflags: 0x0
// Checksum 0x104a7477, Offset: 0x1b98
// Size: 0xd6
function random(array, var_4d9aa26d) {
    if (array.size > 0) {
        keys = getarraykeys(array);
        n_index = randomint(keys.size);
        value = array[keys[n_index]];
        if (value === var_4d9aa26d) {
            n_index++;
            if (n_index >= keys.size) {
                n_index = 0;
            }
            value = array[keys[n_index]];
        }
        return value;
    }
}

// Namespace array/array_shared
// Params 1, eflags: 0x0
// Checksum 0xf627878, Offset: 0x1c78
// Size: 0x9c
function randomize(array) {
    for (i = 0; i < array.size; i++) {
        j = randomint(array.size);
        temp = array[i];
        array[i] = array[j];
        array[j] = temp;
    }
    return array;
}

// Namespace array/array_shared
// Params 2, eflags: 0x0
// Checksum 0x3b212d54, Offset: 0x1d20
// Size: 0x66
function function_4097a53e(array, n_size) {
    a_ret = [];
    for (i = 0; i < n_size; i++) {
        a_ret[i] = array[i];
    }
    return a_ret;
}

// Namespace array/array_shared
// Params 1, eflags: 0x0
// Checksum 0x61097c9f, Offset: 0x1d90
// Size: 0x68
function reverse(array) {
    a_array2 = [];
    for (i = array.size - 1; i >= 0; i--) {
        a_array2[a_array2.size] = array[i];
    }
    return a_array2;
}

// Namespace array/array_shared
// Params 1, eflags: 0x0
// Checksum 0x7a4c8be7, Offset: 0x1e00
// Size: 0xaa
function remove_keys(array) {
    a_new = [];
    foreach (val in array) {
        if (isdefined(val)) {
            a_new[a_new.size] = val;
        }
    }
    return a_new;
}

// Namespace array/array_shared
// Params 3, eflags: 0x0
// Checksum 0x6a6f89c3, Offset: 0x1eb8
// Size: 0x5a
function swap(&array, index1, index2) {
    temp = array[index1];
    array[index1] = array[index2];
    array[index2] = temp;
}

// Namespace array/array_shared
// Params 3, eflags: 0x0
// Checksum 0x6ae160b, Offset: 0x1f20
// Size: 0xc2
function pop(&array, index, b_keep_keys) {
    if (!isdefined(b_keep_keys)) {
        b_keep_keys = 1;
    }
    if (array.size > 0) {
        if (!isdefined(index)) {
            keys = getarraykeys(array);
            index = keys[0];
        }
        if (isdefined(array[index])) {
            ret = array[index];
            arrayremoveindex(array, index, b_keep_keys);
            return ret;
        }
    }
}

// Namespace array/array_shared
// Params 2, eflags: 0x0
// Checksum 0xbbfb4782, Offset: 0x1ff0
// Size: 0x82
function pop_front(&array, b_keep_keys) {
    if (!isdefined(b_keep_keys)) {
        b_keep_keys = 1;
    }
    keys = getarraykeys(array);
    index = keys[keys.size - 1];
    return pop(array, index, b_keep_keys);
}

// Namespace array/array_shared
// Params 3, eflags: 0x0
// Checksum 0x685d9157, Offset: 0x2080
// Size: 0x104
function push(&array, val, index) {
    if (!isdefined(index)) {
        index = 0;
        foreach (key in getarraykeys(array)) {
            if (isint(key) && key >= index) {
                index = key + 1;
            }
        }
    }
    arrayinsert(array, val, index);
}

// Namespace array/array_shared
// Params 2, eflags: 0x0
// Checksum 0xd2a1059e, Offset: 0x2190
// Size: 0x34
function push_front(&array, val) {
    push(array, val, 0);
}

// Namespace array/array_shared
// Params 3, eflags: 0x0
// Checksum 0xf97f252e, Offset: 0x21d0
// Size: 0xac
function replace(array, value, replacement) {
    foreach (i, val in array) {
        if (val === value) {
            array[i] = replacement;
        }
    }
    return array;
}

// Namespace array/array_shared
// Params 2, eflags: 0x0
// Checksum 0x735ebb23, Offset: 0x2288
// Size: 0x58
function find(&array, ent) {
    for (i = 0; i < array.size; i++) {
        if (array[i] === ent) {
            return i;
        }
    }
}

/#

    // Namespace array/array_shared
    // Params 3, eflags: 0x0
    // Checksum 0xf665f182, Offset: 0x22e8
    // Size: 0x3c
    function get_closest(org, &array, dist) {
        assert(0, "<dev string:x152>");
    }

#/

// Namespace array/array_shared
// Params 3, eflags: 0x0
// Checksum 0x5a8508f, Offset: 0x2330
// Size: 0x4c
function function_8e7b4ab7(org, &array, dist) {
    if (!isdefined(dist)) {
        dist = undefined;
    }
    /#
        assert(0, "<dev string:x186>");
    #/
}

// Namespace array/array_shared
// Params 2, eflags: 0x0
// Checksum 0xd0c99728, Offset: 0x2388
// Size: 0x1e
function closerfunc(dist1, dist2) {
    return dist1 >= dist2;
}

// Namespace array/array_shared
// Params 2, eflags: 0x0
// Checksum 0x96570b6b, Offset: 0x23b0
// Size: 0x1e
function fartherfunc(dist1, dist2) {
    return dist1 <= dist2;
}

// Namespace array/array_shared
// Params 5, eflags: 0x0
// Checksum 0xe729138b, Offset: 0x23d8
// Size: 0xc4
function get_all_farthest(org, &array, a_exclude, n_max, n_maxdist) {
    if (!isdefined(n_max)) {
        n_max = array.size;
    }
    a_ret = exclude(array, a_exclude);
    if (isdefined(n_maxdist)) {
        a_ret = arraysort(a_ret, org, 0, n_max, n_maxdist);
    } else {
        a_ret = arraysort(a_ret, org, 0, n_max);
    }
    return a_ret;
}

// Namespace array/array_shared
// Params 5, eflags: 0x0
// Checksum 0x62550431, Offset: 0x24a8
// Size: 0xcc
function get_all_closest(org, &array, a_exclude, n_max, n_maxdist) {
    if (!isdefined(n_max)) {
        n_max = array.size;
    }
    a_ret = exclude(array, a_exclude);
    if (isdefined(n_maxdist)) {
        a_ret = arraysort(a_ret, org, 1, n_max, n_maxdist);
    } else {
        a_ret = arraysort(a_ret, org, 1, n_max);
    }
    return a_ret;
}

// Namespace array/array_shared
// Params 1, eflags: 0x0
// Checksum 0x3afcdf65, Offset: 0x2580
// Size: 0x22
function alphabetize(&array) {
    return sort_by_value(array, 1);
}

// Namespace array/array_shared
// Params 2, eflags: 0x0
// Checksum 0x4dec253b, Offset: 0x25b0
// Size: 0x4a
function sort_by_value(&array, b_lowest_first) {
    if (!isdefined(b_lowest_first)) {
        b_lowest_first = 0;
    }
    return merge_sort(array, &_compare_value, b_lowest_first);
}

// Namespace array/array_shared
// Params 2, eflags: 0x0
// Checksum 0xf9e3fcf, Offset: 0x2608
// Size: 0x4a
function sort_by_script_int(&a_ents, b_lowest_first) {
    if (!isdefined(b_lowest_first)) {
        b_lowest_first = 0;
    }
    return merge_sort(a_ents, &_compare_script_int, b_lowest_first);
}

// Namespace array/array_shared
// Params 3, eflags: 0x0
// Checksum 0xc3c920, Offset: 0x2660
// Size: 0x1e4
function merge_sort(&current_list, func_sort, param) {
    if (current_list.size <= 1) {
        return current_list;
    }
    left = [];
    right = [];
    middle = current_list.size / 2;
    for (x = 0; x < middle; x++) {
        if (!isdefined(left)) {
            left = [];
        } else if (!isarray(left)) {
            left = array(left);
        }
        left[left.size] = current_list[x];
    }
    while (x < current_list.size) {
        if (!isdefined(right)) {
            right = [];
        } else if (!isarray(right)) {
            right = array(right);
        }
        right[right.size] = current_list[x];
        x++;
    }
    left = merge_sort(left, func_sort, param);
    right = merge_sort(right, func_sort, param);
    result = merge(left, right, func_sort, param);
    return result;
}

// Namespace array/array_shared
// Params 4, eflags: 0x0
// Checksum 0xe03a231, Offset: 0x2850
// Size: 0x192
function merge(left, right, func_sort, param) {
    result = [];
    li = 0;
    for (ri = 0; li < left.size && ri < right.size; ri++) {
        b_result = undefined;
        if (isdefined(param)) {
            b_result = [[ func_sort ]](left[li], right[ri], param);
        } else {
            b_result = [[ func_sort ]](left[li], right[ri]);
        }
        if (b_result) {
            result[result.size] = left[li];
            li++;
            continue;
        }
        result[result.size] = right[ri];
    }
    while (li < left.size) {
        result[result.size] = left[li];
        li++;
    }
    while (ri < right.size) {
        result[result.size] = right[ri];
        ri++;
    }
    return result;
}

// Namespace array/array_shared
// Params 3, eflags: 0x0
// Checksum 0x55633c24, Offset: 0x29f0
// Size: 0xba
function function_5fee9333(&a, var_82126fd8, val) {
    if (!isdefined(a)) {
        a = [];
        a[0] = val;
        return;
    }
    for (i = 0; i < a.size; i++) {
        if ([[ var_82126fd8 ]](a[i], val) <= 0) {
            arrayinsert(a, val, i);
            return;
        }
    }
    a[a.size] = val;
}

// Namespace array/array_shared
// Params 7, eflags: 0x0
// Checksum 0xb3b7594f, Offset: 0x2ab8
// Size: 0x1bc
function spread_all(&entities, func, arg1, arg2, arg3, arg4, arg5) {
    /#
        assert(isdefined(entities), "<dev string:x1bb>");
    #/
    /#
        assert(isdefined(func), "<dev string:x1f3>");
    #/
    if (isarray(entities)) {
        foreach (ent in entities) {
            if (isdefined(ent)) {
                util::single_thread(ent, func, arg1, arg2, arg3, arg4, arg5);
            }
            wait randomfloatrange(0.0666667, 0.133333);
        }
        return;
    }
    util::single_thread(entities, func, arg1, arg2, arg3, arg4, arg5);
    wait randomfloatrange(0.0666667, 0.133333);
}

// Namespace array/array_shared
// Params 2, eflags: 0x0
// Checksum 0x290b405f, Offset: 0x2c80
// Size: 0x38
function wait_till_touching(&a_ents, e_volume) {
    while (!is_touching(a_ents, e_volume)) {
        waitframe(1);
    }
}

// Namespace array/array_shared
// Params 2, eflags: 0x0
// Checksum 0xfdaaf0c3, Offset: 0x2cc0
// Size: 0xa4
function is_touching(&a_ents, e_volume) {
    foreach (e_ent in a_ents) {
        if (!e_ent istouching(e_volume)) {
            return false;
        }
    }
    return true;
}

// Namespace array/array_shared
// Params 2, eflags: 0x0
// Checksum 0xd42608c4, Offset: 0x2d70
// Size: 0xbe
function contains(array_or_val, value) {
    if (isarray(array_or_val)) {
        foreach (element in array_or_val) {
            if (element === value) {
                return true;
            }
        }
        return false;
    }
    return array_or_val === value;
}

// Namespace array/array_shared
// Params 2, eflags: 0x0
// Checksum 0x6dcbf6c6, Offset: 0x2e38
// Size: 0x3a
function quick_sort(array, compare_func) {
    return quick_sort_mid(array, 0, array.size - 1, compare_func);
}

// Namespace array/array_shared
// Params 4, eflags: 0x0
// Checksum 0xaa0773d9, Offset: 0x2e80
// Size: 0x1de
function quick_sort_mid(array, start, end, compare_func) {
    i = start;
    k = end;
    if (!isdefined(compare_func)) {
        compare_func = &_compare_value;
    }
    if (end - start >= 1) {
        pivot = array[start];
        while (k > i) {
            while ([[ compare_func ]](array[i], pivot) && i <= end && k > i) {
                i++;
            }
            while (![[ compare_func ]](array[k], pivot) && k >= start && k >= i) {
                k--;
            }
            if (k > i) {
                swap(array, i, k);
            }
        }
        swap(array, start, k);
        array = quick_sort_mid(array, start, k - 1, compare_func);
        array = quick_sort_mid(array, k + 1, end, compare_func);
    } else {
        return array;
    }
    return array;
}

// Namespace array/array_shared
// Params 3, eflags: 0x0
// Checksum 0xf7a545ea, Offset: 0x3068
// Size: 0x54
function _compare_value(val1, val2, b_lowest_first) {
    if (!isdefined(b_lowest_first)) {
        b_lowest_first = 1;
    }
    if (b_lowest_first) {
        return (val1 <= val2);
    }
    return val1 > val2;
}

// Namespace array/array_shared
// Params 3, eflags: 0x0
// Checksum 0xfa7e0fed, Offset: 0x30c8
// Size: 0x76
function _compare_script_int(e1, e2, b_lowest_first) {
    if (!isdefined(b_lowest_first)) {
        b_lowest_first = 1;
    }
    if (b_lowest_first) {
        return (e1.script_int <= e2.script_int);
    }
    return e1.script_int > e2.script_int;
}

// Namespace array/array_shared
// Params 1, eflags: 0x0
// Checksum 0xec7ccf6f, Offset: 0x3148
// Size: 0x12
function _filter_undefined(val) {
    return isdefined(val);
}

// Namespace array/array_shared
// Params 1, eflags: 0x0
// Checksum 0x9fea433e, Offset: 0x3168
// Size: 0x22
function _filter_dead(val) {
    return isalive(val);
}

// Namespace array/array_shared
// Params 2, eflags: 0x0
// Checksum 0xbfe2d0ab, Offset: 0x3198
// Size: 0x4a
function _filter_classname(val, arg) {
    return isdefined(val.classname) && issubstr(val.classname, arg);
}

// Namespace array/array_shared
// Params 2, eflags: 0x0
// Checksum 0x6bb12fbd, Offset: 0x31f0
// Size: 0x4c
function function_3274b192(val, arg) {
    return !(isdefined(val.classname) && issubstr(val.classname, arg));
}

