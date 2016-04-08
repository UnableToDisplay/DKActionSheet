//
//  DKModelBase.m
//  xiaoquan
//
//  Created by Alex on 16/3/28.
//  Copyright © 2016年 Alex. All rights reserved.
//

#import "DKModelBase.h"
#import "MJExtension.h"

@implementation DKModelBase

+ (instancetype)modelWithDictionary:(NSDictionary *)dict
{
    if([dict isKindOfClass:[NSDictionary class]])
    {
        DKModelBase *model=[[self alloc] init];
        [model mj_setKeyValues:dict];
        return model;
    }
    else
    {
        return nil;
    }
}

@end
