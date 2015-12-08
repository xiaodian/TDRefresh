//
//  TDRefershHeader.m
//  TDRefresh
//
//  Created by Sujiandong on 15/10/28.
//  Copyright (c) 2015年 Sujiandong. All rights reserved.
//
#define TD_SCREEN_WIDTH    [UIScreen mainScreen].bounds.size.width

#import "TDRefreshHeader.h"
@interface TDRefreshHeader()

@property (nonatomic, strong) UIImageView *loadIngImageView;

@property (nonatomic, assign) CGFloat progress;

@end
@implementation TDRefreshHeader

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
    self.height = REFRESHHEIGH;
    self.width = newSuperview.width;
    self.positionX = 0;
    self.positionY = -REFRESHHEIGH;
    [self addSubview:self.loadIngImageView];
}

-(void)didMoveToSuperview
{
    [super didMoveToSuperview];
    [self.superview sendSubviewToBack:self];
}

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    if (self.scrollView.contentOffset.y > 0) {
        return ;
    }
    if (self.state == TDRefreshStateRefreshing || self.state == TDRefreshStateRefreshed) return;
    self.scrollViewInset = self.scrollView.contentInset;
    self.scrollViewOffset = CGPointMake(self.scrollView.contentOffset.x, self.scrollView.contentOffset.y + self.scrollViewInset.top);
    self.progress = -self.scrollViewOffset.y / REFRESHHEIGH;
}

- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    if (self.state == TDRefreshStateRefreshing || self.state == TDRefreshStateRefreshed) return;
    
    UIGestureRecognizerState panState = [change[@"new"] integerValue];
    CGFloat y = self.scrollViewOffset.y;
    if (panState == UIGestureRecognizerStateEnded) {
        if (y < - REFRESHHEIGH) {
            self.state = TDRefreshStateRefreshing;
        }
    }
}

#pragma mark - seter

-(void)setProgress:(CGFloat)progress
{
    self.loadIngImageView.alpha = progress;
    CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI * 2 * progress);
    self.loadIngImageView.transform = transform;
    CGFloat y = -self.scrollViewOffset.y;
    self.positionY = (y - REFRESHHEIGH) / 2.0 - y;
}

-(void)setState:(TDRefreshState)state
{
    [super setState:state];
    if (state == TDRefreshStateRefreshed) {
        [self endRefresh];
    }else if (state == TDRefreshStateRefreshing) {
        [UIView animateWithDuration:0.25 animations:^{
            self.scrollView.contentInset = UIEdgeInsetsMake(REFRESHHEIGH + self.scrollViewInset.top, 0, self.scrollViewInset.bottom, 0);
            self.scrollView.contentOffset = CGPointMake(0, -self.scrollViewInset.top - REFRESHHEIGH);
            self.positionY = - REFRESHHEIGH;;
        } completion:^(BOOL finished) {
            [self loadingViewStartAnimation];
            if (self.headerBlock) {
                self.headerBlock();
            }
        }];
    }
}

-(void)endRefresh
{
    [UIView animateWithDuration:0.2 delay:0.3 options:UIViewAnimationOptionCurveLinear animations:^{
        self.scrollView.contentInset = UIEdgeInsetsMake(self.scrollViewInset.top, 0, self.scrollViewInset.bottom, 0);
        self.scrollView.contentOffset = CGPointMake(0, -self.scrollViewInset.top);
        self.positionY = -REFRESHHEIGH / 2.0;
    } completion:^(BOOL finished) {
        [self loadingViewStopAnimation];
        self.state = TDRefreshStateNomal;
    }];
}

-(void)loadingViewStartAnimation
{
    self.loadIngImageView.transform = CGAffineTransformMakeRotation(0);
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 0.6;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = NSIntegerMax;
    [self.loadIngImageView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

-(void)loadingViewStopAnimation
{
    [self.loadIngImageView.layer removeAllAnimations];
}

#pragma mark -getter

-(UIImageView *)loadIngImageView
{
    if (!_loadIngImageView) {
        UIImage *image = [UIImage imageNamed:@"td_loading"];
        CGSize size = image.size;
        _loadIngImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.width/2 - size.width/2, self.height/2 - size.height / 2, size.width, size.height)];
        _loadIngImageView.image = image;
    }
    return _loadIngImageView;
}

#pragma mark - rewrite

-(void)layoutSubviews
{
    [super layoutSubviews];
}

- (void)drawRect:(CGRect)rect
{
    if (self.state == TDRefreshStateWillRefresh) {
        self.state = TDRefreshStateRefreshing;
    }
}

#pragma mark - actions

-(void)headerStartRefresh
{
    //注释掉的也可以
    if (self.window) {
        self.state = TDRefreshStateRefreshing;
    } else {
        self.state = TDRefreshStateWillRefresh;
        [self setNeedsDisplay];
    }
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self.state = TDRefreshStateRefreshing;
//    });
}

-(void)headerStopRefresh
{
    self.state = TDRefreshStateRefreshed;
}

-(BOOL)isHeaderRefreshing
{
    return self.state == TDRefreshStateRefreshing;
}


@end
