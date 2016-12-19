//
//  PhotoListView.m
//  Gouhuiwan
//
//  Created by FJL on 16/10/18.
//  Copyright © 2016年 FJL. All rights reserved.
//

#import "PhotoListView.h"
#import "UIViewExt.h"
#import "PhotoCollectionView.h"
#import "JLImageCommen.h"

@implementation PhotoListView{
    PhotoCollectionView *_collectionView;
    UIView *_desBg;
    NSMutableArray *_descriptionArr;
    
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"PageChangeAction" object:nil];
}


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _images = [NSMutableArray array];
        _descriptionArr = [NSMutableArray array];
        [self _createViews];
    }
    return self;
}


- (void)_createViews {
    
    self.backgroundColor = [UIColor clearColor];

    [self _createPhotoListView];
}


- (void)_createPhotoListView{
    
    //创建布局对象
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(kScreenWidth, kScreenHeight);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 30;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _collectionView =[[PhotoCollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth + 30,kScreenHeight) collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor clearColor];
    [self addSubview:_collectionView];
    
    //文字显示
    _desBg = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight -  85, kScreenWidth, 35)];
    _desBg.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    [self addSubview:_desBg];
    
    _desLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, kScreenWidth - 20, 35)];
    _desLabel.backgroundColor = [UIColor clearColor];
    _desLabel.textColor = [UIColor whiteColor];
    _desLabel.font = [UIFont systemFontOfSize:13];
    _desLabel.textAlignment = NSTextAlignmentLeft;
    _desLabel.numberOfLines = 2;
    _desLabel.userInteractionEnabled = NO;
    [_desBg addSubview:_desLabel];
    
    
    //创建页码显示
    _pageCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kScreenHeight -  50, kScreenWidth, 50)];
    _pageCountLabel.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    _pageCountLabel.textColor = [UIColor whiteColor];
    _pageCountLabel.font = [UIFont systemFontOfSize:15];
    _pageCountLabel.textAlignment = NSTextAlignmentCenter;
    _pageCountLabel.userInteractionEnabled = NO;
    [self addSubview:_pageCountLabel];
    
    //接受通知方法
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(PageChangeAction:) name:@"PageChangeAction" object:nil];
}


- (void)PageChangeAction:(NSNotification *)text {
    NSString *str = text.userInfo[@"nowPage"];
    
   _pageCountLabel.text = [NSString stringWithFormat:@"%li/%lu",[str integerValue] + 1,(unsigned long)_images.count];
  
    
    if (_descriptionArr.count > 0) {
        NSString *desStr = _descriptionArr[[str integerValue]];
        
        if ((NSNull *)desStr != [NSNull null] && desStr != nil) {
            _desLabel.text = desStr;
            _desBg.hidden = NO;
        }else{
            _desBg.hidden = YES;
        }
    }else{
        _desBg.hidden = YES;
    }
}



- (void)setImages:(NSMutableArray *)images{
    
    if(_images != images){
        _images = images;
        _collectionView.images = _images;
        
        _pageCountLabel.text = [NSString stringWithFormat:@"%li/%lu",_indexPath + 1,(unsigned long)_images.count];
    
        if (_descriptionArr.count > 0) {
            NSString *desStr = _descriptionArr[_indexPath];
            
            if ((NSNull *)desStr != [NSNull null] && desStr != nil) {
                _desLabel.text = desStr;
                _desBg.hidden = NO;
            }else{
                _desBg.hidden = YES;
            }
        }else{
            _desBg.hidden = YES;
        }
    }
}


- (void)setIndexPath:(NSInteger)indexPath{

    if(_indexPath != indexPath){
        _indexPath = indexPath;
        
        if(_images.count > 0){
            //滚动到指定的单元格
            [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.indexPath  inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
        }
        
         _pageCountLabel.text = [NSString stringWithFormat:@"%li/%lu",_indexPath + 1,(unsigned long)_images.count];
        
        if (_descriptionArr.count > 0) {
            NSString *desStr = _descriptionArr[_indexPath];
            
            if ((NSNull *)desStr != [NSNull null] && desStr != nil) {
                _desLabel.text = desStr;
                _desBg.hidden = NO;
            }else{
                _desBg.hidden = YES;
            }
        }else{
            _desBg.hidden = YES;
        }
    }
}


- (void)setDesArray:(NSMutableArray *)desArray{
    if (_desArray != desArray) {
        _desArray = desArray;
        _descriptionArr = _desArray;
    }
}





@end
