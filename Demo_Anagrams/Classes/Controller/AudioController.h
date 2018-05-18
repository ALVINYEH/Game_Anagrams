//
//  AudioController.h
//  Demo_Anagrams
//
//  Created by game-netease-chuyou on 2018/5/18.
//  Copyright © 2018年 chuyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AudioController : NSObject

- (void)playEffect:(NSString *)name;
- (void)preloadAudioEffects:(NSArray *)effectFileNames;


@end
