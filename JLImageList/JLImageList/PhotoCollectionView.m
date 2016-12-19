//
//  PhotoCollectionView.m
//  Gouhuiwan
//
//  Created by FJL on 16/10/18.
//  Copyright © 2016年 FJL. All rights reserved.
//

#import "PhotoCollectionView.h"
#import "PhotoCell.h"
#import "UIViewExt.h"
#import "JLImageCommen.h"

static NSString *identy = @"PhotoCell";
@implementation PhotoCollectionView

- (id)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{

    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {

        _images = [NSMutableArray array];
        
        //指定数据源,代理
        self.dataSource = self;
        self.delegate = self;
        
        //注册单元格
        [self registerClass:[PhotoCell class] forCellWithReuseIdentifier:identy];
        
        //分页效果
        self.pagingEnabled = YES;
    }
    return self;

}


#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _images.count;
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    PhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identy forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    //将图片交给单元格
    cell.imageUrl = _images[indexPath.row];
    
    return cell;
}


//单元格相对于屏幕边缘的间隙
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0 ,0, 0, 30);
}


//结束显示某个单元格
- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{

    //获取到单元格上的滑动视图
    UIScrollView *view = (UIScrollView *)[cell viewWithTag:2015];
    //还原缩放倍数
    view.zoomScale = 1;
}


//手指将要离开视图时,自定义分页效果
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    
    /*
     velocity:速度
     targetContentOffset:目标偏移量
     */
    
    //单元格宽度
    CGFloat itmeWidth = kScreenWidth + 20;
    
    CGFloat x = targetContentOffset ->x;
    //计算最终会停留在第几页
    NSInteger index = (x + itmeWidth / 2) / itmeWidth;
    
    NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys: [NSString stringWithFormat:@"%li",index],@"nowPage",nil];
    NSNotification *notification =[NSNotification notificationWithName:@"PageChangeAction" object:nil userInfo:dict];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}

- (void)setImages:(NSMutableArray *)images{
    _images = images;
    [self reloadData];
}



@end
