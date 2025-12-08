#using script_164a456ce05c3483;
#using script_17dcb1172e441bf6;
#using script_1a9763988299e68d;
#using script_1b01e95a6b5270fd;
#using script_1b0b07ff57d1dde3;
#using script_1ee011cd0961afd7;
#using script_2a5bf5b4a00cee0d;
#using script_40f967ad5d18ea74;
#using script_47851dbeea22fe66;
#using script_4d748e58ce25b60c;
#using script_5701633066d199f2;
#using script_5f20d3b434d24884;
#using script_74a56359b7d02ab6;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace namespace_b754744b;

// Namespace namespace_b754744b/namespace_e4817c87
// Params 1
// Checksum 0x7b6b60e1, Offset: 0x148
// Size: 0xd2
function function_b784c6bd( type )
{
    switch ( type )
    {
        case 10:
            self namespace_83eb6304::function_3ecfde67( "player_healOS" );
            self.health += 150;
            
            if ( self.health < self.health )
            {
                self.health = self.health;
            }
            else if ( self.health > 150 )
            {
                self.health = 150;
            }
            
            break;
        case 12:
            self thread function_c3b1a6af();
            break;
    }
}

// Namespace namespace_b754744b/namespace_e4817c87
// Params 0
// Checksum 0x94766ac7, Offset: 0x228
// Size: 0x94
function function_c3b1a6af()
{
    self endon( #"disconnect" );
    self clientfield::set_to_player( "generator_sonar", 1 );
    waitresult = self waittilltimeout( 10, #"death", #"entering_last_stand" );
    self clientfield::set_to_player( "generator_sonar", 0 );
}

