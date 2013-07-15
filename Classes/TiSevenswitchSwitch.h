/**
 * Copyright (c) 2009-2013 by Benjamin Bahrenburg (bencoding.com) All Rights Reserved.
 * Licensed under the terms of the MIT License
 * Please see the LICENSE included with this distribution for details.
 */

#import "TiUIView.h"
#import "SevenSwitch.h"

@interface TiSevenswitchSwitch : TiUIView<LayoutAutosizing> {
@private
	SevenSwitch *switchView;
}

- (IBAction)switchChanged:(id)sender;

@end