//
//  DKAlbumQuickView.m
//  xiaoquan
//
//  Created by Alex on 16/4/7.
//  Copyright © 2016年 Alex. All rights reserved.
//

#import "DKAlbumQuickView.h"
#import "DKAlbumQuickCell.h"
#import "DKAlbumQuickEmptyView.h"

@interface DKAlbumQuickView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic,strong) DKAlbumQuickEmptyView *emptyView;

@property (nonatomic,strong) NSArray <ALAsset *> *assetArray;

@property (nonatomic,strong) NSMutableArray <ALAsset *> *checkAssetArray;

@end

@implementation DKAlbumQuickView
#pragma mark - Getter
- (UICollectionView *)collectionView
{
    if(_collectionView==nil)
    {
        UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
        _collectionView=[[UICollectionView alloc] initWithFrame:self.bounds
                                           collectionViewLayout:flowLayout];
        [_collectionView registerClass:[DKAlbumQuickCell class] forCellWithReuseIdentifier:@"DKAlbumQuickCell"];
        [_collectionView setBackgroundColor:[UIColor colorWithRed:240/255.0
                                                            green:240/255.0
                                                             blue:240/255.0
                                                            alpha:1.0]];
        [_collectionView setDelegate:self];
        [_collectionView setDataSource:self];
        [_collectionView setAlwaysBounceHorizontal:YES];
        [self addSubview:_collectionView];
    }
    return _collectionView;
}

- (DKAlbumQuickEmptyView *)emptyView
{
    if(_emptyView==nil)
    {
        _emptyView=[[DKAlbumQuickEmptyView alloc] init];
        [_emptyView setHidden:YES];
        [self insertSubview:_emptyView aboveSubview:self.collectionView];
    }
    return _emptyView;
}

- (NSMutableArray <ALAsset *> *)checkAssetArray
{
    if(_checkAssetArray==nil)
    {
        _checkAssetArray=[[NSMutableArray alloc] init];
    }
    return _checkAssetArray;
}

#pragma mark - Init
- (void)initUI
{
    [self setBackgroundColor:[UIColor colorWithRed:240/255.0
                                             green:240/255.0
                                              blue:240/255.0
                                             alpha:1.0]];
}



#pragma mark - Layout
- (void)refreshLayout:(CGRect)frame
{
    self.collectionView.frame=CGRectMake(0, 5, frame.size.width, frame.size.height-10);
    
    self.emptyView.frame=self.bounds;
}


