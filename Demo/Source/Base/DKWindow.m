//
//  DKWindow.m
//  xiaoquan
//
//  Created by 许建勇 on 15/9/23.
//  Copyright © 2015年 Alex. All rights reserved.
//

#import "DKWindow.h"

@interface DKWindow()
/**记录上一次frame的形状*/
@property CGRect previousFrame;
@end

@implementation DKWindow

#pragma mark - 初始化操作
-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if(self)
    {
        [self custonInit];
    }
    return self;
}


//自定义的初始化内容
-(void)custonInit
{
    
    //数值初始化
    _previousFrame=CGRectZero;
    
    [self initParameter];
    [self initUI];
}





#pragma mark - 重写父类的方法
-(void)layoutSubviews
{
    [super layoutSubviews];
    if(self.frame.size.width==_previousFrame.size.width
       && self.frame.size.height==_previousFrame.size.height)
    {//形状相同，则不通知刷新布局
        
    }
    else
    {//形状不同，通知刷新布局，且记录新布局
        _previousFrame=self.frame;
        [self refreshLayout:_previousFrame];
    }
}



#pragma mark - getter
-(NSMutableDictionary*)info
{
    if(_info==nil)
    {
        _info=[[NSMutableDictionary alloc] init];
    }
    return _info;
}



#pragma mark - 扩展方法
/**传参初始化*/
- (instancetype)initWithMutableInfo:(NSMutableDictionary*)info
{
    self=[super init];
    if(self)
    {
        _info=info;
    }
    return self;
}

/**传参初始化*/
- (instancetype)initWithInfo:(NSDictionary*)info
{
    self=[super init];
    if(self)
    {
        _info=[NSMutableDictionary dictionaryWithDictionary:info];
    }
    return self;
}

/**初始化UI界面*/
- (void)initUI
{
    
}

/**初始化数值参数*/
- (void)initParameter
{
    
}

/**页面布局调整*/
- (void)refreshLayout:(CGRect)frame
{
    
}
@end
