//
//  fatietuView.m
//  燕庐母婴
//
//  Created by apple on 15/7/1.
//  Copyright (c) 2015年 燕庐科技. All rights reserved.
//

#import "fatietuView.h"
#import "PrefixHeader.pch"
#import "MSImagePickerController.h"

#import "SDPhotoItem.h"
#import "UIButton+WebCache.h"
#import "SDPhotoBrowser.h"
#define imageH  70 // 图片高度
#define imageW 70 // 图片宽度
#define kMaxColumn 4 // 每行显示数量
#define MaxImageCount 9 // 最多显示图片个数
#define deleImageWH 25 // 删除按钮的宽高
#define kAdeleImage @"编辑.png" // 删除按钮图片
#define kAddImage @"添加照片.png" // 添加按钮图片

#define SDPhotoGroupImageMargin ([UIScreen mainScreen].bounds.size.width-300)/3

@interface fatietuView()<UINavigationControllerDelegate, UIImagePickerControllerDelegate,SDPhotoBrowserDelegate,MSImagePickerDelegate>{
    // 标识被编辑的按钮 -1 为添加新的按钮
    NSInteger editTag;
    
    UIActionSheet  *myActionSheet;
    NSMutableArray *imagearray;
}

@end

@implementation fatietuView

//图片显示

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *btn = [self createButtonWithImage:kAddImage andSeletor:@selector(addNew:)];
        
        // 清除图片缓存，便于测试
        [[SDWebImageManager sharedManager].imageCache clearDisk];
        [self addSubview:btn];
        }
    return self;
}


-(NSMutableArray *)images
{
    if(_images == nil) {
         _images = [NSMutableArray array];
        }
    return _images;
}


// 添加新的控件
- (void)addNew:(UIButton *)btn
{
    // 标识为添加一个新的图片
    
    if (![self deleClose:btn]) {
        editTag = -1;
        [self callImagePicker];
        
        //[self openMenu];
        }

}

// 修改旧的控件
- (void)changeOld:(UIButton *)btn
{
    // 标识为修改(tag为修改标识)
    if (![self deleClose:btn]) {
        editTag = btn.tag;
        [self callImagePicker];
        }
    }

// 删除"删除按钮"
- (BOOL)deleClose:(UIButton *)btn
{
    if (btn.subviews.count == 2) {
        [[btn.subviews lastObject] removeFromSuperview];
        [self stop:btn];
        return YES;
        }
    
    return NO;
    }
// 调用图片选择器
- (void)callImagePicker
{
    UIImagePickerController *pc = [[UIImagePickerController alloc] init];
    pc.allowsEditing = YES;
    pc.delegate = self;
    [self.window.rootViewController presentViewController:pc animated:YES completion:nil];
    }

// 根据图片名称或者图片创建一个新的显示控件
- (UIButton *)createButtonWithImage:(id)imageNameOrImage andSeletor : (SEL)selector
{
    UIImage *addImage = nil;
    if ([imageNameOrImage isKindOfClass:[NSString class]]) {
        addImage = [UIImage imageNamed:imageNameOrImage];
        }
    else if([imageNameOrImage isKindOfClass:[UIImage class]])
        {
            addImage = imageNameOrImage;
            }
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setImage:addImage forState:UIControlStateNormal];
    [addBtn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    addBtn.tag = self.subviews.count;
    
    // 添加长按手势,用作删除.加号按钮不添加
    if(addBtn.tag != 0)
        {
            UILongPressGestureRecognizer *gester = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
            [addBtn addGestureRecognizer:gester];
            }
    return addBtn;
    
    }

// 长按添加删除按钮
- (void)longPress : (UIGestureRecognizer *)gester
{
    if (gester.state == UIGestureRecognizerStateBegan)
        {
            UIButton *btn = (UIButton *)gester.view;
            
            UIButton *dele = [UIButton buttonWithType:UIButtonTypeCustom];
            dele.bounds = CGRectMake(0, 0, deleImageWH, deleImageWH);
            [dele setImage:[UIImage imageNamed:kAdeleImage] forState:UIControlStateNormal];
            [dele addTarget:self action:@selector(deletePic:) forControlEvents:UIControlEventTouchUpInside];
            dele.frame = CGRectMake(btn.frame.size.width - dele.frame.size.width, 0, dele.frame.size.width, dele.frame.size.height);
            
            [btn addSubview:dele];
            [self start : btn];

            }
    
    }
// 长按开始抖动
- (void)start : (UIButton *)btn {
    double angle1 = -5.0 / 180.0 * M_PI;
    double angle2 = 5.0 / 180.0 * M_PI;
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    anim.keyPath = @"transform.rotation";
    
    anim.values = @[@(angle1),  @(angle2), @(angle1)];
    anim.duration = 0.25;
    // 动画的重复执行次数
    anim.repeatCount = MAXFLOAT;
    
    // 保持动画执行完毕后的状态
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    
    [btn.layer addAnimation:anim forKey:@"shake"];
    }

