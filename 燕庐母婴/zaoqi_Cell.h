//
//  zaoqi_Cell.h
//  美妈锦囊
//
//  Created by apple on 15/7/27.
//  Copyright (c) 2015年 燕庐科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface zaoqi_Cell : UITableViewCell
@property (strong, nonatomic)     UILabel *lbTime;  //时间
@property (strong, nonatomic)     UIView *infoView; //白色底的那个View
@property (strong, nonatomic)     UILabel *lbInfoContent; //通知内容
@property (strong, nonatomic)     UIImageView *lbInfoContentimage; //通知内容图片
@property (strong, nonatomic)     UIView *lbSegment; //竖着的灰色分割线
@property (strong, nonatomic)     UIButton *btnSegmentrect; //竖着的圆圈
@end
