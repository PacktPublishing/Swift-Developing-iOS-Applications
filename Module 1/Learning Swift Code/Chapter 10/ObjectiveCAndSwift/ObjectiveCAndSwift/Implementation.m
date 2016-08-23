//
//  Implementation.m
//  ObjectiveCAndSwift
//
//  Created by Andrew Wagner on 12/26/15.
//  Copyright © 2015 Andrew Wagner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Header.h"

NSArray *addInviteeToListIfSpotAvailable
    (
    NSArray *invitees,
    NSString *newInvitee
    )
{
    if (invitees.count >= 20) {
        return invitees;
    }
    NSMutableArray *copy = [invitees mutableCopy];
    [copy addObject:newInvitee];
    return copy;
}

@implementation Contact

- (NSArray *)addToInviteeList:(NSArray *)invitees includeLastName:(BOOL)include
{
    if (invitees.count >= 20) {
        return invitees;
    }
    NSMutableArray *copy = [invitees mutableCopy];
    if (include) {
        [copy addObject:[self.firstName stringByAppendingFormat:@" %@", self.lastName]];
    } else {
        [copy addObject:self.firstName];
    }
    return copy;
}

- (NSArray * __nonnull)addToInviteeList:(NSArray * __nullable)invitees
{
    if (!invitees) {
        invitees = [NSArray array];
    }
    return [self addToInviteeList:invitees includeLastName:false];
}

- (NSArray<NSString *> * __nonnull)addStringToInviteeList:(NSArray<NSString *> * __nullable)invitees
{
    return [self addToInviteeList:invitees];
}


@end