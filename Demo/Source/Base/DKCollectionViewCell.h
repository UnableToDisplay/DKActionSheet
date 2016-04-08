//
//  DKCollectionViewCell.h
//  xiaoquan
//
//  Created by 许建勇 on 15/9/28.
//  Copyright © 2015年 Alex. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DKCollectionViewCell : UICollectionViewCell

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
 */
- (void)refreshLayout:(CGRect)frame;

@end
