//
//  TileView.h
//  Demo_Anagrams
//
//  Created by game-netease-chuyou on 2018/5/16.
//  Copyright © 2018年 chuyou. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TileView;

@protocol TileDragDelegateProtocol <NSObject>
- (void)tileView:(TileView *)tileView didDragToPoint:(CGPoint)pt;
@end


@interface TileView : UIImageView

@property (strong, nonatomic, readonly) NSString *letter;
@property (assign, nonatomic) BOOL isMatched;
@property (weak, nonatomic) id<TileDragDelegateProtocol> dragDelegate;

- (instancetype) initWithLetter:(NSString *)letter andSideLength:(float)sideLength;
-(void)randomize;
@end
