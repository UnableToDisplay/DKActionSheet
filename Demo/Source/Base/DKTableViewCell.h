//
//  DKTableViewCell.h
//  HUB
//
//  Created by 许建勇 on 15/7/16.
//  Copyright (c) 2015年 许建勇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DKTableViewCell : UITableViewCell
#pragma mark - 扩展参数
/**上一级传参*/
@property (nonatomic)NSMutableDictionary* info;


#pragma mark - ForExtend
-(void)initUI;

-(void)initParameter;

-(void)refreshLayout:(CGRect)frame;

-(void)refreshValue;



#pragma mark - API
+ (instancetype)cellWithTableView:(UITableView *)tableView;

+ (instancetype)cellForSelectionStyleNoneWithTableView:(UITableView *)tableView;

+ (instancetype)cellWithReuseIdentifer:(NSString *)reuseIdentifier
                             initBlock:(void(^)(UITableViewCell *cell))initBlock
                             tableView:(UITableView *)tableView;

@end
