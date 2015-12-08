//
//  TDRefreshCommonView.h
//  TDRefresh
//
//  Created by Sujiandong on 15/10/28.
//  Copyright (c) 2015年 Sujiandong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+TDPosition.h"

#define REFRESHHEIGH 60

#define REFRESH_FOOTER_HEIGH 50


typedef enum {
    TDRefreshStateNomal = 1,
    TDRefreshStateWillStop,
    TDRefreshStatePulling,
    TDRefreshStateRefreshing,
    TDRefreshStateWillRefresh,
    TDRefreshStateRefreshed,
} TDRefreshState;

@interface TDRefreshBaseView : UIView

@property (nonatomic,weak,readonly) UIScrollView *scrollView;

@property (nonatomic,assign) UIEdgeInsets scrollViewInset;

@property (nonatomic,assign) CGPoint scrollViewOffset;


@property (assign, nonatomic) TDRefreshState state;



- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change;
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change;
- (void)scrollViewPanStateDidChange:(NSDictionary *)change;


@end
