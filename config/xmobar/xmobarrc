-- The .hs version is just for editing and highlighting with nvim
-- Copy into the extensionless xmobarrc afterwards
Config {

   -- appearance
     font =         "JetBrains Mono Nerd Font Mono Bold 11"
   , bgColor =      "#1a1b26"
   , fgColor =      "#a9b1d6"
   , position =     BottomH 26
   -- , border =       BottomB
   -- , borderColor =  "#646464"

   -- layout
   , sepChar =  "%"   -- delineator between plugin names and straight text
   , alignSep = "}{"  -- separator between left-right alignment
   , template = " %multicpu% | %coretemp% | %memory% }{ %alsa:default:Master% | %battery% | %date% "

   -- general behavior
   , lowerOnStart =     True    -- send to bottom of window stack on start
   , hideOnStart =      False   -- start with window unmapped (hidden)
   , allDesktops =      True    -- show on all desktops
   , overrideRedirect = True    -- set the Override Redirect flag (Xlib)
   , pickBroadest =     False   -- choose widest display (multi-monitor)
   , persistent =       True    -- enable/disable hiding (True = disabled)

   -- plugins
   --   Numbers can be automatically colored according to their value. xmobar
   --   decides color based on a three-tier/two-cutoff system, controlled by
   --   command options:
   --     --Low sets the low cutoff
   --     --High sets the high cutoff
   --
   --     --low sets the color below --Low cutoff
   --     --normal sets the color between --Low and --High cutoffs
   --     --High sets the color above --High cutoff
   --
   --   The --template option controls how the plugin is displayed. Text
   --   color can be set by enclosing in <fc></fc> tags. For more details
   --   see http://projects.haskell.org/xmobar/#system-monitor-plugins.
   , commands =

        [

        -- cpu activity monitor
        Run MultiCpu       [ "--template" , "CPU <total>%"
                             , "--Low"      , "50"         -- units: %
                             , "--High"     , "85"         -- units: %
                             , "--low"      , "green"
                             , "--normal"   , "darkorange"
                             , "--high"     , "darkred"
                             ] 50

        -- cpu core temperature monitor
        , Run CoreTemp       [ "--template" , "TEMP <core0>°C"
                             , "--Low"      , "70"        -- units: °C
                             , "--High"     , "80"        -- units: °C
                             , "--low"      , "green"
                             , "--normal"   , "darkorange"
                             , "--high"     , "darkred"
                             ] 50

        -- memory usage monitor
        , Run Memory         [ "--template" , "MEM <usedratio>%"
                             , "--Low"      , "25"        -- units: %
                             , "--High"     , "75"        -- units: %
                             , "--low"      , "green"
                             , "--normal"   , "darkorange"
                             , "--high"     , "darkred"
                             ] 50

        -- battery monitor
        , Run Battery        [ "--template" , "BATT <acstatus>"
                             , "--Low"      , "10"        -- units: %
                             , "--High"     , "80"        -- units: %
                             , "--low"      , "darkred"
                             , "--normal"   , "darkorange"
                             , "--high"     , "green"

                             , "--" -- battery specific options
                                       -- discharging status
                                       , "-o", "<left>% (<timeleft>)"
                                       -- AC "on" status
                                       , "-O", "<left>% <fc=#dAA520>Charging</fc>"
                                       -- charged status
                                       , "-i", "<fc=#006000>Charged</fc>"
                             ] 50
        -- volume monitor which uses alsa
        , Run Alsa           "default" "Master" 
                             [ "--template", "VOL <volume>% <status>"
                             , "--Low"      , "15"        -- units:dB
                             , "--High"     , "25"        -- units:dB
                             , "--low"      , "lightgreen"
                             , "--normal"   , "darkorange"
                             , "--high"     , "darkred"

                             , "--" -- volume specific options
                                       -- muted
                                       , "-o", "OFF"
                                       -- not muted
                                       , "-O", "ON"
                             ]

        -- time and date indicator 
        --   (%F = y-m-d date, %a = day of week, %T = h:m:s time)
        , Run Date           "<fc=#ABABAB>%F %a %T</fc>" "date" 50

        ]
   }
