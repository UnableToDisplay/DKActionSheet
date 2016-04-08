//
//  DKScrollView.m
//  HUB
//
//  Created by 许建勇 on 15/7/18.
//  Copyright (c) 2015年 许建勇. All rights reserved.
//

#import "DKScrollView.h"

@interface DKScrollView()<UIGestureRecognizerDelegate>
/**
 *  记录上一次frame的形状
 */
@property (nonatomic,assign) CGRect previousFrame;

@end

@implementation DKScrollView

#pragma mark - Super
- (instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if(self)
    {
        [self customInit];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if(self.frame.size.width==self.previousFrame.size.width &&
       self.frame.size.height==_previousFrame.size.height)
    {//形状相同，则不通知刷新布局
        
    }
    else
    {//形状不同，通知刷新布局，且记录新布局
        self.previousFrame=self.frame;
        [self refreshLayout:self.previousFrame];
    }
}


#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if([gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]])
    {
        if(gestureRecognizer.view==touch.view)
        {
            return YES;
        }
        else
        {
            return NO;
        }
    }
    
    return YES;
}


#pragma mark - Action
//自定义的初始化内容
- (void)customInit
{
    //数值初始化
    self.previousFrame=CGRectZero;
    
    UITapGestureRecognizer* singleTap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(receiveTouch)];
    singleTap.delegate=self;
    [self addGestureRecognizer:singleTap];
    
    [self initParameter];
    [self initUI];
}


//点击事件
- (void)receiveTouch
{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}


- (void)initUI
{
    
}

- (void)initParameter
{
    
}

- (void)refreshLayout:(CGRect)frame
{
    
}

@end
