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

@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;

@property (nonatomic, strong) UIImageView *loadIngImageView;

@property (nonatomic, strong) NSMutableArray *images;

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
    self.height = 60;
    self.width = newSuperview.width;
    self.positionX = 0;
    self.positionY = -60;
    [self addSubview:self.loadIngImageView];
}

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    if (self.state == TDRefreshStateRefreshing) return;
    self.scrollViewInset = self.scrollView.contentInset;
    self.scrollViewOffset = CGPointMake(self.scrollView.contentOffset.x, self.scrollView.contentOffset.y + self.scrollViewInset.top);
    CGFloat y = self.scrollViewOffset.y;
    [self setImageWithY:y];
}

- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    if (self.state == TDRefreshStateRefreshing) return;
    UIGestureRecognizerState panState = [change[@"new"] integerValue];
    CGFloat y = self.scrollViewOffset.y;
    if (panState == UIGestureRecognizerStateBegan) {
        
    } else if (panState == UIGestureRecognizerStateEnded) {
        if (y < -60) {
            self.state = TDRefreshStateRefreshing;
        }
    }
}

-(void)setImageWithY:(CGFloat)y
{
    if (y < -15) {
        NSInteger index = (NSInteger)((-y)*24/60);
        if (index >24) {
            index = 24;
        }
        if (index < 0) {
            index = 0;
        }
        self.loadIngImageView.image = self.images[index];
    }
}

#pragma mark - seter

-(void)setState:(TDRefreshState)state
{
    [super setState:state];
    if (state == TDRefreshStateNomal) {
        [self endRefresh];
    } else if (state == TDRefreshStateRefreshing) {
        [UIView animateWithDuration:0.25 animations:^{
            self.scrollView.contentInset = UIEdgeInsetsMake(60 + self.scrollViewInset.top, 0, 0, 0);
            self.scrollView.contentOffset = CGPointMake(0, -self.scrollViewInset.top - 60);
        } completion:^(BOOL finished) {
            [self.loadIngImageView startAnimating];
            self.headerBlock();
        }];
    }
}

-(void)endRefresh
{
    [UIView animateWithDuration:0.2 delay:0.3 options:UIViewAnimationOptionCurveLinear animations:^{
        self.scrollView.contentInset = UIEdgeInsetsMake(self.scrollViewInset.top, 0, 0, 0);
        self.scrollView.contentOffset = CGPointMake(0, -self.scrollViewInset.top);
    } completion:^(BOOL finished) {
        [self.indicatorView stopAnimating];
        [self.loadIngImageView stopAnimating];
    }];
}
#pragma mark -getter

-(UIActivityIndicatorView *)indicatorView
{
    if (!_indicatorView) {
        _indicatorView = [[UIActivityIndicatorView alloc] init];
        _indicatorView.color = [UIColor redColor];
    }
    return _indicatorView;
}

-(UIImageView *)loadIngImageView
{
    if (!_loadIngImageView) {
        UIImage *image = [UIImage imageNamed:@"mailer1"];
        CGSize size = image.size;
        _loadIngImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.width/2 - size.width/2, self.height/2 - size.height / 2, size.width, size.height)];
        _loadIngImageView.animationImages = self.images;
        _loadIngImageView.animationDuration = 1.5;
        _loadIngImageView.animationRepeatCount = NSIntegerMax;
        _loadIngImageView.image = image;
    }
    return _loadIngImageView;
}

-(NSMutableArray *)images
{
    if (!_images) {
        _images = [NSMutableArray array];
        for (int i = 1; i < 26; i++) {
            NSString *str = [NSString stringWithFormat:@"mailer%d",i];
            UIImage *img = [UIImage imageNamed:str];
            [_images addObject:img];
        }
    }
    return _images;
}

#pragma mark - rewrite

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.indicatorView.center = CGPointMake(self.width/2 - _indicatorView.width/2, self.height/2 - _indicatorView.height/2);
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
    //注释掉得也可以
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
    self.state = TDRefreshStateNomal;
}

-(BOOL)isHeaderRefreshing
{
    return self.state == TDRefreshStateRefreshing;
}


@end
