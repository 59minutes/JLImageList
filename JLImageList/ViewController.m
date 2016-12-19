//
//  ViewController.m
//  JLImageList
//
//  Created by FJL on 16/12/19.
//  Copyright © 2016年 FJL. All rights reserved.
//

#import "ViewController.h"
#import "ZoomImageView.h"

//屏幕的宽、高
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _creatViews];
}


- (void)_creatViews{

    
    //模拟数据
    NSMutableArray *imageNames = [NSMutableArray array];
    NSMutableArray *desArr = [NSMutableArray array];
    for (NSInteger i = 0; i < 5; i ++) {
        [imageNames addObject:[NSString stringWithFormat:@"tu_%li",i + 1]];
        [desArr addObject:[NSString stringWithFormat:@"华东地区知名厂商生产，江南皮革厂实力打造____%li",i + 1]];
    }
    
    
    CGFloat itemWith = (kScreenWidth - 30 - 20)/3;
    for (NSInteger i = 0; i < 5; i ++) {
        ZoomImageView *imageView = [[ZoomImageView alloc] initWithFrame:CGRectMake(15 + (itemWith + 10) * i - ((i > 2)?((itemWith + 10) * 3):(0)), 64 + 50 + ((i > 2)?(itemWith + 10):(0)), itemWith, itemWith) withImage:[NSString stringWithFormat:@"tu_%li",i + 1]];
        imageView.desArray = desArr;
        imageView.imageArray = imageNames;
        [self.view addSubview:imageView];
    }
}


@end



