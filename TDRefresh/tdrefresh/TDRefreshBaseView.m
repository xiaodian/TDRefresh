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
        self.state = TDRefreshStateNomal;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    _scrollView = (UIScrollView *)newSuperview;
    [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew| NSKeyValueObservingOptionOld context:nil];
    [self.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew| NSKeyValueObservingOptionOld context:nil];
    [self.scrollView.panGestureRecognizer addObserver:self forKeyPath:@"state" options:NSKeyValueObservingOptionNew| NSKeyValueObservingOptionOld context:nil];
}

- (void)removeObservers
{
    [self.scrollView removeObserver:self forKeyPath:@"contentOffset"];
     [self.scrollView removeObserver:self forKeyPath:@"contentSize"];
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
    }  else if ([keyPath isEqualToString:@"contentSize"]) {
        [self scrollViewContentSizeDidChange:change];
    }
}

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    
}
- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    
}

-(void)scrollViewContentSizeDidChange:(NSDictionary *)change
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



-(void)dealloc
{
    [self removeObservers];
}

@end
