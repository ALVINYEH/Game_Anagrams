//
//  AudioController.m
//  Demo_Anagrams
//
//  Created by game-netease-chuyou on 2018/5/18.
//  Copyright © 2018年 chuyou. All rights reserved.
//

#import "AudioController.h"
#import <AVFoundation/AVFoundation.h>

@implementation AudioController
{
    NSMutableDictionary *audio;
}

- (void)preloadAudioEffects:(NSArray *)effectFileNames
{
    audio = [NSMutableDictionary dictionaryWithCapacity: effectFileNames.count];
    
    for (NSString * effect in effectFileNames) {
        
        NSString* soundPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: effect];
        NSURL *soundURL = [NSURL fileURLWithPath:soundPath];
        
        NSError *loadErr = nil;
        AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundURL error:&loadErr];
        NSAssert(loadErr == nil , @"load sound failed");
        
        player.numberOfLoops = 0;
        [player prepareToPlay];
        
        audio[effect] = player;
 
        
    }
}


- (void)playEffect:(NSString *)name
{
    NSAssert(audio[name], @"effect not found");
    
    AVAudioPlayer *player = (AVAudioPlayer *)audio[name];
    if (player.isPlaying) {
        player.currentTime = 0;
    } else {
        [player play];
    }
}
@end
