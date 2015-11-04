//
//  TDRefreshCommonView.h
//  TDRefresh
//
//  Created by Sujiandong on 15/10/28.
//  Copyright (c) 2015年 Sujiandong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+TDPosition.h"

typedef enum {
    /** 普通闲置状态 */
    TDRefreshStateNomal = 1,
    /** 松开就可以进行刷新的状态 */
    TDRefreshStatePulling,
    /** 正在刷新中的状态 */
    TDRefreshStateRefreshing,
    /** 即将刷新的状态 */
    TDRefreshStateWillRefresh,
} TDRefreshState;

@interface TDRefreshBaseView : UIView

@property (nonatomic,weak,readonly) UIScrollView *scrollView;

@property (nonatomic,assign) UIEdgeInsets scrollViewInset;

@property (nonatomic,assign) CGPoint scrollViewOffset;


@property (assign, nonatomic) TDRefreshState state;



- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change;
- (void)scrollViewPanStateDidChange:(NSDictionary *)change;


@end
