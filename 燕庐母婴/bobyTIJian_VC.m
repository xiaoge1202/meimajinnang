//
//  bobyTIJian_VC.m
//  美妈锦囊
//
//  Created by apple on 15/7/30.
//  Copyright (c) 2015年 燕庐科技. All rights reserved.
//

#import "bobyTIJian_VC.h"
#import "bobyTiJIan_Cell.h"
#import "PrefixHeader.pch"
#import "tiJianXiang_VC.h"

@interface bobyTIJian_VC ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation bobyTIJian_VC{
    UITableView *tableview;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"宝    宝   体   检";
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
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
    
    bobyTiJIan_Cell *cell1 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
    cell1 = [tableView cellForRowAtIndexPath:indexPath];
    
    if(cell1 == nil)
    {
        cell1 = [[bobyTiJIan_Cell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier1];
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
    /*
     1.已经体检
     2.超过体检时间
     3.将要体检
     4.将要体检以后的体检
     
     */
    
    NSString *state=@"1";
    
    if([state isEqualToString:@"0"]){
        //已经体检
        cell1.xian.backgroundColor=RGBA(195, 195, 195, 1);
        cell1.lbTitle.textColor=RGBA(195, 195, 195, 1);
        cell1.lbchushengday.textColor=RGBA(195, 195, 195, 1);
        cell1.lbtijianTime.textColor=RGBA(195, 195, 195, 1);
        cell1.lbtijianTime.text=@"体检时间（已完成）";
        cell1.imgTime.image=[UIImage imageNamed:@"完成时间"];
        
        [cell1.btnstate setBackgroundImage:[UIImage imageNamed:@"完成状态"] forState:UIControlStateNormal];
        cell1.btnstate.layer.borderWidth=0;
        state=@"1";
    
    }else if([state isEqualToString:@"1"]){
        //超时体检
        cell1.xian.backgroundColor=RGBA(205, 42, 48, 1);
        cell1.lbtijianTime.textColor=RGBA(205, 42, 48, 1);
        cell1.lbtijianTime.text=@"体检时间（已经超时）";
        cell1.imgTime.image=[UIImage imageNamed:@"超时"];
        
        [cell1.btnstate setBackgroundImage:[UIImage imageNamed:@"超时状态"] forState:UIControlStateNormal];
        cell1.btnstate.layer.borderWidth=0;
        state=@"2";
    
    }else if ([state isEqualToString:@"2"]){
        //将要开始
        
        cell1.xian.backgroundColor=RGBA(244, 167, 39, 1);
        cell1.lbtijianTime.textColor=RGBA(244, 167, 39, 1);
        cell1.lbtijianTime.text=@"体检时间（将要开始）";
        cell1.imgTime.image=[UIImage imageNamed:@"将开始的时间"];
        
        [cell1.btnstate setBackgroundImage:[UIImage imageNamed:@"将开始状态"] forState:UIControlStateNormal];
        cell1.btnstate.layer.borderWidth=0;
    
    }else{
    
    }
    
    
    
    return cell1;
}




-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    tiJianXiang_VC *tijianXiang=[[tiJianXiang_VC alloc]init];
    tijianXiang.hidesBottomBarWhenPushed =YES;
    [self.navigationController pushViewController:tijianXiang animated:YES];
}





-(void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
