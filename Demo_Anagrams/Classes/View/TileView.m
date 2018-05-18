//
//  TileView.m
//  Demo_Anagrams
//
//  Created by game-netease-chuyou on 2018/5/16.
//  Copyright © 2018年 chuyou. All rights reserved.
//

#import "TileView.h"
#import "config.h"
#import <QuartzCore/QuartzCore.h>

@implementation TileView
{
    int _xOffset, _yOffset;
    CGAffineTransform _tempTransform;
}
- (instancetype) initWithLetter:(NSString *)letter andSideLength:(float)sideLength
{
    UIImage *image = [UIImage imageNamed:@"tile.png"];
    
    self = [super initWithImage:image];
    
    if (self != nil) {
        float scale = sideLength / image.size.width;
        self.frame = CGRectMake(0, 0, image.size.width * scale, image.size.height * scale);
        
        UILabel* lblChar = [[UILabel alloc] initWithFrame:self.bounds];
        lblChar.textAlignment = NSTextAlignmentCenter;
        lblChar.textColor = [UIColor whiteColor];
        lblChar.backgroundColor = [UIColor clearColor];
        lblChar.text = [letter uppercaseString];
        lblChar.font = [UIFont fontWithName:@"Verdana-Bold" size:78.0*scale];
        [self addSubview: lblChar];
        
        //begin in unmatched state
        self.isMatched = NO;
        
        //save the letter
        _letter = letter;
        
        self.userInteractionEnabled = YES;
        
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOpacity = 0;
        self.layer.shadowOffset = CGSizeMake(10.0f, 10.0f);
        self.layer.shadowRadius = 15.0f;
        self.layer.masksToBounds = NO;
        
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.bounds];
        self.layer.shadowPath = path.CGPath;
    }

    return self;
}

- (void) randomize
{
    float rotation = randomf(0, 50)/ (float) 100 - 0.2;
    self.transform = CGAffineTransformMakeRotation(rotation);
    
    int yOffset = (arc4random() % 10) - 10;
    self.center = CGPointMake(self.center.x, self.center.y +yOffset);
}

#pragma mark - dragging the title

 - (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
   
    CGPoint pt = [[touches anyObject] locationInView:self.superview];
    _xOffset = pt.x - self.center.x;
    _yOffset = pt.y = self.center.y;
    
    self.layer.shadowOpacity = 0.8;
    self.transform = CGAffineTransformScale(self.transform, 1.2, 1.2);
    _tempTransform = self.transform;
    [self.superview bringSubviewToFront:self];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint pt = [[touches anyObject] locationInView:self.superview];
    self.center = CGPointMake(pt.x - _xOffset, pt.y - _yOffset);
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self touchesMoved:touches withEvent:event];
    
    self.transform = _tempTransform;
    
    if (self.dragDelegate) {
        [self.dragDelegate tileView:self didDragToPoint:self.center];
    }
    
    self.layer.shadowOpacity = 0.0;
    
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.transform = _tempTransform;
    self.layer.shadowOpacity = 0.0;
}

@end
