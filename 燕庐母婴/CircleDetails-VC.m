//
//  CircleDetails-VC.m
//  燕庐母婴
//
//  Created by 董飞剑 on 15/5/29.
//  Copyright (c) 2015年 燕庐科技. All rights reserved.
//圈子详情

#import "CircleDetails-VC.h"
#import "PrefixHeader.pch"
#import "SDRefresh.h"


@interface CircleDetails_VC ()
@property (nonatomic, weak) SDRefreshFooterView *refreshFooter;
@property (nonatomic, weak) SDRefreshHeaderView *refreshHeader;
@end

@implementation CircleDetails_VC{
    UIButton * saveBtn;
    BOOL flag;
    
    NSString *tid;
    UIButton *btn;
    
    NSString *State;
}

-(void)viewWillAppear:(BOOL)animated
{
    [self AFNetworking];
    
}
//获取圈子详细信息
-(void)AFNetworking
{
    self.manager = [AFHTTPRequestOperationManager manager];
    self.manager.responseSerializer = [[AFHTTPResponseSerializer alloc]init];
    [self.manager GET:tieziURL parameters:[@{@"quanziid":self.circleID}mutableCopy] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSData *data =(NSData *)responseObject;
        self.circleArr = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"圈子详细信息 = %@",self.circleArr);
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"失败");
    }];
}





- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"全部帖子";
    
    self.view.backgroundColor = RGBA(239, 239, 239, 1);

    self.view.backgroundColor = RGBA(235, 235, 235, 1);
    //取消导航栏和状态栏的边缘延展效果
    self.modalPresentationCapturesStatusBarAppearance = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    
    //返回按钮
    self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backBtn.frame = CGRectMake(20, 14, 16, 20);
    [self.backBtn setBackgroundImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [self.backBtn addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:self.backBtn];
    self.navigationItem.leftBarButtonItem = leftItem;

    
    //发送帖子
    UIButton *rightSend = [UIButton buttonWithType:UIButtonTypeCustom];
    rightSend.frame = CGRectMake(20, 14, 20, 21);
    [rightSend setBackgroundImage:[UIImage imageNamed:@"发帖"] forState:UIControlStateNormal];
    [rightSend addTarget:self action:@selector(rightSend:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightSend];
    self.navigationItem.rightBarButtonItem = rightItem;

    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    self.circleArr1 = [NSArray array];
    
    //刷新
    [self setupHeader];
    [self setupFooter];
    

}


//判断是否点赞
-(void)goBack:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark 右侧发帖
-(void)rightSend:(id)sender
{
    Seng_VC *send =[[Seng_VC alloc]init];
    send.idCount = self.circleID;
    [self.navigationController pushViewController:send animated:YES];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else if(section == 1){
        
        return 3;
    }else{
        
        return self.circleArr.count;
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *cellID = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 138)];
        img.image = [UIImage imageNamed:@"titlebackgroundColor"];
        img.multipleTouchEnabled = YES;
        img.userInteractionEnabled = YES;
        [cell.contentView addSubview:img];
        
        UIImageView *touxiangImg = [[UIImageView alloc] initWithFrame:CGRectMake(19, 24, 65, 65)];
        touxiangImg.image = [UIImage imageNamed:@"circleImg"];
        touxiangImg.layer.masksToBounds = YES;
        touxiangImg.layer.cornerRadius = touxiangImg.bounds.size.width/2;
        [img addSubview:touxiangImg];
        
        UILabel *namelabel = [[UILabel alloc] initWithFrame:CGRectMake(touxiangImg.frame.origin.x+touxiangImg.frame.size.width+14, 35, 120, 20)];
        namelabel.text = self.circleName;
        namelabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:16];
        namelabel.textColor = RGBA(232, 126, 150, 1);
        [img addSubview:namelabel];
        
        UIImageView *speakNumImg = [[UIImageView alloc] initWithFrame:CGRectMake(touxiangImg.frame.origin.x+touxiangImg.frame.size.width+14, namelabel.frame.origin.y+namelabel.frame.size.height+21, 10, 14)];
        speakNumImg.image = [UIImage imageNamed:@"信息"];
        [img addSubview:speakNumImg];
        //信息的布局
       // UILabel *speakNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(speakNumImg.frame.origin.x+speakNumImg.frame.size.width+11, namelabel.frame.origin.y+namelabel.frame.size.height+21, 20, 14)];
       UILabel *speakNumLabel=[[UILabel alloc]init];
        speakNumLabel.textColor = RGBA(181, 181, 182, 1);
        speakNumLabel.text = self.speakNum;
        speakNumLabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:12];
        [img addSubview:speakNumLabel];

        speakNumLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [img addConstraint:[NSLayoutConstraint constraintWithItem:speakNumLabel
                                                         attribute:NSLayoutAttributeTop
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:namelabel
                                                         attribute:NSLayoutAttributeBottom
                                                        multiplier:1
                                                          constant:21]];
        [img addConstraint:[NSLayoutConstraint constraintWithItem:speakNumLabel
                                                         attribute:NSLayoutAttributeLeft
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:speakNumImg
                                                         attribute:NSLayoutAttributeRight
                                                        multiplier:1
                                                          constant:11]];
        [img addConstraint:[NSLayoutConstraint constraintWithItem:speakNumLabel
                                                         attribute:NSLayoutAttributeHeight
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:img
                                                         attribute:NSLayoutAttributeHeight
                                                        multiplier:0
                                                          constant:14]];
        

        
        
        //UIImageView *peopleNumImg = [[UIImageView alloc] initWithFrame:CGRectMake(speakNumLabel.frame.origin.x+speakNumLabel.frame.size.width+14, namelabel.frame.origin.y+namelabel.frame.size.height+21, 10, 14)];
        UIImageView *peopleNumImg=[[UIImageView alloc]init];
        peopleNumImg.image = [UIImage imageNamed:@"人数"];
        [img addSubview:peopleNumImg];
        peopleNumImg.translatesAutoresizingMaskIntoConstraints = NO;
        [img addConstraint:[NSLayoutConstraint constraintWithItem:peopleNumImg
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:namelabel
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1
                                                         constant:21]];
        [img addConstraint:[NSLayoutConstraint constraintWithItem:peopleNumImg
                                                        attribute:NSLayoutAttributeLeft
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:speakNumLabel
                                                        attribute:NSLayoutAttributeRight
                                                       multiplier:1
                                                         constant:21]];
        [img addConstraint:[NSLayoutConstraint constraintWithItem:peopleNumImg
                                                        attribute:NSLayoutAttributeHeight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:img
                                                        attribute:NSLayoutAttributeHeight
                                                       multiplier:0
                                                         constant:14]];
        [img addConstraint:[NSLayoutConstraint constraintWithItem:peopleNumImg
                                                        attribute:NSLayoutAttributeWidth
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:img
                                                        attribute:NSLayoutAttributeWidth
                                                       multiplier:0
                                                         constant:10]];
        
        
        UILabel *peopleNumLabel = [[UILabel alloc]init];
        peopleNumLabel.textColor = RGBA(181, 181, 182, 1);
        peopleNumLabel.text = self.peopleNum;
        peopleNumLabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:12];
        [img addSubview:peopleNumLabel];
        
        
        peopleNumLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [img addConstraint:[NSLayoutConstraint constraintWithItem:peopleNumLabel
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:namelabel
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1
                                                         constant:21]];
        [img addConstraint:[NSLayoutConstraint constraintWithItem:peopleNumLabel
                                                        attribute:NSLayoutAttributeLeft
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:peopleNumImg
                                                        attribute:NSLayoutAttributeRight
                                                       multiplier:1
                                                         constant:11]];
        [img addConstraint:[NSLayoutConstraint constraintWithItem:peopleNumLabel
                                                        attribute:NSLayoutAttributeHeight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:img
                                                        attribute:NSLayoutAttributeHeight
                                                       multiplier:0
                                                         constant:14]];
        NSInteger count = [self.circleID integerValue];
        NSLog(@"++++++%ld+++++%@",(long)count,self.circleID);

        NSLog(@"0000000%lu",(unsigned long)self.mycircleArr.count);
        saveBtn = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth-63, 45, 45, 18)];
        [saveBtn addTarget:self action:@selector(clickSaveBtn:) forControlEvents:UIControlEventTouchUpInside];
        saveBtn.titleLabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:11];
        [img addSubview:saveBtn];
        
        
        NSLog(@"guanzhuStatus--%@",self.guanzhuBtnTitle);
            if ([self.guanzhuBtnTitle isEqualToString:@"关注"]) {
                [saveBtn setBackgroundColor:[UIColor colorWithRed:237.0f/255.0f green:81.0f/255.0f blue:129.0f/255.0f alpha:1]];
                saveBtn.frame = CGRectMake(ScreenWidth-63, 45, 45, 18);
                [saveBtn setTitle:@"关注" forState:UIControlStateNormal];
                [saveBtn setTitleColor:RGBA(200, 200, 200,1) forState:UIControlStateNormal];
                [saveBtn setImage:[UIImage imageNamed:@"加号"] forState:UIControlStateNormal];
                //按钮设置图片(上左下右)
                [saveBtn setImageEdgeInsets:UIEdgeInsetsMake(0.0, -5, 0.0, 0.0)];
                saveBtn.layer.masksToBounds = YES;
                saveBtn.layer.cornerRadius = 3;

            }
            else
            {
                [saveBtn setBackgroundColor:[UIColor whiteColor]];
                saveBtn.frame = CGRectMake(ScreenWidth-63, 45, 45, 18);
                [saveBtn setTitle:@"取消关注" forState:UIControlStateNormal];
                [saveBtn setTitleColor:RGBA(200, 200, 200,1) forState:UIControlStateNormal];

                [saveBtn setImage:nil forState:UIControlStateNormal];
                saveBtn.layer.masksToBounds = YES;
                saveBtn.layer.cornerRadius = 3;
            }
        
        
        UIImageView *lineImg1 = [[UIImageView alloc] initWithFrame:CGRectMake(10, touxiangImg.frame.origin.y+touxiangImg.frame.size.height+15, ScreenWidth-20, 1)];
        lineImg1.backgroundColor = RGBA(181, 181, 182, 1);
        [img addSubview:lineImg1];
        
        
