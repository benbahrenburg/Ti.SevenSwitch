/**
 * Copyright (c) 2009-2013 by Benjamin Bahrenburg (bencoding.com) All Rights Reserved.
 * Licensed under the terms of the MIT License
 * Please see the LICENSE included with this distribution for details.
 */

#import "TiSevenswitchSwitchProxy.h"
#import "TiUtils.h"

@implementation TiSevenswitchSwitchProxy

-(NSArray *)keySequence
{
    return [NSArray arrayWithObjects:
            @"switchArea",
            @"activeColor",
            @"inactiveColor",
            @"color",
            nil];
}
@end
