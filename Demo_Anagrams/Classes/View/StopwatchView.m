//
//  StopwatchView.m
//  Demo_Anagrams
//
//  Created by game-netease-chuyou on 2018/5/16.
//  Copyright © 2018年 chuyou. All rights reserved.
//

#import "StopwatchView.h"
#import "config.h"
@implementation StopwatchView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.font = kFontHUDBig;
        NSLog(@"font : %@",self.font);
    }
    return self;
}

- (void)setSeconds:(int)seconds
{
    self.text = [NSString stringWithFormat:@" %02.f : %02i", round(seconds / 60), seconds % 60];
}

@end
