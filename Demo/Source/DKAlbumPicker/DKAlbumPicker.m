//
//  HVPickPhotoObject.m
//  xiaoquan
//
//  Created by 许建勇 on 15/9/10.
//  Copyright (c) 2015年 Alex. All rights reserved.
//

#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
#import "DKAlbumPicker.h"
#import "CTAssetsPickerController.h"
#import "DKAlbumQuickView.h"
#import "DKActionSheet.h"

static DKAlbumPicker *pickerHolder=nil;

static CGFloat kConstViedoTimeLimit=5*60;


@interface DKAlbumPicker()<DKActionSheetDelegate,CTAssetsPickerControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,DKAlbumQuickViewDelegate>
#pragma mark - UI
/**
 *  弹出列表
 */
@property (nonatomic,strong) DKActionSheet *actionSheet;

/**
 *  来源
 */
@property (nonatomic,weak) UIViewController *sourceController;

#pragma mark - Parameter
@property (nonatomic,assign) DKAlbumPickerType pickerType;

@property (nonatomic,assign) int videoLimit;

@property (nonatomic,assign) int fileLimit;

@property (nonatomic,weak) id<DKAlbumPickerDelegate> delegate;

@property (nonatomic,strong) NSArray <ALAsset *> *quickAssetArray;
@end


@implementation DKAlbumPicker
#pragma mark - Init
- (instancetype)init
{
    self=[super init];
    if(self)
    {
        self.fileLimit=1;
        self.videoLimit=-1;
        self.pickerType=DKAlbumPickerTypeBoth;
    }
    return self;
}





#pragma mark - DKActionSheetDelegate
- (void)actionSheet:(DKActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(self.quickAssetArray.count>0 && buttonIndex+1==actionSheet.buttonCount)
    {//快速选择点击确定
        switch (self.pickerType)
        {
            case DKAlbumPickerTypePhoto:
            case DKAlbumPickerTypeVideo:
            case DKAlbumPickerTypeBoth:
            {
                if(self.delegate &&
                   [self.delegate respondsToSelector:@selector(albumPicker:didSelectPhotos:)])
                {
                    [self.delegate albumPicker:self
                               didSelectPhotos:self.quickAssetArray];
                }
                pickerHolder=nil;
                break;
            }
            default:
                break;
        }
        return;
    }
    
    switch (self.pickerType)
    {
        case DKAlbumPickerTypePhoto:
        {
            if(buttonIndex==2)
            {//拍照片
                [DKAlbumPicker fetchCameraAuthorityWithCompletion:^(BOOL succeed) {
                    if(succeed)
                    {
                        [self cameraEnableForPhoto];
                    }
                    else
                    {
                        [self cameraDisabled];
                    }
                }];
            }
            else if(buttonIndex==1)
            {//从图库选择图片
                CTAssetsPickerController* picker=[[CTAssetsPickerController alloc] init];
                picker.delegate=self;
                picker.assetsFilter=[ALAssetsFilter allPhotos];
                [self.sourceController presentViewController:picker animated:YES completion:nil];
            }
            else
            {//放弃
                if(self.delegate &&
                   [self.delegate respondsToSelector:@selector(albumPickerDidCancelSelect:)])
                {
                    [self.delegate albumPickerDidCancelSelect:self];
                }
                pickerHolder=nil;
            }
            break;
        }
        case DKAlbumPickerTypeVideo:
        {
            if(buttonIndex==2)
            {//拍视频
                [DKAlbumPicker fetchCameraAuthorityWithCompletion:^(BOOL succeed) {
                    if(succeed)
                    {
                        [self cameraEnableForVideo];
                    }
                    else
                    {
                        [self cameraDisabled];
                    }
                }];
            }
            else if(buttonIndex==1)
            {//从图库选择视频
                CTAssetsPickerController* picker=[[CTAssetsPickerController alloc] init];
                picker.delegate=self;
                picker.assetsFilter=[ALAssetsFilter allVideos];
                [self.sourceController presentViewController:picker animated:YES completion:nil];
            }
            else
            {//放弃
                if(self.delegate &&
                   [self.delegate respondsToSelector:@selector(albumPickerDidCancelSelect:)])
                {
                    [self.delegate albumPickerDidCancelSelect:self];
                }
                pickerHolder=nil;
            }
            break;
        }
        case DKAlbumPickerTypeBoth:
        {
            if(buttonIndex==3)
            {//拍照片
                [DKAlbumPicker fetchCameraAuthorityWithCompletion:^(BOOL succeed) {
                    if(succeed)
                    {
                        [self cameraEnableForPhoto];
                    }
                    else
                    {
                        [self cameraDisabled];
                    }
                }];
            }
            else if(buttonIndex==2)
            {//拍视频
                [DKAlbumPicker fetchCameraAuthorityWithCompletion:^(BOOL succeed) {
                    if(succeed)
                    {
                        [self cameraEnableForVideo];
                    }
                    else
                    {
                        [self cameraDisabled];
                    }
                }];
            }
            else if(buttonIndex==1)
            {//从图库选择照片或视频
                CTAssetsPickerController* picker=[[CTAssetsPickerController alloc] init];
                picker.delegate=self;
                [self.sourceController presentViewController:picker animated:YES completion:nil];
            }
            else
            {//放弃
                if(self.delegate &&
                   [self.delegate respondsToSelector:@selector(albumPickerDidCancelSelect:)])
                {
                    [self.delegate albumPickerDidCancelSelect:self];
                }
                pickerHolder=nil;
            }
            break;
        }
        default:
            break;
    }
}