#pragma mark 圈子三个按钮的布局
        UIButton *quanmemberBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        quanmemberBtn.frame = CGRectMake(0, lineImg1.frame.origin.y+lineImg1.frame.size.height+8,(self.view.bounds.size.width-2)/3, 15);
        [quanmemberBtn setTitle:@"圈 成 员" forState:UIControlStateNormal];
        quanmemberBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        quanmemberBtn.titleLabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:12];
        [quanmemberBtn setTitleColor:RGBA(181, 181, 182, 1) forState:UIControlStateNormal];
        [quanmemberBtn addTarget:self action:@selector(clickquanmemberBtn:) forControlEvents:UIControlEventTouchUpInside];
        [img addSubview:quanmemberBtn];
        
        UIImageView *lineImg2 = [[UIImageView alloc] initWithFrame:CGRectMake(quanmemberBtn.frame.origin.x+quanmemberBtn.frame.size.width, lineImg1.frame.origin.y+lineImg1.frame.size.height+5, 1, 21)];
        lineImg2.backgroundColor = RGBA(181, 181, 182, 1);
        [img addSubview:lineImg2];
        
        UIButton *attendantBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        attendantBtn.frame = CGRectMake(lineImg2.frame.origin.x+lineImg2.frame.size.width, lineImg1.frame.origin.y+lineImg1.frame.size.height+8, ([[UIScreen mainScreen] bounds].size.width-2)/3, 15);
        NSLog(@"%ld",(long)([[UIScreen mainScreen] bounds].size.width-2)/3/2);
        NSLog(@"%ld",(long)(self.view.bounds.size.width-2)/3);
        NSLog(@"%ld",(long)self.view.bounds.size.width);

        [attendantBtn setTitle:@"管 理 员" forState:UIControlStateNormal];
        attendantBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        attendantBtn.titleLabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:12];
        [attendantBtn setTitleColor:RGBA(181, 181, 182, 1) forState:UIControlStateNormal];
        [attendantBtn addTarget:self action:@selector(clickattendantBtn:) forControlEvents:UIControlEventTouchUpInside];
        [img addSubview:attendantBtn];
        
        UIImageView *lineImg3 = [[UIImageView alloc] initWithFrame:CGRectMake(attendantBtn.frame.origin.x+attendantBtn.frame.size.width, lineImg1.frame.origin.y+lineImg1.frame.size.height+5, 1, 21)];
        lineImg3.backgroundColor = RGBA(181, 181, 182, 1);
        [img addSubview:lineImg3];
        
        UIButton *essenceBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        essenceBtn.frame = CGRectMake(lineImg3.frame.origin.x+lineImg3.frame.size.width, lineImg1.frame.origin.y+lineImg1.frame.size.height+8, (self.view.bounds.size.width-2)/3, 15);
        [essenceBtn setTitle:@"圈 精 华" forState:UIControlStateNormal];
        essenceBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        essenceBtn.titleLabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:12];
        [essenceBtn setTitleColor:RGBA(181, 181, 182, 1) forState:UIControlStateNormal];
        [essenceBtn addTarget:self action:@selector(clickessenceBtn:) forControlEvents:UIControlEventTouchUpInside];
        [img addSubview:essenceBtn];
        
        return cell;
    }else if (indexPath.section == 1){
        
        static NSString *cellID = @"cell";
        CircleDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil) {
            cell = [[CircleDetailsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        UIImageView *xinView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 11, 16, 16)];
        xinView.image = [UIImage imageNamed:@"新"];
        [cell addSubview:xinView];

        
        UIImageView *jingView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(xinView.frame)+4, 11, 16, 16)];
        jingView.image = [UIImage imageNamed:@"精"];
        [cell addSubview:jingView];
        
        UIImageView *zhidingView = [[UIImageView alloc] initWithFrame:CGRectMake(jingView.frame.origin.x+jingView.frame.size.width+4, 11, 28, 16)];
        zhidingView.image = [UIImage imageNamed:@"置顶"];
        [cell addSubview:zhidingView];
        return cell;
        
    }else{
        
        static NSString *DetailsCell = @"DetailsCell";
        CircleDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:DetailsCell];
        cell = [self.tableView cellForRowAtIndexPath:indexPath];
        if (cell == nil) {
            cell = [[CircleDetailsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:DetailsCell];
        }else
        {
            //删除cell的所有子视图
            while ([cell.contentView.subviews lastObject] != nil)
            {
                [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
            }
        }
        

        
        
        
        
        //重新布局
        NSString *zhuangtai=  [[[self.circleArr objectAtIndex:indexPath.row]objectForKey:@"zhuangtai"]stringValue];
        if([zhuangtai isEqualToString:@"0"]){
            //默认的没有图片
            cell.titleLab = [[UILabel alloc]initWithFrame:CGRectMake(10,8, ScreenWidth-10, 20)];
        }else if([zhuangtai isEqualToString:@"1"]){
            cell.Img = [[UIImageView alloc] initWithFrame:CGRectMake(10, 11, 16, 16)];
            cell.Img.image = [UIImage imageNamed:@"新1"];
            [cell.contentView addSubview:cell.Img];
            cell.titleLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(cell.Img.frame)+5,8, ScreenWidth-10, 20)];
        }else if ([zhuangtai isEqualToString:@"2"]){
            cell.Img = [[UIImageView alloc] initWithFrame:CGRectMake(10, 11, 16, 16)];
            cell.Img.image = [UIImage imageNamed:@"精"];
            [cell.contentView addSubview:cell.Img];
            cell.titleLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(cell.Img.frame)+5,8, ScreenWidth-10, 20)];
            
        }else if ([zhuangtai isEqualToString:@"3"]){
            cell.Img = [[UIImageView alloc] initWithFrame:CGRectMake(10, 11, 28, 16)];
            cell.Img.image = [UIImage imageNamed:@"置顶"];
            [cell.contentView addSubview:cell.Img];
            cell.titleLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(cell.Img.frame)+5,8, ScreenWidth-10, 20)];
            
        }
        
        
        
        
        //帖子标题
        
        cell.titleLab.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:15];
        cell.titleLab.textColor=RGBA(93, 92, 92, 1);
        [cell.contentView addSubview:cell.titleLab];
        
        
        cell.personImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 40, 9, 11)];
        [cell.contentView addSubview:cell.personImage];
        
        //用户昵称
        cell.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(cell.personImage.frame.origin.x+cell.personImage.frame.size.width+3, 40, 80, 12)];
        cell.nameLabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:10];
        
        cell.nameLabel.textColor=RGBA(148, 148, 149, 1);
        
        [cell.contentView addSubview:cell.nameLabel];
        
        
        
        cell.timeLab = [[UILabel alloc]initWithFrame:CGRectMake(cell.nameLabel.frame.origin.x+cell.nameLabel.frame.size.width, 40, 50, 12)];
        cell.timeLab.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:10];
        cell.timeLab.textColor=RGBA(148, 148, 149, 1);
        [cell.contentView addSubview:cell.timeLab];
        
        
        
        
        
        
        
        
        
        
        //点赞总数
        
        
        
        cell.dianzanLabel=[[UILabel alloc]init];
        cell.dianzanLabel.textColor=RGBA(148, 148, 149, 1);
        cell.dianzanLabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:10];
        [cell.contentView addSubview:cell.dianzanLabel];
        cell.dianzanLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [cell.contentView addConstraint:[NSLayoutConstraint constraintWithItem:cell.dianzanLabel
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:cell.titleLab
                                                                     attribute:NSLayoutAttributeBottom
                                                                    multiplier:1
                                                                      constant:12]];
        [cell.contentView addConstraint:[NSLayoutConstraint constraintWithItem:cell.dianzanLabel
                                                                     attribute:NSLayoutAttributeRight
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:cell.contentView
                                                                     attribute:NSLayoutAttributeRight
                                                                    multiplier:1
                                                                      constant:-10]];
        [cell.contentView addConstraint:[NSLayoutConstraint constraintWithItem:cell.dianzanLabel
                                                                     attribute:NSLayoutAttributeHeight
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:cell.contentView
                                                                     attribute:NSLayoutAttributeHeight
                                                                    multiplier:0
                                                                      constant:12]];
        
        
        
        //点赞按钮
        
        cell.dianzanImg=[[UIButton alloc]init];
        [cell.contentView addSubview:cell.dianzanImg];
        cell.dianzanImg.translatesAutoresizingMaskIntoConstraints = NO;
        [cell addConstraint:[NSLayoutConstraint constraintWithItem:cell.dianzanImg
                                                         attribute:NSLayoutAttributeTop
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:cell
                             .titleLab
                                                         attribute:NSLayoutAttributeBottom
                                                        multiplier:1
                                                          constant:12]];
        [cell.contentView addConstraint:[NSLayoutConstraint constraintWithItem:cell.dianzanImg
                                                                     attribute:NSLayoutAttributeRight
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:cell.dianzanLabel
                                                                     attribute:NSLayoutAttributeLeft
                                                                    multiplier:1
                                                                      constant:-5]];
        [cell.contentView addConstraint:[NSLayoutConstraint constraintWithItem:cell.dianzanImg
                                                                     attribute:NSLayoutAttributeHeight
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:cell.contentView
                                                                     attribute:NSLayoutAttributeHeight
                                                                    multiplier:0
                                                                      constant:10]];
        
        [cell.contentView addConstraint:[NSLayoutConstraint constraintWithItem:cell.dianzanImg
                                                                     attribute:NSLayoutAttributeWidth
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:cell.contentView
                                                                     attribute:NSLayoutAttributeWidth
                                                                    multiplier:0
                                                                      constant:12]];
        
        //回复条数
        //条数的文本
        
        cell.messageLab=[[UILabel alloc]init];
        
        cell.messageLab.textColor=RGBA(148, 148, 149, 1);
        cell.messageLab.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:10];
        [cell.contentView addSubview:cell.messageLab];
        cell.messageLab.translatesAutoresizingMaskIntoConstraints = NO;
        [cell.contentView addConstraint:[NSLayoutConstraint constraintWithItem:cell.messageLab
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:cell.titleLab
                                                                     attribute:NSLayoutAttributeBottom
                                                                    multiplier:1
                                                                      constant:12]];
        [cell.contentView addConstraint:[NSLayoutConstraint constraintWithItem:cell.messageLab
                                                                     attribute:NSLayoutAttributeRight
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:cell.dianzanImg
                                                                     attribute:NSLayoutAttributeLeft
                                                                    multiplier:1
                                                                      constant:-5]];
        [cell.contentView addConstraint:[NSLayoutConstraint constraintWithItem:cell.messageLab
                                                                     attribute:NSLayoutAttributeHeight
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:cell.contentView
                                                                     attribute:NSLayoutAttributeHeight
                                                                    multiplier:0
                                                                      constant:12]];
        
        
        //回复的图片
        cell.messageImg=[[UIImageView alloc]init];
        [cell.contentView addSubview:cell.messageImg];
        cell.messageImg.translatesAutoresizingMaskIntoConstraints = NO;
        [cell.contentView addConstraint:[NSLayoutConstraint constraintWithItem:cell.messageImg
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:cell.titleLab
                                                                     attribute:NSLayoutAttributeBottom
                                                                    multiplier:1
                                                                      constant:12]];
        [cell.contentView addConstraint:[NSLayoutConstraint constraintWithItem:cell.messageImg
                                                                     attribute:NSLayoutAttributeRight
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:cell.messageLab
                                                                     attribute:NSLayoutAttributeLeft
                                                                    multiplier:1
                                                                      constant:-5]];
        [cell.contentView addConstraint:[NSLayoutConstraint constraintWithItem:cell.messageImg
                                                                     attribute:NSLayoutAttributeHeight
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:cell.contentView
                                                                     attribute:NSLayoutAttributeHeight
                                                                    multiplier:0
                                                                      constant:10]];
        
        [cell.contentView addConstraint:[NSLayoutConstraint constraintWithItem:cell.messageImg
                                                                     attribute:NSLayoutAttributeWidth
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:cell.contentView
                                                                     attribute:NSLayoutAttributeWidth
                                                                    multiplier:0
                                                                      constant:12]];
        
        //观看的人数和图片
        
        
        //观看
        cell.zhuanfacountLabel=[[UILabel alloc]init];
        
        cell.zhuanfacountLabel.textColor=RGBA(148, 148, 149, 1);
        cell.zhuanfacountLabel.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:10];
        [cell.contentView addSubview:cell.zhuanfacountLabel];
        cell.zhuanfacountLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [cell.contentView addConstraint:[NSLayoutConstraint constraintWithItem:cell.zhuanfacountLabel
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:cell.titleLab
                                                                     attribute:NSLayoutAttributeBottom
                                                                    multiplier:1
                                                                      constant:12]];
        [cell.contentView addConstraint:[NSLayoutConstraint constraintWithItem:cell.zhuanfacountLabel
                                                                     attribute:NSLayoutAttributeRight
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:cell.messageImg
                                                                     attribute:NSLayoutAttributeLeft
                                                                    multiplier:1
                                                                      constant:-5]];
        [cell.contentView addConstraint:[NSLayoutConstraint constraintWithItem:cell.zhuanfacountLabel
                                                                     attribute:NSLayoutAttributeHeight
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:cell.contentView
                                                                     attribute:NSLayoutAttributeHeight
                                                                    multiplier:0
                                                                      constant:12]];
        
        //回复的图片
        cell.zhuanfaImg=[[UIImageView alloc]init];
        [cell.contentView addSubview:cell.zhuanfaImg];
        cell.zhuanfaImg.translatesAutoresizingMaskIntoConstraints = NO;
        [cell.contentView addConstraint:[NSLayoutConstraint constraintWithItem:cell.zhuanfaImg
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:cell.titleLab
                                                                     attribute:NSLayoutAttributeBottom
                                                                    multiplier:1
                                                                      constant:12]];
        [cell.contentView addConstraint:[NSLayoutConstraint constraintWithItem:cell.zhuanfaImg
                                                                     attribute:NSLayoutAttributeRight
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:cell.zhuanfacountLabel
                                                                     attribute:NSLayoutAttributeLeft
                                                                    multiplier:1
                                                                      constant:-5]];
        [cell.contentView addConstraint:[NSLayoutConstraint constraintWithItem:cell.zhuanfaImg
                                                                     attribute:NSLayoutAttributeHeight
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:cell.contentView
                                                                     attribute:NSLayoutAttributeHeight
                                                                    multiplier:0
                                                                      constant:10]];
        
        [cell.contentView addConstraint:[NSLayoutConstraint constraintWithItem:cell.zhuanfaImg
                                                                     attribute:NSLayoutAttributeWidth
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:cell.contentView
                                                                     attribute:NSLayoutAttributeWidth
                                                                    multiplier:0
                                                                      constant:12]];
        
        cell.titleLab.text = [[self.circleArr objectAtIndex:indexPath.row] objectForKey:@"title"];
        
        
        cell.personImage.image = [UIImage imageNamed:@"人数"];
        
        //cell.nameLabel.text = @"我爱大海啊";
        cell.nameLabel.text=[[self.circleArr objectAtIndex:indexPath.row]objectForKey:@"nicheng"];

        NSLog(@"%d",[[[self.circleArr objectAtIndex:indexPath.row]objectForKey:@"time"] length]);
        //判断时间
        if([[[self.circleArr objectAtIndex:indexPath.row]objectForKey:@"time"] length]==0){
                        cell.timeLab.text=@"时间丢失";
        }else{
            if([[[self.circleArr objectAtIndex:indexPath.row]objectForKey:@"time"] length]==8){
                NSLog(@"ooooo");
                //时间格式20140430
                //解析时间
                NSLog(@"时间是%d",[[[self.circleArr objectAtIndex:indexPath.row]objectForKey:@"time"] length]);
                NSLog(@"===时间时间");
                
                NSDateFormatter *date=[[NSDateFormatter alloc] init];
                [date setDateFormat:@"yyyyMMddHHmmss"];
                NSDate *d=[date dateFromString:[[self.circleArr objectAtIndex:indexPath.row]objectForKey:@"time"]];
                
                NSTimeInterval late=[d timeIntervalSince1970]*1;
                
                
                NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
                NSTimeInterval now=[dat timeIntervalSince1970]*1;
                NSString *timeString=[[self.circleArr objectAtIndex:indexPath.row]objectForKey:@"time"];
                
                NSTimeInterval cha=now-late;
                //liuxiaofeng刚刚出不来
                if(cha/60<1&&cha/60>0) {
                    cell.timeLab.text=@"刚刚";
                    
                    
                }
                NSLog(@"cha is %f",cha);
                if (cha/3600<1) {
                    timeString = [NSString stringWithFormat:@"%f", cha/60];
                    timeString = [timeString substringToIndex:timeString.length-7];
                    timeString=[NSString stringWithFormat:@"%@分钟前", timeString];
                    cell.timeLab.text=[NSString stringWithFormat:@"%@",timeString];
                    
                    
                }
                if (cha/3600>1&&cha/86400<1) {
                    timeString = [NSString stringWithFormat:@"%f", cha/3600];
                    timeString = [timeString substringToIndex:timeString.length-7];
                    timeString=[NSString stringWithFormat:@"%@小时前", timeString];
                    cell.timeLab.text=[NSString stringWithFormat:@"%@",timeString];
                    
                }
                if (cha/86400>1)
                {
                    timeString = [NSString stringWithFormat:@"%f", cha/86400];
                    timeString = [timeString substringToIndex:timeString.length-7];
                    timeString=[NSString stringWithFormat:@"%@天前", timeString];
                    cell.timeLab.text=[NSString stringWithFormat:@"%@",timeString];
                    
                    
                }

                
                
            }else{
                //时间格式2015-12-04 18：39：23
                //得到当前系统时间
                //特定时间
                
                NSDateFormatter *date=[[NSDateFormatter alloc] init];
                [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                NSDate *d=[date dateFromString:[[self.circleArr objectAtIndex:indexPath.row]objectForKey:@"time"]];
                
                NSTimeInterval late=[d timeIntervalSince1970]*1;
                
                
                NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
                NSTimeInterval now=[dat timeIntervalSince1970]*1;
                NSString *timeString=[[self.circleArr objectAtIndex:indexPath.row]objectForKey:@"time"];
                
                NSTimeInterval cha=now-late;
//liuxiaofeng
                if(cha/60<1 &&cha/60>0) {
                    timeString = [NSString stringWithFormat:@"%f", cha];
                    timeString = [timeString substringToIndex:timeString.length-7];
                    timeString=@"刚刚";
                    cell.timeLab.text=[NSString stringWithFormat:@"%@",timeString];
                    
                    
                }
                
                
                if (cha/3600<1) {
                    timeString = [NSString stringWithFormat:@"%f", cha/60];
                    timeString = [timeString substringToIndex:timeString.length-7];
                    timeString=[NSString stringWithFormat:@"%@分钟前", timeString];
                    cell.timeLab.text=[NSString stringWithFormat:@"%@",timeString];
                    
                    
                }
                if (cha/3600>1&&cha/86400<1) {
                    timeString = [NSString stringWithFormat:@"%f", cha/3600];
                    timeString = [timeString substringToIndex:timeString.length-7];
                    timeString=[NSString stringWithFormat:@"%@小时前", timeString];
                    cell.timeLab.text=[NSString stringWithFormat:@"%@",timeString];
                    
                }
                if (cha/86400>1)
                {
                    timeString = [NSString stringWithFormat:@"%f", cha/86400];
                    timeString = [timeString substringToIndex:timeString.length-7];
                    timeString=[NSString stringWithFormat:@"%@天前", timeString];
                    cell.timeLab.text=[NSString stringWithFormat:@"%@",timeString];
                    
                    
                }
                
                if([cell.timeLab.text isEqualToString:@"0分钟前"]){
                cell.timeLab.text=@"刚刚";
                }
            }
            

        }
        
        cell.zhuanfaImg.image = [UIImage imageNamed:@"see"];
        cell.zhuanfacountLabel.text = [[[self.circleArr objectAtIndex:indexPath.row] objectForKey:@"chakanzongshu"] stringValue];
        
        cell.messageImg.image = [UIImage imageNamed:@"话题"];

        cell.messageLab.text=[[[self.circleArr objectAtIndex:indexPath.row]objectForKey:@"pinglunzongshu"]stringValue];
        //判断是否点赞
        [cell.dianzanImg setBackgroundImage:[UIImage imageNamed:@"点赞"] forState:UIControlStateNormal];
        cell.dianzanLabel.text=[NSString stringWithFormat:@"%@",[[[self.circleArr objectAtIndex:indexPath.row]objectForKey:@"dianzanzongshu" ]stringValue]];

        
        return cell;
    }
}

