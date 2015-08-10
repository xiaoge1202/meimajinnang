//
//  NotPregnant-VC.m
//  燕庐母婴
//
//  Created by 侯泽彭 on 15/7/15.
//  Copyright (c) 2015年 燕庐科技. All rights reserved.
//

#import "NotPregnant-VC.h"
#import "NavigationInteractiveTransition.h"

@interface NotPregnant_VC ()<UIGestureRecognizerDelegate>
{
    NSDictionary *group1;
    NSDictionary *group2;
    NSDictionary *group3;
}
@property (nonatomic, weak) UIPanGestureRecognizer *popRecognizer;
/**
 *  方案一不需要的变量
 */
@property (nonatomic, strong) NavigationInteractiveTransition *navT;
@end

@implementation NotPregnant_VC

-(void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self addSearchTextNav];
}


-(void)addTuijianzhishi
{
    //[@{@"time":huaiyuntianshu}mutableCopy]
    self.manager = [AFHTTPRequestOperationManager manager];
    self.manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [self.manager GET:@"http://101.200.234.127:8080/YanLu/jinribidu/list.do" parameters:[@{@"t_id":@"1"}mutableCopy] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSData *data = (NSData *)responseObject;
        self.knowledgeArr =[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"11111111%@",self.knowledgeArr);
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"获取相响应失败");
    }];
}
-(void)addMeizhoubibei
{
    
    //[@{@"shijian":huaiyuntianshu}mutableCopy]
    self.manager = [AFHTTPRequestOperationManager manager];
    self.manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [self.manager GET:@"http://101.200.234.127:8080/YanLu/benzhoubibei/list.do" parameters:[@{@"t_id":@"1"}mutableCopy] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSData *data = (NSData *)responseObject;
        self.mustPrepareArr =[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"22222222%@",self.mustPrepareArr);
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"获取相响应失败");
    }];
}

-(void)addSameAgeRetie
{
    self.manager = [AFHTTPRequestOperationManager manager];
    self.manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    [self.manager GET:@"http://101.200.234.127:8080/YanLu/tiezi/listone.do" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSData *data = (NSData *)responseObject;
        self.sameAgeArr =[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"3333333%@",self.sameAgeArr);
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"获取相响应失败");
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addTuijianzhishi];
    [self addMeizhoubibei];
    [self addSameAgeRetie];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航栏"] forBarMetrics:UIBarMetricsDefault];
    self.navigationItem.title = @"";
    self.view.backgroundColor = RGBA(235, 235, 235, 1);
    self.tableArr = @[@"推荐知识",@"育儿必备物品",@"同城孕育热搜贴"];
    self.imgArr = @[@"推荐",@"必备",@"热贴"];
    self.textArr = @[@"做您孕期最坚实的后盾",@"呵护宝宝，呵护您",@"跟姐妹们聊一聊育儿经"];
    
    [self creatTableView];
    
    UIGestureRecognizer *gesture = self.navigationController.interactivePopGestureRecognizer;
    gesture.enabled = NO;
    UIView *gestureView = gesture.view;
    
    UIPanGestureRecognizer *popRecognizer = [[UIPanGestureRecognizer alloc] init];
    popRecognizer.delegate = self;
    popRecognizer.maximumNumberOfTouches = 1;
    [gestureView addGestureRecognizer:popRecognizer];
    
    //#if USE_方案一
    //    _navT = [[NavigationInteractiveTransition alloc] initWithViewController:self];
    //    [popRecognizer addTarget:_navT action:@selector(handleControllerPop:)];
    //
    //#elif USE_方案二
    /**
     *  获取系统手势的target数组
     */
    NSMutableArray *_targets = [gesture valueForKey:@"_targets"];
    /**
     *  获取它的唯一对象，我们知道它是一个叫UIGestureRecognizerTarget的私有类，它有一个属性叫_target
     */
    id gestureRecognizerTarget = [_targets firstObject];
    /**
     *  获取_target:_UINavigationInteractiveTransition，它有一个方法叫handleNavigationTransition:
     */
    id navigationInteractiveTransition = [gestureRecognizerTarget valueForKey:@"_target"];
    /**
     *  通过前面的打印，我们从控制台获取出来它的方法签名。
     */
    SEL handleTransition = NSSelectorFromString(@"handleNavigationTransition:");
    /**
     *  创建一个与系统一模一样的手势，我们只把它的类改为UIPanGestureRecognizer
     */
    [popRecognizer addTarget:navigationInteractiveTransition action:handleTransition];
    //#endif
    // Do any additional setup after loading the view.
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    /**
     *  这里有两个条件不允许手势执行，1、当前控制器为根控制器；2、如果这个push、pop动画正在执行（私有属性）
     */
    return self.navigationController.viewControllers.count != 1 && ![[self.navigationController valueForKey:@"_isTransitioning"] boolValue];
}

