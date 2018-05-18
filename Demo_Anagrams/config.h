//
//  config.h
//  Demo_Anagrams
//
//  Created by game-netease-chuyou on 2018/5/16.
//  Copyright © 2018年 chuyou. All rights reserved.
//

#ifndef configed

//UI defines
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

//add more definitions here
#define kTileMargin 20
#define kFontHUD [UIFont fontWithName:@"comic andy" size:62.0]
#define kFontHUDBig [UIFont fontWithName:@"comic andy" size:120.0]

#define kSoundDing @"ding.mp3"
#define kSoundWrong @"wrong.m4a"
#define kSoundWin @"win.mp3"

#define kAudioEffectFiles @[kSoundDing, kSoundWrong, kSoundWin]


//handy math functions
#define rad2deg(x) x * 180 / M_PI
#define deg2rad(x) x * M_PI / 180
#define randomf(minX,maxX) ((float)(arc4random() % (maxX - minX + 1)) + (float)minX)




#define configed 1
#endif
