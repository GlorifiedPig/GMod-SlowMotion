
CreateConVar( "slowmotion_multiplier", 0.5, FCVAR_NONE, "This adjusts how slow the slow motion will go whenever you activate it." )
CreateConVar( "slowmotion_keybind", "k", FCVAR_NONE, "This is the keybind used to toggle slow motion." )

function SlowMotion.AddToolMenuCategory()
    spawnmenu.AddToolCategory( "Utilities", "SlowMotion", "Slow Motion Mod" )
end

function SlowMotion.AddToolMenuOptions()
    spawnmenu.AddToolMenuOption( "Utilities", "SlowMotion", "SlowMotion_Settings", "Settings", "", "", function( panel )
        panel:ClearControls()
        local slowMotionMultiplier = panel:NumSlider( "Slow Motion Multiplier", "slowmotion_multiplier", 0.01, 0.99, 2 )
        slowMotionMultiplier:SetValue( 0.5 )
        panel:ControlHelp( "This adjusts how slow the slow motion will go whenever you activate it." )

        panel:TextEntry( "Slow Motion Keybind", "slowmotion_keybind" )
        panel:Button( "Bind", "" )
        panel:ControlHelp( "This is the keybind used to toggle slow motion. WARNING: Clicking 'Bind' will reset all keys assigned to that key!" )
    end )
end

hook.Add( "AddToolMenuCategories", "SlowMotion.Core.AddToolMenuCategories", function()
    SlowMotion.AddToolMenuCategory()
end )

hook.Add( "PopulateToolMenu", "SlowMotion.Core.PopulateToolMenu", function()
    SlowMotion.AddToolMenuOptions()
end )