-(void)addSearchTextNav
{
    UIImageView *navView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    navView.image = [UIImage imageNamed:@"导航栏"];
    navView.multipleTouchEnabled = YES;
    navView.userInteractionEnabled = YES;
    navView.tag = 66;
    [self.navigationController.view addSubview:navView];
    
    UIImageView *imgview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"搜索1"]];
    imgview.frame = CGRectMake(0, 0, ScreenWidth-61, 29);
    
    self.searchText = [UIButton buttonWithType:UIButtonTypeCustom];
    self.searchText.frame = CGRectMake(12, 27, ScreenWidth-61, 29);
    [self.searchText setImage:imgview.image forState:UIControlStateNormal];
    [self.searchText addTarget:self action:@selector(clcikSearchBtn) forControlEvents:UIControlEventTouchUpInside];
    
    [navView addSubview:self.searchText];
    
    
    UIImageView *glassImg = [[UIImageView alloc] initWithFrame:CGRectMake(8, 7, 18, 18)];
    glassImg.image = [UIImage imageNamed:@"放大镜1"];
    [self.searchText addSubview:glassImg];
    
    UIImageView *evenlopeImg = [[UIImageView alloc] initWithFrame:CGRectMake(self.searchText.frame.origin.x+self.searchText.frame.size.width+5, 27, 34, 29)];
    evenlopeImg.multipleTouchEnabled = YES;
    evenlopeImg.userInteractionEnabled = YES;
    evenlopeImg.image = [UIImage imageNamed:@"搜索2"];
    [navView addSubview:evenlopeImg];
    
    UIButton *evenlopeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    evenlopeBtn.frame = CGRectMake(7, 10, 16, 13);
    [evenlopeBtn setImage:[UIImage imageNamed:@"信封"] forState:UIControlStateNormal];
    [evenlopeBtn addTarget:self action:@selector(clickEvenlopeBtn) forControlEvents:UIControlEventTouchUpInside];
    [evenlopeImg addSubview:evenlopeBtn];
}

-(void)clcikSearchBtn
{
    Search_VC *seachVC = [[Search_VC alloc] init];
    seachVC.hidesBottomBarWhenPushed = YES;
    seachVC.searchStr = @"1";
    for (UIView *subviews in [self.navigationController.view subviews]) {
        if (subviews.tag==66) {
            [subviews removeFromSuperview];
        }
    }
    [self.navigationController pushViewController:seachVC animated:YES];
}

-(void)clickEvenlopeBtn
{
    for (UIView *subviews in [self.navigationController.view subviews]) {
        if (subviews.tag==66) {
            [subviews removeFromSuperview];
        }
    }
    Message_VC *mesg =[[Message_VC alloc]init];
    mesg.hidesBottomBarWhenPushed = YES;
    // Message_VC.idCount = self.circleID;
    [self.navigationController pushViewController:mesg animated:YES];
}

//UILabel *labelss;
//- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
//{
//    if ([self.searchText.text isEqualToString:@"        "]) {
//        labelss = [[UILabel alloc] initWithFrame:CGRectMake(30, 7, 150, 18)];
//        labelss.text = @"请输入搜索的问题";
//        labelss.textColor = [UIColor lightGrayColor];
//        labelss.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:12];
//        [self.searchText addSubview:labelss];
//    }
//    
//    
//    return YES;
//}
//
//- (void)textViewDidChange:(UITextView *)textView
//{
//    labelss.text = @"";
//    if ([self.searchText.text isEqualToString:@"        "])
//    {
//        labelss.text = @"请输入搜索的问题";
//    }
//}
//
//- (void)textViewDidEndEditing:(UITextView *)textView
//{
//    labelss.text = @"";
//}
//
//- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
//{
//    if ([self.searchText.text isEqualToString:@"        "]) {
//        return NO;
//    }
//    else
//    {
//        return YES;
//    }
//    
//}

-(void)creatTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    //self.tableView.sectionFooterHeight = 0;
    [self.view addSubview:self.tableView];
    
    UIImageView *titleView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth*0.54)];
    titleView.userInteractionEnabled = YES;
    titleView.multipleTouchEnabled = YES;
    titleView.image = [UIImage imageNamed:@"未标题-21-01"];
    self.tableView.tableHeaderView = titleView;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, titleView.frame.size.height-ScreenWidth*0.1, ScreenWidth, ScreenWidth*0.1)];
    [button setImage:[UIImage imageNamed:@"未标题-21-02"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickzhuangtaiBtn) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:button];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(12, (button.frame.size.height-20)/2, 200, 20)];
    label.text = @"点击切换状态";
    label.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:14];
    label.textColor = RGBA(46, 114, 185, 1);
    [button addSubview:label];
    
    UIButton *jinruBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    jinruBtn.frame = CGRectMake(ScreenWidth-10-ScreenWidth*0.022, (button.frame.size.height-ScreenWidth*0.048)/2, ScreenWidth*0.022, ScreenWidth*0.048);
    [jinruBtn setImage:[UIImage imageNamed:@"未标题-21-03"] forState:UIControlStateNormal];
    [jinruBtn addTarget:self action:@selector(clickzhuangtaiBtn) forControlEvents:UIControlEventTouchUpInside];
    [button addSubview:jinruBtn];
}

