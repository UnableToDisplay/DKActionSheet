//
//  DKActionSheet.m
//  xiaoquan
//
//  Created by Alex on 16/4/7.
//  Copyright © 2016年 Alex. All rights reserved.
//

#import "DKActionSheet.h"
#import "DKActionSheetCell.h"

@interface DKActionSheet()<UITableViewDelegate,UITableViewDataSource>
#pragma mark UI
@property (nonatomic,strong) UIWindow *alertWindow;

@property (nonatomic,strong) UITableView *buttonTableView;

#pragma mark Parameter
@property (nonatomic,strong) NSMutableArray <NSString *> *argumentArray;

@property (nonatomic,copy) NSString *cancelButtonTitle;

@property (nonatomic,copy) NSString *destructiveButtonTitle;

@end


@implementation DKActionSheet
#pragma mark - Getter
- (UIWindow *)alertWindow
{
    if(_alertWindow==nil)
    {
        _alertWindow=[[UIWindow alloc] init];
        [_alertWindow setBackgroundColor:[UIColor clearColor]];
        _alertWindow.windowLevel=UIWindowLevelAlert;
    }
    return _alertWindow;
}


- (UITableView *)buttonTableView
{
    if(_buttonTableView==nil)
    {
        _buttonTableView=[[UITableView alloc] init];
        [_buttonTableView setDelegate:self];
        [_buttonTableView setDataSource:self];
        [_buttonTableView setTableFooterView:[UIView new]];
        [_buttonTableView setRowHeight:45];
        [_buttonTableView setBackgroundColor:[UIColor clearColor]];
        [_buttonTableView setBounces:NO];
        [_buttonTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [self.view addSubview:_buttonTableView];
    }
    return _buttonTableView;
}

#pragma mark - Setter
- (void)setCustomHeaderView:(UIView *)customHeaderView
{
    [_customHeaderView removeFromSuperview];
    
    _customHeaderView=customHeaderView;
    [self.view addSubview:customHeaderView];
}

#pragma mark - Init
- (void)initParameter
{
    self.enableDismssWhenTapBackground=YES;
    _isVisible=NO;
}

- (void)initUI
{
    [self.view setBackgroundColor:[UIColor whiteColor]];
}


#pragma mark - Layout
- (void)refreshLayout:(CGRect)frame
{
    CGFloat tableHeight=self.argumentArray.count*self.buttonTableView.rowHeight;
    if(self.destructiveButtonTitle)
    {
        tableHeight+=self.buttonTableView.rowHeight;
    }
    if(self.cancelButtonTitle)
    {
        tableHeight+=self.buttonTableView.rowHeight+5;
    }
    tableHeight=MIN(tableHeight, [UIScreen mainScreen].bounds.size.height*0.8);
    
    if(self.customHeaderView && self.customHeaderHeight>0)
    {
        self.customHeaderView.frame=CGRectMake(0,
                                               [UIScreen mainScreen].bounds.size.height-self.customHeaderHeight-tableHeight,
                                               [UIScreen mainScreen].bounds.size.width,
                                               self.customHeaderHeight);
        self.buttonTableView.frame=CGRectMake(0,
                                              [UIScreen mainScreen].bounds.size.height-tableHeight,
                                              [UIScreen mainScreen].bounds.size.width,
                                              tableHeight);
    }
    else
    {
        self.buttonTableView.frame=CGRectMake(0,
                                              [UIScreen mainScreen].bounds.size.height-tableHeight,
                                              [UIScreen mainScreen].bounds.size.width,
                                              tableHeight);
    }
}



#pragma mark - Super
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    if(self.enableDismssWhenTapBackground && self.cancelButtonTitle)
    {
        [self dismissWithButtonIndex:0];
    }
}

- (void)dealloc
{
    NSLog(@"dealloc!!!!");
}



