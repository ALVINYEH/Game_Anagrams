//
//  CounterLabelView.m
//  Demo_Anagrams
//
//  Created by game-netease-chuyou on 2018/5/18.
//  Copyright © 2018年 chuyou. All rights reserved.
//

#import "CounterLabelView.h"

@implementation CounterLabelView
{
    int endValue;
    double delta;
}

+ (instancetype)labelWithFont:(UIFont *)font frame:(CGRect)rect andValue:(int)value
{
    CounterLabelView *label = [[CounterLabelView alloc] initWithFrame:rect];
    if (label != nil) {
        label.backgroundColor = [UIColor clearColor];
        label.font = font;
        label.value = value;
    }
    
    return label;
}

- (void)setValue:(int)value
{
    _value = value;
    self.text = [NSString stringWithFormat:@" %i ", self.value];
}

- (void)updateValueBy:(NSNumber *)valueDelta
{
    self.value += [valueDelta intValue];
    if ([valueDelta intValue] > 0) {
        if (self.value > endValue) {
            self.value = endValue;
            return;
        }
    } else {
            if (self.value < endValue) {
                self.value = endValue;
                return;
            }
        }
        [self performSelector:@selector(updateValueBy:) withObject:valueDelta afterDelay:delta];
}

- (void)countTo:(int)to withDuration:(float)t
{
    delta = t / (abs(to-self.value) +1);
    if (delta <0.05) {
        delta = 0.05;
    }
    
    endValue = to;
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
    if (to - self.value >0) {
        [self updateValueBy:@1];
    } else {
        [self updateValueBy:@-1];
    }
    
}

@end
