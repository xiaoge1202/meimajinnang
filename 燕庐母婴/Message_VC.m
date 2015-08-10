//
//  Message_VC.m
//  燕庐母婴
//
//  Created by apple on 15/6/25.
//  Copyright (c) 2015年 燕庐科技. All rights reserved.
//

#import "Message_VC.h"
#import "PrefixHeader.pch"
#import "reply_Cell.h"
#import "AFHTTPRequestOperationManager.h"
#import "UIImageView+AFNetworking.h"
#import "PostsDetails-VC.h"
#import "CircleDetails-VC.h"
#import "Circle-VC.h"
@interface Message_VC ()<UIAlertViewDelegate>
{
    UIButton *backBtn;
    UIButton *replyBtn;//圈子回复
    UIButton *diremegBtn;//私信
    UIButton *sysinfoBtn;//系统消息
    UIView *lineView;
    UIScrollView *scrollView;//滚动视图
    UIView *replyBtnlineView;//我的回复的线
    UIView *titlelineView;
    UIView *diremegBtnlineView;//我的私信的线
    UIView *sysinfoBtnlineView;//系统消息的线
    //表格
    UITableView *replyTable;//圈子回复
    UITableView *directMegTable;//私信
    UITableView *systemTable;//系统
    NSString *appstr;
    CGSize size1;
    CGSize size2;
    CGSize size3;
    CGSize size4;
    CGSize size5;
    NSMutableArray *_replyArray;
    NSMutableDictionary *_replyDic;
    AFHTTPRequestOperationManager *manger;
    NSMutableArray *_sysMessgeAry;
    NSMutableArray *_directmeg;
    
    NSMutableArray *array1;
    
    NSMutableArray *array2;

    CGSize size;
    int a;
    
    
    NSInteger tablenumber;
}

@end

@implementation Message_VC
-(void)viewWillAppear:(BOOL)animated
{
    [self AFNetworking];
    [self sysMessageData];
    [self directMegData];
}

- (void)viewDidLoad {
    array1=[[NSMutableArray alloc]initWithCapacity:0];
    array2=[[NSMutableArray alloc]initWithCapacity:0];
    tablenumber=1;


        [self AFNetworking];
    [self sysMessageData];
    [super viewDidLoad];
    self.numbers=@"10";
    NSLog(@"数字是什么%@",self.numbers);
    self.array=[[NSArray alloc]init];
    self.navigationItem.title = @"消 息 盒 子";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航栏"] forBarMetrics:UIBarMetricsDefault];
    
    /*-------------状态栏改变背景颜色-----------*/
    UIView *head = [[UIView alloc]initWithFrame:CGRectMake(0, 0,self.view.bounds.size.width, 20)];
    head.backgroundColor = [UIColor colorWithRed:248.0f/255.0f green:248.0f/255.0f blue:248.0f/255.0f alpha:1];
    [self.navigationController.view addSubview:head];
    
    self.view.backgroundColor = RGBA(235, 235, 235, 1);
  //  self.view.backgroundColor=RGBA(235,235,235,1);
    
    
    //返回按钮
    backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(20, 14, 16, 20);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIButton *rightSend = [UIButton buttonWithType:UIButtonTypeCustom];
    rightSend.frame = CGRectMake(20, 14, 38, 21);
    [rightSend setBackgroundImage:[UIImage imageNamed:@"清空"] forState:UIControlStateNormal];
    [rightSend addTarget:self action:@selector(rightSend) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightSend];
    self.navigationItem.rightBarButtonItem = rightItem;
    

    [self creatScrollView];
    [self creatView];
    [self creatTabelView];
    [self AFNetworking];


}

