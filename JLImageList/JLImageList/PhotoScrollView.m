//
//  PhotoScrollView.m
//  Gouhuiwan
//
//  Created by FJL on 16/10/18.
//  Copyright © 2016年 FJL. All rights reserved.
//

#import "PhotoScrollView.h"
@implementation PhotoScrollView{

    UIImageView *imageView;

}

- (id)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
       
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        
        //子视图
        imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        //等比例放大
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:imageView];

        //指定代理
        self.delegate = self;
        
        //缩放倍数
        self.maximumZoomScale = 3;
        self.minimumZoomScale = .5;

        //双击手势
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapAction:)];
        
        //设置手指的数量
        doubleTap.numberOfTouchesRequired = 1;
        //点击的数量
        doubleTap.numberOfTapsRequired = 2;
        //将手势添加到滑动视图上
        [self addGestureRecognizer:doubleTap];
        
        //单击手势
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapAction)];
        [self addGestureRecognizer:singleTap];
        
        //双击手势触发时,让单击手势暂时失效
        [singleTap requireGestureRecognizerToFail:doubleTap];

    }

    return self;
}

- (void)setImageUrl:(NSString *)imageUrl{
    
    //填充数据
    //[imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
    imageView.image = [UIImage imageNamed:imageUrl];
}

#pragma mark UITapGestureRecognizer

//单击手势
- (void)singleTapAction{
    
    //发送通知结束浏览
    [[NSNotificationCenter defaultCenter] postNotificationName:@"HideShowViewNotification" object:nil];
    
}


//双击调用的方法
- (void)doubleTapAction:(UITapGestureRecognizer *)tap{
    
    if (self.zoomScale != 1) { //不是正常倍数
        
//        self.zoomScale = 1; //还原
        [self setZoomScale:1 animated:YES];
    }else{
    
//        self.zoomScale = 3;
        [self setZoomScale:3 animated:YES];
    
    }

}

#pragma mark UIScrollViewDelegate
//返回放大的视图
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {

    return imageView;

}

@end
