//
//  Circle-VC.m
//  滚动视图
//
//  Created by 董飞剑 on 15/5/28.
//  Copyright (c) 2015年 侯泽彭. All rights reserved.
//

#import "Circle-VC.h"
#import "Message_VC.h"
#import "MyCircle-VC.h"
//导航栏

#import "UIViewController+MMDrawerController.h"
#import "NavigationInteractiveTransition.h"

@interface Circle_VC ()<UIGestureRecognizerDelegate>{
    NSString *string;
//    AFHTTPRequestOperationManager *manager;
    NSMutableDictionary *dict;
    NSMutableArray *array;
    NSUserDefaults *_user;
    NSString *_userId;
    UIView *rightView;
    UIButton *rightSend;
    
    UILabel *numberLabel;
    NSMutableArray *_directmeg;
    NSMutableArray *quanzilist;
    
    SameAge_VC *sameAge;
    
    SameCity_VC *sameCity;
    
    Gestation_VC *gestation;
    
    Live_VC *live;
    
    Feeling_VC *felling;
    

}

@property (nonatomic, weak) UIPanGestureRecognizer *popRecognizer;
/**
 *  方案一不需要的变量
 */
@property (nonatomic, strong) NavigationInteractiveTransition *navT;

@property (nonatomic,strong) AFHTTPRequestOperationManager *manager;
@property (strong,nonatomic) NSMutableArray *myCircleArr;
@end

@implementation Circle_VC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       // _dataSource = [NSMutableArray array];
        array=[[NSMutableArray alloc]initWithCapacity:0];
        dict=[[NSMutableDictionary alloc]initWithCapacity:0];
        _directmeg =[[NSMutableArray alloc]initWithCapacity:0];
        quanzilist=[[NSMutableArray alloc]initWithCapacity:0];
    }
    return self;
}
//视图将要出现的时候
-(void)viewWillAppear:(BOOL)animated
{
    [self AFNotWork];
    
    MyCircle_VC *my = [[MyCircle_VC alloc]init];
    
    [my.myCircleTableView reloadData];
}


//查看私信
-(void)directMegData
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *userid = [ud objectForKey:@"userid"];
    self.manager = [AFHTTPRequestOperationManager manager];
    self.manager.responseSerializer = [[AFHTTPResponseSerializer alloc]init];
    
    [self.manager GET:@"http://101.200.234.127:8080/YanLu/pletter/list.do" parameters:[@{@"giveuserid":userid,@"zhuangtai":@"1"}mutableCopy] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        _directmeg = [NSJSONSerialization JSONObjectWithData:(NSData *)responseObject options:0 error:nil];
        NSLog(@"我的私信 = %@,%d",_directmeg,_directmeg.count);
       // [directMegTable reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"我的私信失败");
    }];
    
    
}


//网络获取有多少条未读

-(void)AFNotWork{
    _user = [NSUserDefaults standardUserDefaults];
    _userId = [_user objectForKey:@"userid"];
    self.manager = [AFHTTPRequestOperationManager manager];
    self.manager.responseSerializer = [[AFHTTPResponseSerializer alloc]init];
    
    [self.manager GET:@"http://101.200.234.127:8080/YanLu/huifu/list.do" parameters:[@{@"userid":_userId,@"zhuangtai":@"1"}mutableCopy] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        array = [NSJSONSerialization JSONObjectWithData:(NSData *)responseObject options:0 error:nil];
        NSLog(@"我的回帖 = %@,%d",array,array.count);
        NSLog(@"%d",array.count);
        if(array.count>0){
            
            numberLabel=[[UILabel alloc]init];
            numberLabel.frame=CGRectMake(32,-5, 16, 16);
            numberLabel.layer.masksToBounds = YES;
            numberLabel.layer.cornerRadius=numberLabel.bounds.size.width/2;
            numberLabel.backgroundColor=[UIColor redColor];
            numberLabel.textAlignment=NSTextAlignmentCenter;
            self.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",array.count+_directmeg.count];
            
              numberLabel.text=[NSString stringWithFormat:@"%d",array.count+_directmeg.count];
            
            numberLabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:11];
            numberLabel.textColor=[UIColor whiteColor];
            [rightView addSubview:rightSend];
            [rightSend addSubview:numberLabel];
        }else if(array.count>99){
                numberLabel.text=@"99+";
                self.tabBarItem.badgeValue = [NSString stringWithFormat:@"%@",@"99+"];
                
                numberLabel.frame=CGRectMake(26,-5, 22, 16);
           // numberLabel.text=@"99+";
            

              numberLabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:11];
            numberLabel.textColor=[UIColor whiteColor];
            [rightView addSubview:rightSend];
            [rightSend addSubview:numberLabel];
        }
        else{
            [rightView addSubview:rightSend];
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"失败");
    }];

    
    
}

