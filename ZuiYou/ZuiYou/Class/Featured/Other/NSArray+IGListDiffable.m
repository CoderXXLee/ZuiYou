//
//  NSArray+IGListDiffable.m
//  ZuiYou
//
//  Created by mac on 2018/3/5.
//  Copyright © 2018年 le. All rights reserved.
//

#import "NSArray+IGListDiffable.h"

@implementation NSArray (IGListDiffable)

- (id<NSObject>)diffIdentifier {
    return self;
}

- (BOOL)isEqualToDiffableObject:(id)object {
    // since the diff identifier returns self, object should only be compared with same instance
    return self == object;
}

@end