#pragma mark - UICollectionViewDelegate+Datasource+FlowLayout
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.assetArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ALAsset *asset=self.assetArray[indexPath.row];
    CGFloat width=round(asset.defaultRepresentation.dimensions.width*collectionView.frame.size.height/asset.defaultRepresentation.dimensions.height);
    width=MAX(100, width);
    
    return CGSizeMake(width, collectionView.frame.size.height);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DKAlbumQuickCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"DKAlbumQuickCell"
                                                                     forIndexPath:indexPath];
    ALAsset *asset=self.assetArray[indexPath.row];
    [cell setAsset:asset];
    
    if([self.checkAssetArray containsObject:asset])
    {
        [cell setIsSelect:YES];
    }
    else
    {
        [cell setIsSelect:NO];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DKAlbumQuickCell *cell=(DKAlbumQuickCell *)[collectionView cellForItemAtIndexPath:indexPath];
    

    if([self.checkAssetArray containsObject:cell.asset])
    {
        [cell setIsSelect:NO];
        [self.checkAssetArray removeObject:cell.asset];
    }
    else
    {
        NSInteger videoCount=0;
        NSInteger photCount=0;
        for(ALAsset *asset in self.checkAssetArray)
        {
            if([[asset valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto])
            {
                photCount++;
            }
            else
            {
                videoCount++;
            }
        }
        
        if(self.mediaType==DKAlbumQuickMediaTypePhoto)
        {
            if(self.photoLimit>=0)
            {
                if(self.photoLimit==1)
                {
                    [self.checkAssetArray removeAllObjects];
                    [self.checkAssetArray addObject:cell.asset];
                    [self.collectionView reloadData];
                }
                else
                {
                    if(self.photoLimit<=photCount)
                    {
                        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:nil
                                                                          message:@"照片超出数量限制"
                                                                         delegate:nil
                                                                cancelButtonTitle:@"确认"
                                                                otherButtonTitles:nil];
                        [alertView show];
                        return;
                    }
                    else
                    {
                        [cell setIsSelect:YES];
                        [self.checkAssetArray addObject:cell.asset];
                    }
                }
            }
            else
            {
                [cell setIsSelect:YES];
                [self.checkAssetArray addObject:cell.asset];
            }
        }
        else if(self.mediaType==DKAlbumQuickMediaTypeVideo)
        {
            if(self.videoLimit>=0)
            {
                if(self.videoLimit==1)
                {
                    [self.checkAssetArray removeAllObjects];
                    [self.checkAssetArray addObject:cell.asset];
                    [self.collectionView reloadData];
                }
                else
                {
                    if(self.videoLimit<=videoCount)
                    {
                        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:nil
                                                                          message:@"视频超出数量限制"
                                                                         delegate:nil
                                                                cancelButtonTitle:@"确认"
                                                                otherButtonTitles:nil];
                        [alertView show];
                        return;
                    }
                    else
                    {
                        [cell setIsSelect:YES];
                        [self.checkAssetArray addObject:cell.asset];
                    }
                }
            }
            else
            {
                [cell setIsSelect:YES];
                [self.checkAssetArray addObject:cell.asset];
            }
        }
        else
        {
            if(self.totalLimit>=0)
            {
                if(self.totalLimit<=photCount+videoCount)
                {
                    UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:nil
                                                                      message:@"文件超出数量限制"
                                                                     delegate:nil
                                                            cancelButtonTitle:@"确认"
                                                            otherButtonTitles:nil];
                    [alertView show];
                    return;
                }
                else
                {
                    [cell setIsSelect:YES];
                    [self.checkAssetArray addObject:cell.asset];
                }
            }
            else
            {
                [cell setIsSelect:YES];
                [self.checkAssetArray addObject:cell.asset];
            }
        }

    }
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(albumQuickView:didCheckAssets:)])
    {
        [self.delegate albumQuickView:self didCheckAssets:self.checkAssetArray];
    }
}



#pragma mark - API
- (void)reloadData
{
    self.emptyView.hidden=YES;
    [DKAlbumQuickView fetchPhotoFromPhotoLibraryWithLimit:50
                                                mediaType:self.mediaType
                                          completionBlock:^(BOOL succeed, NSError *error, NSArray<ALAsset *> *items) {
                                              if(succeed)
                                              {
                                                  self.assetArray=items;
                                                  [self.collectionView reloadData];
                                              }
                                              else
                                              {
                                                  self.emptyView.hidden=NO;
                                              }
                                          }];
}




#pragma mark - Static
+ (void)fetchPhotoFromPhotoLibraryWithLimit:(NSInteger)limit
                                  mediaType:(DKAlbumQuickMediaType)mediaType
                            completionBlock:(void (^)(BOOL succeed, NSError *error, NSArray <ALAsset *> *items))completionBlock
{
    ALAssetsLibrary *library=[self defaultAssetsLibrary];
    NSMutableArray *items = [NSMutableArray array];
    [library enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop)
    {
        if (group != nil)
        {
            [group enumerateAssetsWithOptions:NSEnumerationReverse usingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop)
            {
                if(result!=nil)
                {
                    if(mediaType==DKAlbumQuickMediaTypePhoto && [[result valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto])
                    {
                        [items addObject:result];
                    }
                    else if(mediaType==DKAlbumQuickMediaTypeVideo && [[result valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypeVideo])
                    {
                        [items addObject:result];
                    }
                    else if(mediaType==DKAlbumQuickMediaTypeBoth)
                    {
                        [items addObject:result];
                    }
                }
                
                if([items count]>=limit)
                {
                    *stop = YES;
                }
            }];
            if (completionBlock)
            {
                completionBlock(YES,nil,items);
            }
            *stop = YES;
        }
    } failureBlock:^(NSError *error) {
        if (completionBlock)
        {
            completionBlock(NO,error,nil);
        }
    }];
}

+ (ALAssetsLibrary *)defaultAssetsLibrary
{
    static dispatch_once_t pred = 0;
    static ALAssetsLibrary *library = nil;
    dispatch_once(&pred,
                  ^{
                      library = [[ALAssetsLibrary alloc] init];
                  });
    return library;
}

@end
