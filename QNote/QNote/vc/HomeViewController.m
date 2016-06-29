//
//  HomeViewController.m
//  QNote
//
//  Created by 林宁宁 on 16/6/2.
//  Copyright © 2016年 林宁宁. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeTableViewCell.h"

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (retain, nonatomic) NSMutableArray <NSDictionary *> * dataList;

@property (weak, nonatomic) IBOutlet UITableView *tableV;

@end

/**
 *  项目地址
 *  https://github.com/MaiyaT/AongQ
 */

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataList = [[NSMutableArray alloc] init];
        
    [self.dataList addObject:@{@"title":@"Runtime学习",@"subtitle":@"2016-6-23",@"vc":@"RunTimeViewController"}];
    
    [self.dataList addObject:@{@"title":@"HTML本地",@"subtitle":@"2016-6-23",@"vc":@"HTMLWebViewController"}];
    
    [self.dataList addObject:@{@"title":@"UIBezierPath",@"subtitle":@"2016-6-9",@"vc":@"BezierViewController"}];
    
    [self.dataList addObject:@{@"title":@"CAShapeLayer-Progress",@"subtitle":@"2016-6-7",@"vc":@"ProgressViewController"}];
    
    [self.dataList addObject:@{@"title":@"AFNetworking—学习",@"subtitle":@"2016-6-4__框架学习",@"vc":@"AFNetworkingNoteVC"}];
    
    [self.dataList addObject:@{@"title":@"AFNetworking—demo",@"subtitle":@"2016-6-4__AFNDemo",@"vc":@"AFNetworkingViewController"}];
    
    
    [self.dataList addObject:@{@"title":@"ValueForKeyPath",@"subtitle":@"2016-6-4__ValueForKeyPath操作",@"vc":@"ValueForKeyPathViewController"}];
    
    [self.dataList addObject:@{@"title":@"函数",@"subtitle":@"2016-6-3__数学函数",@"vc":@"MathFuntionViewController"}];
    
    
    [self.dataList addObject:@{@"title":@"PropertyKeyWords",@"subtitle":@"2016-6-2__属性的关键字",@"vc":@"PropertyKeyWordVController"}];
    
    
    [self.dataList addObject:@{@"title":@"NSSecureCoding",@"subtitle":@"2016-6-1__归档-编码解码",@"vc":@"SecureCodingViewController",@"sugueid":@"pushSecure"}];
    
    
    
    
    self.tableV.tableFooterView = [UIView new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"noteCellIdentify"];
    
    NSDictionary * dataDic = self.dataList[indexPath.row];
    
    NSString * title = dataDic[@"title"];
    NSString * subtitle = dataDic[@"subtitle"];
    
    cell.cellTitle.text = title;
    cell.cellSubTitle.text = subtitle?subtitle:@"";
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary * dataDic = self.dataList[indexPath.row];
    
    NSString * title = dataDic[@"title"];
    NSString * vcClass   = dataDic[@"vc"];
    NSString * sugueid = dataDic[@"sugueid"];
    
    if(sugueid)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self performSegueWithIdentifier:sugueid sender:self];
        });
    }
//    else if ([[self storyboard] instantiateViewControllerWithIdentifier:vcClass])
//    {
//        [self.navigationController pushViewController:[[self storyboard] instantiateViewControllerWithIdentifier:vcClass] animated:YES];
//    }
    else
    {
        UIViewController * vc = [[NSClassFromString(vcClass) alloc] init];
        vc.title = title;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

//判断 segue跳不跳
-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    return YES;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
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
