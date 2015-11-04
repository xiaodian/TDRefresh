//
//  TDRefreshCommonView.m
//  TDRefresh
//
//  Created by Sujiandong on 15/10/28.
//  Copyright (c) 2015年 Sujiandong. All rights reserved.
//

#import "TDRefreshBaseView.h"

@implementation TDRefreshBaseView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.backgroundColor = [UIColor blackColor];
        self.state = TDRefreshStateNomal;
    }
    return self;
}

-(void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    _scrollView = (UIScrollView *)newSuperview;
    [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew| NSKeyValueObservingOptionOld context:nil];
    [self.scrollView.panGestureRecognizer addObserver:self forKeyPath:@"state" options:NSKeyValueObservingOptionNew| NSKeyValueObservingOptionOld context:nil];
    
}

- (void)removeObservers
{
    [self.scrollView removeObserver:self forKeyPath:@"contentOffset"];
    [self.scrollView.panGestureRecognizer removeObserver:self forKeyPath:@"state"];
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (!self.userInteractionEnabled) return;
    
    if ([keyPath isEqualToString:@"contentOffset"]) {
        _scrollViewOffset = self.scrollView.contentOffset;
        [self scrollViewContentOffsetDidChange:change];
    } else if ([keyPath isEqualToString:@"state"]) {
        [self scrollViewPanStateDidChange:change];
    }
}

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    
}
- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    
}


#pragma mark - setter

-(void)setState:(TDRefreshState)state
{
    if (state == _state) {
        return;
    }
    _state = state;
}

//- (void)drawRect:(CGRect)rect
//{
//    [super drawRect:rect];
//    
//    if (self.state == TDRefreshStateWillRefresh) {
//        // 预防view还没显示出来就调用了beginRefreshing
//        self.state = TDRefreshStateRefreshing;
//    }
//}



-(void)dealloc
{
    [self removeObservers];
}

@end
