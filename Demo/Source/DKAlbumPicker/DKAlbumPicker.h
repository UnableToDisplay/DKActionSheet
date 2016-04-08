//
//  HVPickPhotoObject.h
//  xiaoquan
//
//  Created by 许建勇 on 15/9/10.
//  Copyright (c) 2015年 Alex. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    /**
     *  图片
     */
    DKAlbumPickerTypePhoto=1,
    /**
     *  视频
     */
    DKAlbumPickerTypeVideo,
    /**
     *  不限
     */
    DKAlbumPickerTypeBoth
}DKAlbumPickerType;


@class DKAlbumPicker;
@protocol DKAlbumPickerDelegate <NSObject>

@optional
/**
 * NSArray中可能返回UIImage、NSURL、ALAsset
 */
- (void)albumPicker:(DKAlbumPicker *)albumPicker didSelectPhotos:(NSArray *)photos;
- (void)albumPickerDidCancelSelect:(DKAlbumPicker *)albumPicker;

@end







@interface DKAlbumPicker : NSObject

/**
 *  弹出ActionSheet进行多媒体文件的选择
 *
 *  @param pickerType       选择的文件类型
 *  @param fileLimit        文件限制(-1则不限制)
 *  @param videoLimit       视频限制(-1则不限制)
 *  @param delegate         委托
 *  @param sourceController 来源
 *
 *  @return 实例
 */
+ (DKAlbumPicker *)showPickerWithMediaType:(DKAlbumPickerType)pickerType
                                 fileLimit:(int)fileLimit
                                videoLimit:(int)videoLimit
                                  delegate:(id <DKAlbumPickerDelegate>)delegate
                          sourceController:(UIViewController *)sourceController;

/**
 *  直接进入相册选择
 */
+ (DKAlbumPicker *)presentPickerForLibraryWithMediaType:(DKAlbumPickerType)pickerType
                                              fileLimit:(int)fileLimit
                                             videoLimit:(int)videoLimit
                                               delegate:(id <DKAlbumPickerDelegate>)delegate
                                       sourceController:(UIViewController *)sourceController;

/**
 *  直接进入拍照
 */
+ (DKAlbumPicker *)presentPickerForCameraWithMediaType:(DKAlbumPickerType)pickerType
                                              delegate:(id <DKAlbumPickerDelegate>)delegate
                                      sourceController:(UIViewController *)sourceController;

@end
