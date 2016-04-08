//
//  小圈
//
//  Created by 许建勇 on 15/7/16.
//  Copyright (c) 2015年 HUB-ALEX. All rights reserved.
//

#import "DKViewController.h"

@interface DKViewController()
/**
 *  记录上一次frame的形状
 */
@property (nonatomic,assign) CGRect previousFrame;

@end

@implementation DKViewController

#pragma mark - Init
-(instancetype)init
{
    self=[super init];
    if(self)
    {
        
    }
    return self;
}


#pragma mark - Getter
- (NSMutableDictionary *)info
{
    if(_info==nil)
    {
        _info=[[NSMutableDictionary alloc] init];
    }
    return _info;
}




#pragma mark - Super
/**
 *  页面布局改变
 */
-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    [self checkLayout];
}

/**
 *  添加通知+监听
 *
 *  @param animated 系统参数
 */
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardAppear:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDisappear)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [self keyboardDisappear];
}



-(void)viewDidLoad
{
    [super viewDidLoad];

    //设定背景色
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    //数值初始化
    _previousFrame=CGRectZero;
    _keyboardHeight=0;
    
    //初始化参数+UI
    [self initParameter];
    [self initUI];
    //服务器加载数据
    [self initData];
}



#pragma mark - Action
/**
 *  检查布局是否需要改变
 */
-(void)checkLayout
{
    CGRect reviseFrame=self.view.frame;//修正的frame
    reviseFrame.size.height-=_keyboardHeight;
    if(_previousFrame.size.width == reviseFrame.size.width
       && _previousFrame.size.height == reviseFrame.size.height)
    {//形状相同，则不通知刷新布局
        
    }
    else
    {//形状不同，通知刷新布局，且记录新布局
        _previousFrame=reviseFrame;
        [self refreshLayout:_previousFrame];
    }
}

/**
 *  键盘弹起时触发
 *
 *  @param notification 通知
 */
-(void)keyboardAppear:(NSNotification*)notification
{
    CGRect keyboardBounds;
    [[notification.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardBounds];
    _keyboardHeight=keyboardBounds.size.height;
    [self checkLayout];
}

/**
 *  键盘收起时触发
 */
-(void)keyboardDisappear
{
    _keyboardHeight=0;
    [self checkLayout];
}








#pragma mark - 扩展方法

/**传参初始化*/
-(instancetype)initWithMutableInfo:(NSMutableDictionary*)info
{
    self=[super init];
    if(self)
    {
        _info=info;
    }
    return self;
}

/**传参初始化*/
-(instancetype)initWithInfo:(NSDictionary*)info
{
    self=[super init];
    if(self)
    {
        _info=[NSMutableDictionary dictionaryWithDictionary:info];
    }
    return self;
}

- (void)refreshLayout
{
    CGRect reviseFrame=self.view.frame;//修正的frame
    reviseFrame.size.height-=_keyboardHeight;
    _previousFrame=reviseFrame;
    [self refreshLayout:_previousFrame];
}

/**初始化UI界面*/
-(void)initUI
{
    
}

/**初始化数值参数*/
-(void)initParameter
{
    
}

/**
 *  从服务器下载数据
 */
-(void)initData
{
    
}

/**页面布局调整*/
-(void)refreshLayout:(CGRect)frame
{
    
}


/**
 *  控制器销毁时调用
 */
- (void)vcDealloc
{
    
}
@end
