//
//  PhotoCollectionView.h
//  Gouhuiwan
//
//  Created by FJL on 16/10/18.
//  Copyright © 2016年 FJL. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface PhotoCollectionView : UICollectionView<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong)NSMutableArray *images;



@end
