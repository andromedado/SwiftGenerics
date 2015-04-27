//
//  Examples.m
//  SwiftGenerics
//
//  Created by Shad Downey on 4/27/15.
//  Copyright (c) 2015 com.shad.swiftGenerics. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HasEquivalent;

@protocol HasEquivalent <NSObject>

@required
- (BOOL) isEquivalent:(id<HasEquivalent>) other;

@end

@interface NSArray (Equivalence)

/**
 Does this array have an object that is an equivalent of the given object
 */
- (BOOL) containsEquivalent:(id<HasEquivalent>) object;

@end

@implementation NSArray (Equivalence)

- (BOOL) containsEquivalent:(id<HasEquivalent>) object
{
    __block BOOL containsEquivalent = NO;
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj conformsToProtocol:@protocol(HasEquivalent)]) {
            containsEquivalent = [obj isEquivalent:object];
            *stop = containsEquivalent;
        }
    }];
    return containsEquivalent;
}

@end
