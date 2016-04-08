//
//  DKWindow.h
//  xiaoquan
//
//  Created by 许建勇 on 15/9/23.
//  Copyright © 2015年 Alex. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DKWindow : UIWindow
#pragma mark - 扩展参数
/**上一级传参*/
@property (nonatomic)NSMutableDictionary* info;


#pragma mark - 扩展方法
/**传参初始化*/
-(instancetype)initWithMutableInfo:(NSMutableDictionary*)info;

/**传参初始化*/
-(instancetype)initWithInfo:(NSDictionary*)info;

/**初始化UI界面*/
-(void)initUI;

/**初始化数值参数*/
-(void)initParameter;

/**页面布局调整*/
-(void)refreshLayout:(CGRect)frame;
@end
