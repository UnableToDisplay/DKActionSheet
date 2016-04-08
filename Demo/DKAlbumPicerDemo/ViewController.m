//
//  ViewController.m
//  DKAlbumPicerDemo
//
//  Created by Alex on 16/4/8.
//  Copyright © 2016年 Alex. All rights reserved.
//

#import "ViewController.h"
#import "DKActionSheet.h"
#import "DKAlbumPicker.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()<DKAlbumPickerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *showImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)clickActionSheet:(id)sender {
    DKActionSheet *sheet=[[DKActionSheet alloc] initWithCancelButtonTitle:@"取消"
                                                   destructiveButtonTitle:@"确定"
                                                        otherButtonTitles:@"按钮1",@"按钮2", nil];
    [sheet setDidDismissBlock:^(DKActionSheet *sheet, NSInteger buttonIdex)
     {
         NSLog(@"buttonIndex:%ld,buttonName:%@",buttonIdex,[sheet buttonTitleAtIndex:buttonIdex]);
     }];
    [sheet show];
}
- (IBAction)clickAlbumPicker:(id)sender {
    [DKAlbumPicker showPickerWithMediaType:DKAlbumPickerTypeBoth
                                 fileLimit:4
                                videoLimit:1
                                  delegate:self
                          sourceController:self];
}


#pragma mark - DKAlbumPickerDelegate
- (void)albumPicker:(DKAlbumPicker *)albumPicker didSelectPhotos:(NSArray *)photos
{
    id object=photos.firstObject;
    if([object isKindOfClass:[ALAsset class]])
    {//相册选择的图片／视频
        ALAsset *asset=(ALAsset *)object;
        self.showImageView.image=[UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
    }
    else if([object isKindOfClass:[UIImage class]])
    {//相机拍摄的图片
        self.showImageView.image=object;
    }
    else if([object isKindOfClass:[NSURL class]])
    {//相机拍摄的视频
        NSURL *videoURL=(NSURL *)object;
        
        AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
        AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
        gen.appliesPreferredTrackTransform = YES;
        CMTime time = CMTimeMakeWithSeconds(0, 600);
        NSError *error = nil;
        CMTime actualTime;
        CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
        UIImage *thumbImg = [[UIImage alloc] initWithCGImage:image];
        
        self.showImageView.image=thumbImg;
    }
}

- (void)albumPickerDidCancelSelect:(DKAlbumPicker *)albumPicker
{
    NSLog(@"取消选择");
}

@end
