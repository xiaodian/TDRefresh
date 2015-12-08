//
//  UIScrollView+TDRefresh.h
//  TDRefresh
//
//  Created by Sujiandong on 15/10/28.
//  Copyright (c) 2015年 Sujiandong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TDRefreshHeader.h"
#import "TDRefreshFooter.h"


@interface UIScrollView (TDRefresh)

@property (nonatomic, strong) TDRefreshHeader *refreshHeader;
@property (nonatomic, strong) TDRefreshFooter *refreshFooter;

-(void)addFooterRefreshBlock:(TDRefreshFooterRefreshingBlock) block;
-(void)addHeaderRefreshBlock:(TDRefreshHeaderRefreshingBlock) block;

-(void)headerStopRefresh;
-(void)headerStartRefresh;
-(BOOL)isHeaderRefreshing;

-(void)footerStopRefresh;
-(BOOL)isFooterRefreshing;

@end
