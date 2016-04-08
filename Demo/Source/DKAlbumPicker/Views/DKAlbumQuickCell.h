//
//  DKAlbumQuickCell.h
//  xiaoquan
//
//  Created by Alex on 16/4/7.
//  Copyright © 2016年 Alex. All rights reserved.
//

#import "DKCollectionViewCell.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface DKAlbumQuickCell : DKCollectionViewCell

@property (nonatomic,strong) ALAsset *asset;

@property (nonatomic,assign) BOOL isSelect;

@end
