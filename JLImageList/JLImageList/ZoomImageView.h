//
//  ZoomImageView.h
//  Gouhuiwan
//
//  Created by FJL on 16/10/18.
//  Copyright © 2016年 FJL. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZoomImageView;

@protocol ZoomImageViewDelegate <NSObject>

@optional

//图片将要放大
- (void)imageWillZoomIn:(ZoomImageView *)imageView;

//图片已经放大
- (void)imageDidZoomIn:(ZoomImageView *)imageView;

//图片将要隐藏
- (void)imageWillZoomOut:(ZoomImageView *)imageView;

//图片已经隐藏
- (void)imageDidZoomOut:(ZoomImageView *)imageView;

@end



@interface ZoomImageView : UIImageView {
    UIImageView *_fullImageView;
}

@property (nonatomic, weak)id<ZoomImageViewDelegate> delegate;

//绑定数据用于浏览
@property (nonatomic,strong)NSMutableArray *imageArray;
//描述
@property (nonatomic,strong)NSMutableArray *desArray;
//当前图片
@property (nonatomic,strong)NSString *nowImage;


- (instancetype)initWithFrame:(CGRect)frame withImage:(NSString *)imageStr;

@end











