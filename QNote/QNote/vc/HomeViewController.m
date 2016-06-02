//
//  HomeViewController.m
//  QNote
//
//  Created by 林宁宁 on 16/6/2.
//  Copyright © 2016年 林宁宁. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (retain, nonatomic) NSMutableArray <NSDictionary *> * dataList;

@property (weak, nonatomic) IBOutlet UITableView *tableV;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataList = [[NSMutableArray alloc] init];
    
    [self.dataList addObject:@{@"title":@"NSSecureCoding",@"subtitle":@"asd",@"vc":@"SecureCodingViewController"}];
    
    self.tableV.tableFooterView = [UIView new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"noteCellIdentify"];
    
    NSDictionary * dataDic = self.dataList[indexPath.row];
    
    NSString * title = dataDic[@"title"];
    NSString * subtitle = dataDic[@"subtitle"];
    
    cell.textLabel.text = title;
    cell.detailTextLabel.text = subtitle?subtitle:@"";
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * dataDic = self.dataList[indexPath.row];
    
    NSString * title = dataDic[@"title"];
    NSString * vcClass   = dataDic[@"vc"];
    
//    UIViewController * vc = [[NSClassFromString(vcClass) alloc] init];
//    vc.title = title;
//    [self.navigationController pushViewController:vc animated:YES];

//    
//    UIViewController * vc = [[self storyboard] instantiateViewControllerWithIdentifier:vcClass];
//    
//    [self.navigationController pushViewController:vc animated:YES];
    
    
    [self performSegueWithIdentifier:vcClass sender:self];
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
