//
//  TDRefreshFooter.m
//  TDRefresh
//
//  Created by Sujiandong on 15/10/28.
//  Copyright (c) 2015年 Sujiandong. All rights reserved.
//

#import "TDRefreshFooter.h"
@interface TDRefreshFooter()

@property (nonatomic, strong) UIActivityIndicatorView *indicator;

@end
@implementation TDRefreshFooter

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

-(void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    self.height = REFRESH_FOOTER_HEIGH;
    self.width = newSuperview.width;
    self.positionX = 0;
    [self addSubview:self.indicator];
    self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, REFRESH_FOOTER_HEIGH, 0);
}

-(void)didMoveToSuperview
{
    [super didMoveToSuperview];
    [self.superview sendSubviewToBack:self];
}

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
    self.scrollViewInset = self.scrollView.contentInset;
    if (self.scrollView.contentOffset.y + self.scrollViewInset.top < REFRESH_FOOTER_HEIGH) return ;
    if (self.state == TDRefreshStateRefreshing || self.state == TDRefreshStateRefreshed) return;
    
    self.scrollViewOffset = CGPointMake(self.scrollView.contentOffset.x, self.scrollView.contentOffset.y + self.scrollViewInset.top);

    if (self.scrollView.contentSize.height >= self.scrollView.height) {
        if (self.scrollView.contentOffset.y + self.scrollView.height >= self.scrollView.contentSize.height + REFRESH_FOOTER_HEIGH ) {
            self.state = TDRefreshStateRefreshing;
        }
    } else {
        if (self.scrollViewOffset.y >= REFRESH_FOOTER_HEIGH) {
            if (!self.window) return;
            self.state = TDRefreshStateRefreshing;
        }
    }
}

-(void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
    self.positionY = self.scrollView.contentSize.height;
}

-(void)setState:(TDRefreshState)state
{
    [super setState:state];
    if (state == TDRefreshStateRefreshing) {
        [self footerStartRefresh];
    } else if (self.state == TDRefreshStateRefreshed) {
        [self footerStopRefresh];
    }
}

-(void)footerStartRefresh
{
    [self.indicator startAnimating];
    if (self.footBlock) {
        self.footBlock();
    }
}

-(void)footerStopRefresh
{
    [self.indicator stopAnimating];
    self.state = TDRefreshStateNomal;
}

-(UIActivityIndicatorView *)indicator
{
    if (!_indicator) {
        _indicator =  [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray] ;
        _indicator.tintColor = [UIColor redColor];
        _indicator.center = CGPointMake(self.width / 2, self.height / 2);
    }
    return _indicator;
}

@end
