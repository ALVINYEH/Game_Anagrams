//
//  HUDView.h
//  Demo_Anagrams
//
//  Created by game-netease-chuyou on 2018/5/16.
//  Copyright © 2018年 chuyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StopwatchView.h"
#import "CounterLabelView.h"

@interface HUDView : UIView

@property (strong, nonatomic) StopwatchView *stopWatch;
@property (strong, nonatomic) CounterLabelView *gamePoints;
@property (strong, nonatomic) UIButton *btnHelp;

+ (instancetype)viewWithRect:(CGRect)r;

@end
