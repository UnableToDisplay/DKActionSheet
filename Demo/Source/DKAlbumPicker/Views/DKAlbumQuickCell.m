//
//  DKAlbumQuickCell.m
//  xiaoquan
//
//  Created by Alex on 16/4/7.
//  Copyright © 2016年 Alex. All rights reserved.
//

#import "DKAlbumQuickCell.h"

@interface DKAlbumQuickCell()

@property (nonatomic,strong) UIImageView *imageView;

@property (nonatomic,strong) UIImageView *checkImageView;

@property (nonatomic,strong) UIImageView *videoSymbol;

@end

@implementation DKAlbumQuickCell
#pragma mark - Getter
- (UIImageView *)imageView
{
    if(_imageView==nil)
    {
        _imageView=[[UIImageView alloc] init];
        [_imageView setContentMode:UIViewContentModeScaleAspectFill];
        [_imageView setClipsToBounds:YES];
        [self.contentView addSubview:_imageView];
    }
    return _imageView;
}

- (UIImageView *)checkImageView
{
    if(_checkImageView==nil)
    {
        _checkImageView=[[UIImageView alloc] init];
        [_checkImageView setContentMode:UIViewContentModeScaleAspectFit];
        [self.imageView addSubview:_checkImageView];
    }
    return _checkImageView;
}

- (UIImageView *)videoSymbol
{
    if(_videoSymbol==nil)
    {
        _videoSymbol=[[UIImageView alloc] init];
        [_videoSymbol setContentMode:UIViewContentModeScaleAspectFit];
        [_videoSymbol setImage:[UIImage imageNamed:@"AlbumPickerVideoSymbol"]];
        [self addSubview:_videoSymbol];
    }
    return _videoSymbol;
}

#pragma mark - Setter
- (void)setIsSelect:(BOOL)isSelect
{
    _isSelect=isSelect;
    if(isSelect)
    {
        [self.checkImageView setImage:[UIImage imageNamed:@"AlbumPickerCheck"]];
    }
    else
    {
        [self.checkImageView setImage:[UIImage imageNamed:@"AlbumPickerUnCheck"]];
    }
}

- (void)setAsset:(ALAsset *)asset
{
    _asset=asset;
    [self.imageView setImage:[UIImage imageWithCGImage:asset.aspectRatioThumbnail]];
    if([[asset valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypeVideo])
    {
        self.videoSymbol.hidden=NO;
    }
    else
    {
        self.videoSymbol.hidden=YES;
    }
}

#pragma mark - Init
- (void)initParameter
{
    self.isSelect=NO;
}

#pragma mark - Layout
- (void)refreshLayout:(CGRect)frame
{
    self.imageView.frame=CGRectMake(0, 0, frame.size.width, frame.size.height);
    
    self.checkImageView.frame=CGRectMake(frame.size.width-30,
                                         5,
                                         20,
                                         20);
    
    self.videoSymbol.frame=CGRectMake((frame.size.width-40)/2,
                                      (frame.size.height-40)/2,
                                      40,
                                      40);
}


@end
