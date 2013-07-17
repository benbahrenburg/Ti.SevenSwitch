/**
 * Copyright (c) 2009-2013 by Benjamin Bahrenburg (bencoding.com) All Rights Reserved.
 * Licensed under the terms of the MIT License
 * Please see the LICENSE included with this distribution for details.
 */

#import "TiSevenswitchSwitch.h"
#import "TiViewProxy.h"
#import "TiUtils.h"

@implementation TiSevenswitchSwitch

-(void)dealloc
{
	[switchView removeTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
}

-(SevenSwitch*)switchView
{
	if (switchView==nil)
	{
		switchView = [[SevenSwitch alloc]  initWithFrame:[self bounds]];
		[switchView addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
        
		[self addSubview:switchView];
	}
	return switchView;
}

- (id)accessibilityElement
{
	return [self switchView];
}

-(BOOL)hasTouchableListener
{
	// since this guy only works with touch events, we always want them
	// just always return YES no matter what listeners we have registered
	return YES;
}

#pragma mark View controller stuff

-(void) setIsRounded_:(id)value
{
	[[self switchView] setIsRounded:[TiUtils boolValue:value]];
}
-(void)setEnabled_:(id)value
{
	[[self switchView] setEnabled:[TiUtils boolValue:value]];
}

-(void)setOffImage_:(id)value
{
    SevenSwitch *sw = [self switchView];
	sw.offImage = [self loadImage:value];
}

-(void)setOnImage_:(id)value
{
    SevenSwitch *sw = [self switchView];
	sw.onImage = [self loadImage:value];
}

-(void)setKnobColor_:(id)value
{
    TiColor *newColor = [TiUtils colorValue:value];
	[self switchView].knobColor = [newColor _color];
}
-(void)setActiveColor_:(id)value
{
    TiColor *newColor = [TiUtils colorValue:value];
	[self switchView].activeColor=[newColor _color];
}
-(void)setInactiveColor_:(id)value
{
    TiColor *newColor = [TiUtils colorValue:value];
	[self switchView].inactiveColor = [newColor _color];
}
-(void)setOnColor_:(id)value
{
    TiColor *newColor = [TiUtils colorValue:value];
	[self switchView].onColor = [newColor _color];
}
-(void)setBorderColor_:(id)value
{
    TiColor *newColor = [TiUtils colorValue:value];
	[self switchView].borderColor = [newColor _color];
}
-(void)setShadowColor_:(id)value
{
    TiColor *newColor = [TiUtils colorValue:value];
	[self switchView].shadowColor = [newColor _color];
}
-(void)setValue_:(id)value
{
	// need to check if we're in a reproxy when this is set
	// so we don't artifically trigger a change event or
	// animate the change -- this happens on the tableview
	// reproxy as we scroll
	BOOL reproxying = [self.proxy inReproxy];
	BOOL newValue = [TiUtils boolValue:value];
	BOOL animated = !reproxying;
	SevenSwitch * ourSwitch = [self switchView];
    if ([ourSwitch on] == newValue) {
        return;
    }
	[ourSwitch setOn:newValue animated:animated];
    
	// Don't rely on switchChanged: - isOn can report erroneous values immediately after the value is changed!
	// This only seems to happen in 4.2+ - could be an Apple bug.
	if ((reproxying == NO) && configurationSet && [self.proxy _hasListeners:@"change"])
	{
		[self.proxy fireEvent:@"change" withObject:[NSDictionary dictionaryWithObject:value forKey:@"value"]];
	}
}

-(void)frameSizeChanged:(CGRect)frame bounds:(CGRect)bounds
{
    [super frameSizeChanged:frame bounds:bounds];
    [switchView setFrame:frame];
    [switchView resizeControl];
    [self setCenter:[self center]];
}


-(void)setCenter:(CGPoint)center
{
	CGSize ourSize = [self bounds].size;
	CGPoint ourAnchor = [[self layer] anchorPoint];
	CGFloat originx = center.x - (ourSize.width * ourAnchor.x);
	CGFloat originy = center.y - (ourSize.height * ourAnchor.y);
    
	center.x -= originx - floorf(originx);
	center.y -= originy	- floorf(originy);
    
	[super setCenter:center];
}

- (IBAction)switchChanged:(id)sender
{
	NSNumber * newValue = [NSNumber numberWithBool:[(SevenSwitch *)sender on]];
	[self.proxy replaceValue:newValue forKey:@"value" notification:NO];
    
	//No need to setValue, because it's already been set.
	if ([self.proxy _hasListeners:@"change"])
	{
		[self.proxy fireEvent:@"change" withObject:[NSDictionary dictionaryWithObject:newValue forKey:@"value"]];
	}
}

@end
