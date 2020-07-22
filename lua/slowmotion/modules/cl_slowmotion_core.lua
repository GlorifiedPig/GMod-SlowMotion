
CreateConVar( "slowmotion_multiplier", 0.75, FCVAR_NONE, "This adjusts how slow the slow motion will go whenever you activate it." )

function SlowMotion.AddToolMenuCategory()
    spawnmenu.AddToolCategory( "Utilities", "SlowMotion", "Slow Motion Mod" )
end

function SlowMotion.AddToolMenuOptions()
    spawnmenu.AddToolMenuOption( "Utilities", "SlowMotion", "SlowMotion_Settings", "Settings", "", "", function( panel )
        panel:ClearControls()
        local slowMotionMultiplier = panel:NumSlider( "Slow Motion Multiplier", "slowmotion_multiplier", 0.01, 1, 2 )
        slowMotionMultiplier:SetValue( 0.75 )
        panel:ControlHelp( "This adjusts how slow the slow motion will go whenever you activate it." )
    end )
end

hook.Add( "AddToolMenuCategories", "SlowMotion.Core.AddToolMenuCategories", function()
    SlowMotion.AddToolMenuCategory()
end )

hook.Add( "PopulateToolMenu", "SlowMotion.Core.PopulateToolMenu", function()
    SlowMotion.AddToolMenuOptions()
end )