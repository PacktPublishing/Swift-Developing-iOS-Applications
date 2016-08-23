//
//  Header.h
//  ObjectiveCAndSwift
//
//  Created by Andrew Wagner on 12/26/15.
//  Copyright © 2015 Andrew Wagner. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef Header_h
#define Header_h

// Function

NSArray *addInviteeToListIfSpotAvailable
    (
    NSArray *invtees,
    NSString *newInvitee
    );

// Type, methods, and properties

@interface Contact : NSObject
@property NSString *firstName;
@property NSString *lastName;
- (NSArray *)addToInviteeList:(NSArray *)invitees includeLastName:(BOOL)include;
- (NSArray * __nonnull)addToInviteeList:
        (NSArray * __nullable)invitees;
- (NSArray<NSString *> * __nonnull)addStringToInviteeList:
        (NSArray<NSString *> * __nullable)invitees;

@end

// Enumeration

typedef enum {
    PrimaryColorRed,
    PrimaryColorGreen,
    PrimaryColorBlue,
} PrimaryColor;

#endif /* Header_h */