//关注
-(void)clickSaveBtn:(UIButton*)btn
{
    
    NSLog(@"%@",self.circleID);
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *userId = [user objectForKey:@"userid"];
    NSLog(@"%@",userId);
    [self.manager GET:panDuanURL parameters:[@{@"userid":userId,@"quanziid":self.circleID}mutableCopy] success:^(AFHTTPRequestOperation *operation, id responseObject){
        
        NSData *data = responseObject;
        NSString *str1 = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"str111111111:%@",str1);
        if ([str1 isEqualToString:@"false"]) {
            
            [self.manager GET:addGuanZhuURL parameters:[@{@"userid":userId,@"quanziid":self.circleID}mutableCopy] success:^(AFHTTPRequestOperation *operation, id responseObject){
                //[self addbtn];
                //[self AFNetworking];
//                [saveBtn setBackgroundColor:[UIColor colorWithRed:237.0f/255.0f green:81.0f/255.0f blue:129.0f/255.0f alpha:1]];
                [saveBtn setBackgroundColor:[UIColor whiteColor]];
                saveBtn.frame = CGRectMake(ScreenWidth-63, 45, 45, 18);
                [saveBtn setTitle:@"取消关注" forState:UIControlStateNormal];
                [saveBtn setTitleColor:RGBA(200, 200, 200,1) forState:UIControlStateNormal];
                [saveBtn setImage:nil forState:UIControlStateNormal];
                saveBtn.layer.masksToBounds = YES;
                saveBtn.layer.cornerRadius = 3;

                // [self.tableView reloadData];
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
                NSLog(@"失败");
            }];
            
        }else{
            
            [self.manager GET:deleteGuanZhuURL parameters:[@{@"userid":userId,@"quanziid":self.circleID}mutableCopy] success:^(AFHTTPRequestOperation *operation, id responseObject){
                //[self addbtn];
                //[self postToServer];
                saveBtn.frame = CGRectMake(ScreenWidth-63, 45, 45, 18);
               // saveBtn.frame = CGRectMake(ScreenWidth-58, 30, 40, 18);
                [saveBtn setBackgroundColor:[UIColor colorWithRed:237.0f/255.0f green:81.0f/255.0f blue:129.0f/255.0f alpha:1]];
                [saveBtn setTitle:@"关注" forState:UIControlStateNormal];
                [saveBtn setImage:[UIImage imageNamed:@"加号"] forState:UIControlStateNormal];
                //按钮设置图片(上左下右)
                [saveBtn setImageEdgeInsets:UIEdgeInsetsMake(0.0, -5, 0.0, 0.0)];
                saveBtn.layer.masksToBounds = YES;
                saveBtn.layer.cornerRadius = 3;
                
                // [self.tableView reloadData];
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
                NSLog(@"失败");
            }];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"失败");
    }];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        return 138;
    }else if(indexPath.section == 1){
        
        return 40;
    }else{
        
        return 60;
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section != 0) {
        NSDictionary *dict =[self.circleArr objectAtIndex:indexPath.row];
        
        NSString *tieziID =[dict objectForKey:@"id"];
        NSString *neirong =[dict objectForKey:@"neirong"];
        NSString *title = [dict objectForKey:@"title"];
        NSString *quanziID=[dict objectForKey:@"quanziid"];
        NSString *dianzan=[[dict objectForKey:@"dianzan"]stringValue];
        NSString *zhuangtia=[[dict objectForKey:@"zhuangtai"]stringValue];
        
        NSString *pinglunNUmber=[dict objectForKey:@"pinglunzongshu"];
        NSString *userid=[dict objectForKey:@"userid"];
        NSString *dianzanzongshu=[[dict objectForKey:@"dianzanzongshu"]stringValue];
        NSString *time=[dict objectForKey:@"time"];
        
         NSString *chakanzongshu=[[dict objectForKey:@"chakanzongshu"]stringValue];

        PostsDetails_VC *Posts = [[PostsDetails_VC alloc] init];
        Posts.TidCount = tieziID;
        Posts.userId=userid;
        NSLog(@"用户id%@",userid);
        Posts.quanziID=quanziID;
        NSLog(@"帖子ID = %@",tieziID);
        Posts.title = title;
        Posts.neirong = neirong;
        Posts.zannumber=dianzanzongshu;
        Posts.quanName=self.circleName;
        Posts.time=time;
        Posts.dianzan=dianzan;
        Posts.pinglunnuber=pinglunNUmber;
        Posts.chakanzongshu=chakanzongshu;
        Posts.zhuangtai=zhuangtia;
        Posts.hidesBottomBarWhenPushed =YES;
        [self.navigationController pushViewController:Posts animated:YES];
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 4;
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 4;
}
//刷新表格

