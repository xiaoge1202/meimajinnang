//
//  meixing_VC.m
//  美妈锦囊
//
//  Created by apple on 15/7/30.
//  Copyright (c) 2015年 燕庐科技. All rights reserved.
//

#import "meixing_VC.h"
#import "PrefixHeader.pch"
#import "meixing_Cell.h"
#import "meixingXiang_VC.h"
#import "AFHTTPRequestOperationManager.h"
#import "PrefixHeader.pch"
#import "UIImageView+AFNetworking.h"
@interface meixing_VC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation meixing_VC{
    UITableView *tableview;
    AFHTTPRequestOperationManager *manager;
    NSMutableArray *infoArray;
}
//网络获取数据
-(void)AFNetworking
{
    manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc]init];
    [manager GET:@"http://101.200.234.127:8080/YanLu/meixing/listone.do" parameters:[@{@"leiid":self.tieId}mutableCopy] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSData *data =(NSData *)responseObject;
        infoArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"餐后列表 = %@",infoArray);
        [tableview reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"失败");
    }];
}

- (void)viewDidLoad {
    
    
    [super viewDidLoad];
    infoArray=[[NSMutableArray alloc]initWithCapacity:0];
    [self AFNetworking];
    self.view.backgroundColor=[UIColor whiteColor];
    
    self.navigationItem.title = @"产    后   美   型";
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航栏"] forBarMetrics:UIBarMetricsDefault];
    
    
    //取消导航栏和状态栏的边缘延展效果
    self.modalPresentationCapturesStatusBarAppearance = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    
    //返回按钮
    UIButton  * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(10, 16, 12, 20);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];

    [backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    tableview=[[UITableView alloc]initWithFrame:CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height-69) style:UITableViewStylePlain];
    tableview.delegate=self;
    tableview.dataSource = self;
    [self.view addSubview:tableview];
    [tableview reloadData];
    
}
/*
 
 表格的协议
 */

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return infoArray.count;
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *CellIdentifier1 = [NSString stringWithFormat:@"indexPath"];
    
    meixing_Cell *cell1 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
    cell1 = [tableView cellForRowAtIndexPath:indexPath];
    
    if(cell1 == nil)
    {
        cell1 = [[meixing_Cell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier1];
        //        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    else
    {
        //删除cell的所有子视图
        while ([cell1.contentView.subviews lastObject] != nil)
        {
            [(UIView*)[cell1.contentView.subviews lastObject] removeFromSuperview];
        }
    }
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
    tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    cell1.title.text=[NSString stringWithFormat:@"%@",[[infoArray objectAtIndex:indexPath.row] objectForKey:@"title"]];
    cell1.zuozheName.text=[NSString stringWithFormat:@"%@",[[infoArray objectAtIndex:indexPath.row] objectForKey:@"zuozhe"]];
    cell1.guankannumber.text=[NSString stringWithFormat:@"%@",[[infoArray objectAtIndex:indexPath.row] objectForKey:@"chakancishu"]];
    return cell1;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //得到id
    NSString *ids=[[infoArray objectAtIndex:indexPath.row] objectForKey:@"id"];
    NSString *title=[[infoArray objectAtIndex:indexPath.row] objectForKey:@"title"];
    meixingXiang_VC *xiang=[[meixingXiang_VC alloc]init];
    xiang.hidesBottomBarWhenPushed =YES;
    xiang.ids=ids;
    xiang.title=title;
    [self.navigationController pushViewController:xiang animated:YES];
}

-(void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
