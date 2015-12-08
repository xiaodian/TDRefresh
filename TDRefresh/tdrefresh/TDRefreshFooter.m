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
    if (self.scrollView.contentOffset.y < 0) return ;
    if (self.scrollView.contentSize.height <=  0) return ;
    if (self.state == TDRefreshStateRefreshing || self.state == TDRefreshStateRefreshed) return;
    NSLog(@"contentOffset : %f",self.scrollView.contentOffset.y);
    NSLog(@"contentSize : %f",self.scrollView.contentSize.height);
    
    if (self.scrollView.contentOffset.y + self.scrollView.height >= self.scrollView.contentSize.height + REFRESH_FOOTER_HEIGH ) {
        self.state = TDRefreshStateRefreshing;
    }
}

-(void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    if (self.scrollView.contentSize.height < self.scrollView.height) {
        self.positionY = self.scrollView.height;
    } else {
        self.positionY = self.scrollView.contentSize.height;
    }
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

-(BOOL)isFooterRefreshing
{
    return self.state == TDRefreshStateRefreshing;
}



-(UIActivityIndicatorView *)indicator
{
    if (!_indicator) {
        _indicator =  [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray] ;
        _indicator.tintColor = [UIColor redColor];
        _indicator.center = CGPointMake(self.width / 2, self.height / 2);
        _indicator.hidesWhenStopped = NO;
    }
    return _indicator;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
}

@end
