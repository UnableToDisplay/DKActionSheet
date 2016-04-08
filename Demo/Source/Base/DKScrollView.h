//
//  DKScrollView.h
//  HUB
//
//  Created by 许建勇 on 15/7/18.
//  Copyright (c) 2015年 许建勇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DKScrollView : UIScrollView
/**
 *  初始化UI界面
 */
- (void)initUI;

/**
 *  初始化数值参数
 */
- (void)initParameter;

/**
 *  页面布局调整
 *
 *  @param frame 尺寸
 */
- (void)refreshLayout:(CGRect)frame;

@end