-(void)clickzhuangtaiBtn
{
    ChangeStateViewController *changeVC = [[ChangeStateViewController alloc] init];
    changeVC.hidesBottomBarWhenPushed = YES;
    for (UIView *subviews in [self.navigationController.view subviews]) {
        if (subviews.tag==66) {
            [subviews removeFromSuperview];
        }
    }
    [self.navigationController pushViewController:changeVC animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.tableArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return self.knowledgeArr.count;
            break;
            
        case 1:
            return self.mustPrepareArr.count;
            break;
            
        default:
            return 2;
            //return self.sameAgeArr.count;
            break;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *str1 = [NSString stringWithFormat:@"cell%d%d",indexPath.section,indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:str1];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str1];
    }
    //    else
    //    {
    //        while ([cell.contentView.subviews lastObject] != nil) {
    //            [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
    //        }
    //    }
    
    UIImageView *touxiangImg = [[UIImageView alloc] initWithFrame:CGRectMake(20, 12, 62, 50)];
    touxiangImg.image = [UIImage imageNamed:@"宝宝头像"];
    
    UILabel *neironglabel = [[UILabel alloc] initWithFrame:CGRectMake(touxiangImg.frame.origin.x+touxiangImg.frame.size.width+15, 20, ScreenWidth-(touxiangImg.frame.origin.x+touxiangImg.frame.size.width+15), 12)];
    neironglabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:12];
    neironglabel.textColor = RGBA(89, 87, 87, 1);
    
    UIImageView *liulanImg = [[UIImageView alloc] initWithFrame:CGRectMake(touxiangImg.frame.origin.x+touxiangImg.frame.size.width+15, neironglabel.frame.origin.y+neironglabel.frame.size.height+15, 12, 9)];
    liulanImg.image = [UIImage imageNamed:@"see"];
    
    UILabel *liulanLabel = [[UILabel alloc] initWithFrame:CGRectMake(liulanImg.frame.origin.x+liulanImg.frame.size.width+5, neironglabel.frame.origin.y+neironglabel.frame.size.height+15, 30, 9)];
    liulanLabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:9];
    liulanLabel.textColor = RGBA(89, 87, 87, 1);
    
    UIImageView *huifuImg = [[UIImageView alloc] initWithFrame:CGRectMake(liulanLabel.frame.origin.x+liulanLabel.frame.size.width+50, neironglabel.frame.origin.y+neironglabel.frame.size.height+15, 12, 9)];
    huifuImg.image = [UIImage imageNamed:@"话题"];
    
    UILabel *huifuLabel = [[UILabel alloc] initWithFrame:CGRectMake(huifuImg.frame.origin.x+huifuImg.frame.size.width+5, neironglabel.frame.origin.y+neironglabel.frame.size.height+15, 30, 9)];
    huifuLabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:9];
    huifuLabel.textColor = RGBA(89, 87, 87, 1);
    
    UIImageView *bibeiimgage1 = [[UIImageView alloc] initWithFrame:CGRectMake(20, 12, 62, 57)];
    bibeiimgage1.image = [UIImage imageNamed:@"宝宝头像"];
    
    UILabel *bibeilabel1 = [[UILabel alloc] initWithFrame:CGRectMake(20, bibeiimgage1.frame.origin.y+bibeiimgage1.frame.size.height+10, 62, 9)];
    bibeilabel1.textColor = RGBA(89, 87, 87, 1);
    bibeilabel1.textAlignment = NSTextAlignmentCenter;
    bibeilabel1.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:9];
    
    UIImageView *bibeiimgage2 = [[UIImageView alloc] initWithFrame:CGRectMake(bibeiimgage1.frame.origin.x+bibeiimgage1.frame.size.width+(ScreenWidth-279)/3, 12, 59, 57)];
    bibeiimgage2.image = [UIImage imageNamed:@"宝宝头像"];
    
    UILabel *bibeilabel2 = [[UILabel alloc] initWithFrame:CGRectMake(bibeiimgage1.frame.origin.x+bibeiimgage1.frame.size.width+(ScreenWidth-279)/3, bibeiimgage2.frame.origin.y+bibeiimgage2.frame.size.height+10, 62, 9)];
    bibeilabel2.textAlignment = NSTextAlignmentCenter;
    bibeilabel2.textColor = RGBA(89, 87, 87, 1);
    bibeilabel2.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:9];
    
    UIImageView *bibeiimgage3 = [[UIImageView alloc] initWithFrame:CGRectMake(bibeiimgage2.frame.origin.x+bibeiimgage2.frame.size.width+(ScreenWidth-279)/3, 12, 62, 57)];
    bibeiimgage3.image = [UIImage imageNamed:@"宝宝头像"];
    
    UILabel *bibeilabel3 = [[UILabel alloc] initWithFrame:CGRectMake(bibeiimgage2.frame.origin.x+bibeiimgage2.frame.size.width+(ScreenWidth-279)/3, bibeiimgage3.frame.origin.y+bibeiimgage3.frame.size.height+10, 62, 9)];
    bibeilabel3.textAlignment = NSTextAlignmentCenter;
    bibeilabel3.textColor = RGBA(89, 87, 87, 1);
    bibeilabel3.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:9];
    
    UIImageView *bibeiimgage4 = [[UIImageView alloc] initWithFrame:CGRectMake(bibeiimgage3.frame.origin.x+bibeiimgage3.frame.size.width+(ScreenWidth-279)/3, 12, 62, 57)];
    bibeiimgage4.image = [UIImage imageNamed:@"宝宝头像"];
    
    UILabel *bibeilabel4 = [[UILabel alloc] initWithFrame:CGRectMake(bibeiimgage3.frame.origin.x+bibeiimgage3.frame.size.width+(ScreenWidth-279)/3, bibeiimgage4.frame.origin.y+bibeiimgage4.frame.size.height+10, 62, 9)];
    bibeilabel4.textColor = RGBA(89, 87, 87, 1);
    bibeilabel4.textAlignment = NSTextAlignmentCenter;
    bibeilabel4.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:9];
    
    
    switch (indexPath.section) {
        case 1:
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell addSubview:bibeiimgage1];
            [cell addSubview:bibeilabel1];
            [cell addSubview:bibeiimgage2];
            [cell addSubview:bibeilabel2];
            [cell addSubview:bibeiimgage3];
            [cell addSubview:bibeilabel3];
            [cell addSubview:bibeiimgage4];
            [cell addSubview:bibeilabel4];
            bibeilabel1.text = @"防辐射服";
            bibeilabel2.text = @"隔热奶瓶";
            bibeilabel3.text = @"尿不湿";
            bibeilabel4.text = @"爬行服";
            break;
            
        default:
            //[cell addSubview:touxiangImg];
            [cell addSubview:neironglabel];
            [cell addSubview:liulanImg];
            [cell addSubview:liulanLabel];
            [cell addSubview:huifuImg];
            [cell addSubview:huifuLabel];
            switch (indexPath.section) {
                case 0:
                    group1=[[NSDictionary alloc]initWithObjectsAndKeys:indexPath,@"indexpath",cell,@"cell", nil];
                    [NSThread detachNewThreadSelector:@selector(loadLabelTableView:) toTarget:self withObject:group1];
                    neironglabel.text = [[self.knowledgeArr objectAtIndex:indexPath.row] objectForKey:@"biaoti"];
                    liulanLabel.text = [[[self.knowledgeArr objectAtIndex:indexPath.row] objectForKey:@"yueducishu"] stringValue];
                    huifuLabel.text = [[self.knowledgeArr objectAtIndex:indexPath.row] objectForKey:@"huifuzongshu"];
                    break;
                    
                case 2:
                    group2=[[NSDictionary alloc]initWithObjectsAndKeys:indexPath,@"indexpath",cell,@"cell", nil];
                    [NSThread detachNewThreadSelector:@selector(loadLabelTableView:) toTarget:self withObject:group2];
                    neironglabel.text = [[self.sameAgeArr objectAtIndex:indexPath.row] objectForKey:@"title"];
                    liulanLabel.text = [[[self.sameAgeArr objectAtIndex:indexPath.row] objectForKey:@"chakanzongshu"] stringValue];
                    huifuLabel.text = [[[self.sameAgeArr objectAtIndex:indexPath.row] objectForKey:@"pinglunzongshu"] stringValue];
                    break;
                    
                    
                default:
                    break;
            }
            break;
    }
    return cell;
    
}

