//
//  tiJianXiang_Cell.m
//  美妈锦囊
//
//  Created by apple on 15/7/30.
//  Copyright (c) 2015年 燕庐科技. All rights reserved.
//

#import "tiJianXiang_Cell.h"
#import "PrefixHeader.pch"

@implementation tiJianXiang_Cell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    
    }
     return self;
}
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, rect);
    
    //下分割线
    CGContextSetStrokeColorWithColor(context,RGBA(241, 240, 241, 1).CGColor);
    CGContextStrokeRect(context, CGRectMake(0, rect.size.height, rect.size.width , 1));
}
@end
