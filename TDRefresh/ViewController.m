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
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *t ;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    t = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    t.backgroundColor = [UIColor blackColor];
    t.delegate = self;
    t.dataSource = self;
    [self.view addSubview:t];

    [t addHeaderRefreshBlock:^{
        [t performSelector:@selector(headerStopRefresh) withObject:nil afterDelay:4.0];
    }];

    [t headerStartRefresh];
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
    return 30;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [UITableViewCell new];
    cell.backgroundColor = [UIColor whiteColor];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
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
