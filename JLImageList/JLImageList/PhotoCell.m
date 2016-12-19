//
//  PhotoCell.m
//  Gouhuiwan
//
//  Created by FJL on 16/10/18.
//  Copyright © 2016年 FJL. All rights reserved.
//

#import "PhotoCell.h"
#import "PhotoScrollView.h"
@implementation PhotoCell{

    PhotoScrollView *scrollView;
}

- (id)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        
        //创建子视图
        [self _createSubViewes];
    }
    return self;

}
//重写set方法
- (void)setImageUrl:(NSString *)imageUrl{
     _imageUrl = imageUrl;
    scrollView.imageUrl = _imageUrl;

}

- (void)_createSubViewes{
    
    //子类化滑动视图
    scrollView = [[PhotoScrollView alloc] initWithFrame:self.bounds];    
    [self.contentView addSubview:scrollView];
    
}

@end











