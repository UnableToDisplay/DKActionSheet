//
//  DKActionSheet.h
//  xiaoquan
//
//  Created by Alex on 16/4/7.
//  Copyright © 2016年 Alex. All rights reserved.
//

#import "DKViewController.h"

@class DKActionSheet;
@protocol DKActionSheetDelegate <NSObject>
@optional
- (void)actionSheet:(DKActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex;
- (void)actionSheet:(DKActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex;

@end

typedef void(^DKActionSheetWillDismissBlock)(DKActionSheet *actionSheet, NSInteger buttonIndex);

typedef void(^DKActionSheetDidDismissBlock)(DKActionSheet *actionSheet, NSInteger buttonIndex);




@interface DKActionSheet : DKViewController

/**
 *  是否允许点击背景关闭
 */
@property (nonatomic,assign) BOOL enableDismssWhenTapBackground;

/**
 *  是否可见
 */
@property (nonatomic,assign,readonly) BOOL isVisible;


#pragma mark - Header
/**
 *  自定义头部View
 */
@property (nonatomic,strong) UIView *customHeaderView;

/**
 *  自定义头部view高度
 */
@property (nonatomic,assign) CGFloat customHeaderHeight;



#pragma mark - Event
/**
 *  委托
 */
@property (nonatomic,weak) id <DKActionSheetDelegate> delegate;

/**
 *  动画前的回调
 */
@property (nonatomic,copy) DKActionSheetWillDismissBlock willlDismissBlock;

/**
 *  动画后的回调
 */
@property (nonatomic,copy) DKActionSheetDidDismissBlock didDismissBlock;







#pragma mark - API
- (instancetype)initWithCancelButtonTitle:(NSString *)cancelButtonTitle
                   destructiveButtonTitle:(NSString *)destructiveButtonTitle
                        otherButtonTitles:(NSString *)otherButtonTitles,...NS_REQUIRES_NIL_TERMINATION;

- (void)show;

/**
 *  增加按钮
 *
 *  @param buttonTitles 按钮名称
 */
- (void)addButtonWithButtonTitles:(NSArray <NSString *> *)buttonTitles;

/**
 *  获取指定位置的Button文字
 *
 *  @param index 位置
 *
 *  @return 文字
 */
- (NSString *)buttonTitleAtIndex:(NSInteger)index;

/**
 *  更改指定位置Button的文字
 *
 *  @param buttonTitle 更改后的文字
 *  @param index       位置
 */
- (void)setButtonTitle:(NSString *)buttonTitle atIndex:(NSInteger)index;

/**
 *  Button数量
 *
 *  @return 数量
 */
- (NSInteger)buttonCount;

@end
