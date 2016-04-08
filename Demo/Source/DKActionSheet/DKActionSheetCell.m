//
//  DKActionSheetCell.m
//  xiaoquan
//
//  Created by Alex on 16/4/7.
//  Copyright © 2016年 Alex. All rights reserved.
//

#import "DKActionSheetCell.h"

@interface DKActionSheetCell()

@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic,strong) UIView *splitLine;

@end

@implementation DKActionSheetCell
#pragma mark - Getter
- (UILabel *)titleLabel
{
    if(_titleLabel==nil)
    {
        _titleLabel=[[UILabel alloc] init];
        [_titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
        [_titleLabel setTextColor:[UIColor colorWithRed:51/255.0
                                                  green:51/255.0
                                                   blue:51/255.0
                                                  alpha:1.0]];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UIView *)splitLine
{
    if(_splitLine==nil)
    {
        _splitLine=[[UIView alloc] init];
        [_splitLine setBackgroundColor:[UIColor colorWithRed:209/255.0
                                                       green:209/255.0
                                                        blue:209/255.0
                                                       alpha:1.0]];
        [self.contentView addSubview:_splitLine];
    }
    return _splitLine;
}


#pragma mark - Setter
- (void)setTitle:(NSString *)title
{
    _title=title;
    self.titleLabel.text=title;
}

- (void)setTitleColor:(UIColor *)titleColor
{
    _titleColor=titleColor;
    self.titleLabel.textColor=titleColor;
}

- (void)setHidenSplit:(BOOL)hidenSplit
{
    _hidenSplit=hidenSplit;
    self.splitLine.hidden=hidenSplit;
}


#pragma mark - Init
- (void)initUI
{
    [self setBackgroundColor:[UIColor whiteColor]];
}



#pragma mark - Layout
- (void)refreshLayout:(CGRect)frame
{
    self.titleLabel.frame=self.bounds;
    self.splitLine.frame=CGRectMake(0,
                                    frame.size.height-0.5,
                                    frame.size.width,
                                    0.5);
}

@end
