//
//  TargetView.h
//  Demo_Anagrams
//
//  Created by game-netease-chuyou on 2018/5/16.
//  Copyright © 2018年 chuyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TargetView : UIImageView

@property (strong, nonatomic, readonly) NSString *letter;
@property (assign, nonatomic) BOOL isMatched;

- (instancetype) initWithLetter:(NSString *)letter andSideLength:(float)sideLength;

@end
