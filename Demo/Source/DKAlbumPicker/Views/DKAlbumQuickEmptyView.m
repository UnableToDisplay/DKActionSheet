//
//  DKAlbumQuickEmptyView.m
//  xiaoquan
//
//  Created by Alex on 16/4/8.
//  Copyright © 2016年 Alex. All rights reserved.
//

#import "DKAlbumQuickEmptyView.h"

@interface DKAlbumQuickEmptyView()

@property (nonatomic,strong) UILabel *emptyLabel;

@end

@implementation DKAlbumQuickEmptyView
#pragma mark - Getter
- (UILabel *)emptyLabel
{
    if(_emptyLabel==nil)
    {
        _emptyLabel=[[UILabel alloc] init];
        [_emptyLabel setFont:[UIFont systemFontOfSize:14.0f]];
        [_emptyLabel setTextColor:[UIColor colorWithRed:153/255.0
                                                  green:153/255.0
                                                   blue:153/255.0
                                                  alpha:1.0]];
        [_emptyLabel setNumberOfLines:0];
        [_emptyLabel setText:@"请在设备的“设置－隐私－照片“中允许访问照片"];
        [_emptyLabel setTextAlignment:NSTextAlignmentCenter];
        [_emptyLabel setUserInteractionEnabled:YES];
        [_emptyLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickEmpty)]];
        [self addSubview:_emptyLabel];
    }
    return _emptyLabel;
}



#pragma mark - Layout
- (void)refreshLayout:(CGRect)frame
{
    self.emptyLabel.frame=CGRectMake(0,
                                     0,
                                     frame.size.width,
                                     frame.size.height);
}

#pragma mark - Action
- (void)clickEmpty
{
}

@end
