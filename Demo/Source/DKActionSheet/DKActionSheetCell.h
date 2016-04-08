//
//  DKActionSheetCell.h
//  xiaoquan
//
//  Created by Alex on 16/4/7.
//  Copyright © 2016年 Alex. All rights reserved.
//

#import "DKTableViewCell.h"

@interface DKActionSheetCell : DKTableViewCell

@property (nonatomic,copy) NSString *title;

@property (nonatomic,strong) UIColor *titleColor;

@property (nonatomic,assign) BOOL hidenSplit;

@end
