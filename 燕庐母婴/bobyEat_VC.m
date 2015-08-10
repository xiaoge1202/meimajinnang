//
//  bobyEat_VC.m
//  美妈锦囊
//
//  Created by apple on 15/7/24.
//  Copyright (c) 2015年 燕庐科技. All rights reserved.
//

#import "bobyEat_VC.h"
#import "bodyEat_Cell.h"
#import "bobyEatxiang.h"
#import "PrefixHeader.pch"
#import "zaoqiXiang_VC.h"

#import "AFHTTPRequestOperationManager.h"


@interface bobyEat_VC ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation bobyEat_VC{
    
    UITableView *tableview;//表格
   // NSMutableArray *infoArray;
    int messageSum;
    
    AFHTTPRequestOperationManager *manager;
    NSMutableDictionary *dic;
    NSUserDefaults *ud;
    NSString *huaiyuntianshu;
    NSString *zhuangtai;
    NSString *huaiyunshijian;
    UIImageView *imgView;//选中的图片
    NSMutableArray *array;
    NSMutableArray *array1;//详细数据
    NSMutableArray *idArray;//需要传的id数组

}


//网络获取数据
-(void)AFNetworking
{
    manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [[AFHTTPResponseSerializer alloc]init];
    [manager GET:@"http://101.200.234.127:8080/YanLu/fushilei/fushileilist.do" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSData *data =(NSData *)responseObject;
        array = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        NSLog(@"辅食详细信息 = %@",array);
        self.infoArray=array;
        NSLog(@"%@",self.infoArray);
        for(int i=0;i<array.count;i++){
            NSString *ids=[NSString stringWithFormat:@"%d",i+1];
            [manager GET:@"http://101.200.234.127:8080/YanLu/shifu/listone.do" parameters:[@{@"t_id":ids}mutableCopy] success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                NSData *data =(NSData *)responseObject;
                array1 = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                
                NSLog(@"辅食详细信息 = %@",array1);
                [idArray addObject:array1];
                NSLog(@"%@",idArray);
                [tableview reloadData];
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"失败");
            }];
            [idArray addObject:array1];

            NSLog(@"%@",idArray);

        }
        NSLog(@"%@",idArray);

    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"失败");
        }];
        
    [tableview reloadData];

}
////得到分组下面详细的数据
-(void)AFNetworkings
{
    for(int i=0;i<7;i++){
        manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [[AFHTTPResponseSerializer alloc]init];
       
    }
    
    [tableview reloadData];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    

    //刷新表格
//    [UITableView reloadData];
}

- (void)viewDidLoad {
    dic=[[NSMutableDictionary alloc]initWithCapacity:0];
    array=[[NSMutableArray alloc]initWithCapacity:0];
    array1=[[NSMutableArray alloc]initWithCapacity:0];
    idArray=[[NSMutableArray alloc]initWithCapacity:0];
    self.infoArray=[[NSMutableArray alloc]initWithCapacity:0];
    [super viewDidLoad];
    [self AFNetworking];
    [self AFNetworkings];
    
   
    //self.infoArray=[[NSMutableArray alloc]initWithCapacity:0];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"宝    宝   辅   食";
    
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
//    tableview.tablefooterView = [UIView alloc] init];
    tableview.tableFooterView=[[UIView alloc]init];
    tableview.backgroundColor=RGBA(235, 235, 235, 1);
    [self.view addSubview:tableview];
    
    [self getud];
    [tableview reloadData];
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableview.frame.size.width, 1)];
    v.backgroundColor = [UIColor whiteColor];
    //[tableView setTableFooterView:v];
    [tableview setTableFooterView:v];

}

+ (void)hideEmptySeparators:(UITableView *)tableView
{
    UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
    [tableView setTableFooterView:v];
}
//获取怀孕天数,怀孕时间
-(void)getud
{
    ud = [NSUserDefaults standardUserDefaults];
    huaiyunshijian = [ud objectForKey:@"huaiyuntime"];
    huaiyuntianshu = [ud objectForKey:@"huaiyuntianshu"];
    //huaiyuntianshu = @"180";
    NSLog(@"44444999999999   %@",huaiyuntianshu);
    NSLog(@"44444999999999   %@",huaiyunshijian);

    zhuangtai = [ud objectForKey:@"zhuangtai"];
}

