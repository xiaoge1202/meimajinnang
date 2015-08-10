//
//  FIndCollectionViewCell.m
//  燕庐母婴
//
//  Created by 侯泽彭 on 15/6/2.
//  Copyright (c) 2015年 燕庐科技. All rights reserved.
//

#import "FIndCollectionViewCell.h"

@implementation FIndCollectionViewCell

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 0, 60, 60)];
        [self addSubview:_imgView];
        
        
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 65, 90, 20)];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = [UIFont fontWithName:nil size:12];
        [self addSubview:_label];
    }
    return self;
}
@end
