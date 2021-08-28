import XMonad
import Data.Monoid
import Data.Maybe (fromJust)
import System.Exit
import System.IO

-- Utilities
import XMonad.Util.Run (spawnPipe)
import XMonad.Util.SpawnOnce
-- import XMonad.Util.EZConfig (additionalKeys)

-- Hooks
import XMonad.Hooks.DynamicLog (dynamicLogWithPP, wrap, xmobarPP, xmobarColor, shorten, PP(..))
import XMonad.Hooks.ManageDocks (avoidStruts, docksEventHook, manageDocks, ToggleStruts(..))
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageHelpers (doCenterFloat)

-- Layouts
import XMonad.Layout.Spacing
import XMonad.Layout.NoBorders
import XMonad.Layout.ThreeColumns

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
myTerminal      = "alacritty"

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = False

-- Whether clicking on a window to focus also passes the click to the window
myClickJustFocuses :: Bool
myClickJustFocuses = True

-- Width of the window border in pixels.
--
myBorderWidth   = 3

-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myModMask       = mod4Mask

-- The default number of workspaces (virtual screens) and their names.
-- By default we use numeric strings, but any string may be used as a
-- workspace name. The number of workspaces is determined by the length
-- of this list.
--
-- A tagging example:
--
-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
--

myWorkspaces    = ["1","2","3","4","5","6","7","8","9"]
myWorkspaceIndices = M.fromList $ zipWith (,) myWorkspaces [1..] -- (,) == \x y -> (x,y)

clickable ws = "<action=xdotool key super+"++show i++">"++ws++"</action>"
    where i = fromJust $ M.lookup ws myWorkspaceIndices


-- Border colors for unfocused and focused windows, respectively.
--
myNormalBorderColor  = "#727072"
myFocusedBorderColor = "#AB9DF2"

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--START_KEYS
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- | XMONAD ACTIONS:
    -- Quit xmonad                  - Mod + Shift + q
    [ ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))

    -- Recompile and Restart xmonad	- Mod + q
    , ((modm              , xK_q     ), spawn "xmonad --recompile; xmonad --restart")



    -- | LAUNCH APPLICATIONS:
    -- Launch a terminal [alacritty]    - Mod + Shift + Enter
    , ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)

    -- Launch browser [brave]           - Mod + Shift + b
    , ((modm .|. shiftMask, xK_b     ), spawn "brave")

    -- Launch file manager [pcmanfm]    - Mod + Shift + f
    , ((modm .|. shiftMask, xK_f     ), spawn "pcmanfm")

	-- Launch bluetooth manager [blueman]	- Mod + b
    , ((modm 			, xK_b     ), spawn "blueman-manager")

    -- Launch dmenu                     - Mod + p
    , ((modm            , xK_p       ), spawn "dmenu_run -c -l 15 -p 'Run: '")

    -- Launch dmenu in config edit mode - Mod + c
    , ((modm            , xK_c		 ), spawn "sh /home/anirudh/.config/dmenu-scripts/dmenu-conf.sh")
    
    
    
    -- | MULTIMEDIA KEYS:
    -- Increase volume              - Dedicated Volume Up key
    , ((0               , 0x1008ff13 ), spawn "sh ~/.config/dunst/volume.sh up")

    -- Decrease volume              - Dedicated Volume Down key
    , ((0               , 0x1008ff11 ), spawn "sh ~/.config/dunst/volume.sh down")

    -- Mute audio                   - Dedicated Mute key
    , ((0               , 0x1008ff12 ), spawn "sh ~/.config/dunst/volume.sh mute")

    -- Increase display brightness  - Dedicated Increase brightness key
    , ((0               , 0x1008ff02 ), spawn "xbacklight -inc 10")

    -- Decrease display brightness  - Dedicated Decrease brightness key
    , ((0               , 0x1008ff03 ), spawn "xbacklight -dec 10")

    
    
    -- | DISPLAY ACTIONS:
    -- Lock screen [slock]    - Ctrl + Alt + l
    , ((controlMask .|. mod1Mask,xK_l), spawn "slock")

    -- Screenshot [flameshot] - Mod + Shift + s
    , ((modm .|. shiftMask, xK_s     ), spawn "flameshot gui")

    -- Show all keybindings   - Mod + Shift + /
    , ((modm .|. shiftMask, xK_slash ), spawn "sh ~/.xmonad/keybindings.sh")

    
    
    -- | WINDOW ACTIONS:
    -- Close focused window                                   - Mod + Shift + c
    , ((modm .|. shiftMask, xK_c     ), kill)

    -- Rotate through the available layout algorithms         - Mod + Space
    , ((modm,               xK_space ), sendMessage NextLayout)

    -- Reset the layouts on the current workspace to default  - Mod + Shift + Space
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size              - Mod + n
    , ((modm,               xK_n     ), refresh)

    -- Move focus to the next window                          - Mod + Tab
    , ((modm,               xK_Tab   ), windows W.focusDown)

    -- Move focus to the next window                          - Mod + j
    , ((modm,               xK_j     ), windows W.focusDown)

    -- Move focus to the previous window                      - Mod + k
    , ((modm,               xK_k     ), windows W.focusUp  )

    -- Move focus to the master window                        - Mod + m
    , ((modm,               xK_m     ), windows W.focusMaster  )

    -- Swap the focused window and the master window          - Mod + Return
    , ((modm,               xK_Return), windows W.swapMaster)

    -- Swap the focused window with the next window           - Mod + Shift + j
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )

    -- Swap the focused window with the previous window       - Mod + Shift + k
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )

    -- Shrink the master area                                 - Mod + h
    , ((modm,               xK_h     ), sendMessage Shrink)

    -- Expand the master area                                 - Mod + l
    , ((modm,               xK_l     ), sendMessage Expand)

    -- Push window back into tiling                           - Mod + t
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)

    -- Increment the number of windows in the master area     - Mod + ,
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area   - Mod + .
    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))

    --Toggle the status bar gap
    --Use this binding with avoidStruts from Hooks.ManageDocks.
    --See also the statusBar function from Hooks.DynamicLog.
    --
    -- , ((modm              , xK_b     ), sendMessage ToggleStruts)

    --Run xmessage with a summary of the default keybindings (useful for beginners)
    -- , ((modm .|. shiftMask, xK_slash ), spawn ("echo \"" ++ help ++ "\" | xmessage -file -"))
    ]
    ++

    --
    -- Switch to workspace N                                  - Mod + 1...9
    -- Move client to workspace N                             - Mod + Shift + 1...9
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++
--END_KEYS
    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]


