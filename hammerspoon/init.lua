iconWidth = 156
hs.window.animationDuration = 0
laptopScreen = "Color LCD"
homeMainMonitor = "DELL U2715H"

-- Add constant to layout
function maximizedWithIcons()
  local screen = hs.screen.primaryScreen()
  local screenFrame = screen:frame()
  return hs.geometry.rect(0, 0, 1 - (iconWidth / screenFrame.w), 1)
end
hs.layout.maximizedWithIcons = maximizedWithIcons()

-- Modal setup
local modal = hs.hotkey.modal.new({"shift", "cmd"}, ";")
local enterModal = function() modal:enter() end
local exitModal = function() modal:exit() end

-- Main window with a small strip on the right to see desktop icons
modal:bind({}, "1", function()
  local win = hs.window:focusedWindow()
  local screen = hs.screen.primaryScreen()
  local frame = screen:fromUnitRect(hs.layout.maximizedWithIcons)

  win:setFrame(frame)
  win:moveToScreen(homeMainMonitor, true)
  exitModal()
end)

-- Thin window on the left (messages, mastodon, etc)
modal:bind({}, "2", function()
  local win = hs.window:focusedWindow()
  local screen = hs.screen.primaryScreen()
  local frame = screen:fromUnitRect(hs.layout.left25)

  win:setFrame(frame)
  win:moveToScreen(homeMainMonitor, true)
  exitModal()
end)

modal:bind({}, "[", function()
  local win = hs.window:focusedWindow()
  local screen = hs.screen.find(laptopScreen)
  local frame = screen:fromUnitRect(hs.layout.maximized)

  win:setFrame(frame)
  win:moveToScreen(homeMainMonitor, true)
  exitModal()
end)

-- Full size on laptop screen
modal:bind({}, "[", function()
  local win = hs.window:focusedWindow()
  local screen = hs.screen.find(laptopScreen)
  local screenFrame = screen:frame()
  local widthWithIconSpace = screenFrame.w - iconWidth
  local frame = hs.geometry.rect(0, 0, widthWithIconSpace, screenFrame.h)

  win:setFrame(frame)
  win:moveToScreen(laptopScreen, true)
  exitModal()
end)

modal:bind({}, "left", function()
  local win = hs.window:focusedWindow()
  local screen = hs.screen.primaryScreen()
  local frame = screen:fromUnitRect(hs.layout.left50)

  win:setFrame(frame)
  win:moveToScreen(homeMainMonitor, true)
  exitModal()
end)

modal:bind({}, "right", function()
  local win = hs.window:focusedWindow()
  local screen = hs.screen.primaryScreen()
  local frame = screen:fromUnitRect(hs.layout.right50)

  win:setFrame(frame)
  win:moveToScreen(homeMainMonitor, true)
  exitModal()
end)

modal:bind({}, "return", function()
  local primaryMonitor = hs.screen.primaryScreen()
  local mainFrame = primaryMonitor:frame()
  local widthWithIconSpace = mainFrame.w - iconWidth
  local fullWithIconSpace = hs.geometry.rect(0, 0, widthWithIconSpace, mainFrame.h)
  if primaryMonitor:name() == laptopScreen then
    local windowLayout = {
      {nil, allWindowsFilter, primaryMonitor, nil, fullWithIconSpace, nil},
      -- some specific app window configs
      {"Gitter", nil, laptopScreen, hs.layout.maximized, nil, nil},
      {"Messages", nil, primaryMonitor, hs.layout.left25, nil, nil},
      {"Slack", nil, laptopScreen, hs.layout.maximized, nil, nil},
      {"Terminal", nil, primaryMonitor, hs.layout.left50, nil, nil},
    }
    hs.layout.apply(windowLayout)
  else
    local windowLayout = {
      {nil, allWindowsFilter, primaryMonitor, nil, fullWithIconSpace, nil},
    }
    hs.layout.apply(windowLayout)
  end
  exitModal()
end)

-- filter for windows
function allWindowsFilter(_)
  local filter = hs.window.filter.default
  filter:unsubscribeAll()
  filter:rejectApp("Finder")
  filter:rejectApp("Gitter")
  filter:rejectApp("Hammerspoon")
  filter:rejectApp("Messages")
  filter:rejectApp("Slack")
  filter:rejectApp("Terminal")

  return filter:getWindows()
end

function reloadConfig(files)
    doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end
myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show("Hammerspoon reloaded")
