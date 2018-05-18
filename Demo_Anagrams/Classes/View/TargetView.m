//
//  TargetView.m
//  Demo_Anagrams
//
//  Created by game-netease-chuyou on 2018/5/16.
//  Copyright © 2018年 chuyou. All rights reserved.
//

#import "TargetView.h"

@implementation TargetView

 - (id) initWithFrame:(CGRect)frame
{
    NSAssert(NO, @"Use initWithLetter:andSideLength instead");
    return nil;
}

- (instancetype)initWithLetter:(NSString *)letter andSideLength:(float)sideLength
{
    UIImage *image = [UIImage imageNamed:@"slot"];
    self = [super initWithImage:image];
    
    if (self != nil) {
        self.isMatched = NO;
        
        float scale = sideLength/image.size.width;
        self.frame = CGRectMake(0, 0, image.size.width * scale, image.size.height * scale);
        
        _letter = letter;
    }
    return self;
}

@end
