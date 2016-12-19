//
//  ZoomImageView.m
//  Gouhuiwan
//
//  Created by FJL on 16/10/18.
//  Copyright © 2016年 FJL. All rights reserved.
//

#import "ZoomImageView.h"
#import "UIViewExt.h"
#import "PhotoScrollView.h"
#import "PhotoListView.h"

@implementation ZoomImageView {
    PhotoScrollView *_scrollImageView;
    PhotoListView *_photoListView;
    UIView *_maskView;//蒙砂视图
    BOOL _isTap;
}

- (instancetype)initWithFrame:(CGRect)frame withImage:(NSString *)imageStr{
    if (self = [super initWithFrame:frame]) {
        
        self.nowImage = imageStr;
        self.image = [UIImage imageNamed:self.nowImage];
        
        [self _initTap];
    }
    return self;
}


- (void)_initTap {
    
    _isTap = NO;
    //添加点击手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(zoomIn)];
    
    [self addGestureRecognizer:tap];
    
    self.userInteractionEnabled = YES;
    
    //等比例放大缩小
    self.contentMode = UIViewContentModeScaleAspectFit;
    
    //接受通知隐藏浏览视图
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideShowView) name:@"HideShowViewNotification" object:nil];
}



//创建大图显示时需要的子视图
- (void)_createView {
    
    if (_photoListView == nil) {
       
        //蒙砂视图
        _maskView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _maskView.backgroundColor = [UIColor blackColor];
        _maskView.alpha = 1;
        _maskView.hidden = YES;
        [self.window addSubview:_maskView];

        
        //图片浏览视图
        _photoListView = [[PhotoListView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _photoListView.hidden = YES;
        _photoListView.desArray = _desArray;
        _photoListView.images = _imageArray;
        
        
        //计算当前视图为第几张
        for(NSInteger i = 0; i < _imageArray.count;i++){
            NSString *urlNow = _imageArray[i];
            if([_nowImage isEqualToString:urlNow] ){
                _photoListView.indexPath = i;
            }
        }
        
        [self.window addSubview:_photoListView];
        
        //创建大图显示视图
        _fullImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _fullImageView.image = self.image;
        _fullImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.window addSubview:_fullImageView];

    }
}




#pragma mark --- 图片的放大 ---
- (void)zoomIn {
    
    if (_isTap == YES) {
        return;
    }else{
        _isTap = YES;
    }
    
    NSLog(@"开始放大");
    
    //调用代理对象将要放大的协议方法
    if ([self.delegate respondsToSelector:@selector(imageWillZoomIn:)]) {
        [self.delegate imageWillZoomIn:self];
    }
    [self _createView];
    

    
    //坐标系由当前视图转化为window的坐标
    CGRect frame = [self convertRect:self.bounds toView:self.window];
    
    _fullImageView.frame = frame;
    _maskView.alpha = 1;
    _maskView.hidden = NO;
    
    //设置动画效果实现放大
    [UIView animateWithDuration:0.3 animations:^{
        //放大到整个屏幕
        _fullImageView.frame = [UIScreen mainScreen].bounds;
        
    } completion:^(BOOL finished) {
        
        _photoListView.hidden = NO;
        _maskView.hidden = NO;
        _fullImageView.hidden = YES;
        
        //调用代理对象已经放大的协议方法
        if ([self.delegate respondsToSelector:@selector(imageDidZoomIn:)]) {
            [self.delegate imageDidZoomIn:self];
        }
    }];
}


#pragma mark --- 图片隐藏 ---
- (void)hideShowView{
    _isTap = NO;
    //调用代理对象将要缩小的协议方法
    if ([self.delegate respondsToSelector:@selector(imageWillZoomOut:)]) {
        [self.delegate imageWillZoomOut:self];
    }

     _photoListView.alpha = 1;;
    _maskView.alpha = 1;
    
    [UIView animateWithDuration:0.1 animations:^{
        
        _photoListView.alpha = 0;
        _maskView.alpha = 0;
        
    } completion:^(BOOL finished) {
        [_photoListView removeFromSuperview];
        _fullImageView = nil;
        _photoListView = nil;
        
        //调用代理对象已经缩小的协议方法
        if ([self.delegate respondsToSelector:@selector(imageDidZoomOut:)]) {
            [self.delegate imageDidZoomOut:self];
        }
    }];
}


#pragma mark --- set方法 ---
- (void)setImageArray:(NSMutableArray *)imageArray{
    _imageArray = imageArray;
}


- (void)setDesArray:(NSMutableArray *)desArray{
    _desArray = desArray;
}





@end















































