#pragma mark - CTAssetsPickerControllerDelegate
- (void)assetsPickerControllerDidCancel:(CTAssetsPickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    if(self.delegate &&
       [self.delegate respondsToSelector:@selector(albumPickerDidCancelSelect:)])
    {
        [self.delegate albumPickerDidCancelSelect:self];
    }
    pickerHolder=nil;
}
- (void)assetsPickerController:(CTAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    if(self.delegate &&
       [self.delegate respondsToSelector:@selector(albumPicker:didSelectPhotos:)])
    {
        [self.delegate albumPicker:self didSelectPhotos:assets];
    }
    pickerHolder=nil;
}


- (BOOL)assetsPickerController:(CTAssetsPickerController *)picker shouldSelectAsset:(ALAsset *)asset
{
    //---------------------------------------------------------------------------------------------------
    //文件数量限制
    if(picker.selectedAssets.count>=self.fileLimit)
    {
        UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"提示"
                                                      message:[NSString stringWithFormat:@"超出数量限制%d",self.fileLimit]
                                                     delegate:nil
                                            cancelButtonTitle:@"确认"
                                            otherButtonTitles:nil];
        [alert show];
        return NO;
    }
    else
    {
        //视频数量限制
        if(self.videoLimit>=0)
        {
            NSInteger videoCount=0;
            for(int i=0;i<picker.selectedAssets.count;i++)
            {
                ALAsset *asset=picker.selectedAssets[i];
                if([[asset valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypeVideo])
                {
                    videoCount++;
                }
            }
            if(videoCount>=_videoLimit && [[asset valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypeVideo])
            {
                UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"提示"
                                                              message:[NSString stringWithFormat:@"视频超出数量限制%d",self.videoLimit]
                                                             delegate:nil
                                                    cancelButtonTitle:@"确认"
                                                    otherButtonTitles:nil];
                [alert show];
                return NO;
            }
        }
        
        //文件长度限制
        if([[asset valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto])
        {//图片
            
        }
        else if([[asset valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypeVideo])
        {//视频
            AVURLAsset* urlAsset=[AVURLAsset assetWithURL:asset.defaultRepresentation.url];
            NSInteger second=urlAsset.duration.value/urlAsset.duration.timescale;
            if(second>=kConstViedoTimeLimit)
            {
                UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"提示"
                                                              message:[NSString stringWithFormat:@"视频长度不能超过%.0fs",kConstViedoTimeLimit]
                                                             delegate:nil
                                                    cancelButtonTitle:@"确认"
                                                    otherButtonTitles:nil];
                [alert show];
                return NO;
            }
        }
        return YES;
    }
}



#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    if(self.delegate &&
       [self.delegate respondsToSelector:@selector(albumPickerDidCancelSelect:)])
    {
        [self.delegate albumPickerDidCancelSelect:self];
    }
    pickerHolder=nil;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    if([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:(NSString*)kUTTypeMovie])
    {//视频类型
        NSURL* url=[info objectForKey:UIImagePickerControllerMediaURL];
        if(self.delegate &&
           [self.delegate respondsToSelector:@selector(albumPicker:didSelectPhotos:)])
        {
            [self.delegate albumPicker:self didSelectPhotos:@[url]];
        }
        pickerHolder=nil;
    }
    else
    {//图片类型
        UIImage *image=info[UIImagePickerControllerOriginalImage];
        if(self.delegate &&
           [self.delegate respondsToSelector:@selector(albumPicker:didSelectPhotos:)])
        {
            [self.delegate albumPicker:self didSelectPhotos:@[image]];
        }
        pickerHolder=nil;
    }
}