#pragma mark - UITableViewDelegate+DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section==0)
    {
        if(self.destructiveButtonTitle)
        {
            return 1;
        }
        else
        {
            return 0;
        }
    }
    else if(section==1)
    {
        return self.argumentArray.count;
    }
    else
    {
        if(self.cancelButtonTitle)
        {
            return 1;
        }
        else
        {
            return 0;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section==2 && self.cancelButtonTitle)
    {
        return 5;
    }
    else
    {
        return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section==2 && self.cancelButtonTitle)
    {
        UIView *headView=[[UIView alloc] init];
        [headView setBackgroundColor:[UIColor colorWithRed:240/255.0
                                                     green:240/255.0
                                                      blue:240/255.0
                                                     alpha:1.0]];
        return headView;
    }
    else
    {
        return nil;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0)
    {
        DKActionSheetCell *cell=[DKActionSheetCell cellWithTableView:tableView];
        [cell setTitle:self.destructiveButtonTitle];
        if(self.argumentArray.count>0)
        {
            [cell setHidenSplit:NO];
        }
        else
        {
            [cell setHidenSplit:YES];
        }
        [cell setTitleColor:[UIColor colorWithRed:239/255.0
                                            green:102/255.0
                                             blue:70/255.0
                                            alpha:1.0]];
        return cell;
    }
    else if(indexPath.section==1)
    {
        DKActionSheetCell *cell=[DKActionSheetCell cellWithTableView:tableView];
        [cell setTitle:self.argumentArray[indexPath.row]];
        if(indexPath.row+1==self.argumentArray.count)
        {
            [cell setHidenSplit:YES];
        }
        else
        {
            [cell setHidenSplit:NO];
        }
        [cell setTitleColor:[UIColor colorWithRed:51/255.0
                                            green:51/255.0
                                             blue:51/255.0
                                            alpha:1.0]];
        return cell;
    }
    else
    {
        DKActionSheetCell *cell=[DKActionSheetCell cellWithTableView:tableView];
        [cell setTitle:self.cancelButtonTitle];
        [cell setHidenSplit:YES];
        [cell setTitleColor:[UIColor colorWithRed:51/255.0
                                            green:51/255.0
                                             blue:51/255.0
                                            alpha:1.0]];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSInteger buttonIndex=0;
    if(indexPath.section==0)
    {
        buttonIndex=self.argumentArray.count;
        if(self.cancelButtonTitle)
        {
            buttonIndex++;
        }
    }
    else if(indexPath.section==1)
    {
        buttonIndex=self.argumentArray.count-indexPath.row-1;
        if(self.cancelButtonTitle)
        {
            buttonIndex++;
        }
    }
    else if(indexPath.section==2)
    {
        buttonIndex=0;
    }
    [self dismissWithButtonIndex:buttonIndex];
}






#pragma mark - Action
- (void)dismissWithButtonIndex:(NSInteger)buttonIndex;
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(actionSheet:willDismissWithButtonIndex:)])
    {
        [self.delegate actionSheet:self willDismissWithButtonIndex:buttonIndex];
    }
    if(self.willlDismissBlock)
    {
        self.willlDismissBlock(self,buttonIndex);
    }
    
    [UIView animateWithDuration:0.2
                     animations:^{
                         self.view.backgroundColor=[UIColor clearColor];
                         if(self.customHeaderView && self.customHeaderHeight>0)
                         {
                             self.customHeaderView.frame=CGRectMake(self.customHeaderView.frame.origin.x,
                                                                    [UIScreen mainScreen].bounds.size.height,
                                                                    self.customHeaderView.frame.size.width,
                                                                    self.customHeaderView.frame.size.height);
                             self.buttonTableView.frame=CGRectMake(self.buttonTableView.frame.origin.x,
                                                                   [UIScreen mainScreen].bounds.size.height+self.customHeaderHeight,
                                                                   self.buttonTableView.frame.size.width,
                                                                   self.buttonTableView.frame.size.height);
                         }
                         else
                         {
                             self.buttonTableView.frame=CGRectMake(self.buttonTableView.frame.origin.x,
                                                                   [UIScreen mainScreen].bounds.size.height,
                                                                   self.buttonTableView.frame.size.width,
                                                                   self.buttonTableView.frame.size.height);
                         }
                     }
                     completion:^(BOOL finished) {
                         self.alertWindow.rootViewController=nil;
                         self.alertWindow.hidden=YES;
                         _isVisible=NO;
                         
                         if(self.delegate && [self.delegate respondsToSelector:@selector(actionSheet:didDismissWithButtonIndex:)])
                         {
                             [self.delegate actionSheet:self didDismissWithButtonIndex:buttonIndex];
                         }
                         if(self.didDismissBlock)
                         {
                             self.didDismissBlock(self,buttonIndex);
                         }
                     }];
}