-(void)AFNetworking
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *userid = [ud objectForKey:@"userid"];
    manger = [AFHTTPRequestOperationManager manager];
    manger.responseSerializer = [[AFHTTPResponseSerializer alloc]init];
    
    [manger GET:@"http://101.200.234.127:8080/YanLu/huifu/list.do" parameters:[@{@"userid":userid,@"zhuangtai":@"1"}mutableCopy] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        _replyArray = [NSJSONSerialization JSONObjectWithData:(NSData *)responseObject options:0 error:nil];
        NSLog(@"我的回复 = %@,%d",_replyArray,_replyArray.count);
        
        //得到所有未读消息的id
        
        
       
        [replyTable reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"失败");
    }];
    
    
}
//查看私信
-(void)directMegData
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *userid = [ud objectForKey:@"userid"];
    manger = [AFHTTPRequestOperationManager manager];
    manger.responseSerializer = [[AFHTTPResponseSerializer alloc]init];
    
    [manger GET:@"http://101.200.234.127:8080/YanLu/pletter/list.do" parameters:[@{@"giveuserid":userid,@"zhuangtai":@"1"}mutableCopy] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        _directmeg = [NSJSONSerialization JSONObjectWithData:(NSData *)responseObject options:0 error:nil];
        NSLog(@"我的私信 = %@,%d",_directmeg,_directmeg.count);
        [directMegTable reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"我的私信失败");
    }];
    
    
}

//系统消息
-(void)sysMessageData{
    manger = [AFHTTPRequestOperationManager manager];
    manger.responseSerializer = [[AFHTTPResponseSerializer alloc]init];
    
    
    [manger GET:@"http://101.200.234.127:8080/YanLu/system/list.do" parameters:Nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        _sysMessgeAry = [NSJSONSerialization JSONObjectWithData:(NSData *)responseObject options:0 error:nil];
        NSLog(@"系统消息 = %@,%d",_sysMessgeAry,_sysMessgeAry.count);
        [systemTable reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"系统消息失败");
    }];
//    [manger GET:@"http://101.200.234.127:8080/YanLu/huifu/list.do" parameters:[@{@"userid":userid,@"zhuangtai":@"1"}mutableCopy] success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        _sysMessgeAry = [NSJSONSerialization JSONObjectWithData:(NSData *)responseObject options:0 error:nil];
//        NSLog(@"我的回复 = %@,%d",_replyArray,_replyArray.count);
//        [systemTable reloadData];
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//        NSLog(@"失败");
//    }];
}
#pragma mark 上面的按钮布局
-(void)creatView
{
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH ,39)];
    titleView.backgroundColor = RGBA(235, 235, 235, 1);
    [self.view addSubview:titleView];
    replyBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    replyBtn.frame = CGRectMake(0, 9, ScreenWidth/3, 12);
    [replyBtn setTitle:@"圈子回复" forState:UIControlStateNormal];
    [replyBtn setTitleColor:RGBA(236, 119, 147, 1) forState:UIControlStateNormal];
    [replyBtn.titleLabel setFont:[UIFont fontWithName:@"Microsoft Yahei UI" size:12]];
    [replyBtn addTarget:self action:@selector(clickreplyBtn) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:replyBtn];
    //私信
    diremegBtn= [UIButton buttonWithType:UIButtonTypeRoundedRect];
    diremegBtn.frame = CGRectMake(replyBtn.bounds.origin.x+replyBtn.bounds.size.width, 9, ScreenWidth/3, 12);
    [diremegBtn setTitle:@"我的私聊" forState:UIControlStateNormal];
    [diremegBtn setTitleColor:RGBA(137, 137, 137, 1) forState:UIControlStateNormal];
    [diremegBtn.titleLabel setFont:[UIFont fontWithName:@"Microsoft Yahei UI" size:12]];
    [diremegBtn addTarget:self action:@selector(clickdiremegBtn) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:diremegBtn];
    //系统
    //私信
    sysinfoBtn= [UIButton buttonWithType:UIButtonTypeRoundedRect];
    sysinfoBtn.frame = CGRectMake(SCREEN_WIDTH-(SCREEN_WIDTH/3), 9, ScreenWidth/3, 12);
    [sysinfoBtn setTitle:@"系统消息" forState:UIControlStateNormal];
    
    [sysinfoBtn setTitleColor:RGBA(137, 137, 137, 1) forState:UIControlStateNormal];
    [sysinfoBtn.titleLabel setFont:[UIFont fontWithName:@"Microsoft Yahei UI" size:12]];
    [sysinfoBtn addTarget:self action:@selector(clicksysinfoBtn) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:sysinfoBtn];
    titlelineView = [[UIView alloc] initWithFrame:CGRectMake(0, titleView.frame.size.height-4, ScreenWidth, 1)];
    titlelineView.backgroundColor = RGBA(195, 195, 196, 1);
    [titleView addSubview:titlelineView];
    
    lineView = [[UIView alloc] initWithFrame:CGRectMake(0, titlelineView.frame.origin.y+titlelineView.frame.size.height, ScreenWidth, 3)];
    [titleView addSubview:lineView];
    
    replyBtnlineView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, (ScreenWidth-30)/3, lineView.frame.size.height)];
    replyBtnlineView.backgroundColor = RGBA(236, 119, 147, 1);
    [lineView addSubview:replyBtnlineView];
    
    diremegBtnlineView = [[UIView alloc] initWithFrame:CGRectMake(replyBtn.bounds.origin.x+replyBtn.bounds.size.width, 0, (ScreenWidth-30)/3, lineView.frame.size.height)];
    [lineView addSubview:diremegBtnlineView];
    
    sysinfoBtnlineView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-(SCREEN_WIDTH-30)/3-10, 0, (ScreenWidth-30)/3, lineView.frame.size.height)];
    [lineView addSubview:sysinfoBtnlineView];

}

