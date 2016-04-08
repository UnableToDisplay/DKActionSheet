//
//  DKViewController.h
//  小圈
//
//  Created by 许建勇 on 15/7/16.
//  Copyright (c) 2015年 HUB-ALEX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DKViewController : UIViewController
/**
 *  记录键盘弹出的高度
 */
@property (nonatomic,assign,readonly) CGFloat keyboardHeight;


#pragma mark - 扩展参数
/**
 *  上一级传参
 */
@property (nonatomic,strong) NSMutableDictionary *info;


#pragma mark - 扩展方法
/**
 *  传参初始化
 *
 *  @param info 参数
 *
 *  @return 实例
 */
-(instancetype)initWithMutableInfo:(NSMutableDictionary *)info;

/**
 *  传参初始化
 *
 *  @param info 参数
 *
 *  @return 实例
 */
-(instancetype)initWithInfo:(NSDictionary *)info;


/**
 *  重新刷新布局
 */
-(void)refreshLayout;



//-------------------------------------------------------
//继承专用
/**
 *  初始化UI界面
 */
-(void)initUI;

/**
 *  初始化数值参数
 */
-(void)initParameter;

/**
 *  从服务器下载数据
 */
-(void)initData;

/**
 *  页面布局调整(继承,不要直接调用)
 *
 *  @param frame 新frame
 */
-(void)refreshLayout:(CGRect)frame;

/**
 *  控制器销毁时调用(千万不要在此处移除KVO中的Observer，会造成crash，请直接继承dealloc)
 */
- (void)vcDealloc;

@end
