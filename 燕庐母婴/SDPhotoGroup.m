//
//  SDPhotoGroup.m
//  桥餐厅-燕庐
//
//  Created by zhaodeyu on 15/6/1.
//  Copyright (c) 2015年 燕庐科技. All rights reserved.
//
#define SDPhotoGroupImageMargin 15

#import "SDPhotoGroup.h"
#import "SDPhotoItem.h"
#import "UIButton+WebCache.h"
#import "SDPhotoBrowser.h"

@interface SDPhotoGroup () <SDPhotoBrowserDelegate>

@end

@implementation SDPhotoGroup 




- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
           }
    return self;
}

- (void)setPhotoItemArray:(NSArray *)photoItemArray
{
    _photoItemArray = photoItemArray;
    [photoItemArray enumerateObjectsUsingBlock:^(SDPhotoItem *obj, NSUInteger idx, BOOL *stop) {
        UIButton *btn = [[UIButton alloc] init];
        [btn sd_setImageWithURL:[NSURL URLWithString:obj.thumbnail_pic] forState:UIControlStateNormal];
        
        
        btn.tag = idx;
        
        [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }];
}

int perRowImageCount;
- (void)layoutSubviews
{
    [super layoutSubviews];
    int imageCount = self.photoItemArray.count;
     perRowImageCount = ((imageCount == 9) ? 2 : 3);
    
    if (imageCount == 3)
    {
        perRowImageCount = 3;
    }
    if (imageCount == 6)
    {
        perRowImageCount = 3;
    }
    if (imageCount == 9)
    {
        perRowImageCount = 3;
    }

    
    //int totalRowCount = imageCount / perRowImageCount + 0.99999; // ((imageCount + perRowImageCount - 1) / perRowImageCount)
    
    int totalRowCount =   ((imageCount + perRowImageCount - 1) / perRowImageCount);
 
    NSLog(@"btnStr--%ld",self.btnStr);
    
    if (self.btnStr == 6)
    {
        CGFloat w = 60;
        CGFloat h = 60;
        
        [self.subviews enumerateObjectsUsingBlock:^(UIButton *btn, NSUInteger idx, BOOL *stop) {
            
            int rowIndex = idx / perRowImageCount;
            int columnIndex = idx % perRowImageCount;
            CGFloat x = columnIndex * (w + 5);
            CGFloat y = rowIndex * (h + 5);
            btn.frame = CGRectMake(x, y, w, h);
        }];
        
        self.frame = CGRectMake(10, 10, 60, totalRowCount * (5 + h)-10);
    }
    else
    {
        CGFloat w = 80;
        CGFloat h = 80;
        
        [self.subviews enumerateObjectsUsingBlock:^(UIButton *btn, NSUInteger idx, BOOL *stop) {
            
            int rowIndex = idx / perRowImageCount;
            int columnIndex = idx % perRowImageCount;
            CGFloat x = columnIndex * (w + 5);
            CGFloat y = rowIndex * (h + 5);
            btn.frame = CGRectMake(x, y, w, h);
        }];
        
        self.frame = CGRectMake(20, 100, 280, totalRowCount * (5 + h));
    }
    
    

    
   
}

- (void)buttonClick:(UIButton *)button
{
    SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
    browser.sourceImagesContainerView = self; // 原图的父控件
    browser.imageCount = self.photoItemArray.count; // 图片总数
    browser.currentImageIndex = button.tag;
    browser.delegate = self;
    [browser show];
    
}

#pragma mark - photobrowser代理方法

// 返回临时占位图片（即原来的小图）
- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    return [self.subviews[index] currentImage];
}


// 返回高质量图片的url
- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    NSString *urlStr = [self.photoItemArray[index] thumbnail_pic];
    return [NSURL URLWithString:urlStr];
}


@end