// 停止抖动
- (void)stop : (UIButton *)btn{
    [btn.layer removeAnimationForKey:@"shake"];
    }

// 删除图片
- (void)deletePic : (UIButton *)btn
{
    [self.images removeObject:[(UIButton *)btn.superview imageForState:UIControlStateNormal]];
    [btn.superview removeFromSuperview];
    if ([[self.subviews lastObject] isHidden]) {
        [[self.subviews lastObject] setHidden:NO];
        }
    
    
    }
- (void)layoutSubviews
{
    [super layoutSubviews];
    long imageCount = self.subviews.count;
    int perRowImageCount = ((imageCount == 10) ? 3 : 4);
    CGFloat perRowImageCountF = (CGFloat)perRowImageCount;
    int totalRowCount = ceil(imageCount / perRowImageCountF); // ((imageCount + perRowImageCount - 1) / perRowImageCount)
    CGFloat w = 70;
    CGFloat h = 70;
    if(imageCount==0){
        self.frame = CGRectMake(10, 10, 280, totalRowCount * (SDPhotoGroupImageMargin + h));
    }else{
        [self.subviews enumerateObjectsUsingBlock:^(UIButton *btn, NSUInteger idx, BOOL *stop) {
            
            
            long rowIndex = idx / perRowImageCount;
            int columnIndex = idx % perRowImageCount;
            CGFloat x = columnIndex * (w + SDPhotoGroupImageMargin);
            CGFloat y = rowIndex * (h + SDPhotoGroupImageMargin);
            btn.frame = CGRectMake(x+10, y+10, w, h);
        }];
        
        

    }
    
        //UIButton *btn = self.subviews;
    
}


#pragma mark - UIImagePickerController 代理方法
//当选择图片之后到这里
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage* image;
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"]) {
        image=[info objectForKey:UIImagePickerControllerOriginalImage];
        UIImageOrientation imageOrientation=image.imageOrientation;
        if(imageOrientation!=UIImageOrientationUp)
        {
            // 原始图片可以根据照相时的角度来显示，但UIImage无法判定，于是出现获取的图片会向左转９０度的现象。
            // 以下为调整图片角度的部分
            UIGraphicsBeginImageContext(image.size);
            //改变图片的大小
            [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
            image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            // 调整图片角度完毕
        }
        if (editTag == -1) {
            // 创建一个新的控件
            UIButton *btn = [self createButtonWithImage:image andSeletor:@selector(changeOld:)];
            [self insertSubview:btn atIndex:self.subviews.count - 1];
            [self.images addObject:image];
            if (self.subviews.count - 1 == MaxImageCount) {
                [[self.subviews lastObject] setHidden:YES];
            }
        }
        else
        {
            // 根据tag修改需要编辑的控件
            UIButton *btn = (UIButton *)[self viewWithTag:editTag];
            int index = [self.images indexOfObject:[btn imageForState:UIControlStateNormal]];
            [self.images removeObjectAtIndex:index];
            [btn setImage:image forState:UIControlStateNormal];
            [self.images insertObject:image atIndex:index];
        }

        [picker dismissViewControllerAnimated:YES completion:nil];
    }
 
}

#pragma mark 拍照
-(void)openMenu
{
    //在这里呼出下方菜单按钮项
    myActionSheet = [[UIActionSheet alloc]
                     initWithTitle:nil
                     delegate:self
                     cancelButtonTitle:@"取消"
                     destructiveButtonTitle:nil
                     otherButtonTitles: @"打开照相机", @"从手机相册获取",nil];
    
    [myActionSheet showInView:self];
    
   // UIImagePickerController
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    //呼出的菜单按钮点击后的响应
    if (buttonIndex == myActionSheet.cancelButtonIndex)
    {
        NSLog(@"取消");
    }
    
    switch (buttonIndex)
    {
        case 0:  //打开照相机拍照
            [self takePhoto];
            break;
            
        case 1:  //打开本地相册
            [self LocalPhoto];
            break;
    }
}

//开始拍照
-(void)takePhoto
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        //打开照相机
        [self.window.rootViewController presentModalViewController:picker animated:YES];
        
        //[self fixOrientation:picker];
       // [self presentModalViewController:picker animated:YES];
    }else
    {
        NSLog(@"模拟其中无法打开照相机,请在真机中使用");
    }
}


//打开本地相册
-(void)LocalPhoto
{
    MSImagePickerController* picker = [[MSImagePickerController alloc] init];
    picker.msDelegate = self;
    //打开相册
    [self.window.rootViewController presentViewController:picker animated:YES completion:nil];
//    [self presentViewController:picker animated:YES completion:nil];
    
}

//点击图片变大变小的按钮
- (void)buttonClick:(UIButton *)button
{
    NSLog(@"点击放大");
    SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
    browser.sourceImagesContainerView = self; // 原图的父控件
    browser.imageCount = self.images.count; // 图片总数
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
    NSString *urlStr = [[self.images[index] thumbnail_pic] stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
    return [NSURL URLWithString:urlStr];
}


@end
