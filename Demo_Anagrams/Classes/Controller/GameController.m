//
//  GameController.m
//  Demo_Anagrams
//
//  Created by game-netease-chuyou on 2018/5/16.
//  Copyright © 2018年 chuyou. All rights reserved.
//

#import "GameController.h"
#import "TileView.h"
#import "config.h"
#import "TargetView.h"
#import "ExplodeView.h"
#import "StarDustView.h"

@implementation GameController
{
    NSMutableArray *_tiles;
    NSMutableArray *_targets;
    
    int _secondsLeft;
    NSTimer *_timer;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.data = [[GameData alloc]init];
        
        self.audioController = [[AudioController alloc]init];
        [self.audioController preloadAudioEffects:kAudioEffectFiles];
    }
    return self;
}


- (void)setHud:(HUDView *)hud
{
    _hud = hud;
    [hud.btnHelp addTarget:self action:@selector(actionHint) forControlEvents:UIControlEventTouchUpInside];
}

- (void)dealRandomAnagram
{
   
    NSAssert(self.level.anagrams, @"no level loaded");
    
    int randomIndex = arc4random()%[self.level.anagrams count];
    NSArray *anaPair = self.level.anagrams[randomIndex];
    
    NSString *anagram1 = anaPair[0];
    NSString *anagram2 = anaPair[1];
    
    int ana1len = [anagram1 length];
    int ana2len = [anagram2 length];
    
    
    NSLog(@"pharse1[%i]: %@", ana1len, anagram1);
    NSLog(@"pharse2[%i]: %@", ana2len, anagram2);
    
    float tileSide = ceilf( kScreenWidth*0.9 / (float)MAX(ana1len, ana2len) ) - kTileMargin;
    
    //get the left margin for first tile
    float xOffset = (kScreenWidth - MAX(ana1len, ana2len) * (tileSide + kTileMargin))/2;
    
    //adjust for tile center (instead of the tile's origin)
    xOffset += tileSide/2;
    
    
    _targets = [NSMutableArray arrayWithCapacity:ana2len];
    for (int i = 0; i < ana2len; i++) {
        NSString *letter = [anagram2 substringWithRange:NSMakeRange(i, 1)];
        
        if (![letter isEqualToString:@" "]) {
            TargetView *target = [[TargetView alloc] initWithLetter:letter andSideLength:tileSide];
            target.center = CGPointMake(xOffset + i * (tileSide + kTileMargin), kScreenHeight / 4);
            
            [self.gameView addSubview:target];
            [_targets addObject:target];
        }
    }
    
    _tiles = [NSMutableArray arrayWithCapacity: ana1len];
    
    //2 create tiles
    for (int i=0;i<ana1len;i++) {
        NSString* letter = [anagram1 substringWithRange:NSMakeRange(i, 1)];
        
        //3
        if (![letter isEqualToString:@" "]) {
            TileView* tile = [[TileView alloc] initWithLetter:letter andSideLength:tileSide];
            [tile randomize];
            tile.dragDelegate = self;
            tile.center = CGPointMake(xOffset + i*(tileSide + kTileMargin), kScreenHeight/4*3);
            
            //4
            [self.gameView addSubview:tile];
            [_tiles addObject: tile];
            
        }
    }
    
     [self startStopWatch];
//    NSLog(@"%d",_secondsLeft);
//    NSLog(@"%d",self.level.timeToSolve);
    self.hud.btnHelp.enabled = YES;
}

- (void)tileView:(TileView *)tileView didDragToPoint:(CGPoint)pt
{
    TargetView *targetView = nil;
    
    for (TargetView *tv in _targets) {
        if (CGRectContainsPoint(tv.frame, pt)) {
            targetView = tv;
            break;
        }
    }
    
    //1 check if target was found
    if (targetView != nil) {
        
        //2 check if letter matches
        if ([targetView.letter isEqualToString: tileView.letter]) {
            
            //3
            [self placeTile:tileView atTarget:targetView];
            //NSLog(@"Success! You should place the tile here!");
            
            //more stuff to do on success here
             [self checkForSuccess];
            self.data.points += self.level.pointsPerTitle;
            [self.hud.gamePoints countTo:self.data.points withDuration:1.5];
           
            [self.audioController playEffect:kSoundDing];
            
    
            //NSLog(@"Check if the player has completed the phrase");
            
        } else {
            
            //1
            //visualize the mistake
            [tileView randomize];
            
            //2
            [UIView animateWithDuration:0.35
                                  delay:0.00
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 tileView.center = CGPointMake(tileView.center.x + randomf(-20, 20),
                                                               tileView.center.y + randomf(20, 30));
                             } completion:nil];
            //4
            //NSLog(@"Failure. Let the player know this tile doesn't belong here.");
            
            //more stuff to do on failure here
            self.data.points += self.level.pointsPerTitle/2;
            [self.hud.gamePoints countTo:self.data.points withDuration:.75];
            
             [self.audioController playEffect:kSoundWrong];
        }
    }
}

