//
//  DKCollectionViewCell.m
//  xiaoquan
//
//  Created by 许建勇 on 15/9/28.
//  Copyright © 2015年 Alex. All rights reserved.
//

#import "DKCollectionViewCell.h"

@interface DKCollectionViewCell()
/**
 *  记录上一次frame的形状
 */
@property (nonatomic,assign) CGRect previousFrame;

@end

@implementation DKCollectionViewCell
#pragma mark - Super
- (instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if(self)
    {
        [self custonInit];
    }
    return self;
}



#pragma mark - Action
//自定义的初始化内容
- (void)custonInit
{
    
    //数值初始化
    self.previousFrame=CGRectZero;
    
    [self initParameter];
    [self initUI];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if(self.frame.size.width==self.previousFrame.size.width &&
       self.frame.size.height==self.previousFrame.size.height)
    {//形状相同，则不通知刷新布局
        
    }
    else
    {//形状不同，通知刷新布局，且记录新布局
        self.previousFrame=self.frame;
        [self refreshLayout:self.previousFrame];
    }
}




#pragma mark - Extension
- (void)initUI
{
    
}

- (void)initParameter
{
    
}

- (void)refreshLayout:(CGRect)frame
{
    
}

- (void)refreshValue
{
    
}
@end
