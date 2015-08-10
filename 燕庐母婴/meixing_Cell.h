//
//  meixing_Cell.h
//  美妈锦囊
//
//  Created by apple on 15/7/30.
//  Copyright (c) 2015年 燕庐科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface meixing_Cell : UITableViewCell
@property (strong, nonatomic)     UILabel *title; //标题
@property (strong, nonatomic)     UIImageView *zuozheImage;  //作者图片
@property (strong, nonatomic)     UILabel *zuozheName; //作者名称
@property (strong, nonatomic)     UIImageView *guankanImage;  //观看图片
@property (strong, nonatomic)     UILabel *guankannumber; //观看数量

@end