-(void)creatScrollView
{
   scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,lineView.frame.origin.y+lineView.frame.size.height, ScreenWidth, ScreenHeight-lineView.frame.origin.y-lineView.frame.size.height-64-40)];
    scrollView.contentSize = CGSizeMake(ScreenWidth*4, 1);
    scrollView.userInteractionEnabled = YES;
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
}

-(void)creatTabelView
{
    replyTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, ScreenWidth,CGRectGetHeight(scrollView.frame)-49) style:UITableViewStylePlain];
    replyTable.delegate = self;
    replyTable.dataSource  = self;
    [self setExtraCellLineHidden:replyTable];
    [scrollView addSubview:replyTable];
    
    directMegTable = [[UITableView alloc] initWithFrame:CGRectMake(ScreenWidth, 40, ScreenWidth, scrollView.frame.size.height) style:UITableViewStylePlain];
    directMegTable.delegate = self;
    directMegTable.dataSource  = self;
    [self setExtraCellLineHidden:directMegTable];
    [scrollView addSubview:directMegTable];
    
    systemTable = [[UITableView alloc] initWithFrame:CGRectMake(ScreenWidth*2, 40, ScreenWidth, scrollView.frame.size.height) style:UITableViewStylePlain];
    systemTable.delegate = self;
    systemTable.dataSource  = self;
    [self setExtraCellLineHidden:systemTable];
    [scrollView addSubview:systemTable];
    
}

-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view =[[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    [tableView setTableHeaderView:view];
}
//圈子回复
-(void)clickreplyBtn
{
    scrollView.contentOffset = CGPointMake(0, 1);
    [replyBtn setTitleColor:RGBA(236, 119, 147, 1) forState:UIControlStateNormal];
    [diremegBtn setTitleColor:RGBA(137, 137, 137, 1) forState:UIControlStateNormal];
    [sysinfoBtn setTitleColor:RGBA(137, 137, 137, 1) forState:UIControlStateNormal];
    replyBtnlineView.backgroundColor = RGBA(236, 119, 147, 1);
    diremegBtnlineView.backgroundColor = RGBA(235, 235, 235, 1);
    sysinfoBtnlineView.backgroundColor = RGBA(235, 235, 235, 1);
    tablenumber = 1;


}
//我的私信
-(void)clickdiremegBtn
{
    scrollView.contentOffset = CGPointMake(ScreenWidth, 1);
    [diremegBtn setTitleColor:RGBA(236, 119, 147, 1) forState:UIControlStateNormal];
    [replyBtn setTitleColor:RGBA(137, 137, 137, 1) forState:UIControlStateNormal];
    [sysinfoBtn setTitleColor:RGBA(137, 137, 137, 1) forState:UIControlStateNormal];
    diremegBtnlineView.backgroundColor = RGBA(236, 119, 147, 1);
    replyBtnlineView.backgroundColor = RGBA(235, 235, 235, 1);
    sysinfoBtnlineView.backgroundColor = RGBA(235, 235, 235, 1);
    tablenumber = 2;
}
//系统消息
-(void)clicksysinfoBtn
{
    scrollView.contentOffset = CGPointMake(ScreenWidth*2, 1);
    [sysinfoBtn setTitleColor:RGBA(236, 119, 147, 1) forState:UIControlStateNormal];
    [diremegBtn setTitleColor:RGBA(137, 137, 137, 1) forState:UIControlStateNormal];
    [replyBtn setTitleColor:RGBA(137, 137, 137, 1) forState:UIControlStateNormal];
    sysinfoBtnlineView.backgroundColor = RGBA(236, 119, 147, 1);
    diremegBtnlineView.backgroundColor = RGBA(235, 235, 235, 1);
    replyBtnlineView.backgroundColor = RGBA(235, 235, 235, 1);
    tablenumber = 3;
}



- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x==0) {
        //[self clickBtn1];
        [self clickreplyBtn];
    }
    else if (scrollView.contentOffset.x==SCREEN_WIDTH){
        [self clickdiremegBtn];
    }else{
        //[self clickBtn2];
        [self clicksysinfoBtn];
    }
}
//返回
-(void)goBack:(UIButton*)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 表格协议
//返回多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == replyTable) {
        return _replyArray.count;
    }else if(tableView==directMegTable){
        return _directmeg.count;
    }else{
        return [_sysMessgeAry count];
    }
    return 0;
}
//

