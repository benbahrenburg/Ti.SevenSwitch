[![gitTio](http://gitt.io/badge.svg)](http://gitt.io/component/ti.sevenswitch)

## Ti.SevenSwitch

The Ti.SevenSwitch project allows you to use [Ben Vogelzang's](https://github.com/bvogelzang) awesome open source [SevenSwitch](https://github.com/bvogelzang/SevenSwitch) project in your Titanium iOS app.


![Animation](https://raw.github.com/benbahrenburg/Ti.SevenSwitch/master/demo.gif)

![Default](https://raw.github.com/benbahrenburg/Ti.SevenSwitch/master/demo.png)


### Before you start
* These are iOS and Android native modules designed to work with Titanium SDK 3.4.1.GA
* Before using this module you first need to install the package. If you need instructions on how to install a 3rd party module please read this installation guide.


### Get it via Gitt.io

`$ gittio install Ti.SevenSwitch`

### Download the compiled release

Download the module from the [dist folder](https://github.com/benbahrenburg/Ti.SevenSwitch/tree/master/dist)


### Building from source?

If you are building from source you will need to do the following:

Import the project into Xcode:

* Modify the titanium.xcconfig file with the path to your Titanium installation

### Setup

* Download the latest release from the releases folder ( or you can build it yourself )
* Install the ti.sq module. If you need help here is a "How To" [guide](https://wiki.appcelerator.org/display/guides/Configuring+Apps+to+Use+Modules). 
* You can now use the module via the commonJS require method, example shown below.

### Importing the module using require

```js
var mod = require('ti.sevenswitch');
```

### Creating the Switch Object
The Ti.SevenSwitch object supports a majority of the standard [Ti.UI.Switch](http://docs.appcelerator.com/titanium/latest/#!/api/Titanium.UI.Switch) properties.  The below listed properties are specific to the Ti.SevenSwitch object.

<b>Parameters</b>

<b>borderColor</b> : String / Color

Border color of the switch, as a color name or hex triplet.

<b>shadowColor</b> : : String / Color

Shadow color of the switch, as a color name or hex triplet.

<b>knobColor</b> : : String / Color

Color of the switch's knob.  The color is passed as a color name or hex triplet.

<b>onColor</b> : : String / Color

Color displayed when switch is in the "on" status.  The color is passed as a color name or hex triplet.

<b>activeColor</b> : : String / Color

The selection value on the Ti.SQ calendar View

<b>inactiveColor</b> : : String / Color

Color displayed when switch is in the "off" status.  The color is passed as a color name or hex triplet.

<b>onImage</b> : String / Path

Image to be displayed when switch is in the "on" state, specified as a local file path or URL.

<b>offImage</b> : String / Path

Image to be displayed when switch is in the "off" state, specified as a local file path or URL.

### Example

Please check the module's example folder or on [github](https://github.com/benbahrenburg/Ti.SevenSwitch/tree/master/example)

```js
var mod = require('ti.sevenswitch');
Ti.API.info("module is => " + mod);

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
	top:5, height:50, width:250, left:20, value:true
});
win.add(bigSwitch);

win.add(Ti.UI.createLabel({
	text:"Knob Color", textAlign:"left", height:25, left:7, top:15
}));
var colorKnobSwitch = mod.createSwitch({
	top:5, left:20, height:30, width:50, value:true, knobColor:"orange"
});
win.add(colorKnobSwitch);

win.add(Ti.UI.createLabel({
	text:"Active/Pressed Color", textAlign:"left", height:25, left:7, top:15
}));
var activeColorSwitch = mod.createSwitch({
	top:5, left:20, height:30, value:true, activeColor:"orange", height:30, width:50
});
win.add(activeColorSwitch);

win.add(Ti.UI.createLabel({
	text:"On Color", textAlign:"left", height:25, left:7, top:15
}));
var onColorSwitch = mod.createSwitch({
	top:5, left:20, height:30, value:false, onColor:"yellow", height:30, width:50
});
win.add(onColorSwitch);

win.add(Ti.UI.createLabel({
	text:"Inactive Color", textAlign:"left", height:25, left:7, top:15
}));
var inactiveColorSwitch = mod.createSwitch({
	top:5, left:20, height:30, value:false, inactiveColor:"blue", height:30, width:50
});
win.add(inactiveColorSwitch);

win.open();
```

### The SevenSwitch Project

SevenSwitch is an awesome project by Ben Vogelzang which brings the iOS7 style UISwitch to iOS5+.  

To learn more about the project please visit [https://github.com/bvogelzang/SevenSwitch](https://github.com/bvogelzang/SevenSwitch)

### Twitter

If you like the Titanium module,please consider following the [@benCoding Twitter](http://www.twitter.com/benCoding) for updates.

### Blog

For module updates, Titanium tutorials and more please check out my blog at [benCoding.Com](http://benCoding.com).
