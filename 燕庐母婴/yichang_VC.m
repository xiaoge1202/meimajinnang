//
//  yichang_VC.m
//  美妈锦囊
//
//  Created by apple on 15/7/27.
//  Copyright (c) 2015年 燕庐科技. All rights reserved.
//

#import "yichang_VC.h"
#import "yichang_Cell.h"
#import "ycXiang_VC.h"
#import "PrefixHeader.pch"
#import "AFHTTPRequestOperationManager.h"
@interface yichang_VC ()

@end

@implementation yichang_VC{
    UITableView *tableview;//表格
    NSMutableArray *infoArray;
    int messageSum;
    
    AFHTTPRequestOperationManager *manager;
}

//afn网络获取数据
-(void) requestUseAFN_V2{
    

}

//网络获取数据
-(void)AFNetworking
{
    manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc]init];
    [manager GET:@"http://101.200.234.127:8080/YanLu/yichang/listone.do" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSData *data =(NSData *)responseObject;
        infoArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"辅食详细信息 = %@",infoArray);
        [tableview reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"失败");
    }];
    
    
}


- (void)viewDidLoad {
    [self requestUseAFN_V2];
    
    [super viewDidLoad];
    [self AFNetworking];
    infoArray=[[NSMutableArray alloc]initWithCapacity:0];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"异    常   情   况";
    
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
    return infoArray.count;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section==0){
        return 1;
    }else{
        return 1;
    }
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *CellIdentifier1 = [NSString stringWithFormat:@"indexPath"];
    
    yichang_Cell *cell1 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
    cell1 = [tableView cellForRowAtIndexPath:indexPath];
    
    if(cell1 == nil)
    {
        cell1 = [[yichang_Cell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier1];
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
    
    if(indexPath.row==0){
        cell1.lbInfoContent.text=[NSString stringWithFormat:@"%@",[[infoArray objectAtIndex:0] objectForKey:@"title"]];
        NSLog(@"宝宝%@",[[infoArray objectAtIndex:0] objectForKey:@"title"]);
        
        
        cell1.lbTime.text=[[infoArray objectAtIndex:0] objectForKey:@"days"];
    }else{
        cell1.lbInfoContent.text=[NSString stringWithFormat:@"%@",[[infoArray objectAtIndex:1] objectForKey:@"title"]];
        NSLog(@"宝宝%@",[[infoArray objectAtIndex:1] objectForKey:@"title"]);
        
        
        cell1.lbTime.text=[[infoArray objectAtIndex:1] objectForKey:@"days"];
    }
    
    
    
    return cell1;
}




-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 137;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ycXiang_VC *xiang=[[ycXiang_VC alloc]init];
    xiang.hidesBottomBarWhenPushed =YES;
    [self.navigationController pushViewController:xiang animated:YES];
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}


//添加表头高度


- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *s=@"我是表头";
    return s;
}


//section的标题栏高度
-(CGFloat)tableview:(UITableView *)tableview heightforheaderinsection:(NSInteger)section
{
    
    return 30;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* myView = [[UIView alloc] init];
    myView.backgroundColor = [UIColor whiteColor];
    myView.layer.borderWidth=1;
    myView.layer.borderColor=RGBA(253, 244, 248, 1).CGColor;
    //myView.layer.borderColor=[UIColor p].CGColor;
    myView.layer.borderWidth=0.5;
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 90, 22)];
    titleLabel.textColor=RGBA(226, 50, 103, 1);
    titleLabel.backgroundColor = [UIColor clearColor];
    
    if(section==0){
        titleLabel.text=[NSString stringWithFormat:@"宝宝%@",[[infoArray objectAtIndex:0] objectForKey:@"times"]];
    }else{
        titleLabel.text=[NSString stringWithFormat:@"宝宝%@",[[infoArray objectAtIndex:1] objectForKey:@"times"]];
    }
    //  titleLabel.text=[self.keys objectAtIndex:section];
    [myView addSubview:titleLabel];
    // [titleLabel release];
    return myView;
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
