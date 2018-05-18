//
//  GameData.m
//  Demo_Anagrams
//
//  Created by game-netease-chuyou on 2018/5/18.
//  Copyright © 2018年 chuyou. All rights reserved.
//

#import "GameData.h"

@implementation GameData

- (void)setPoints:(int)points
{
    _points = MAX(points, 0);
}


@end
