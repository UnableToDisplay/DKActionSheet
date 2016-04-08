//
//  DKView.h
//  HUB
//
//  Created by 许建勇 on 15/7/16.
//  Copyright (c) 2015年 许建勇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DKView : UIView
#pragma mark - 扩展参数
/**上一级传参*/
@property (nonatomic)NSMutableDictionary* info;


#pragma mark - 扩展方法
/**传参初始化*/
- (instancetype)initWithMutableInfo:(NSMutableDictionary*)info;

/**传参初始化*/
- (instancetype)initWithInfo:(NSDictionary*)info;

/**初始化UI界面*/
- (void)initUI;

/**初始化数值参数*/
- (void)initParameter;

/**页面布局调整*/
- (void)refreshLayout:(CGRect)frame;
@end
