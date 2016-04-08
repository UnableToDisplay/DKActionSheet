//
//  DKLabel.h
//  xiaoquan
//
//  Created by 许建勇 on 15/7/22.
//  Copyright (c) 2015年 Alex. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DKTextField : UITextField

#pragma mark - 扩展方法
/**初始化UI界面*/
-(void)initUI;

/**初始化数值参数*/
-(void)initParameter;

/**页面布局调整*/
-(void)refreshLayout:(CGRect)frame;

@end