-(void)loadLabelTableView:(NSDictionary *)group
{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 12, 62, 50)];
    NSData *data;
    if (group == group1) {
        data=[NSData dataWithContentsOfURL:[NSURL URLWithString:[[self.knowledgeArr objectAtIndex:[[group objectForKey:@"indexpath"] row]] objectForKey:@"tupian"]]];
    }
    else if (group == group2)
    {
        data=[NSData dataWithContentsOfURL:[NSURL URLWithString:[[self.sameAgeArr objectAtIndex:[[group objectForKey:@"indexpath"] row]] objectForKey:@"touxiang"]]];
    }
//    else if (group == group3)
//    {
//        data=[NSData dataWithContentsOfURL:[NSURL URLWithString:[[self.sameAgeArr objectAtIndex:[[group objectForKey:@"indexpath"] row]] objectForKey:@"touxiang"]]];
//    }
    
    //NSLog(@"tupian:%@",data);
    UIImage *img=[UIImage imageWithData:data];
    
    imageView.image=img;
    if (data == nil) {
        imageView.image = [UIImage imageNamed:@"宝宝头像"];
    }
    [[group objectForKey:@"cell"]  addSubview:imageView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 1)
    {
        return 58+ScreenHeight*0.26;
    }
    else
    {
        return 58;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 2) {
        return 20;
    }
    else
    {
        self.tableView.sectionFooterHeight = 0;
        return 0;
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 1:
            return 101;
            break;
            
        default:
            return 72;
            break;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if(section == 1)
    {
        UIView *biaotouView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 133)];
        biaotouView.backgroundColor = [UIColor whiteColor];
        
        UITapGestureRecognizer *singleTouch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard:)];
        [biaotouView addGestureRecognizer:singleTouch];
        
        UIImageView *shipinImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight*0.26)];
        shipinImg.image = [UIImage imageNamed:@"shipinImg"];
        shipinImg.userInteractionEnabled = YES;
        shipinImg.multipleTouchEnabled = YES;
        [biaotouView addSubview:shipinImg];
        
        UIButton *renqiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        renqiBtn.frame = CGRectMake(ScreenWidth*0.076, shipinImg.frame.size.height*0.06, ScreenWidth*0.155, shipinImg.frame.size.height*0.352);
        [renqiBtn setImage:[UIImage imageNamed:@"人气"] forState:UIControlStateNormal];
        [renqiBtn addTarget:self action:@selector(clickrenqiBtn) forControlEvents:UIControlEventTouchUpInside];
        [shipinImg addSubview:renqiBtn];
        
        UILabel *renqiLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth*0.076-5, renqiBtn.frame.origin.y+renqiBtn.frame.size.height+2, ScreenWidth*0.155+10, 10)];
        renqiLabel.text = @"美妈萌宝上电视";
        renqiLabel.textAlignment = NSTextAlignmentCenter;
        renqiLabel.textColor = [UIColor whiteColor];
        renqiLabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:8];
        [shipinImg addSubview:renqiLabel];
        
        UIButton *quanweiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        quanweiBtn.frame = CGRectMake(renqiBtn.frame.origin.x+renqiBtn.frame.size.width+ScreenWidth*0.076, shipinImg.frame.size.height*0.06, ScreenWidth*0.155, shipinImg.frame.size.height*0.352);
        [quanweiBtn setImage:[UIImage imageNamed:@"权威"] forState:UIControlStateNormal];
        [quanweiBtn addTarget:self action:@selector(clickquanweiBtn) forControlEvents:UIControlEventTouchUpInside];
        [shipinImg addSubview:quanweiBtn];
        
        UILabel *quanweiLabel = [[UILabel alloc] initWithFrame:CGRectMake(renqiBtn.frame.origin.x+renqiBtn.frame.size.width+ScreenWidth*0.076-10, quanweiBtn.frame.origin.y+quanweiBtn.frame.size.height+2, ScreenWidth*0.155+15, 10)];
        quanweiLabel.textColor = [UIColor whiteColor];
        quanweiLabel.textAlignment = NSTextAlignmentCenter;
        quanweiLabel.text = @"母婴专家知识视频";
        quanweiLabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:8];
        [shipinImg addSubview:quanweiLabel];
        
        UIButton *jianbiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        jianbiBtn.frame = CGRectMake(quanweiBtn.frame.origin.x+quanweiBtn.frame.size.width+ScreenWidth*0.076, shipinImg.frame.size.height*0.06, ScreenWidth*0.155, shipinImg.frame.size.height*0.352);
        [jianbiBtn setImage:[UIImage imageNamed:@"爆笑简笔画"] forState:UIControlStateNormal];
        [jianbiBtn addTarget:self action:@selector(clickjianbiBtn) forControlEvents:UIControlEventTouchUpInside];
        [shipinImg addSubview:jianbiBtn];
        
        UILabel *jianbiLabel = [[UILabel alloc] initWithFrame:CGRectMake(quanweiBtn.frame.origin.x+quanweiBtn.frame.size.width+ScreenWidth*0.076, jianbiBtn.frame.origin.y+jianbiBtn.frame.size.height+2, ScreenWidth*0.155, 10)];
        jianbiLabel.text = @"爆笑简笔画";
        jianbiLabel.textAlignment = NSTextAlignmentCenter;
        jianbiLabel.textColor = [UIColor whiteColor];
        jianbiLabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:8];
        [shipinImg addSubview:jianbiLabel];
        
        UIButton *bibeiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        bibeiBtn.frame = CGRectMake(jianbiBtn.frame.origin.x+jianbiBtn.frame.size.width+ScreenWidth*0.076, shipinImg.frame.size.height*0.06, ScreenWidth*0.155, shipinImg.frame.size.height*0.352);
        [bibeiBtn setImage:[UIImage imageNamed:@"备孕必备"] forState:UIControlStateNormal];
        [bibeiBtn addTarget:self action:@selector(clickbibeiBtn) forControlEvents:UIControlEventTouchUpInside];
        [shipinImg addSubview:bibeiBtn];
        
        UILabel *bibeiLabel = [[UILabel alloc] initWithFrame:CGRectMake(jianbiBtn.frame.origin.x+jianbiBtn.frame.size.width+ScreenWidth*0.076, bibeiBtn.frame.origin.y+bibeiBtn.frame.size.height+2, ScreenWidth*0.155, 10)];
        bibeiLabel.text = @"备孕必备";
        bibeiLabel.textAlignment = NSTextAlignmentCenter;
        bibeiLabel.textColor = [UIColor whiteColor];
        bibeiLabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:8];
        [shipinImg addSubview:bibeiLabel];
        
        UIButton *zhishiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        zhishiBtn.frame = CGRectMake(ScreenWidth*0.076, renqiLabel.frame.origin.y+renqiLabel.frame.size.height+shipinImg.frame.size.height*0.06, ScreenWidth*0.155, shipinImg.frame.size.height*0.352);
        [zhishiBtn setImage:[UIImage imageNamed:@"备孕知识"] forState:UIControlStateNormal];
        [zhishiBtn addTarget:self action:@selector(clickzhishiBtn) forControlEvents:UIControlEventTouchUpInside];
        [shipinImg addSubview:zhishiBtn];
        
        UILabel *zhishiLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth*0.076, zhishiBtn.frame.origin.y+zhishiBtn.frame.size.height+2, ScreenWidth*0.155, 10)];
        zhishiLabel.text = @"备孕知识";
        zhishiLabel.textAlignment = NSTextAlignmentCenter;
        zhishiLabel.textColor = [UIColor whiteColor];
        zhishiLabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:8];
        [shipinImg addSubview:zhishiLabel];
        
        UIButton *zhenjiaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        zhenjiaBtn.frame = CGRectMake(zhishiBtn.frame.origin.x+zhishiBtn.frame.size.width+ScreenWidth*0.076, renqiLabel.frame.origin.y+renqiLabel.frame.size.height+shipinImg.frame.size.height*0.06, ScreenWidth*0.155, shipinImg.frame.size.height*0.352);
        [zhenjiaBtn setImage:[UIImage imageNamed:@"真假辟谣"] forState:UIControlStateNormal];
        [zhenjiaBtn addTarget:self action:@selector(clickzhenjiaBtn) forControlEvents:UIControlEventTouchUpInside];
        [shipinImg addSubview:zhenjiaBtn];
        
        UILabel *zhenjiaLabel = [[UILabel alloc] initWithFrame:CGRectMake(zhishiBtn.frame.origin.x+zhishiBtn.frame.size.width+ScreenWidth*0.076, zhenjiaBtn.frame.origin.y+zhenjiaBtn.frame.size.height+2, ScreenWidth*0.155, 10)];
        zhenjiaLabel.text = @"真假辟谣";
        zhenjiaLabel.textAlignment = NSTextAlignmentCenter;
        zhenjiaLabel.textColor = [UIColor whiteColor];
        zhenjiaLabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:8];
        [shipinImg addSubview:zhenjiaLabel];
        
        UIButton *jiqiaoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        jiqiaoBtn.frame = CGRectMake(zhenjiaBtn.frame.origin.x+zhenjiaBtn.frame.size.width+ScreenWidth*0.076, renqiLabel.frame.origin.y+renqiLabel.frame.size.height+shipinImg.frame.size.height*0.06, ScreenWidth*0.155, shipinImg.frame.size.height*0.352);
        [jiqiaoBtn setImage:[UIImage imageNamed:@"备孕技巧"] forState:UIControlStateNormal];
        [jiqiaoBtn addTarget:self action:@selector(clickjiqiaoBtn) forControlEvents:UIControlEventTouchUpInside];
        [shipinImg addSubview:jiqiaoBtn];
        
        UILabel *jiqiaoLabel = [[UILabel alloc] initWithFrame:CGRectMake(zhenjiaBtn.frame.origin.x+zhenjiaBtn.frame.size.width+ScreenWidth*0.076, zhenjiaBtn.frame.origin.y+zhenjiaBtn.frame.size.height+2, ScreenWidth*0.155, 10)];
        jiqiaoLabel.text = @"备孕技巧";
        jiqiaoLabel.textAlignment = NSTextAlignmentCenter;
        jiqiaoLabel.textColor = [UIColor whiteColor];
        jiqiaoLabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:8];
        [shipinImg addSubview:jiqiaoLabel];
        
        
        UIButton *gengduoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        gengduoBtn.frame = CGRectMake(jiqiaoBtn.frame.origin.x+jiqiaoBtn.frame.size.width+ScreenWidth*0.076, renqiLabel.frame.origin.y+renqiLabel.frame.size.height+shipinImg.frame.size.height*0.06, ScreenWidth*0.155, shipinImg.frame.size.height*0.352);
        [gengduoBtn setImage:[UIImage imageNamed:@"更多知识"] forState:UIControlStateNormal];
        [gengduoBtn addTarget:self action:@selector(clickgengduoBtn) forControlEvents:UIControlEventTouchUpInside];
        [shipinImg addSubview:gengduoBtn];
        
        UILabel *gengduoLabel = [[UILabel alloc] initWithFrame:CGRectMake(jiqiaoBtn.frame.origin.x+jiqiaoBtn.frame.size.width+ScreenWidth*0.076, gengduoBtn.frame.origin.y+gengduoBtn.frame.size.height+2, ScreenWidth*0.155, 10)];
        gengduoLabel.text = @"更多知识";
        gengduoLabel.textAlignment = NSTextAlignmentCenter;
        gengduoLabel.textColor = [UIColor whiteColor];
        gengduoLabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:8];
        [shipinImg addSubview:gengduoLabel];
        
        UIImageView *titleImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, shipinImg.frame.size.height+15, 33, 33)];
        titleImg.image = [UIImage imageNamed:[self.imgArr objectAtIndex:section]];
        [biaotouView addSubview:titleImg];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleImg.frame.origin.x+titleImg.frame.size.width+12, shipinImg.frame.size.height+15, ScreenWidth-(titleImg.frame.origin.x+titleImg.frame.size.width+42), 15)];
        titleLabel.textColor = RGBA(238, 128, 135, 1);
        titleLabel.text = [self.tableArr objectAtIndex:section];
        titleLabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:15];
        [biaotouView addSubview:titleLabel];
        
        UILabel *titletext = [[UILabel alloc] initWithFrame:CGRectMake(titleImg.frame.origin.x+titleImg.frame.size.width+12, titleLabel.frame.origin.y+titleLabel.frame.size.height+5, ScreenWidth-(titleImg.frame.origin.x+titleImg.frame.size.width+42), 8)];
        titletext.textColor = RGBA(89, 87, 87, 1);
        titletext.text = [self.textArr objectAtIndex:section];
        titletext.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:8];
        [biaotouView addSubview:titletext];
        
        return biaotouView;
        
    }
    else
    {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 58)];
        headerView.backgroundColor = [UIColor whiteColor];
        UITapGestureRecognizer *singleTouch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard:)];
        [headerView addGestureRecognizer:singleTouch];
        
        UIImageView *titleImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 33, 33)];
        titleImg.image = [UIImage imageNamed:[self.imgArr objectAtIndex:section]];
        [headerView addSubview:titleImg];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleImg.frame.origin.x+titleImg.frame.size.width+12, 15, ScreenWidth-(titleImg.frame.origin.x+titleImg.frame.size.width+42), 15)];
        titleLabel.textColor = RGBA(238, 128, 135, 1);
        titleLabel.text = [self.tableArr objectAtIndex:section];
        titleLabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:15];
        [headerView addSubview:titleLabel];
        
        UILabel *titletext = [[UILabel alloc] initWithFrame:CGRectMake(titleImg.frame.origin.x+titleImg.frame.size.width+12, titleLabel.frame.origin.y+titleLabel.frame.size.height+5, ScreenWidth-(titleImg.frame.origin.x+titleImg.frame.size.width+42), 8)];
        titletext.textColor = RGBA(89, 87, 87, 1);
        titletext.text = [self.textArr objectAtIndex:section];
        titletext.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:8];
        [headerView addSubview:titletext];
        if (section == 1) {
            self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(ScreenWidth-117,21, 106, 25)];
            self.searchBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            //self.searchBar.layer.borderWidth = 1.5;
            //self.searchBar.layer.masksToBounds = YES;
            //self.searchBar.layer.cornerRadius = 10;
            self.searchBar.delegate = self;
            self.searchBar.placeholder = @"能不能吃...";
            self.searchBar.layer.borderColor = [UIColor clearColor].CGColor;
            self.searchBar.backgroundImage = [self imageWithColor:[UIColor clearColor] size:self.searchBar.bounds.size];
            [self.searchBar setImage:[UIImage imageNamed:@"放大镜2"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
            [self.searchBar setSearchFieldBackgroundImage:[UIImage imageNamed:@"搜索3@2x"] forState:UIControlStateNormal];
            [self setSearchBarTextfiled:self.searchBar];
            self.searchBar.showsScopeBar = YES;
            [headerView addSubview:self.searchBar];
        }
        
        return headerView;
    }
}

