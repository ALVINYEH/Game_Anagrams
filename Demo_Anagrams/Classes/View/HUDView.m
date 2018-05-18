//
//  HUDView.m
//  Demo_Anagrams
//
//  Created by game-netease-chuyou on 2018/5/16.
//  Copyright © 2018年 chuyou. All rights reserved.
//

#import "HUDView.h"
#import "config.h"
@implementation HUDView

+ (instancetype)viewWithRect:(CGRect)r
{
    HUDView *hud = [[HUDView alloc] initWithFrame:r];
    hud.userInteractionEnabled = YES;
    
    hud.stopWatch = [[StopwatchView alloc] initWithFrame:CGRectMake(kScreenWidth/2-150, 0, 300, 100)];
    hud.stopWatch.seconds = 0;
    [hud addSubview:hud.stopWatch];
    
    UILabel *points = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 340, 30, 140, 70)];
    points.backgroundColor = [UIColor clearColor];
    points.font = kFontHUD;
    points.text = @"Points: ";
    [hud addSubview:points];
    
    hud.gamePoints = [CounterLabelView labelWithFont:kFontHUD frame:CGRectMake(kScreenWidth-200, 30, 200, 70) andValue:0];
    hud.gamePoints.textColor = [UIColor colorWithRed:0.38 green:0.098 blue:0.035 alpha:1];
    [hud addSubview:hud.gamePoints];

    UIImage *image = [UIImage imageNamed:@"btn"];
    
    hud.btnHelp = [UIButton buttonWithType:UIButtonTypeCustom];
    [hud.btnHelp setTitle:@"Hint!" forState:UIControlStateNormal];
    hud.btnHelp.titleLabel.font = kFontHUD;
    [hud.btnHelp setBackgroundImage:image forState:UIControlStateNormal];
    hud.btnHelp.frame = CGRectMake(50, 30, image.size.width, image.size.height);
    hud.btnHelp.alpha = 0.8;
    [hud addSubview:hud.btnHelp];
    
    return hud;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *hitView = (UIView *)[super hitTest:point withEvent:event];
    
    if ([hitView isKindOfClass:[UIButton class]]) {
        return hitView;
    }
    
    return nil;
}

@end