/*
 
 表格的协议
 */

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSLog(@"%ld",(unsigned long)self.infoArray.count);
    return array.count;
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    for(int i=0;i<array.count;i++){
        if(section==i){
            return array1.count;
        }
    }
    return 10;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSString *CellIdentifier1 = [NSString stringWithFormat:@"indexPath"];
    
    bodyEat_Cell *cell1 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
    cell1 = [tableView cellForRowAtIndexPath:indexPath];
    
    if(cell1 == nil)
    {
        cell1 = [[bodyEat_Cell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier1];
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
    
    
    [tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    
    //最后一行分隔线顶头显示


        cell1.separatorInset = UIEdgeInsetsMake(0, 0, 0, cell1.bounds.size.width);
    
        cell1.backgroundColor=RGBA(235, 235, 235, 1);

//划线
    cell1.selectionStyle = UITableViewCellSelectionStyleNone;
    tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    if(indexPath.section==0 && indexPath.row==0){
    cell1.xian.backgroundColor=RGBA(235, 235, 235, 1);
    }else if(indexPath.section==1&& indexPath.row==3){
    cell1.xian.backgroundColor=RGBA(235, 235, 235, 1);
    }else{
    cell1.xian.backgroundColor=RGBA(201, 201, 201, 1);
    }
    //得到当前时间
    NSDate *  senddate=[NSDate date];
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    
    NSLog(@"locationString:%@",locationString);
    imgView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 10, 60, 20)];
    //imgView.backgroundColor=RGBA(216, 104, 132, 0.5);
    imgView.image=[UIImage imageNamed:@"选中"];
    imgView.alpha=0.5;
    [cell1.contentView addSubview:imgView];
    imgView.hidden=YES;
    /*
     判断宝宝月份先把组分出来
     
     
     1.判断宝宝多少岁
     2.判断宝宝多少每一岁的多少月
     3.宝宝在每个月下的多少天
     */
    NSLog(@"==%d",[[[_infoArray objectAtIndex:1] objectForKey:@"days"] intValue]);
    if(indexPath.section==0){
        if([[[_infoArray objectAtIndex:1] objectForKey:@"days"] intValue]==5){
            //当前时间选中状态
            imgView.hidden=NO;
            cell1.lbTime.alpha=1;
            cell1.lbTime.textColor=RGBA(216, 104, 132, 1);
            cell1.lbSegment.backgroundColor=RGBA(216, 104, 132, 0.8);
            cell1.btnSegmentrect.layer.borderColor=RGBA(216, 104, 132, 0.8).CGColor;
        }
        if([[_infoArray objectAtIndex:1] objectForKey:@"days"]<=huaiyuntianshu){
            //已经过去的会怀孕天数
            
            
            
        }else{
            cell1.lbSegment.backgroundColor=RGBA(216, 104, 132, 0.8);
            cell1.btnSegmentrect.layer.borderColor=RGBA(216, 104, 132, 0.8).CGColor;
        }

    }else{
        cell1.lbSegment.backgroundColor=RGBA(122, 165, 217, 0.8);
        cell1.btnSegmentrect.layer.borderColor=RGBA(122, 165, 217, 0.8).CGColor;
    }
    //显示数据
    for(int i=0;i<array.count;i++){
        if(indexPath.section==i){
            
            
                    cell1.lbInfoContent.text=[NSString stringWithFormat:@"%@",[[array1 objectAtIndex:indexPath.row] objectForKey:@"title"]];
                    NSLog(@"宝宝%@",[[array1 objectAtIndex:indexPath.row] objectForKey:@"title"]);
            
            
                    cell1.lbTime.text=[[array1 objectAtIndex:indexPath.row] objectForKey:@"days"];
                }    }

    
//    if(indexPath.row==0){
//        cell1.lbInfoContent.text=[NSString stringWithFormat:@"%@",[[_infoArray objectAtIndex:0] objectForKey:@"title"]];
//        NSLog(@"宝宝%@",[[_infoArray objectAtIndex:0] objectForKey:@"title"]);
//        
//        
//        cell1.lbTime.text=[[_infoArray objectAtIndex:0] objectForKey:@"days"];
//    }else{
//        cell1.lbInfoContent.text=[NSString stringWithFormat:@"%@",[[_infoArray objectAtIndex:1] objectForKey:@"title"]];
//        NSLog(@"宝宝%@",[[_infoArray objectAtIndex:1] objectForKey:@"title"]);
//        
//        
//        cell1.lbTime.text=[[_infoArray objectAtIndex:1] objectForKey:@"days"];
//    }
    
    


        return cell1;
}




-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 137;
}
//去掉某一条下分割线
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    [cell drawRect:CGRectMake(0, 0, 400, 10)];
    

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0){
        bobyEatxiang *xiang=[[bobyEatxiang alloc]init];
        xiang.hidesBottomBarWhenPushed =YES;
        [self.navigationController pushViewController:xiang animated:YES];
    }else if(indexPath.section==1){
        zaoqiXiang_VC *xiang=[[zaoqiXiang_VC alloc]init];
        xiang.hidesBottomBarWhenPushed =YES;
        [self.navigationController pushViewController:xiang animated:YES];
    }
    
    
    //得到分组indexPath.section
    
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
    for(int i=0;i<array.count;i++){
        if(section==i){
        titleLabel.text=[NSString stringWithFormat:@"宝宝%@",[[array objectAtIndex:i] objectForKey:@"times"]];
        }
        
    }
    [myView addSubview:titleLabel];
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
