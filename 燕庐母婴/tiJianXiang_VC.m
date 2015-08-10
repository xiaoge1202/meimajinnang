//
//  tiJianXiang_VC.m
//  美妈锦囊
//
//  Created by apple on 15/7/30.
//  Copyright (c) 2015年 燕庐科技. All rights reserved.
//

#import "tiJianXiang_VC.h"
#import "PrefixHeader.pch"
#import "tiJianXiang_Cell.h"
#import "TYAttributedLabel.h"
@interface tiJianXiang_VC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, weak) TYAttributedLabel *label1;
@end

@implementation tiJianXiang_VC{
    UITableView *tableview;
    UILabel *lbTitle;//标题
    UILabel *chushengTime;//出生日期
    UIButton *btnstate;//状态按钮
    UIImageView *imgTime;//时间图片
    UILabel *lbTiJian;//体检日期
    UILabel *lbTiJian1;
    TYAttributedLabel *label1;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    self.navigationItem.title = @"体   检   详   情";
    
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


-(void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
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
        
        return 2;
    }else{
        
        return 1;
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSString *CellIdentifier1 = [NSString stringWithFormat:@"indexPath"];
    
    tiJianXiang_Cell *cell1 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
    cell1 = [tableView cellForRowAtIndexPath:indexPath];
    
    if(cell1 == nil)
    {
        cell1 = [[tiJianXiang_Cell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier1];
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
    if(indexPath.section==0){
        //布局
        //标题
        lbTitle=[[UILabel alloc]init];
        lbTitle.textColor = [UIColor blackColor];
        lbTitle.text=@"宝宝第一次体检";
        lbTitle.textColor=RGBA(63, 62, 61, 1);
        lbTitle.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:17];
        lbTitle.textAlignment=NSTextAlignmentLeft;
        [cell1.contentView addSubview:lbTitle];
        
        lbTitle.translatesAutoresizingMaskIntoConstraints = NO;
        [cell1.contentView addConstraint:[NSLayoutConstraint constraintWithItem:lbTitle
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:cell1.contentView
                                                                     attribute:NSLayoutAttributeTop
                                                                    multiplier:1
                                                                      constant:15]];
        [cell1.contentView addConstraint:[NSLayoutConstraint constraintWithItem:lbTitle
                                                                     attribute:NSLayoutAttributeLeft
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:cell1.contentView
                                                                     attribute:NSLayoutAttributeLeft
                                                                    multiplier:1
                                                                      constant:20]];
        [cell1.contentView addConstraint:[NSLayoutConstraint constraintWithItem:lbTitle
                                                                     attribute:NSLayoutAttributeHeight
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:cell1.contentView
                                                                     attribute:NSLayoutAttributeHeight
                                                                    multiplier:0
                                                                      constant:20]];
        //下面的字
        
        chushengTime=[[UILabel alloc]init];
        chushengTime.textColor = [UIColor blackColor];
        chushengTime.text=@"宝宝出生";
        chushengTime.textColor=RGBA(152, 152, 151, 1);
        chushengTime.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:15];
        chushengTime.textAlignment=NSTextAlignmentLeft;
        [cell1.contentView addSubview:chushengTime];
        
        chushengTime.translatesAutoresizingMaskIntoConstraints = NO;
        [cell1.contentView addConstraint:[NSLayoutConstraint constraintWithItem:chushengTime
                                                                      attribute:NSLayoutAttributeTop
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:lbTitle
                                                                      attribute:NSLayoutAttributeBottom
                                                                     multiplier:1
                                                                       constant:13]];
        [cell1.contentView addConstraint:[NSLayoutConstraint constraintWithItem:chushengTime
                                                                      attribute:NSLayoutAttributeLeft
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:cell1.contentView
                                                                      attribute:NSLayoutAttributeLeft
                                                                     multiplier:1
                                                                       constant:20]];
        [cell1.contentView addConstraint:[NSLayoutConstraint constraintWithItem:chushengTime
                                                                      attribute:NSLayoutAttributeHeight
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:cell1.contentView
                                                                      attribute:NSLayoutAttributeHeight
                                                                     multiplier:0
                                                                       constant:20]];
        //按钮
        btnstate=[[UIButton alloc]init];
        
        btnstate.layer.borderColor=RGBA(54, 52, 52, 1).CGColor;
        btnstate.layer.borderWidth=2;
        btnstate.layer.masksToBounds = YES;
        btnstate.backgroundColor=[UIColor whiteColor];
        // 设置圆角角度
        btnstate.layer.cornerRadius = 15;
        //[self.btnSegmentrect setBackgroundColor:[UIColor redColor]];
        //[self.btnSegmentrect setBackgroundImage:[UIImage imageNamed:@"蓝色圈"] forState:UIControlStateNormal];
        [cell1.contentView addSubview:btnstate];
        btnstate.translatesAutoresizingMaskIntoConstraints = NO;
        [cell1.contentView addConstraint:[NSLayoutConstraint constraintWithItem:btnstate
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:cell1.contentView
                                                                     attribute:NSLayoutAttributeTop
                                                                    multiplier:1
                                                                      constant:25]];
        [cell1.contentView addConstraint:[NSLayoutConstraint constraintWithItem:btnstate
                                                                     attribute:NSLayoutAttributeRight
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:cell1.contentView
                                                                     attribute:NSLayoutAttributeRight
                                                                    multiplier:1
                                                                      constant:-15]];
        [cell1.contentView addConstraint:[NSLayoutConstraint constraintWithItem:btnstate
                                                                     attribute:NSLayoutAttributeWidth
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:cell1.contentView
                                                                     attribute:NSLayoutAttributeWidth
                                                                    multiplier:0
                                                                      constant:30]];
        [cell1.contentView addConstraint:[NSLayoutConstraint constraintWithItem:btnstate
                                                                     attribute:NSLayoutAttributeHeight
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:cell1.contentView
                                                                     attribute:NSLayoutAttributeHeight
                                                                    multiplier:0
                                                                      constant:30]];
    
    }else if (indexPath.section==1){
    //体检日期的钱的时间图
        cell1.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
        imgTime=[[UIImageView alloc]init];

        [cell1.contentView addSubview:imgTime];
        imgTime.translatesAutoresizingMaskIntoConstraints = NO;
        [cell1.contentView addConstraint:[NSLayoutConstraint constraintWithItem:imgTime
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:cell1.contentView
                                                                     attribute:NSLayoutAttributeTop
                                                                    multiplier:1
                                                                      constant:12]];
        [cell1.contentView addConstraint:[NSLayoutConstraint constraintWithItem:imgTime
                                                                     attribute:NSLayoutAttributeLeft
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:cell1.contentView
                                                                     attribute:NSLayoutAttributeLeft
                                                                    multiplier:1
                                                                      constant:15]];
        [cell1.contentView addConstraint:[NSLayoutConstraint constraintWithItem:imgTime
                                                                     attribute:NSLayoutAttributeWidth
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:cell1.contentView
                                                                     attribute:NSLayoutAttributeWidth
                                                                    multiplier:0
                                                                      constant:20]];
        [cell1.contentView addConstraint:[NSLayoutConstraint constraintWithItem:imgTime
                                                                     attribute:NSLayoutAttributeHeight
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:cell1.contentView
                                                                     attribute:NSLayoutAttributeHeight
                                                                    multiplier:0
                                                                      constant:15]];
        //体检日期
        
        lbTiJian=[[UILabel alloc]init];
        lbTiJian.textColor = [UIColor blackColor];
        lbTiJian.textColor=RGBA(126, 124, 123, 1);
        lbTiJian.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:15];
        lbTiJian.textAlignment=NSTextAlignmentLeft;
        [cell1.contentView addSubview:lbTiJian];
        
        lbTiJian.translatesAutoresizingMaskIntoConstraints = NO;
        [cell1.contentView addConstraint:[NSLayoutConstraint constraintWithItem:lbTiJian
                                                                      attribute:NSLayoutAttributeTop
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:cell1.contentView
                                                                      attribute:NSLayoutAttributeTop
                                                                     multiplier:1
                                                                       constant:12]];
        [cell1.contentView addConstraint:[NSLayoutConstraint constraintWithItem:lbTiJian
                                                                      attribute:NSLayoutAttributeLeft
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:imgTime
                                                                      attribute:NSLayoutAttributeRight
                                                                     multiplier:1
                                                                       constant:15]];
        [cell1.contentView addConstraint:[NSLayoutConstraint constraintWithItem:lbTiJian
                                                                      attribute:NSLayoutAttributeHeight
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:cell1.contentView
                                                                      attribute:NSLayoutAttributeHeight
                                                                     multiplier:0
                                                                       constant:15]];
        
        
        //日期
        
        
        lbTiJian1=[[UILabel alloc]init];
        lbTiJian1.textColor = [UIColor blackColor];
        lbTiJian1.textColor=RGBA(126, 124, 123, 1);
        lbTiJian1.text=@"星期四2015-5-23";
        lbTiJian1.font = [UIFont fontWithName:@"Microsoft Yahei UI" size:15];
        lbTiJian1.textAlignment=NSTextAlignmentLeft;
        [cell1.contentView addSubview:lbTiJian1];
        
        lbTiJian1.translatesAutoresizingMaskIntoConstraints = NO;
        [cell1.contentView addConstraint:[NSLayoutConstraint constraintWithItem:lbTiJian1
                                                                      attribute:NSLayoutAttributeTop
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:cell1.contentView
                                                                      attribute:NSLayoutAttributeTop
                                                                     multiplier:1
                                                                       constant:12]];
        [cell1.contentView addConstraint:[NSLayoutConstraint constraintWithItem:lbTiJian1
                                                                      attribute:NSLayoutAttributeRight
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:cell1.contentView
                                                                      attribute:NSLayoutAttributeRight
                                                                     multiplier:1
                                                                       constant:0]];
        [cell1.contentView addConstraint:[NSLayoutConstraint constraintWithItem:lbTiJian1
                                                                      attribute:NSLayoutAttributeHeight
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:cell1.contentView
                                                                      attribute:NSLayoutAttributeHeight
                                                                     multiplier:0
                                                                       constant:15]];
        if(indexPath.row==0){
            imgTime.image=[UIImage imageNamed:@"日期"];
            lbTiJian.text=@"体检日期";
            lbTiJian1.text=@"2015-06-23(周四)";
        }else{
            imgTime.hidden=YES;
            
            imgTime=[[UIImageView alloc]init];
            imgTime.image=[UIImage imageNamed:@"提醒时间"];
            [cell1.contentView addSubview:imgTime];
            imgTime.translatesAutoresizingMaskIntoConstraints = NO;
            [cell1.contentView addConstraint:[NSLayoutConstraint constraintWithItem:imgTime
                                                                          attribute:NSLayoutAttributeTop
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:cell1.contentView
                                                                          attribute:NSLayoutAttributeTop
                                                                         multiplier:1
                                                                           constant:12]];
            [cell1.contentView addConstraint:[NSLayoutConstraint constraintWithItem:imgTime
                                                                          attribute:NSLayoutAttributeLeft
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:cell1.contentView
                                                                          attribute:NSLayoutAttributeLeft
                                                                         multiplier:1
                                                                           constant:15]];
            [cell1.contentView addConstraint:[NSLayoutConstraint constraintWithItem:imgTime
                                                                          attribute:NSLayoutAttributeWidth
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:cell1.contentView
                                                                          attribute:NSLayoutAttributeWidth
                                                                         multiplier:0
                                                                           constant:15]];
            [cell1.contentView addConstraint:[NSLayoutConstraint constraintWithItem:imgTime
                                                                          attribute:NSLayoutAttributeHeight
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:cell1.contentView
                                                                          attribute:NSLayoutAttributeHeight
                                                                         multiplier:0
                                                                           constant:15]];
            lbTiJian.text=@"提醒时间";
            lbTiJian1.text=@"体检前一天8：00";
        
        }
        
    
    }else{
        label1 = [[TYAttributedLabel alloc]initWithFrame:CGRectMake(15, 0, CGRectGetWidth(cell1.contentView.frame)-15, 0)];
        [cell1.contentView addSubview:label1];
        NSString *text = @"总有一天你将破蛹而出，成长得比人们期待的还要美丽。但这个过程会很痛，会很辛苦，有时候还会觉得灰心。面对着汹涌而来的现实，觉得自己渺小无力。但这，也是生命的一部分，做好现在你能做的，然后，一切都会好的。我们都将孤独地长大，不要害怕。";
        
        NSArray *textArray = [text componentsSeparatedByString:@"。"];

        NSInteger index = 0;
        for (NSString *text in textArray) {
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:text];

            // 设置当前文本颜色
            [attributedString addAttributeTextColor:RGBA(126, 124, 123, 1)];
            [attributedString addAttributeFont:[UIFont systemFontOfSize:15]];
//            if (index == 2) {
//                // 当前文本添加下划线
//                [attributedString addAttributeUnderlineStyle:kCTUnderlineStyleSingle modifier:kCTUnderlinePatternSolid];
//            }
//            if (index == 4) {
//                [attributedString addAttributeUnderlineStyle:kCTUnderlineStyleSingle modifier:kCTUnderlinePatternDot];
//            }
            [label1 appendText:@"\n\t"];
            // 追加(添加到最后)属性文本
            [label1 appendTextAttributedString:attributedString];
            //[label1 appendText:@"\n\t"];
            index++;
        }
        
        [label1 sizeToFit];
        
        _label1 = label1;
    
    }
    return cell1;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        return 80;
    }else if(indexPath.section == 1){
        
        return 40;
    }else{
        
        return label1.frame.size.height;
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if(section==2){
    return 0;
    }else{
    return 10;
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
