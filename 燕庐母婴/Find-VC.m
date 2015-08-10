//
//  Find-VC.m
//  滚动视图
//
//  Created by 董飞剑 on 15/5/28.
//  Copyright (c) 2015年 侯泽彭. All rights reserved.
//

#import "Find-VC.h"
#import "bobyEat_VC.h"
#import "yichang_VC.h"
#import "zaoqi_VC.h"
#import "bobyTIJian_VC.h"
#import "bobyYimiao_VC.h"
#import "canHou_VC.h"
#import "NavigationInteractiveTransition.h"
@interface Find_VC ()<UIGestureRecognizerDelegate>
@property (nonatomic, weak) UIPanGestureRecognizer *popRecognizer;
/**
 *  方案一不需要的变量
 */
@property (nonatomic, strong) NavigationInteractiveTransition *navT;
@end

@implementation Find_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"发 现";
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航栏"] forBarMetrics:UIBarMetricsDefault];
    
    
    self.findTextArr = @[@"宝宝辅食",@"产后恢复",@"异常情况",@"早期教育",@"宝宝疫苗",@"宝宝体检",@"美妈萌宝上电视"];
    

    self.findImageArr = @[@"宝宝辅食",@"产后恢复",@"异常情况",@"早期教育",@"宝宝疫苗",@"宝宝体检",@"mom上TV"];

    
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    //网格大小
    flowLayout.itemSize = CGSizeMake(90, 80);
    //滑动方向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //四周空白的距离---上、左、下、右
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 15, 0, 10);
    //行距
    flowLayout.minimumLineSpacing = 20;
    //    flowLayout.minimumInteritemSpac ing = 23;
    
    
    self.myCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) collectionViewLayout:flowLayout];
    self.myCollectionView.delegate = self;
    self.myCollectionView.dataSource = self;
    self.myCollectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.myCollectionView];
    
    [_myCollectionView registerClass:[FIndCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
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



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.findImageArr.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"cell";
    FIndCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:str forIndexPath:indexPath];
    
    cell.imgView.image = [UIImage imageNamed:[self.findImageArr objectAtIndex:indexPath.row]];
    cell.label.text = [self.findTextArr objectAtIndex:indexPath.row];
    
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        bobyEat_VC *boby=[[bobyEat_VC alloc]init];
        boby.hidesBottomBarWhenPushed =YES;
        [self.navigationController pushViewController:boby animated:YES];
        NSLog(@"0");
    } else if (indexPath.row == 1){
        canHou_VC *canhou=[[canHou_VC alloc]init];
        canhou.hidesBottomBarWhenPushed =YES;
        [self.navigationController pushViewController:canhou animated:YES];
        NSLog(@"1");
    }else if (indexPath.row == 2){
        yichang_VC *yichang=[[yichang_VC alloc]init];
        yichang.hidesBottomBarWhenPushed =YES;
        [self.navigationController pushViewController:yichang animated:YES];
        
        NSLog(@"2");
    }else if (indexPath.row == 3){
        zaoqi_VC *zaoqi=[[zaoqi_VC alloc]init];
        zaoqi.hidesBottomBarWhenPushed =YES;
        [self.navigationController pushViewController:zaoqi animated:YES];
        NSLog(@"3");
    }else if (indexPath.row == 4) {
        bobyYimiao_VC *yimiao=[[bobyYimiao_VC alloc]init];
        yimiao.hidesBottomBarWhenPushed =YES;
        [self.navigationController pushViewController:yimiao animated:YES];
//        BabyVaccine_VC *babyVaccine = [[BabyVaccine_VC alloc] init];
//        babyVaccine.hidesBottomBarWhenPushed =YES;
//        [self.navigationController pushViewController:babyVaccine animated:YES];
    }else if (indexPath.row == 5) {
        bobyTIJian_VC *tijian=[[bobyTIJian_VC alloc]init];
        tijian.hidesBottomBarWhenPushed =YES;
        [self.navigationController pushViewController:tijian animated:YES];
        
//        BabyHealthy_VC *babyHealthy = [[BabyHealthy_VC alloc] init];
//        babyHealthy.hidesBottomBarWhenPushed =YES;
//        [self.navigationController pushViewController:babyHealthy animated:YES];
    }else{
        
        MomTV_VC *mom = [[MomTV_VC alloc] init];
        mom.hidesBottomBarWhenPushed =YES;
        [self.navigationController pushViewController:mom animated:YES];
    }

}


@end
