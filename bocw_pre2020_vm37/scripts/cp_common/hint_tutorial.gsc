#using script_35ae72be7b4fec10;
#using script_4937c6974f43bb71;
#using scripts\cp_common\gametypes\globallogic_ui;
#using scripts\cp_common\ui\prompts;

#namespace hint_tutorial;

// Namespace hint_tutorial/hint_tutorial
// Params 8
// Checksum 0x4cf4f3e6, Offset: 0x1a8
// Size: 0x2e4
function function_4c2d4fc4( message, title = #"", var_9696a2d = 0, var_db331a85 = #"", type = 0, var_c18a5a8b, var_9763e3fa, var_ad825676 = 1 )
{
    if ( !scripted_widgets::exists( #"hint_tutorial" ) )
    {
        var_48bf6e66 = #"hash_775d3d8906586398";
        
        if ( type == 2 )
        {
            var_48bf6e66 = #"hash_30386b6ca189daa3";
        }
        else if ( type > 2 )
        {
            var_48bf6e66 = #"hash_77649627c20d31b1";
        }
        
        if ( var_ad825676 )
        {
            prompts::function_86eedc();
        }
        
        scripted_widgets::create( #"hint_tutorial", var_48bf6e66 );
    }
    
    scripted_widgets::function_9ade1d9b( #"hint_tutorial", "description", message );
    scripted_widgets::function_9ade1d9b( #"hint_tutorial", "title", title );
    scripted_widgets::function_9ade1d9b( #"hint_tutorial", "demoWidgeType", var_9696a2d );
    scripted_widgets::function_9ade1d9b( #"hint_tutorial", "callToAction", var_db331a85 );
    scripted_widgets::function_9ade1d9b( #"hint_tutorial", "type", type );
    scripted_widgets::function_9ade1d9b( #"hint_tutorial", "delayAndFadeTime", -1 );
    scripted_widgets::function_9ade1d9b( #"hint_tutorial", "pause", 0 );
    
    if ( type == 1 )
    {
        namespace_82bfe441::fade( 1, "FadeImmediate" );
    }
    
    level.var_940e0c3e = type;
    
    if ( isdefined( var_c18a5a8b ) || isdefined( var_9763e3fa ) )
    {
        self thread function_9f427d88( var_c18a5a8b, var_9763e3fa );
    }
}

// Namespace hint_tutorial/hint_tutorial
// Params 2
// Checksum 0xf86acda0, Offset: 0x498
// Size: 0x94
function function_c05468c7( index, displayText )
{
    if ( scripted_widgets::exists( #"hint_tutorial" ) )
    {
        scripted_widgets::function_f2a9266( #"hint_tutorial", index, "displayText", displayText );
        scripted_widgets::function_f2a9266( #"hint_tutorial", index, "param", index );
    }
}

// Namespace hint_tutorial/hint_tutorial
// Params 3
// Checksum 0xb1c4a48e, Offset: 0x538
// Size: 0xe4
function function_df8cdb06( image, var_8f804bca, var_783524a3 )
{
    if ( scripted_widgets::exists( #"hint_tutorial" ) )
    {
        scripted_widgets::function_9ade1d9b( #"hint_tutorial", "demoImage", image, 1, 0, 0, 1 );
        scripted_widgets::function_9ade1d9b( #"hint_tutorial", "demoImageCaptionTitle", var_8f804bca, 1, 0, 0, 1 );
        scripted_widgets::function_9ade1d9b( #"hint_tutorial", "demoImageCaptionMessage", var_783524a3, 1, 0, 0, 1 );
    }
}

// Namespace hint_tutorial/hint_tutorial
// Params 1
// Checksum 0x258a86c5, Offset: 0x628
// Size: 0x74
function function_df08d48( var_72b185dd = 0 )
{
    if ( scripted_widgets::exists( #"hint_tutorial" ) )
    {
        scripted_widgets::function_9ade1d9b( #"hint_tutorial", "worldBlurAmount", var_72b185dd, 1, 0, 0, 1 );
    }
}

// Namespace hint_tutorial/hint_tutorial
// Params 5
// Checksum 0x69179bf8, Offset: 0x6a8
// Size: 0x1a4
function pause( var_1d470cc4 = #"ui_cancel", var_63d0d48f = #"hash_3f87d00d07eb799e", var_29fa9286 = 2, var_f191bdbc, var_37e3f2b0 )
{
    if ( scripted_widgets::exists( #"hint_tutorial" ) )
    {
        scripted_widgets::set_focus( #"hint_tutorial", 1 );
        scripted_widgets::function_9ade1d9b( #"hint_tutorial", "pausePromptCancelMessage", var_63d0d48f );
        scripted_widgets::function_9ade1d9b( #"hint_tutorial", "input", var_1d470cc4 );
        scripted_widgets::function_24e5fa63( #"hint_tutorial", var_1d470cc4, 1 );
        scripted_widgets::function_9ade1d9b( #"hint_tutorial", "pause", var_29fa9286 );
        selected = level waittill( #"lui_unpause_game" );
        
        if ( isdefined( var_37e3f2b0 ) )
        {
            level notify( var_37e3f2b0 );
        }
        
        function_9f427d88( 0, var_f191bdbc );
    }
}

// Namespace hint_tutorial/hint_tutorial
// Params 2
// Checksum 0x55bf7648, Offset: 0x858
// Size: 0x25c
function function_9f427d88( var_67df10fb = 1, var_f191bdbc )
{
    self notify( "5155762d9830ec94" );
    self endon( "5155762d9830ec94" );
    self endon( #"death" );
    
    if ( !isdefined( var_f191bdbc ) )
    {
        var_f191bdbc = [];
    }
    else if ( !isarray( var_f191bdbc ) )
    {
        var_f191bdbc = array( var_f191bdbc );
    }
    
    reason = undefined;
    
    if ( var_67df10fb >= float( function_60d95f53() ) / 1000 )
    {
        if ( var_f191bdbc.size > 0 )
        {
            reason = self waittilltimeout( var_67df10fb, var_f191bdbc );
        }
        else
        {
            wait var_67df10fb;
        }
    }
    else if ( var_f191bdbc.size > 0 )
    {
        self waittill( var_f191bdbc );
        var_67df10fb = 0;
    }
    
    if ( scripted_widgets::exists( #"hint_tutorial" ) )
    {
        scripted_widgets::function_9ade1d9b( #"hint_tutorial", "delayAndFadeTime", var_67df10fb );
    }
    
    if ( var_67df10fb > 0 && reason._notify === #"timeout" )
    {
        wait 2;
    }
    
    if ( scripted_widgets::exists( #"hint_tutorial" ) )
    {
        scripted_widgets::set_focus( #"hint_tutorial", 0 );
        scripted_widgets::remove( #"hint_tutorial" );
    }
    
    if ( level.var_940e0c3e === 1 )
    {
        namespace_82bfe441::fade( 0, "FadeMedium" );
    }
    
    level.var_940e0c3e = undefined;
    prompts::function_d675f5a4();
}