#pragma mark - DKAlbumQuickViewDelegate
- (void)albumQuickView:(DKAlbumQuickView *)quickView didCheckAssets:(NSArray<ALAsset *> *)assets
{
    self.quickAssetArray=assets;
    
    
    static NSString *previousName=nil;
    if(self.quickAssetArray.count>0)
    {
        if(previousName==nil)
        {
            previousName=[self.actionSheet buttonTitleAtIndex:self.actionSheet.buttonCount-1];
        }
        [self.actionSheet setButtonTitle:[NSString stringWithFormat:@"确定(%ld)",self.quickAssetArray.count]
                                 atIndex:self.actionSheet.buttonCount-1];
    }
    else
    {
        if(previousName)
        {
            [self.actionSheet setButtonTitle:previousName
                                     atIndex:self.actionSheet.buttonCount-1];
        }
    }
}






#pragma mark - Action
- (void)cameraEnableForPhoto
{
    UIImagePickerController* picker=[[UIImagePickerController alloc] init];
    picker.sourceType=UIImagePickerControllerSourceTypeCamera;
    picker.delegate=self;
    picker.allowsEditing=NO;
    [self.sourceController presentViewController:picker animated:YES completion:nil];
}

- (void)cameraEnableForVideo
{
    UIImagePickerController* picker=[[UIImagePickerController alloc] init];
    picker.delegate=self;
    picker.allowsEditing=YES;
    picker.sourceType=UIImagePickerControllerSourceTypeCamera;
    picker.mediaTypes=@[(NSString*)kUTTypeMovie];
    picker.videoQuality=UIImagePickerControllerQualityTypeMedium;
    picker.videoMaximumDuration=kConstViedoTimeLimit;
    
    [self.sourceController presentViewController:picker animated:YES completion:nil];
}

-(void)cameraDisabled
{
    UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"提示"
                                                  message:@"请在设备的“设置－隐私－相机“中允许访问相机"
                                                 delegate:nil
                                        cancelButtonTitle:@"确认"
                                        otherButtonTitles:nil];
    [alert show];
}



- (void)showActionSheet
{
    DKAlbumQuickView *quickView=[[DKAlbumQuickView alloc] init];
    quickView.delegate=self;
    
    switch (self.pickerType)
    {
        case DKAlbumPickerTypePhoto:
        {
            self.actionSheet=[[DKActionSheet alloc] initWithCancelButtonTitle:@"取消"
                                                       destructiveButtonTitle:nil
                                                            otherButtonTitles:@"拍照片",@"从手机相册选择", nil];
            self.actionSheet.delegate=self;
            quickView.mediaType=DKAlbumQuickMediaTypePhoto;
            if(self.pickerType==DKAlbumPickerTypePhoto)
            {
                quickView.photoLimit=self.fileLimit;
            }
            else
            {
                quickView.photoLimit=1;
            }
            break;
        }
        case DKAlbumPickerTypeVideo:
        {
            self.actionSheet=[[DKActionSheet alloc] initWithCancelButtonTitle:@"取消"
                                                       destructiveButtonTitle:nil
                                                            otherButtonTitles:@"拍视频",@"从手机相册选择", nil];
            self.actionSheet.delegate=self;
            quickView.mediaType=DKAlbumQuickMediaTypeVideo;
            quickView.videoLimit=self.videoLimit;
            break;
        }
        case DKAlbumPickerTypeBoth:
        {
            self.actionSheet=[[DKActionSheet alloc] initWithCancelButtonTitle:@"取消"
                                                       destructiveButtonTitle:nil
                                                            otherButtonTitles:@"拍照片",@"拍视频",@"从手机相册选择", nil];
            self.actionSheet.delegate=self;
            quickView.mediaType=DKAlbumQuickMediaTypeBoth;
            quickView.totalLimit=self.fileLimit;
            break;
        }
        default:
            break;
    }
    self.actionSheet.customHeaderView=quickView;
    [quickView reloadData];
    self.actionSheet.customHeaderHeight=200;
    
    self.actionSheet.view.tag=-1;
    [self.actionSheet show];
}

