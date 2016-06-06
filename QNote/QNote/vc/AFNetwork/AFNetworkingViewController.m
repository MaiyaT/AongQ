//
//  AFNetworkingViewController.m
//  QNote
//
//  Created by 林宁宁 on 16/6/4.
//  Copyright © 2016年 林宁宁. All rights reserved.
//

#import "AFNetworkingViewController.h"
#import "AFNTableViewCell.h"
#import "AFNPost.h"
#import <MJRefresh.h>

//直接demo工程自己敲一变
@interface AFNetworkingViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (retain, nonatomic) UITableView * tableV;

@property (readwrite, nonatomic, strong) NSArray *posts;

@end

@implementation AFNetworkingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableV = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    self.tableV.autoresizingMask = 0xff;
    
    [self.view addSubview:self.tableV];
    
    self.tableV.tableFooterView = [UIView new];
    
    self.tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(pullRefresh)];
    self.tableV.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(pullLoadMore)];
    
    [self.tableV.mj_header beginRefreshing];
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (NSInteger)[self.posts count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AFNTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:[AFNTableViewCell cellIdentify]];
    if(!cell)
    {
        cell = [[AFNTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:[AFNTableViewCell cellIdentify]];
    }
    cell.post = self.posts[(NSUInteger)indexPath.row];
    
    
    return cell;
}


- (CGFloat)tableView:(__unused UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [AFNTableViewCell heightForCellWithPost:self.posts[(NSUInteger)indexPath.row]];
}



- (void)pullRefresh
{
    __unused NSURLSessionTask * task = [AFNPost globalTimelinePostsWithBlock:^(NSArray *posts, NSError *error) {
        
        if (!error) {
            self.posts = posts;
            [self.tableV reloadData];
            
            [self.tableV.mj_header endRefreshing];
        }
        
    }];
}

- (void)pullLoadMore
{

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
