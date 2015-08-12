// Utilities
var key = function(key) {
	return key + ':d,shift,alt,cmd'
}

// Variables
var laptop = '1440x900',
		sizePrimary = { 'direction': 'top-left', 'width': 'screenSizeX*.9', 'height': 'screenSizeY' },
		sizeLaptopPrimary = { 'direction': 'top-left', 'width': 'screenSizeX*.8', 'height': 'screenSizeY' },
		sizeSocialFeed = { 'direction': 'top-left', 'width': 'screenSizeX*.2', 'height': 'screenSizeY' },
    sizeLeft = { 'direction': 'top-left', 'width': 'screenSizeX/2', 'height': 'screenSizeY' },
    sizeRight = { 'direction': 'top-right', 'width': 'screenSizeX/2', 'height': 'screenSizeY' },
		sizeContactList = { 'direction': 'top-right', width: '226' },
		screenLaptop = { 'screen': laptop };

// Operations
var mainBase = slate.operation('corner', {
	'screen': '1', direction: 'top-left'
});
var laptopBase = mainBase.dup(screenLaptop);

var mainScreenPrimary = mainBase.dup(sizePrimary),
    mainScreenLeft = mainBase.dup(sizeLeft),
 		mainScreenRight = mainBase.dup(sizeRight),
 		mainScreenSocial = mainBase.dup(sizeSocialFeed),
 		laptopScreenSocial = mainScreenSocial.dup(screenLaptop),
 		laptopScreenPrimary = laptopBase.dup(sizeLaptopPrimary),
		adiumContactScreen = laptopBase.dup(sizeContactList);

var adium = function(win) {
	if (win.title() === 'Contacts') {
		win.doOperation(adiumContactScreen);
	} else {
		win.doOperation(laptopScreenPrimary);
	}
}

// Layouts
var layoutDual = slate.layout('layoutDual', {
	'Safari':		{ 'operations': [mainScreenPrimary] },
	'Chrome': 	{ 'operations': [mainScreenPrimary] },
	'iTunes': 	{ 'operations': [mainScreenPrimary] },
	'Airmail':  { 'operations': [mainScreenPrimary] },
	'ReadKit': 	{ 'operations': [mainScreenPrimary] },
	'Calendar': { 'operations': [mainScreenPrimary] },
	'Preview': 	{ 'operations': [mainScreenPrimary] },
	'Maps': 		{ 'operations': [mainScreenPrimary] },
	'Dash': 		{ 'operations': [mainScreenPrimary] },
	'Xcode': 		{ 'operations': [mainScreenPrimary] },

	'Atom':					{ 'operations': [mainScreenRight], repeat: true },
	'Terminal':			{ 'operations': [mainScreenLeft] },
	'Slack':				{ 'operations': [laptopScreenPrimary] },
	'Adium':				{ 'operations': [adium], repeat: true },
	'Twitterrific':	{ 'operations': [mainScreenSocial] },
	'Messages':			{ 'operations': [mainScreenSocial] }
});

var layoutSingular = slate.layout('layoutSingular', {
	'Safari':		{ 'operations': [laptopScreenPrimary] },
	'Chrome': 	{ 'operations': [laptopScreenPrimary] },
	'iTunes': 	{ 'operations': [laptopScreenPrimary] },
	'Airmail':  { 'operations': [laptopScreenPrimary] },
	'ReadKit': 	{ 'operations': [laptopScreenPrimary] },
	'Calendar': { 'operations': [laptopScreenPrimary] },
	'Preview': 	{ 'operations': [laptopScreenPrimary] },
	'Maps': 		{ 'operations': [laptopScreenPrimary] },
	'Dash': 		{ 'operations': [laptopScreenPrimary] },
	'Xcode': 		{ 'operations': [laptopScreenPrimary] },

	'Atom':					{ 'operations': [laptopScreenPrimary], repeat: true },
	'Terminal':			{ 'operations': [laptopScreenPrimary] },
	'Slack':				{ 'operations': [laptopScreenPrimary] },
	'Adium':				{ 'operations': [adium], repeat: true },
	'Twitterrific':	{ 'operations': [laptopScreenSocial] },
	'Messages':			{ 'operations': [laptopScreenSocial] }
});

slate.default(2, layoutDual);
slate.default(laptop, layoutSingular);

// Layout Operations
var oneMonitor = slate.operation('layout', { 'name': layoutSingular });
var twoMonitor = slate.operation('layout', { 'name': layoutDual });

// Bindings
slate.bind(key('1'), mainScreenPrimary);
slate.bind(key('2'), mainScreenSocial);
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
