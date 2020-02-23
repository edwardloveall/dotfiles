iconWidth = 156
hs.window.animationDuration = 0
laptopScreenId = "Color LCD"
homeMainScreenId = "iMac"

primaryScreen = hs.screen.primaryScreen()
laptopScreen = hs.screen.find(laptopScreenId)
iMacOnly = primaryScreen:name() == homeMainScreenId

if iMacOnly then
  laptopScreen = primaryScreen
end

-- Add constant to layout
function maximizedWithIcons()
  local screenFrame = primaryScreen:frame()
  return hs.geometry.rect(0, 0, 1 - (iconWidth / screenFrame.w), 1)
end
hs.layout.maximizedWithIcons = maximizedWithIcons()

-- Modal setup
modal = hs.hotkey.modal.new({"shift", "cmd"}, ";")
enterModal = function() modal:enter() end
exitModal = function() modal:exit() end

-- Window Filters
primaryFrame = primaryScreen:frame()
smallWidth = primaryFrame.w * 0.40
smallHeight = primaryFrame.h * 0.60
allOther = hs.window.filter.new(
  function(win)
    local frame = win:frame()
    return frame.w > smallWidth and frame.h > smallHeight
  end
)
allOther:setFilters({
  ["Mastonaut"] = false,
  ["Messages"] = false,
  ["Slack"] = false,
  ["Gitter"] = false,
  ["Hammerspoon"] = false,
})
allOtherWindows = function()
  return allOther:getWindows()
end

-- Main window with a small strip on the right to see desktop icons
modal:bind({}, "1", function()
  local win = hs.window:focusedWindow()
  local frame = primaryScreen:fromUnitRect(hs.layout.maximizedWithIcons)

  win:setFrame(frame)
  win:moveToScreen(homeMainScreenId, true)
  exitModal()
end)

-- Thin window on the left (messages, mastodon, etc)
modal:bind({}, "2", function()
  local win = hs.window:focusedWindow()
  local frame = primaryScreen:fromUnitRect(hs.layout.left25)

  win:setFrame(frame)
  win:moveToScreen(homeMainScreenId, true)
  exitModal()
end)

-- Full size on laptop screen
modal:bind({}, "[", function()
  local win = hs.window:focusedWindow()
  local screenFrame = laptopScreen:frame()
  local widthWithIconSpace = screenFrame.w - iconWidth
  local frame = hs.geometry.rect(0, 0, widthWithIconSpace, screenFrame.h)

  win:setFrame(frame)
  win:moveToScreen(laptopScreenId, true)
  exitModal()
end)

modal:bind({}, "left", function()
  local win = hs.window:focusedWindow()
  local frame = primaryScreen:fromUnitRect(hs.layout.left50)

  win:setFrame(frame)
  win:moveToScreen(homeMainScreenId, true)
  exitModal()
end)

modal:bind({}, "right", function()
  local win = hs.window:focusedWindow()
  local frame = primaryScreen:fromUnitRect(hs.layout.right50)

  win:setFrame(frame)
  win:moveToScreen(homeMainScreenId, true)
  exitModal()
end)

modal:bind({}, "return", function()
  local mainFrame = primaryScreen:frame()
  local fullWithIconSpace = primaryScreen:fromUnitRect(hs.layout.maximizedWithIcons)
  local laptopWidth = fullWithIconSpace

  if iMacOnly then
    local halfWidth = laptopScreen:fromUnitRect(hs.layout.left50)
    laptopWidth = hs.geometry.rect(0, 0, halfWidth.w, mainFrame.h)
  end
  print(table.unpack(allOtherWindows()))

  local windowLayout = {
    { nil, allOtherWindows, primaryScreen, nil, fullWithIconSpace, nil },
    {"Messages", nil, primaryScreen, hs.layout.left25, nil, nil},
    {"Mastonaut", nil, primaryScreen, hs.layout.left50, nil, nil},
    {"Slack", nil, laptopScreen, nil, laptopWidth, nil},
    {"Gitter", nil, laptopScreen, nil, laptopWidth, nil},
  }

  hs.layout.apply(windowLayout)

  exitModal()
end)

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
