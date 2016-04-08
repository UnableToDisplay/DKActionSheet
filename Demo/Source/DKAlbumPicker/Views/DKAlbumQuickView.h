//
//  DKAlbumQuickView.h
//  xiaoquan
//
//  Created by Alex on 16/4/7.
//  Copyright © 2016年 Alex. All rights reserved.
//

#import "DKView.h"
#import <AssetsLibrary/AssetsLibrary.h>

typedef NS_ENUM(NSInteger , DKAlbumQuickMediaType)
{
    DKAlbumQuickMediaTypePhoto,
    DKAlbumQuickMediaTypeVideo,
    DKAlbumQuickMediaTypeBoth
};

@class DKAlbumQuickView;
@protocol DKAlbumQuickViewDelegate <NSObject>
@optional

- (void)albumQuickView:(DKAlbumQuickView *)quickView didCheckAssets:(NSArray <ALAsset *> *)assets;

@end



@interface DKAlbumQuickView : DKView

@property (nonatomic,assign) DKAlbumQuickMediaType mediaType;

@property (nonatomic,assign) NSInteger videoLimit;

@property (nonatomic,assign) NSInteger photoLimit;

@property (nonatomic,assign) NSInteger totalLimit;

@property (nonatomic,weak) id <DKAlbumQuickViewDelegate> delegate;

- (void)reloadData;

@end
