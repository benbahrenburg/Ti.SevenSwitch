// This is a test harness for your module
// You should do something interesting in this harness 
// to test out the module and to provide instructions 
// to users on how to use it by example.


// TODO: write your module tests here
var mod = require('ti.sevenswitch');
Ti.API.info("module is => " + mod);

// open a single window
var win = Ti.UI.createWindow({
	backgroundColor:'white'
});

var mySwitch = mod.createSwitch({
	top:20, height:80, width:250, left:20, value:true
});
win.add(mySwitch);

win.open();