-(void)placeTile:(TileView*)tileView atTarget:(TargetView*)targetView
{
    //1
    targetView.isMatched = YES;
    tileView.isMatched = YES;
    
    //2
    tileView.userInteractionEnabled = NO;
    
    //3
    [UIView animateWithDuration:0.35
                          delay:0.00
                        options:UIViewAnimationOptionCurveEaseOut
     //4
                     animations:^{
                         tileView.center = targetView.center;
                         tileView.transform = CGAffineTransformIdentity;
                     }
     //5
                     completion:^(BOOL finished){
                         targetView.hidden = YES;
                     }];
    
    ExplodeView *explode = [[ExplodeView alloc] initWithFrame:CGRectMake(tileView.center.x, tileView.center.y, 10, 10)];
    [tileView.superview addSubview:explode];
    [tileView.superview sendSubviewToBack:explode];
    
    
}

- (void)checkForSuccess
{
    
    
    for (TargetView* t in _targets) {
        //no success, bail out
        if (t.isMatched==NO) return;
    }
    
    NSLog(@"Game Over!");
    
    self.hud.btnHelp.enabled = NO;
    [self stopStopWatch];
    [self.audioController playEffect:kSoundWin];
    
    TargetView *firstTarget = _targets[0];
    
    int startX = 0;
    int endX = kScreenWidth + 300;
    int startY = firstTarget.center.y;
    
    StarDustView *stars = [[StarDustView alloc] initWithFrame:CGRectMake(startX, startY, 10, 10)];
    [self.gameView addSubview:stars];
    [self.gameView sendSubviewToBack:stars];
    
    [UIView animateWithDuration:3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        stars.center = CGPointMake(endX, startY);
    } completion:^(BOOL finished) {
        [stars removeFromSuperview];
        
        [self clearBoard];
        self.onAnagramSolved();
    }];
    
    
}

- (void)startStopWatch
{
    _secondsLeft = self.level.timeToSolve;
    [self.hud.stopWatch setSeconds:_secondsLeft];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(tick:) userInfo:nil repeats:YES];
    
}

- (void)stopStopWatch
{
    [_timer invalidate];
    _timer = nil;
}

- (void)tick:(NSTimer *)timer
{
    _secondsLeft --;
    [self.hud.stopWatch setSeconds:_secondsLeft];
    
    if (_secondsLeft == 0) {
        [self stopStopWatch];
    }
}
- (void)actionHint
{
    self.hud.btnHelp.enabled = NO;
    
    self.data.points -= self.level.pointsPerTitle/2;
    [self.hud.gamePoints countTo:self.data.points withDuration:1.5];
    
    TargetView *target = nil;
    for (TargetView *t in _targets) {
        if (t.isMatched == NO) {
            target = t;
            break;
        }
    }
    
    TileView *tile = nil;
    for (TileView *t in _tiles) {
        if (t.isMatched == NO && [t.letter isEqualToString:target.letter]) {
            tile = t;
            break;
        }
    }
    
    [self.gameView bringSubviewToFront:tile];
    
    [UIView animateWithDuration:1.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        tile.center = target.center;
    } completion:^(BOOL finished) {
        [self placeTile:tile atTarget:target];

        
        [self checkForSuccess];
        
        self.hud.btnHelp.enabled = YES;
    }];
}

- (void)clearBoard
{
    [_tiles removeAllObjects];
    [_targets removeAllObjects];
    
    for (UIView *view in self.gameView.subviews) {
        [view removeFromSuperview];
    }
}

@end
