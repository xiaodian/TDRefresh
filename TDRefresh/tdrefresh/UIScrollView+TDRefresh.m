//
//  UIScrollView+TDRefresh.m
//  TDRefresh
//
//  Created by Sujiandong on 15/10/28.
//  Copyright (c) 2015年 Sujiandong. All rights reserved.
//

#import "UIScrollView+TDRefresh.h"
#import <objc/runtime.h>

@implementation UIScrollView (TDRefresh)


-(void)setRefreshHeader:(TDRefreshHeader *)refreshHeader
{
    if (refreshHeader) {
        objc_setAssociatedObject(self, @selector(refreshHeader), refreshHeader, OBJC_ASSOCIATION_ASSIGN);
    }
}

-(TDRefreshHeader *)refreshHeader
{
    return objc_getAssociatedObject(self, @selector(refreshHeader));
}


-(void)setRefreshFooter:(TDRefreshFooter *)refreshFooter
{
    if (refreshFooter) {
        objc_setAssociatedObject(self, @selector(refreshFooter), refreshFooter, OBJC_ASSOCIATION_ASSIGN);
    }
}

-(TDRefreshFooter *)refreshFooter
{
    return objc_getAssociatedObject(self, @selector(refreshFooter));
}


-(void)addHeaderRefreshBlock:(TDRefreshHeaderRefreshingBlock)block
{
    if (!self.refreshHeader) {
        TDRefreshHeader *header = [[TDRefreshHeader alloc] init];
        [self addSubview:header];
        self.refreshHeader = header;
    }
    self.refreshHeader.headerBlock = block ;
}

-(void)addFooterRefreshBlock:(TDRefreshFooterRefreshingBlock)block
{
    if (!self.refreshFooter) {
        TDRefreshFooter *footer = [[TDRefreshFooter alloc] init];
        [self addSubview:footer];
        self.refreshFooter = footer;
    }
    self.refreshFooter.footBlock = block;
}

-(void)headerStartRefresh
{
    [self.refreshHeader headerStartRefresh];
}

-(void)headerStopRefresh
{
    [self.refreshHeader headerStopRefresh];
}

-(BOOL)isHeaderRefreshing
{
    return YES;
}

-(void)footerStartRefresh
{
    
}

-(void)footerStopRefresh
{
    
}

-(BOOL)isFooterRefreshing
{
    return YES;
}

@end