-(void)clickrenqiBtn
{
    for (UIView *subviews in [self.navigationController.view subviews]) {
        if (subviews.tag==66) {
            [subviews removeFromSuperview];
        }
    }
    MomTV_VC *momVC = [[MomTV_VC alloc] init];
    momVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:momVC animated:YES];
}

-(void)clickquanweiBtn
{
    for (UIView *subviews in [self.navigationController.view subviews]) {
        if (subviews.tag==66) {
            [subviews removeFromSuperview];
        }
    }
    Search_VC *searchVC = [[Search_VC alloc] init];
    searchVC.searchStr = @"1";
    searchVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:searchVC animated:YES];
    
}

-(void)clickjianbiBtn
{
    
}

-(void)clickbibeiBtn
{
    for (UIView *subviews in [self.navigationController.view subviews]) {
        if (subviews.tag==66) {
            [subviews removeFromSuperview];
        }
    }
    Beiyun_VC *beiyunVC = [[Beiyun_VC alloc] init];
    beiyunVC.title = @"备孕必备";
    beiyunVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:beiyunVC animated:YES];
    
}

-(void)clickzhishiBtn
{
    for (UIView *subviews in [self.navigationController.view subviews]) {
        if (subviews.tag==66) {
            [subviews removeFromSuperview];
        }
    }
    Beiyun_VC *beiyunVC = [[Beiyun_VC alloc] init];
    beiyunVC.title = @"备孕知识";
    beiyunVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:beiyunVC animated:YES];
}