- (void)setupHeader
{
    SDRefreshHeaderView *refreshHeader = [SDRefreshHeaderView refreshView];
    
    // 默认是在navigationController环境下，如果不是在此环境下，请设置 refreshHeader.isEffectedByNavigationController = NO;
    [refreshHeader addToScrollView:self.tableView];
    
    __weak SDRefreshHeaderView *weakRefreshHeader = refreshHeader;
    refreshHeader.beginRefreshingOperation = ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self AFNetworking];
            [self.tableView reloadData];
            [weakRefreshHeader endRefreshing];
        });
    };
    
    // 进入页面自动加载一次数据
    [refreshHeader beginRefreshing];
}

- (void)setupFooter
{
    [self AFNetworking];
    SDRefreshFooterView *refreshFooter = [SDRefreshFooterView refreshView];
    [refreshFooter addToScrollView:self.tableView];
    [refreshFooter addTarget:self refreshAction:@selector(footerRefresh)];
    _refreshFooter = refreshFooter;
}


- (void)footerRefresh
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self AFNetworking];
        [self.tableView reloadData];
        [self.refreshFooter endRefreshing];
    });
}


//圈成员
-(void)clickquanmemberBtn:(UIButton*)sender
{
    NSLog(@"圈成员");
    
}
//管理员
-(void)clickattendantBtn:(UIButton*)sender
{
    NSLog(@"管理员");
    
}
//圈精华
-(void)clickessenceBtn:(UIButton*)sender
{
    NSLog(@"圈精华");
}

@end
