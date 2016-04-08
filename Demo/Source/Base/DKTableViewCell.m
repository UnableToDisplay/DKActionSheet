//
//  DKTableViewCell.m
//  HUB
//
//  Created by 许建勇 on 15/7/16.
//  Copyright (c) 2015年 许建勇. All rights reserved.
//

#import "DKTableViewCell.h"
@interface DKTableViewCell()
/**记录上一次frame的形状*/
@property CGRect previousFrame;
@end

@implementation DKTableViewCell

#pragma mark - 重写父类方法
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
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


#pragma mark- set方法
-(void)setInfo:(NSMutableDictionary *)info
{
    _info=info;
    [self refreshValue];
}





#pragma mark - 扩展方法
/**初始化UI界面*/
-(void)initUI
{
    
}

/**初始化数值参数*/
-(void)initParameter
{
    
}

/**页面布局调整*/
-(void)refreshLayout:(CGRect)frame
{
    
}

/**刷新内容显示*/
-(void)refreshValue
{
    
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    NSString *reuseIdentifier=NSStringFromClass(self);
    return [self cellWithReuseIdentifer:reuseIdentifier
                              initBlock:nil
                              tableView:tableView];
}

+ (instancetype)cellForSelectionStyleNoneWithTableView:(UITableView *)tableView
{
    NSString *reuseIdentifier=NSStringFromClass(self);
    return [self cellWithReuseIdentifer:reuseIdentifier
                              initBlock:^(UITableViewCell *cell) {
                                  cell.selectionStyle=UITableViewCellSelectionStyleNone;
                              }
                              tableView:tableView];
}


+ (instancetype)cellWithReuseIdentifer:(NSString *)reuseIdentifier
                             initBlock:(void(^)(UITableViewCell *cell))initBlock
                             tableView:(UITableView *)tableView;
{
    DKTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if(!cell)
    {
        cell=[[self alloc] initWithStyle:UITableViewCellStyleDefault
                         reuseIdentifier:reuseIdentifier];
        if(initBlock)
        {
            initBlock(cell);
        }
    }
    return cell;
}

@end
