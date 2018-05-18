//
//  Level.h
//  Demo_Anagrams
//
//  Created by game-netease-chuyou on 2018/5/16.
//  Copyright © 2018年 chuyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Level : NSObject

// .plist 文件中存储的属性
@property (assign, nonatomic) int pointsPerTitle;
@property (assign, nonatomic) int timeToSolve;
@property (strong, nonatomic) NSArray *anagrams;

//使用工厂方法来读取 .plist文件和初始化model
+(instancetype)levelWithNum:(int)levelNum;

@end
