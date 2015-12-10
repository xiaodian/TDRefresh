//
//  TDRefreshFooter.h
//  TDRefresh
//
//  Created by Sujiandong on 15/10/28.
//  Copyright (c) 2015年 Sujiandong. All rights reserved.
//

#import "TDRefreshBaseView.h"
typedef void (^TDRefreshFooterRefreshingBlock)();

@interface TDRefreshFooter : TDRefreshBaseView

@property (nonatomic, copy) TDRefreshFooterRefreshingBlock footBlock;

-(void)footerStopRefresh;

@end