#pragma mark - API
- (instancetype)initWithCancelButtonTitle:(NSString *)cancelButtonTitle
                   destructiveButtonTitle:(NSString *)destructiveButtonTitle
                        otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    DKActionSheet *sheet=[super init];
    if(sheet)
    {
        sheet.cancelButtonTitle=cancelButtonTitle;
        sheet.destructiveButtonTitle=destructiveButtonTitle;
        
        NSMutableArray *argumentArray=[[NSMutableArray alloc] init];
        if(otherButtonTitles)
        {
            [argumentArray addObject:otherButtonTitles];
            
            va_list argumentList;
            va_start(argumentList,otherButtonTitles);
            id eachObject;
            while((eachObject=va_arg(argumentList, id)))
            {
                [argumentArray addObject:eachObject];
            }
            va_end(argumentList);  
        }
        sheet.argumentArray=argumentArray;
    }
    
    return sheet;
}

- (void)show
{
    self.alertWindow.hidden=NO;
    self.alertWindow.frame=[UIScreen mainScreen].bounds;
    
    self.alertWindow.rootViewController=self;
    [self.view setBackgroundColor:[UIColor clearColor]];
    
    CGFloat tableHeight=self.argumentArray.count*self.buttonTableView.rowHeight;
    if(self.destructiveButtonTitle)
    {
        tableHeight+=self.buttonTableView.rowHeight;
    }
    if(self.cancelButtonTitle)
    {
        tableHeight+=self.buttonTableView.rowHeight+5;
    }
    tableHeight=MIN(tableHeight, [UIScreen mainScreen].bounds.size.height*0.8);
    if(self.customHeaderView && self.customHeaderHeight>0)
    {
        self.customHeaderView.frame=CGRectMake(0,
                                               [UIScreen mainScreen].bounds.size.height,
                                               [UIScreen mainScreen].bounds.size.width,
                                               self.customHeaderHeight);
        self.buttonTableView.frame=CGRectMake(0,
                                              [UIScreen mainScreen].bounds.size.height+self.customHeaderHeight,
                                              [UIScreen mainScreen].bounds.size.width,
                                              tableHeight);
    }
    else
    {
        self.buttonTableView.frame=CGRectMake(0,
                                              [UIScreen mainScreen].bounds.size.height+tableHeight,
                                              [UIScreen mainScreen].bounds.size.width,
                                              tableHeight);
    }
    
    [UIView animateWithDuration:0.2
                     animations:^{
                         self.view.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.4];
                         if(self.customHeaderView && self.customHeaderHeight>0)
                         {
                             self.customHeaderView.frame=CGRectMake(self.customHeaderView.frame.origin.x,
                                                                    [UIScreen mainScreen].bounds.size.height-self.customHeaderView.frame.size.height-self.buttonTableView.frame.size.height,
                                                                    self.customHeaderView.frame.size.width,
                                                                    self.customHeaderView.frame.size.height);
                             self.buttonTableView.frame=CGRectMake(self.buttonTableView.frame.origin.x,
                                                                   [UIScreen mainScreen].bounds.size.height-self.buttonTableView.frame.size.height,
                                                                   self.buttonTableView.frame.size.width,
                                                                   self.buttonTableView.frame.size.height);
                         }
                         else
                         {
                             self.buttonTableView.frame=CGRectMake(self.buttonTableView.frame.origin.x,
                                                                   [UIScreen mainScreen].bounds.size.height-self.buttonTableView.frame.size.height,
                                                                   self.buttonTableView.frame.size.width,
                                                                   self.buttonTableView.frame.size.height);
                         }
                     }
                     completion:^(BOOL finished) {
                         _isVisible=YES;
                     }];
    
}


