var mod = require('ti.sevenswitch');
Ti.API.info("module is => " + mod);

// open a single window
var win = Ti.UI.createWindow({
	backgroundColor:'white', layout:'vertical'
});

win.add(Ti.UI.createLabel({
	text:"Default", textAlign:"left", height:25, left:7, top:0
}));

var defaultSwitch = mod.createSwitch({
	top:5, left:20, value:true, height:30, width:50
});
win.add(defaultSwitch);

win.add(Ti.UI.createLabel({
	text:"Sized Switch", textAlign:"left", height:25, left:7, top:15
}));

var bigSwitch = mod.createSwitch({
	top:5, height:50, width:250, left:20, value:true, switchArea:{
		height:50, width:250
	}
});
win.add(bigSwitch);


win.open();