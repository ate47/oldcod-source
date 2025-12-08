#using script_35ae72be7b4fec10;
#using script_3dc93ca9902a9cda;
#using scripts\core_common\util_shared;

#namespace namespace_6fdcb0;

// Namespace namespace_6fdcb0/namespace_d2b0877a
// Params 1
// Checksum 0xcd5ad76c, Offset: 0x198
// Size: 0x39c
function function_912776e6( var_f03e723e )
{
    assert( ishash( var_f03e723e ) );
    var_1e80d435 = getscriptbundle( var_f03e723e );
    var_272aa18c = var_1e80d435.var_ca65c53;
    level.var_9cc7e850 = 0;
    
    if ( !isdefined( level.combination ) )
    {
        level.combination = [];
    }
    
    if ( !isdefined( level.var_91d22c7d ) )
    {
        level.var_91d22c7d = [];
    }
    
    assert( var_272aa18c.size > 0 );
    
    if ( scripted_widgets::exists( #"hash_3b32288cc17c7c50" ) )
    {
        scripted_widgets::remove( #"hash_3b32288cc17c7c50" );
    }
    
    scripted_widgets::create( #"hash_3b32288cc17c7c50", #"hash_719a4d9188d68f7" );
    scripted_widgets::function_9ade1d9b( #"hash_3b32288cc17c7c50", "ActiveIndex", -1 );
    function_2c85ed08( 0 );
    
    for ( i = 0; i < var_272aa18c.size ; i++ )
    {
        item = var_272aa18c[ i ];
        
        if ( !isdefined( level.combination ) )
        {
            level.combination = [];
        }
        else if ( !isarray( level.combination ) )
        {
            level.combination = array( level.combination );
        }
        
        level.combination[ level.combination.size ] = isdefined( item.var_509412f0 ) ? item.var_509412f0 : 0;
        
        if ( !isdefined( level.var_91d22c7d ) )
        {
            level.var_91d22c7d = [];
        }
        else if ( !isarray( level.var_91d22c7d ) )
        {
            level.var_91d22c7d = array( level.var_91d22c7d );
        }
        
        level.var_91d22c7d[ level.var_91d22c7d.size ] = isdefined( item.initial_value ) ? item.initial_value : 0;
        scripted_widgets::function_9ade1d9b( #"hash_3b32288cc17c7c50", "Combo" + i, isdefined( item.initial_value ) ? item.initial_value : 0 );
    }
    
    function_2c85ed08();
    scripted_widgets::function_9ade1d9b( #"hash_3b32288cc17c7c50", "ActiveIndex", 0 );
    scripted_widgets::set_focus( #"hash_3b32288cc17c7c50", 1 );
    thread function_7825ee37();
}

// Namespace namespace_6fdcb0/namespace_d2b0877a
// Params 1, eflags: 0x4
// Checksum 0x826c78aa, Offset: 0x540
// Size: 0x424
function private function_7825ee37( var_31d7501a )
{
    player = getplayers()[ 0 ];
    player notifyonplayercommand( "move_left", "+actionslot 3" );
    player notifyonplayercommand( "move_right", "+actionslot 4" );
    player notifyonplayercommand( "move_up", "+actionslot 1" );
    player notifyonplayercommand( "move_down", "+actionslot 2" );
    player notifyonplayercommand( "exit", "+stance" );
    
    if ( !isdefined( var_31d7501a ) )
    {
        var_31d7501a = 10;
    }
    
    selected = 0;
    var_ab89de9b = 0;
    
    while ( true )
    {
        s_result = player waittill( #"move_left", #"move_right", #"move_up", #"move_down", #"exit" );
        
        if ( s_result._notify == #"exit" )
        {
            function_838e9ba9();
            player notify( #"exit" );
            return;
        }
        
        if ( s_result._notify == #"move_left" || s_result._notify == #"move_right" )
        {
            snd::play( "evt_kgb_combo_lock_slide", player );
            selected = s_result._notify == #"move_left" ? selected - 1 : selected + 1;
            
            if ( selected < 0 )
            {
                selected = 0;
            }
            else if ( selected > level.combination.size - 1 )
            {
                selected = level.combination.size - 1;
            }
            
            level.var_9cc7e850 = selected;
            scripted_widgets::function_9ade1d9b( #"hash_3b32288cc17c7c50", "ActiveIndex", selected );
            
            if ( function_ab53f639() )
            {
                return;
            }
        }
        
        if ( s_result._notify == #"move_up" || s_result._notify == #"move_down" )
        {
            snd::play( "evt_kgb_combo_lock_click", player );
            var_d509dc78 = level.var_91d22c7d[ level.var_9cc7e850 ];
            var_ab89de9b = s_result._notify == #"move_down" ? var_d509dc78 - 1 : var_d509dc78 + 1;
            var_ab89de9b %= var_31d7501a;
            
            if ( var_ab89de9b < 0 )
            {
                var_ab89de9b += var_31d7501a;
            }
            
            level.var_91d22c7d[ level.var_9cc7e850 ] = var_ab89de9b;
            scripted_widgets::function_9ade1d9b( #"hash_3b32288cc17c7c50", "Combo" + level.var_9cc7e850, var_ab89de9b );
            
            if ( function_ab53f639() )
            {
                return;
            }
        }
    }
}

// Namespace namespace_6fdcb0/namespace_d2b0877a
// Params 0, eflags: 0x4
// Checksum 0xf2b00c44, Offset: 0x970
// Size: 0xe8, Type: bool
function private function_ab53f639()
{
    for ( i = 0; i < level.var_91d22c7d.size ; i++ )
    {
        if ( level.var_91d22c7d[ i ] != level.combination[ i ] )
        {
            return false;
        }
    }
    
    function_2c85ed08( 3 );
    player = getplayers()[ 0 ];
    snd::play( "evt_lockpick_wrench_tighten", player );
    wait 1;
    player notify( #"combination_correct" );
    snd::play( "evt_kgb_combo_lock_success", player );
    return true;
}

// Namespace namespace_6fdcb0/namespace_d2b0877a
// Params 1
// Checksum 0x8ffb992a, Offset: 0xa60
// Size: 0x44
function function_2c85ed08( state = 1 )
{
    scripted_widgets::function_9ade1d9b( #"hash_3b32288cc17c7c50", "State", state );
}

// Namespace namespace_6fdcb0/namespace_d2b0877a
// Params 0
// Checksum 0x226277c9, Offset: 0xab0
// Size: 0x16a
function function_838e9ba9()
{
    if ( scripted_widgets::exists( #"hash_3b32288cc17c7c50" ) )
    {
        scripted_widgets::set_focus( #"hash_3b32288cc17c7c50", 0 );
        scripted_widgets::remove( #"hash_3b32288cc17c7c50" );
    }
    
    player = getplayers()[ 0 ];
    player notifyonplayercommandremove( "move_left", "+actionslot 4" );
    player notifyonplayercommandremove( "move_right", "+actionslot 2" );
    player notifyonplayercommandremove( "move_up", "+actionslot 1" );
    player notifyonplayercommandremove( "move_down", "+actionslot 3" );
    player notifyonplayercommandremove( "exit", "+stance" );
    level.combination = undefined;
    level.var_91d22c7d = undefined;
}

// Namespace namespace_6fdcb0/namespace_d2b0877a
// Params 0, eflags: 0x4
// Checksum 0x53017e8d, Offset: 0xc28
// Size: 0x294
function private function_51b45957()
{
    left_pressed = 0;
    right_pressed = 0;
    selected = 0;
    old_selected = undefined;
    last_presstime = 0;
    player = getplayers()[ 0 ];
    
    while ( true )
    {
        if ( self scripted_widgets::function_57fbd346() )
        {
            player notify( #"exit" );
            break;
        }
        
        if ( old_selected !== selected )
        {
            scripted_widgets::function_9ade1d9b( #"hash_3b32288cc17c7c50", "ActiveIndex", selected );
            level.var_9cc7e850 = selected;
            
            if ( function_ab53f639() )
            {
                return;
            }
            
            old_selected = selected;
        }
        
        if ( gettime() - last_presstime > 250 )
        {
            left_pressed = 0;
            right_pressed = 0;
        }
        
        left_right = util::function_b5338ccb( player getnormalizedmovement()[ 1 ], 0.2 );
        
        if ( !left_pressed )
        {
            if ( player actionslotthreebuttonpressed() || left_right < 0 )
            {
                left_pressed = 1;
                last_presstime = gettime();
                selected--;
            }
        }
        else if ( !player actionslotthreebuttonpressed() && left_right >= 0 )
        {
            left_pressed = 0;
        }
        
        if ( !right_pressed )
        {
            if ( player actionslotfourbuttonpressed() || left_right > 0 )
            {
                right_pressed = 1;
                last_presstime = gettime();
                selected++;
            }
        }
        else if ( !player actionslotfourbuttonpressed() && left_right <= 0 )
        {
            right_pressed = 0;
        }
        
        if ( selected < 0 )
        {
            selected = 0;
        }
        else if ( selected > level.combination.size - 1 )
        {
            selected = level.combination.size - 1;
        }
        
        waitframe( 1 );
    }
}

// Namespace namespace_6fdcb0/namespace_d2b0877a
// Params 1, eflags: 0x4
// Checksum 0x1f013e6a, Offset: 0xec8
// Size: 0x2c6
function private function_4f5fbfb5( var_31d7501a = 10 )
{
    up_pressed = 0;
    down_pressed = 0;
    selected = 0;
    old_selected = undefined;
    last_presstime = 0;
    player = getplayers()[ 0 ];
    
    while ( true )
    {
        if ( old_selected !== selected )
        {
            scripted_widgets::function_9ade1d9b( #"hash_3b32288cc17c7c50", "Combo" + level.var_9cc7e850, selected );
            old_selected = selected;
            
            if ( function_ab53f639() )
            {
                return;
            }
        }
        
        if ( gettime() - last_presstime > 250 )
        {
            up_pressed = 0;
            down_pressed = 0;
        }
        
        var_546112ef = player getnormalizedmovement();
        
        if ( !up_pressed )
        {
            if ( player actionslotonebuttonpressed() || player forwardbuttonpressed() || var_546112ef[ 0 ] >= 0.2 )
            {
                up_pressed = 1;
                last_presstime = gettime();
                selected--;
            }
        }
        else if ( !player actionslotonebuttonpressed() && !player forwardbuttonpressed() && var_546112ef[ 0 ] < 0.2 )
        {
            up_pressed = 0;
        }
        
        if ( !down_pressed )
        {
            if ( player actionslottwobuttonpressed() || player backbuttonpressed() || var_546112ef[ 0 ] <= -0.2 )
            {
                down_pressed = 1;
                last_presstime = gettime();
                selected++;
            }
        }
        else if ( !player actionslottwobuttonpressed() && !player backbuttonpressed() && var_546112ef[ 0 ] > -0.2 )
        {
            down_pressed = 0;
        }
        
        if ( selected < 0 )
        {
            selected = 0;
        }
        else if ( selected > var_31d7501a - 1 )
        {
            selected = var_31d7501a - 1;
        }
        
        waitframe( 1 );
    }
}