- (void)addButtonWithButtonTitles:(NSArray <NSString *> *)buttonTitles
{
    [self.argumentArray addObjectsFromArray:buttonTitles];
    if(self.isVisible)
    {
        CGFloat tableHeight=self.argumentArray.count*self.buttonTableView.rowHeight;
        if(self.destructiveButtonTitle)
        {
            tableHeight+=self.buttonTableView.rowHeight;
        }
        if(self.cancelButtonTitle)
        {
            tableHeight+=self.buttonTableView.rowHeight+5;
        }
        tableHeight=MIN(tableHeight, [UIScreen mainScreen].bounds.size.height*0.8);
        if(self.customHeaderView && self.customHeaderHeight>0)
        {
            self.customHeaderView.frame=CGRectMake(0,
                                                   [UIScreen mainScreen].bounds.size.height-tableHeight-self.customHeaderHeight,
                                                   [UIScreen mainScreen].bounds.size.width,
                                                   self.customHeaderHeight);
            self.buttonTableView.frame=CGRectMake(0,
                                                  [UIScreen mainScreen].bounds.size.height-tableHeight,
                                                  [UIScreen mainScreen].bounds.size.width,
                                                  tableHeight);
        }
        else
        {
            self.buttonTableView.frame=CGRectMake(0,
                                                  [UIScreen mainScreen].bounds.size.height-tableHeight,
                                                  [UIScreen mainScreen].bounds.size.width,
                                                  tableHeight);
        }
    }
}


- (NSString *)buttonTitleAtIndex:(NSInteger)index
{
    NSMutableArray *titleArray=[NSMutableArray arrayWithArray:[[self.argumentArray reverseObjectEnumerator] allObjects]];
    if(self.cancelButtonTitle)
    {
        [titleArray insertObject:self.cancelButtonTitle atIndex:0];
    }
    if(self.destructiveButtonTitle)
    {
        [titleArray addObject:self.destructiveButtonTitle];
    }
    if(index<titleArray.count && index>=0)
    {
        return titleArray[index];
    }
    else
    {
        return nil;
    }
}


- (void)setButtonTitle:(NSString *)buttonTitle atIndex:(NSInteger)index
{
    if(self.cancelButtonTitle)
    {
        if(index==0)
        {
            self.cancelButtonTitle=buttonTitle;
            [self.buttonTableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
            return;
        }
        else
        {
            index--;
        }
    }
    
    
    if(index>=0 && index<self.argumentArray.count)
    {
        [self.argumentArray replaceObjectAtIndex:self.argumentArray.count-index-1
                                      withObject:buttonTitle];
        [self.buttonTableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
        return;
    }
    else
    {
        index-=self.argumentArray.count;
    }
    
    if(index==0 && self.destructiveButtonTitle)
    {
        self.destructiveButtonTitle=buttonTitle;
        [self.buttonTableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationNone];
        return;
    }
}

- (NSInteger)buttonCount
{
    NSInteger buttonCount=self.argumentArray.count;
    if(self.cancelButtonTitle)
    {
        buttonCount++;
    }
    if(self.destructiveButtonTitle)
    {
        buttonCount++;
    }
    return buttonCount;
}

@end
