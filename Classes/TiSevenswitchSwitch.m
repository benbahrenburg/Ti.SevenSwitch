/**
 * Copyright (c) 2009-2013 by Benjamin Bahrenburg (bencoding.com) All Rights Reserved.
 * Licensed under the terms of the MIT License
 * Please see the LICENSE included with this distribution for details.
 */

#import "TiSevenswitchSwitch.h"

@implementation TiSevenswitchSwitch

-(void)dealloc
{
	[switchView removeTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
}

-(SevenSwitch*)switchView
{
	if (switchView==nil)
	{
		switchView = [[SevenSwitch alloc] init];
		[switchView addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
        //Set the defaults
        switchView.knobColor = [UIColor colorWithRed:0.19f green:0.23f blue:0.33f alpha:1.00f];
        switchView.activeColor = [UIColor colorWithRed:0.07f green:0.09f blue:0.11f alpha:1.00f];
        switchView.inactiveColor = [UIColor colorWithRed:0.07f green:0.09f blue:0.11f alpha:1.00f];
        switchView.onColor = [UIColor colorWithRed:0.45f green:0.58f blue:0.67f alpha:1.00f];
        switchView.borderColor = [UIColor clearColor];
        switchView.shadowColor = [UIColor blackColor];
        
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
	UIColor *clr = [newColor _color];
	SevenSwitch *sw = [self switchView];
    sw.knobColor = clr;
}
-(void)setActiveColor_:(id)value
{
    TiColor *newColor = [TiUtils colorValue:value];
	UIColor *clr = [newColor _color];
	SevenSwitch *sw = [self switchView];
    sw.knobColor = clr;
}
-(void)setInactiveColor_:(id)value
{
    TiColor *newColor = [TiUtils colorValue:value];
	UIColor *clr = [newColor _color];
	SevenSwitch *sw = [self switchView];
    sw.knobColor = clr;
}
-(void)setOnColor_:(id)value
{
    TiColor *newColor = [TiUtils colorValue:value];
	UIColor *clr = [newColor _color];
	SevenSwitch *sw = [self switchView];
    sw.onColor = clr;
}
-(void)setBorderColor_:(id)value
{
    TiColor *newColor = [TiUtils colorValue:value];
	UIColor *clr = [newColor _color];
	SevenSwitch *sw = [self switchView];
    sw.borderColor = clr;
}
-(void)setShadowColor_:(id)value
{
    TiColor *newColor = [TiUtils colorValue:value];
	UIColor *clr = [newColor _color];
	SevenSwitch *sw = [self switchView];
    sw.shadowColor = clr;
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

-(CGFloat)verifyWidth:(CGFloat)suggestedWidth
{
	return [switchView sizeThatFits:CGSizeZero].width;
}

-(CGFloat)verifyHeight:(CGFloat)suggestedHeight
{
	return [switchView sizeThatFits:CGSizeZero].height;
}

USE_PROXY_FOR_VERIFY_AUTORESIZING

@end
