//
//  ViewController.m
//  Demo_Anagrams
//
//  Created by game-netease-chuyou on 2018/5/16.
//  Copyright © 2018年 chuyou. All rights reserved.
//

#import "ViewController.h"
#import "Level.h"
#import "GameController.h"
#import "config.h"
#import "HUDView.h"
@interface ViewController ()<UIAlertViewDelegate>

@property (strong, nonatomic) GameController *controller;

@end

@implementation ViewController

-(instancetype)initWithCoder:(NSCoder *)decoder
{
    self = [super initWithCoder:decoder];
    if (self != nil) {
        //create the game controller
        self.controller = [[GameController alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
   // Level *level1 = [Level levelWithNum:1];
   // NSLog(@"anagrams: %@", level1.anagrams );
   // NSLog(@"timeToSolve: %d",level1.timeToSolve);
    
    UIView* gameLayer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [self.view addSubview: gameLayer];
    
    self.controller.gameView = gameLayer;
    
    HUDView *hudView = [HUDView viewWithRect:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [self.view addSubview:hudView];
    self.controller.hud = hudView;
    
    
//    self.controller.level = level1;
//    [self.controller dealRandomAnagram];
    
    __weak ViewController* weakSelf = self;
    self.controller.onAnagramSolved = ^(){
        [weakSelf showLevelMenu];
    };
    
}


#pragma mark - Game Menu

- (void) showLevelMenu
{
    //UIActionSheet *action = [UIActionSheet alloc];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Play @ difficulty level:" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction *easy = [UIAlertAction actionWithTitle:@"Easy-peasy" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
            self.controller.level = [Level levelWithNum:1];
            [self.controller dealRandomAnagram];
                           }];
    UIAlertAction *medium = [UIAlertAction actionWithTitle:@"Challenge accepted" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        self.controller.level = [Level levelWithNum:2];
        [self.controller dealRandomAnagram];
    }];
    UIAlertAction *hard = [UIAlertAction actionWithTitle:@"I'm totally hard-core" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        self.controller.level = [Level levelWithNum:3];
        [self.controller dealRandomAnagram];
    }];

    [alertController addAction:easy];
    [alertController addAction:medium];
    [alertController addAction:hard];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self showLevelMenu];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
