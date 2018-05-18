//
//  GameController.h
//  Demo_Anagrams
//
//  Created by game-netease-chuyou on 2018/5/16.
//  Copyright © 2018年 chuyou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Level.h"
#import "TileView.h"
#import "HUDView.h"
#import "GameData.h"
#import "AudioController.h"

typedef void(^CallbackBlock)();

@interface GameController : NSObject <TileDragDelegateProtocol>

@property (weak, nonatomic) UIView *gameView;
@property (strong, nonatomic) Level *level;
@property (weak, nonatomic) HUDView *hud;
@property (strong, nonatomic) GameData *data;
@property (strong, nonatomic) AudioController *audioController;
@property (strong, nonatomic) CallbackBlock onAnagramSolved;


- (void)dealRandomAnagram;


@end
