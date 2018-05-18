//
//  Level.m
//  Demo_Anagrams
//
//  Created by game-netease-chuyou on 2018/5/16.
//  Copyright © 2018年 chuyou. All rights reserved.
//

#import "Level.h"

@implementation Level

+(instancetype)levelWithNum:(int)levelNum
{
    //1 find .plist file for this level
    NSString *fileName = [NSString stringWithFormat:@"level%i.plist",levelNum];
    NSString *levelPath = [[[NSBundle mainBundle] resourcePath]stringByAppendingPathComponent:fileName];
    
    //2 load .plist file
    NSDictionary *levelDict = [NSDictionary dictionaryWithContentsOfFile:levelPath];
    
    //3 validation
    NSAssert(levelDict, @"level config file not found");
    
    //4 create Level instance
    Level *level = [[Level alloc] init];
    
    //5 initialize the object from the dictionary
    level.pointsPerTitle = [levelDict[@"pointsPerTile"] intValue];
    level.anagrams = levelDict[@"anagrams"];
    level.timeToSolve = [levelDict[@"timeToSolve"] intValue];
   
    return level;
}

@end
