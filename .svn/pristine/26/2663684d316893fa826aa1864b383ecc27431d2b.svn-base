//
//  MomTV-VC.h
//  燕庐母婴
//
//  Created by 董飞剑 on 15/6/25.
//  Copyright (c) 2015年 燕庐科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFHTTPRequestOperationManager.h"

#import "PrefixHeader.pch"
#import "SquareChild-VC.h"
#import "Notice-Cell.h"
#import "Square-Cell.h"
#import "TopListHeader-Cell.h"
#import "Top-listCell.h"
#import "UIImage+Video.h"
#import <MediaPlayer/MediaPlayer.h>
#import <CoreMedia/CoreMedia.h>
#import <AVFoundation/AVFoundation.h>
@interface MomTV_VC : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UIActionSheetDelegate,UICollectionViewDelegateFlowLayout>
{
    NSUserDefaults *_user;
    NSString *_userId;
    
    UIImagePickerControllerQualityType                  _qualityType;
    NSString*                                           _mp4Quality;
    
    NSURL*                                              _videoURL;
    NSString*                                           _mp4Path;
    
    UILabel*                                            _fileSize;
    UILabel*                                            _videoLen;
    UIAlertView*                                        _alert;
    NSDate*                                             _startDate;
    
    UILabel*                                            _convertTime;
    UILabel*                                            _mp4Size;
    
    BOOL                                                _hasVideo;
    BOOL                                                _networkOpt;
    BOOL                                                _hasMp4;
}
@property (nonatomic,strong) AFHTTPRequestOperationManager *manager;
@property (strong,nonatomic) UIView *navView;//导航栏view

@property (strong,nonatomic) UIButton *backBtn; //返回按钮


@property (strong,nonatomic) UIButton *noticeBtn;//关注按钮
@property (strong,nonatomic) UILabel *noticeLab;//关注白点


@property (strong,nonatomic) UIButton *squareBtn;//广场按钮
@property (strong,nonatomic) UILabel *squareLab;//广场白点


@property (strong,nonatomic) UIButton *listBtn;//榜单按钮
@property (strong,nonatomic) UILabel *listLab;//榜单白点


@property (strong,nonatomic) UIButton *cameraBtn;//录像按钮


@property (strong,nonatomic) UIScrollView *scrollView;
@property (strong,nonatomic) UIView *noticeView; //关注view
@property (strong,nonatomic) UIView *squareView; //广场view
@property (strong,nonatomic) UIView *listView;   //榜单view

@property (strong,nonatomic) UICollectionView *noticeCollection;              //关注页面控件
@property (strong,nonatomic) UICollectionView *squareCollection;              //广场页面控件
@property (strong,nonatomic) UICollectionView *topListCollection;           //榜单页面控件
@property (strong,nonatomic) UIImagePickerController *picker;
@property (strong,nonatomic) UIActionSheet *actionSheet;
@end