#pragma mark 清空数据

-(void)qingkongshuju
{
    manger = [AFHTTPRequestOperationManager manager];
    manger.responseSerializer = [[AFHTTPResponseSerializer alloc]init];
    for (NSMutableDictionary *mess in _replyArray)
    {
        [array1 addObject:[mess objectForKey:@"huifuid"]];
        
        
        
    }

    //拼接字符串
    NSString *string = [array1 componentsJoinedByString:@","];
    NSLog(@"aaa---%@",string);
    
    [manger GET:@"http://101.200.234.127:8080/YanLu/huifu/toupdate.do" parameters:[@{@"huifuids":string}mutableCopy] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"删除成功");
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"失败");
    }];
    
    
}

//清空私聊
-(void)qingkongsiliao
{
    manger = [AFHTTPRequestOperationManager manager];
    manger.responseSerializer = [[AFHTTPResponseSerializer alloc]init];
    for (NSMutableDictionary *mess in _directmeg)
    {
        [array2 addObject:[mess objectForKey:@"id"]];
        
        
        
    }
    NSLog(@"%@",array2);
    
    //拼接字符串
    NSString *string = [array2 componentsJoinedByString:@","];
    NSLog(@"aaa---%@",string);
    
    [manger GET:@"http://101.200.234.127:8080/YanLu/pletter/update.do" parameters:[@{@"ids":string}mutableCopy] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"删除成功");
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"失败");
    }];
    
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cell";
    reply_Cell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[reply_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    if (tableView == replyTable) {
        NSLog(@"=====%d",_replyArray.count);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if([_replyArray count]==0){
            UIImageView *imgview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH,scrollView.frame.size.height)];
            imgview.image=[UIImage imageNamed:@"已怀孕"];
            [scrollView addSubview:imgview];
            
        
        }else{

           
            //添加头像
            _replyDic=[[NSMutableDictionary alloc]initWithCapacity:0];
            _replyDic=[_replyArray objectAtIndex:indexPath.row];
            [cell.headImage setImageWithURL:[NSURL URLWithString:[_replyDic objectForKey:@"touxaing"]] placeholderImage:[UIImage imageNamed:@"消息盒子头像"]];
            NSLog(@"%d",[_replyArray count]);
            //标题
          //  cell.titleLab.text=@"本宫办不到啊";
            cell.titleLab.text=[NSString stringWithFormat:@"%@",[_replyDic objectForKey:@"nicheng"]];
            NSLog(@"%@",[_replyDic objectForKey:@"nicheng"]);
            //cell.titleLab.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:12];
            cell.titleLab.textColor=RGBA(89, 89, 87, 1);
            //动态获取高度
            cell.titleLab.numberOfLines = 0;
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
            paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
            NSDictionary *attributes = @{NSFontAttributeName:cell.titleLab.font, NSParagraphStyleAttributeName:paragraphStyle.copy};
            size1 = [cell.titleLab.text boundingRectWithSize:CGSizeMake(ScreenWidth-51, 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
            [cell.titleLab setFrame:CGRectMake(cell.headImage.frame.origin.x+cell.headImage.frame.size.width+5, 11, size1.width, size1.height)];
            
            NSLog(@"content高度%lf",cell.titleLab.bounds.origin.y);
            NSLog(@"%lf",cell.titleLab.bounds.size.height);
            
            //时间
            //获取时间
            //截取时间
            
            NSMutableString *timeString = [NSMutableString stringWithFormat:@"%@",[[_replyArray objectAtIndex:indexPath.row] objectForKey:@"time"]];
            cell.titleLab.textColor=RGBA(89, 89, 87, 1);
            cell.contentLab.text=[NSString stringWithFormat:@"%@",[_replyDic objectForKey:@"neirong"]];
            cell.contentLab.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:15];
            
            //cell.contentLab.text=[dict objectForKey:@"neirong"];
            //动态获取label的宽度和高度
            cell.contentLab.numberOfLines = 0;
            NSMutableParagraphStyle *paragraphStyle1 = [[NSMutableParagraphStyle alloc]init];
            paragraphStyle1.lineBreakMode = NSLineBreakByWordWrapping;
            NSDictionary *attributes1 = @{NSFontAttributeName:cell.contentLab.font, NSParagraphStyleAttributeName:paragraphStyle1.copy};
            size2 = [cell.contentLab.text boundingRectWithSize:CGSizeMake(ScreenWidth-51, 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes1 context:nil].size;
            [cell.contentLab setFrame:CGRectMake(46,cell.titleLab.bounds.origin.y+size1.height+10, size2.width, size2.height)];
            NSLog(@"content高度%lf",cell.contentLab.bounds.origin.y);
            NSLog(@"%lf",cell.contentLab.bounds.size.height);
            //回复的内容
            cell.huifuContent.text=[NSString stringWithFormat:@"%@",[_replyDic objectForKey:@"tneirong"]];
            //cell.huifuContent.text=@"zklcnln;xbczxbvibjvbdvbjkbvkdgivbdbhzivbdbhxzvkbxzhvbigvfaeibvbvkbvxbkvcbxjkzbvkbvkjzbchbzxiyfbjkbvkcx bcbchzxbkcbxzhcbhzxbhckbxzhvbhcisbydbhsd";
            
            
           // cell.huifuContent.font=[UIFont systemFontOfSize:14];
            cell.huifuContent.frame=CGRectMake(10,CGRectGetMaxY(cell.contentLab.frame)+5, SCREEN_WIDTH-60, [cell.huifuContent.text sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(SCREEN_WIDTH-40, 10000) lineBreakMode:NSLineBreakByWordWrapping].height+15);

            a=cell.huifuContent.bounds.size.height;
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:[cell.huifuContent bounds]];
            
            imageView.image = [UIImage imageNamed:@"回帖框"];
            
            [cell.huifuContent addSubview:imageView];
            cell.huifuContent.backgroundColor=[UIColor clearColor];
            
           [cell.huifuContent sendSubviewToBack:imageView];

            cell.huifuContent.textColor=RGBA(148, 147, 148, 1);

        
        }


    
    }else if(tableView==directMegTable){
                //判断表格里是否有内容
        if(_directmeg.count==0){
        
        }else{
             //[self directMegData];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.headImage setImageWithURL:[NSURL URLWithString:[[_directmeg objectAtIndex:indexPath.row] objectForKey:@"touxaing"]] placeholderImage:[UIImage imageNamed:@"消息盒子头像"]];
            //昵称
            cell.titleLab.text=[NSString stringWithFormat:@"%@",[[_directmeg objectAtIndex:indexPath.row] objectForKey:@"nicheng"]];
            cell.titleLab.textColor=RGBA(89, 87, 87, 1);
            //cell.contentLab.text=@"本宫不死，必有后路。";
            cell.contentLab.text=[NSString stringWithFormat:@"%@",[[_directmeg objectAtIndex:indexPath.row] objectForKey:@"neirong"]];
            //cell.contentLab.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:15];
            cell.contentLab.textColor=RGBA(89, 87, 87, 1);
            
            
            //时间
            //cell.timeLab.text=@"6月28日 23：11";
            cell.timeLab.text=[NSString stringWithFormat:@"%@",[[_directmeg objectAtIndex:indexPath.row] objectForKey:@"time"]];
            cell.titleLab.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:10];
            // cell.titleLab.textColor=RGBA(148, 147, 148, 1);

        }
        //
        
        
    }else{
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //添加头像
        cell.headImage.image = [UIImage imageNamed:@"系统消息"];
        
        
        cell.titleLab.text=[NSString stringWithFormat:@"%@",[[_sysMessgeAry objectAtIndex:indexPath.row] objectForKey:@"nicheng"]];
        cell.titleLab.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:10];
        cell.titleLab.textColor=RGBA(89, 89, 87, 1);
        cell.contentLab.text=[NSString stringWithFormat:@"%@",[[_sysMessgeAry objectAtIndex:indexPath.row] objectForKey:@"neirong"]];
        //cell.contentLab.text=@"系统说你已经通过审核可以直接上传说说和内容，哈哈jzjvnj∆˚n再看你就能尽快V字你就出现新款智能子女尽可能快举行可惜女空间小女警可能性可不能看就行呢。";
        
        cell.contentLab.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:15];
        cell.contentLab.textColor=RGBA(89, 89, 87, 1);
        //动态获取高度
                cell.contentLab.numberOfLines = 0;
                NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
                paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
                NSDictionary *attributes = @{NSFontAttributeName:cell.contentLab.font, NSParagraphStyleAttributeName:paragraphStyle.copy};
                size4 = [cell.contentLab.text boundingRectWithSize:CGSizeMake(ScreenWidth-51, 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
                [cell.contentLab setFrame:CGRectMake(46,CGRectGetMaxY(cell.titleLab.frame), size4.width, size4.height)];
        
        //时间
        cell.timeLab.text=@"6月28日 23：11";
        cell.titleLab.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:10];
        cell.titleLab.textColor=RGBA(89, 89, 87, 1);
    
    }
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView==replyTable){
        
        PostsDetails_VC *Posts = [[PostsDetails_VC alloc] init];
        
        Posts.TidCount =[NSString stringWithFormat:@"%@",[[_replyArray objectAtIndex:indexPath.row] objectForKey:@"tid"]];
        Posts.userId=[NSString stringWithFormat:@"%@",[[_replyArray objectAtIndex:indexPath.row] objectForKey:@"userid"]];
        Posts.quanziID=[NSString stringWithFormat:@"%@",[[_replyArray objectAtIndex:indexPath.row] objectForKey:@"quanziid"]];
        Posts.title = [NSString stringWithFormat:@"%@",[[_replyArray objectAtIndex:indexPath.row] objectForKey:@"nicheng"]];
        Posts.neirong =[NSString stringWithFormat:@"%@",[[_replyArray objectAtIndex:indexPath.row] objectForKey:@"neirong"]];
        Posts.zannumber=[NSString stringWithFormat:@"%@",[[_replyArray objectAtIndex:indexPath.row] objectForKey:@"dianzanzongshu"]];
        Posts.quanName=[NSString stringWithFormat:@"%@",[[_replyArray objectAtIndex:indexPath.row] objectForKey:@"quanname"]];
        Posts.time=[NSString stringWithFormat:@"%@",[[_replyArray objectAtIndex:indexPath.row] objectForKey:@"time"]];
        Posts.hidesBottomBarWhenPushed =YES;
        [self.navigationController pushViewController:Posts animated:YES];

    
    }else if(tableView==directMegTable){
        //跳转到私聊界面
    }
    
    
    


}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView ==replyTable) {
        return size2.height+a+37;
        NSLog(@"%d",a);
        NSLog(@"%f",size2.height);
    }else if (tableView ==directMegTable){
        return 60;
    }
    else
    {
        return size4.height+41;
    }
}
//清空


-(void)rightSend{
    NSLog(@"清空");
    UIAlertView *alit=[[UIAlertView alloc]initWithTitle:nil message:@"确认清空全部消息" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    alit.backgroundColor=[UIColor whiteColor];
    alit.delegate=self;
    [alit show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    
        if(buttonIndex==1){
            
            if(tablenumber==1){
                [self qingkongshuju];
                [replyTable reloadData];
            
            }else if(tablenumber==2){
                [self qingkongsiliao];
                [directMegTable reloadData];
            
            }else if(tablenumber==3){
                NSLog(@"删除系统消息");
            }
            NSLog(@"删除");
           // [self directMegData];
           
        }else{
            NSLog(@"取消");
        }
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