- (void)presentToLibrary
{
    CTAssetsPickerController* picker=nil;
    switch (self.pickerType)
    {
        case DKAlbumPickerTypePhoto:
        {
            picker=[[CTAssetsPickerController alloc] init];
            picker.delegate=self;
            picker.assetsFilter=[ALAssetsFilter allPhotos];
            break;
        }
        case DKAlbumPickerTypeVideo:
        {
            picker=[[CTAssetsPickerController alloc] init];
            picker.delegate=self;
            picker.assetsFilter=[ALAssetsFilter allVideos];
            break;
        }
        case DKAlbumPickerTypeBoth:
        {
            picker=[[CTAssetsPickerController alloc] init];
            picker.delegate=self;
            break;
        }
        default:
            break;
    }
    
    if(picker)
    {
        [self.sourceController presentViewController:picker
                                            animated:YES
                                          completion:nil];
    }
}


+ (void)fetchCameraAuthorityWithCompletion:(void (^)(BOOL succeed))completion
{
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo
                             completionHandler:^(BOOL granted) {
                                 dispatch_async(dispatch_get_main_queue(), ^{
                                     if(completion)
                                     {
                                         completion(granted);
                                     }
                                 });
                             }];
}



#pragma mark - API
+ (DKAlbumPicker *)showPickerWithMediaType:(DKAlbumPickerType)pickerType
                                 fileLimit:(int)fileLimit
                                videoLimit:(int)videoLimit
                                  delegate:(id<DKAlbumPickerDelegate>)delegate
                          sourceController:(UIViewController *)sourceController
{
    DKAlbumPicker *picker=[[DKAlbumPicker alloc] init];
    picker.pickerType=pickerType;
    picker.fileLimit=fileLimit;
    picker.videoLimit=videoLimit;
    picker.delegate=delegate;
    picker.sourceController=sourceController;
    
    [picker showActionSheet];
    
    pickerHolder=picker;
    return picker;
}

+ (DKAlbumPicker *)presentPickerForLibraryWithMediaType:(DKAlbumPickerType)pickerType
                                              fileLimit:(int)fileLimit videoLimit:(int)videoLimit
                                               delegate:(id<DKAlbumPickerDelegate>)delegate
                                       sourceController:(UIViewController *)sourceController
{
    DKAlbumPicker *picker=[[DKAlbumPicker alloc] init];
    picker.pickerType=pickerType;
    picker.fileLimit=fileLimit;
    picker.videoLimit=videoLimit;
    picker.delegate=delegate;
    picker.sourceController=sourceController;
    
    [picker presentToLibrary];
    
    pickerHolder=picker;
    return picker;
}

+ (DKAlbumPicker *)presentPickerForCameraWithMediaType:(DKAlbumPickerType)pickerType
                                              delegate:(id <DKAlbumPickerDelegate>)delegate
                                      sourceController:(UIViewController *)sourceController
{
    DKAlbumPicker *picker=[[DKAlbumPicker alloc] init];
    picker.pickerType=pickerType;
    picker.fileLimit=1;
    picker.videoLimit=-1;
    picker.delegate=delegate;
    picker.sourceController=sourceController;
    
    [DKAlbumPicker fetchCameraAuthorityWithCompletion:^(BOOL succeed) {
        if(succeed)
        {
            [picker cameraEnableForPhoto];
        }
        else
        {
            [picker cameraDisabled];
        }
    }];
    
    pickerHolder=picker;
    return picker;
}

@end