////获取圈子列表
-(void)huoququanzilist
{

    self.manager = [AFHTTPRequestOperationManager manager];
    self.manager.responseSerializer = [[AFHTTPResponseSerializer alloc]init];
    
    [self.manager GET:@"http://101.200.234.127:8080/YanLu/fenlei/list.do" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        quanzilist = [NSJSONSerialization JSONObjectWithData:(NSData *)responseObject options:0 error:nil];
        
        
        
        //sameAge.title =[NSString stringWithFormat:@"%@",[[[quanzilist objectAtIndex:0] objectForKey:@"liename"]]];
        
        sameAge.title=[NSString stringWithFormat:@"%@",[[quanzilist objectAtIndex:0]objectForKey:@"liename"]];
     
        // sameCity.title = @"同城";
        sameCity.title=[NSString stringWithFormat:@"%@",[[quanzilist objectAtIndex:1]objectForKey:@"liename"]];
        
        
        
        //gestation.title = @"孕育";
        gestation.title=[NSString stringWithFormat:@"%@",[[quanzilist objectAtIndex:2]objectForKey:@"liename"]];
        
        
        
        //live.title = @"生活";
        live.title=[NSString stringWithFormat:@"%@",[[quanzilist objectAtIndex:3]objectForKey:@"liename"]];
        
        
        
        felling.title=[NSString stringWithFormat:@"%@",[[quanzilist objectAtIndex:4]objectForKey:@"liename"]];
        NSLog(@"我的圈子列表 = %@,%d",quanzilist,quanzilist.count);
        // [directMegTable reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"我的圈子列表失败");
    }];
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self AFNotWork];
    [self directMegData];
    [self huoququanzilist];
   

    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航栏"] forBarMetrics:UIBarMetricsDefault];
    
    self.view.backgroundColor = RGBA(235, 235, 235, 1);

    
    self.navigationItem.title = @"圈 子";
    //tarbar的消息提示
    
    
    
    //消息盒子
    rightView=[[UIView alloc]init];
//    rightView.backgroundColor=[UIColor clearColor];
    rightView.frame=CGRectMake(20, 100, 100, self.navigationController.navigationBar.bounds.size.height);
    rightSend = [UIButton buttonWithType:UIButtonTypeCustom];
    rightSend.frame = CGRectMake(rightView.bounds.origin.x+rightView.bounds.size.width-37,10, 30, 20);
    //rightSend.backgroundColor=[UIColor greenColor];
   [rightSend setBackgroundImage:[UIImage imageNamed:@"信封1"] forState:UIControlStateNormal];
   // rightSend.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"信封"]];
    //[rightSend setImage:[UIImage imageNamed:@"信封1"] forState:UIControlStateNormal];
    [rightSend addTarget:self action:@selector(rightSend:) forControlEvents:UIControlEventTouchUpInside];
    [rightView addSubview:rightSend];
    
    
    
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightView];
    self.navigationItem.rightBarButtonItem=rightItem;
    
    
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }

    
   


    
    MyCircle_VC *myciecle = [[MyCircle_VC alloc] init];
    
    myciecle.title = @"我的圈";
    sameAge = [[SameAge_VC alloc] init];
    [sameAge.sameAgeTableView reloadData];
    sameAge.title = @"孕育圈";
    
    
    sameCity = [[SameCity_VC alloc] init];
    [sameCity.sameCityTableView reloadData];
    sameCity.title = @"医院圈";
    
    gestation = [[Gestation_VC alloc] init];
    [gestation.gestationTableView reloadData];
    gestation.title = @"同龄圈";
    
    live = [[Live_VC alloc] init];
    [live.liveTableView reloadData];
    live.title = @"情感圈";
    
    felling = [[Feeling_VC alloc]init];
    [felling.feelingTableView reloadData];
    felling.title = @"同城圈";

    
//    More_VC *more = [[More_VC alloc] init];
//    [more.moreTableView reloadData];
//    more.title = @"更多";
//    
//    
//    All_VC *all = [[All_VC alloc] init];
//    [all.allTableView reloadData];
//    all.title = @"全部";
    
    
    SCNavTabBarController *navTabBarController = [[SCNavTabBarController alloc] init];
    navTabBarController.subViewControllers = @[myciecle, sameAge, sameCity, gestation, live, felling];
    [navTabBarController addParentController:self];
    
    // [self.slideSwitchView buildUI];
    
    
    UIGestureRecognizer *gesture = self.navigationController.interactivePopGestureRecognizer;
    gesture.enabled = NO;
    UIView *gestureView = gesture.view;
    
    UIPanGestureRecognizer *popRecognizer = [[UIPanGestureRecognizer alloc] init];
    popRecognizer.delegate = self;
    popRecognizer.maximumNumberOfTouches = 1;
    [gestureView addGestureRecognizer:popRecognizer];
    
    //    #if USE_方案一
    //        _navT = [[NavigationInteractiveTransition alloc] initWithViewController:self];
    //        [popRecognizer addTarget:_navT action:@selector(handleControllerPop:)];
    //
    //    #elif USE_方案二
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
    // Do any additional setup after loading the view.
    //#endif
    
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    /**
     *  这里有两个条件不允许手势执行，1、当前控制器为根控制器；2、如果这个push、pop动画正在执行（私有属性）
     */
    return self.navigationController.viewControllers.count != 1 && ![[self.navigationController valueForKey:@"_isTransitioning"] boolValue];
}

#pragma mark 右侧发帖
-(void)rightSend:(id)sender
{
    Message_VC *mesg =[[Message_VC alloc]init];
    mesg.hidesBottomBarWhenPushed = YES;
   // Message_VC.idCount = self.circleID;
    [self.navigationController pushViewController:mesg animated:YES];
}



@end
