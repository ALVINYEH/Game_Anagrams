//
//  CounterLabelView.h
//  Demo_Anagrams
//
//  Created by game-netease-chuyou on 2018/5/18.
//  Copyright © 2018年 chuyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CounterLabelView : UILabel

@property (assign, nonatomic) int value;

+ (instancetype)labelWithFont:(UIFont *)font frame:(CGRect)rect andValue:(int)value;

- (void) countTo:(int)to withDuration:(float)t;

@end
