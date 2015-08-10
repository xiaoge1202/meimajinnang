//
//  bobyYimiao_Cell.h
//  美妈锦囊
//
//  Created by apple on 15/7/30.
//  Copyright (c) 2015年 燕庐科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface bobyYimiao_Cell : UITableViewCell
@property (strong, nonatomic)     UIView *xian;  //竖着的线
@property (strong, nonatomic)     UILabel *lbTitle; //标题
@property (strong, nonatomic)     UILabel *lbchushengday; //出生天数
@property (strong, nonatomic)     UILabel *lbtijianTime; //体检时间
@property (strong, nonatomic)     UIView *xina2; //按钮前面的线
@property (strong, nonatomic)     UIButton *btnstate; //是否体检的状态按钮
@property (strong, nonatomic)     UIImageView *imgTime; //体检时间的图标
@end