-(void)clickzhenjiaBtn
{
    for (UIView *subviews in [self.navigationController.view subviews]) {
        if (subviews.tag==66) {
            [subviews removeFromSuperview];
        }
    }
    Beiyun_VC *beiyunVC = [[Beiyun_VC alloc] init];
    beiyunVC.title = @"真假辟谣";
    beiyunVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:beiyunVC animated:YES];
}

-(void)clickjiqiaoBtn
{
    for (UIView *subviews in [self.navigationController.view subviews]) {
        if (subviews.tag==66) {
            [subviews removeFromSuperview];
        }
    }
    Beiyun_VC *beiyunVC = [[Beiyun_VC alloc] init];
    beiyunVC.title = @"备孕技巧";
    beiyunVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:beiyunVC animated:YES];
}

-(void)clickgengduoBtn
{
    for (UIView *subviews in [self.navigationController.view subviews]) {
        if (subviews.tag==66) {
            [subviews removeFromSuperview];
        }
    }
    MoreZhishi_VC *moreVC = [[MoreZhishi_VC alloc] init];
    moreVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:moreVC animated:YES];
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, ScreenWidth, 20)];
    
    UIButton *sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sendBtn.frame = CGRectMake(10, 5, 12, 12);
    [sendBtn setImage:[UIImage imageNamed:@"意见反馈"] forState:UIControlStateNormal];
    [sendBtn addTarget:self action:@selector(sendBtn) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:sendBtn];
    
    UILabel *yijianLabel = [[UILabel alloc] initWithFrame:CGRectMake(sendBtn.frame.origin.x+sendBtn.frame.size.width+5, 8, 100, 9)];
    yijianLabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:9];
    yijianLabel.textColor = RGBA(89, 87, 87, 1);
    yijianLabel.text = @"意见反馈";
    [footerView addSubview:yijianLabel];
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    
    if (section == 2) {
        return footerView;
    }
    
    else
    {
        return view;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.searchBar resignFirstResponder];
    [self.searchText resignFirstResponder];
    ArticlDetailsViewController *articlVC = [[ArticlDetailsViewController alloc] init];
    articlVC.hidesBottomBarWhenPushed = YES;
    
    if(indexPath.section<2)
    {
        switch (indexPath.section) {
            case 0:
                if (indexPath.row != self.knowledgeArr.count) {
                    articlVC.dataDic = [self.knowledgeArr objectAtIndex:indexPath.row];
                    for (UIView *subviews in [self.navigationController.view subviews]) {
                        if (subviews.tag==66) {
                            [subviews removeFromSuperview];
                        }
                    }
                    [self.navigationController pushViewController:articlVC animated:YES];
                }
                
                break;
                
            case 1:
                articlVC.dataDic = [self.mustPrepareArr objectAtIndex:indexPath.row];
                for (UIView *subviews in [self.navigationController.view subviews]) {
                    if (subviews.tag==66) {
                        [subviews removeFromSuperview];
                    }
                }
                [self.navigationController pushViewController:articlVC animated:YES];
                break;
                
            default:
                break;
        }
        //UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:articlVC];
        
    }
    if (indexPath.section == 2) {
        
        NSDictionary *dict = [self.sameAgeArr objectAtIndex:indexPath.row];
        
        NSString *tieziID =[dict objectForKey:@"id"];
        NSString *neirong =[dict objectForKey:@"neirong"];
        NSString *title = [dict objectForKey:@"title"];
        NSString *quanziID=[dict objectForKey:@"quanziid"];
        NSString *userid=[dict objectForKey:@"userid"];
        NSString *dianzanzongshu=[[dict objectForKey:@"dianzanzongshu"]stringValue];
        NSString *time=[dict objectForKey:@"time"];
        
        PostsDetails_VC *Posts = [[PostsDetails_VC alloc] init];
        Posts.TidCount = tieziID;
        Posts.userId=userid;
        NSLog(@"用户id%@",userid);
        Posts.quanziID=quanziID;
        NSLog(@"帖子ID = %@",tieziID);
        Posts.title = title;
        Posts.neirong = neirong;
        Posts.zannumber=dianzanzongshu;
        Posts.quanName=@"北京妈妈圈";
        Posts.time=time;
        Posts.hidesBottomBarWhenPushed =YES;
        for (UIView *subviews in [self.navigationController.view subviews]) {
            if (subviews.tag==66) {
                [subviews removeFromSuperview];
            }
        }
        [self.navigationController pushViewController:Posts animated:YES];
    }
    
}

-(void)sendBtn
{
    
}

-(void)dismissKeyboard:(id)sender{
    [self.searchText resignFirstResponder];
    [self.searchBar resignFirstResponder];
}

-(void)clickmaotouBtn
{
    
}

-(void)clickjiangbeiBtn
{
    
}

-(void)clickdownloadBtn
{
    
}

-(void)clickyusanBtn
{
    
}

- (void)setSearchBarTextfiled:(UISearchBar *)searchBar{
    for (UIView *view in searchBar.subviews){
        for (id subview in view.subviews){
            if ( [subview isKindOfClass:[UITextField class]] ){
                [(UITextField *)subview setTintColor:RGBA(137, 137, 137, 1)];
                [(UITextField *)subview setFont:[UIFont fontWithName:@"Microsoft Yahei UI" size:10]];
                return;
            }
        }
    }
}

//取消searchbar背景色
- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    //    color = RGBA(235, 235, 235, 1);
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
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
