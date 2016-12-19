//
//  PhotoListView.h
//  Gouhuiwan
//
//  Created by FJL on 16/10/18.
//  Copyright © 2016年 FJL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoListView : UIView{
    
    BOOL isHide;
}


@property (nonatomic,strong)UILabel *pageCountLabel;//页码显示
//文字显示
@property (nonatomic,strong)UILabel *desLabel;


@property (nonatomic,strong)NSMutableArray *images;//所有图片
@property (nonatomic,assign)NSInteger indexPath; //第几张
@property (nonatomic,strong)NSMutableArray *desArray;//图片描述





@end
