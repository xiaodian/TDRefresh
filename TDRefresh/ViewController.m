//
//  ViewController.m
//  TDRefresh
//
//  Created by Sujiandong on 15/10/28.
//  Copyright (c) 2015年 Sujiandong. All rights reserved.
//

#import "ViewController.h"
#import "UIScrollView+TDRefresh.h"
#import "AAAViewController.h"
#import "SVPullToRefresh.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *t ;
    NSInteger num;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:[UIView new]];
    t = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    t.positionY = 64;
    t.height -= 64;
    t.delegate = self;
    t.dataSource = self;
    t.tableFooterView = [UIView new];
    [self.view addSubview:t];
    num = 25;
    __weak typeof(t) weakt = t;
    [t addHeaderRefreshBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            num = 5;
            [weakt headerStopRefresh];
            [weakt reloadData];
        });
    }];
    
    [t addFooterRefreshBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            num += 5;
            [weakt footerStopRefresh];
            [weakt reloadData];
        });
    }];
    
//    [t addInfiniteScrollingWithActionHandler:^{
//        num += 5;
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [t.infiniteScrollingView stopAnimating];
//            [t reloadData];
//        });
//    }];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return num;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [UITableViewCell new];
    cell.backgroundColor = [UIColor whiteColor];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
   // cell.backgroundColor = [UIColor lightGrayColor];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AAAViewController *ac = [[AAAViewController alloc] init];
    [self.navigationController pushViewController:ac animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
