//
//  UIView+TDPosition.h
//  TDRefresh
//
//  Created by Sujiandong on 15/10/28.
//  Copyright (c) 2015年 Sujiandong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (TDPosition)

@property(nonatomic) CGPoint position;
@property(nonatomic) CGPoint left;
@property(nonatomic) CGPoint right;
@property(nonatomic) float positionX;
@property(nonatomic) float positionY;
@property(nonatomic,readonly) float endX;
@property(nonatomic,readonly) float endY;
@property(nonatomic) float centerX;
@property(nonatomic) float centerY;

@property(nonatomic) CGSize size;
@property(nonatomic) float width;
@property(nonatomic) float height;
@end
