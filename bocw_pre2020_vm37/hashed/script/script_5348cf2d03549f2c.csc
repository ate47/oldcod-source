#using script_18910f59cc847b42;
#using script_24879e3929b5b5e9;
#using script_30c7fb449869910;
#using script_3314b730521b9666;
#using script_38635d174016f682;
#using script_42cbbdcd1e160063;
#using script_64e5d3ad71ce8140;
#using script_67049b48b589d81;
#using script_6b71c9befed901f2;
#using script_71603a58e2da0698;
#using script_75c3996cce8959f7;
#using script_76abb7986de59601;
#using script_77163d5a569e2071;
#using script_771f5bff431d8d57;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace namespace_f63bdb08;

// Namespace namespace_f63bdb08/namespace_f63bdb08
// Params 0
// Checksum 0xcf24bf65, Offset: 0x268
// Size: 0x94
function init()
{
    clientfield::register( "scriptmover", "door_state", 1, 2, "int", &set_door_state, 0, 0 );
    clientfield::register( "scriptmover", "door_type", 1, 2, "int", &function_7769cbbe, 0, 0 );
}

// Namespace namespace_f63bdb08/namespace_f63bdb08
// Params 7, eflags: 0x4
// Checksum 0x8db1641f, Offset: 0x308
// Size: 0x292
function private set_door_state( localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    self endon( #"death" );
    self util::waittill_dobj( fieldname );
    self useanimtree( "generic" );
    
    if ( bwastimejump == 1 )
    {
        switch ( self.door_type )
        {
            case 1:
                self setanimrestart( "p8_fxanim_zm_towers_buyable_gate_01_open_anim", 1, 0, 1 );
                break;
            case 2:
                self setanimrestart( "p8_fxanim_zm_towers_buyable_gate_02_a_open_anim", 1, 0, 1 );
                break;
            case 3:
                self setanimrestart( "p8_fxanim_zm_towers_buyable_gate_02_b_open_anim", 1, 0, 1 );
                break;
            case 4:
                break;
        }
        
        return;
    }
    
    if ( bwastimejump == 2 )
    {
        switch ( self.door_type )
        {
            case 1:
                self setanimrestart( "p8_fxanim_zm_towers_buyable_gate_01_close_anim", 1, 0, 1 );
                break;
            case 2:
                self setanimrestart( "p8_fxanim_zm_towers_buyable_gate_02_a_close_anim", 1, 0, 1 );
                break;
            case 3:
                self setanimrestart( "p8_fxanim_zm_towers_buyable_gate_02_b_close_anim", 1, 0, 1 );
                break;
        }
    }
}

// Namespace namespace_f63bdb08/namespace_f63bdb08
// Params 7, eflags: 0x4
// Checksum 0xdd0516ca, Offset: 0x5a8
// Size: 0x4a
function private function_7769cbbe( *localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    self.door_type = bwastimejump;
}

