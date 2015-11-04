//
//  TDRefershHeader.h
//  TDRefresh
//
//  Created by Sujiandong on 15/10/28.
//  Copyright (c) 2015年 Sujiandong. All rights reserved.
//

#import "TDRefreshBaseView.h"
typedef void (^TDRefreshHeaderRefreshingBlock)();

@interface TDRefreshHeader : TDRefreshBaseView
@property (nonatomic, copy) TDRefreshHeaderRefreshingBlock headerBlock;

-(void)headerStopRefresh;
-(void)headerStartRefresh;
-(BOOL)isHeaderRefreshing;

@end