------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))

    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

------------------------------------------------------------------------
-- Layouts:

-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--
myLayout = avoidStruts $ (tiled ||| Mirror tiled ||| Full ||| ThreeColMid 1 (3/100) (1/2))
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   	= spacing 5 $ Tall nmaster delta ratio

	 -- The default number of windows in the master pane
     nmaster 	= 1

     -- Default proportion of screen occupied by master pane
     ratio   	= 1/2

     -- Percent of screen to increment by when resizing panes
     delta   	= 3/100


------------------------------------------------------------------------
-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook = composeAll
    [ className =? "MPlayer"        --> doFloat
    , className =? "Gimp"           --> doFloat
    , className =? "qalculate-gtk"  --> doFloat
    , className =? "Yad"            --> doCenterFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore ]

------------------------------------------------------------------------
-- Event handling

-- * EwmhDesktops users should change this to ewmhDesktopsEventHook
--
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
-- myEventHook = mempty

------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
-- myLogHook = return()

------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
myStartupHook = do
	spawnOnce "nitrogen --restore &"
	spawnOnce "dunst &"
	spawnOnce "picom -b --config ~/.config/picom/picom.conf"

------------------------------------------------------------------------
-- Window Count
--

-- windowCount :: X (Maybe String)
windowCount = gets $ Just . show . length . W.integrate' . W.stack . W.workspace . W.current . windowset

------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

-- Run xmonad with the settings you specify. No need to modify this.

main = do
	xmproc <- spawnPipe "xmobar /home/anirudh/.config/xmobar/xmobarrc0"
	xmonad $ ewmh def 
		{
      	-- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        clickJustFocuses   = myClickJustFocuses,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

      	-- key bindings
        keys               = myKeys,
        mouseBindings      = myMouseBindings,

      	-- hooks, layouts
        layoutHook         = myLayout,
        manageHook         = myManageHook <+> manageDocks,
        handleEventHook    = docksEventHook <+> fullscreenEventHook,
        logHook            = dynamicLogWithPP $ xmobarPP
                            {   ppOutput = hPutStrLn xmproc                         	      -- xmobar on monitor
                              , ppCurrent = xmobarColor "#78DCE8" "" . wrap "[" "]"           -- Current workspace
                              , ppVisible = xmobarColor "#403E41" "" . clickable              -- Visible but not current workspace
                              , ppHidden = xmobarColor "#FC9867" "" . wrap "*" "" . clickable -- Hidden workspaces
                              , ppHiddenNoWindows = xmobarColor "#727072" ""  . clickable     -- Hidden workspaces (no windows)
                              , ppTitle = xmobarColor "#727072" "" . shorten 60               -- Title of active window
                              , ppSep =  "  |  "						                      -- Separator character
                              , ppUrgent = xmobarColor "#C45500" "" . wrap "!" "!"            -- Urgent workspace
                              , ppExtras  = [windowCount]                                     -- # of windows current workspace
                              , ppOrder  = \(ws:l:t:ex) -> [ws,l]++ex++[t]                    -- order of things in xmobar
                            },
        startupHook        = myStartupHook
    	}
