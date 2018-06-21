// Utilities
var key = function(key) {
  return key + ':d,shift,alt,cmd'
}

// Variables
var laptop = '1680x1050',
    sizePrimary = { 'direction': 'top-left', 'width': 'screenSizeX*.9', 'height': 'screenSizeY' },
    sizeLaptopPrimary = { 'direction': 'top-left', 'width': 'screenSizeX*.9', 'height': 'screenSizeY' },
    sizeSocialFeed = { 'direction': 'top-left', 'width': 'screenSizeX*.2', 'height': 'screenSizeY' },
    sizeLeft = { 'direction': 'top-left', 'width': 'screenSizeX/2', 'height': 'screenSizeY' },
    sizeRight = { 'direction': 'top-right', 'width': 'screenSizeX/2', 'height': 'screenSizeY' },
    sizeContactList = { 'direction': 'top-right', width: '226' },
    screenLaptop = { 'screen': laptop };

// Operations
var mainBase = slate.operation('corner', {
  'screen': '0', direction: 'top-left'
});
var laptopBase = mainBase.dup(screenLaptop);

var mainScreenPrimary = mainBase.dup(sizePrimary),
    mainScreenLeft = mainBase.dup(sizeLeft),
    mainScreenRight = mainBase.dup(sizeRight),
    mainScreenSocial = mainBase.dup(sizeSocialFeed),
    laptopScreenSocial = mainScreenSocial.dup(screenLaptop),
    laptopScreenPrimary = laptopBase.dup(sizeLaptopPrimary)


// Layouts
var layoutDual = slate.layout('layoutDual', {
  'Airmail':  { 'operations': [mainScreenPrimary] },
  'Calendar': { 'operations': [mainScreenPrimary] },
  'Chrome':   { 'operations': [mainScreenPrimary] },
  'Dash':     { 'operations': [mainScreenPrimary] },
  'iTunes':   { 'operations': [mainScreenPrimary] },
  'MailMate': { 'operations': [mainScreenPrimary] },
  'Maps':     { 'operations': [mainScreenPrimary] },
  'Preview':  { 'operations': [mainScreenPrimary] },
  'ReadKit':  { 'operations': [mainScreenPrimary] },
  'Reeder':   { 'operations': [mainScreenPrimary] },
  'Safari':   { 'operations': [mainScreenPrimary] },
  'Spotify':  { 'operations': [mainScreenPrimary] },
  'Tower':    { 'operations': [mainScreenPrimary] },
  'Xcode':    { 'operations': [mainScreenPrimary] },

  'Atom':         { 'operations': [mainScreenRight], repeat: true },
  'Gitter':       { 'operations': [laptopScreenPrimary] },
  'Messages':     { 'operations': [mainScreenSocial] },
  'Slack':        { 'operations': [laptopScreenPrimary] },
  'Terminal':     { 'operations': [mainScreenLeft] },
  'Twitterrific': { 'operations': [mainScreenSocial] }
});

var layoutSingular = slate.layout('layoutSingular', {
  'Airmail':  { 'operations': [laptopScreenPrimary] },
  'Calendar': { 'operations': [laptopScreenPrimary] },
  'Chrome':   { 'operations': [laptopScreenPrimary] },
  'Dash':     { 'operations': [laptopScreenPrimary] },
  'iTunes':   { 'operations': [laptopScreenPrimary] },
  'MailMate': { 'operations': [laptopScreenPrimary] },
  'Maps':     { 'operations': [laptopScreenPrimary] },
  'Preview':  { 'operations': [laptopScreenPrimary] },
  'ReadKit':  { 'operations': [laptopScreenPrimary] },
  'Reeder':   { 'operations': [laptopScreenPrimary] },
  'Safari':   { 'operations': [laptopScreenPrimary] },
  'Spotify':  { 'operations': [laptopScreenPrimary] },
  'Tower':    { 'operations': [laptopScreenPrimary] },
  'Xcode':    { 'operations': [laptopScreenPrimary] },

  'Atom':         { 'operations': [laptopScreenPrimary], repeat: true },
  'Gitter':       { 'operations': [laptopScreenPrimary] },
  'Messages':     { 'operations': [laptopScreenSocial] },
  'Slack':        { 'operations': [laptopScreenPrimary] },
  'Terminal':     { 'operations': [laptopScreenPrimary] },
  'Twitterrific': { 'operations': [laptopScreenSocial] }
});

slate.default(2, layoutDual);
slate.default(laptop, layoutSingular);

// Layout Operations
var oneMonitor = slate.operation('layout', { 'name': layoutSingular });
var twoMonitor = slate.operation('layout', { 'name': layoutDual });

// Bindings
slate.bind(key('1'), mainScreenPrimary);
slate.bind(key('2'), mainScreenSocial);
slate.bind(key('['), laptopScreenPrimary);
slate.bind(key('left'), mainScreenLeft);
slate.bind(key('right'), mainScreenRight);

slate.bind(key('return'), function(window) {
  if(slate.screenCount() === 1) {
    oneMonitor.run();
  } else {
    twoMonitor.run();
  }
});

slate.bind(key('r'), slate.operation('relaunch'));

// Global Config
slate.configAll({
  "orderScreensLeftToRight": false
});
