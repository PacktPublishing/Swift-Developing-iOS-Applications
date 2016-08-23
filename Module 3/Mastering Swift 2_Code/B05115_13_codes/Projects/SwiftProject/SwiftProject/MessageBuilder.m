//
//  MessageBuilder.m
//  SwiftProject
//
//  Created by Jon Hoffman on 2/12/15.
//  Copyright (c) 2015 Jon Hoffman. All rights reserved.
//

#import "MessageBuilder.h"
#import "SwiftProject-Swift.h"

@implementation MessageBuilder

-(NSString *)getPersonalizedMessageForName:(NSString*)name {
    Messages *messages = [[Messages alloc] init];

    NSString *retString = [NSString stringWithFormat:@"To: %@, %@",name, [messages getMessage]];
    return retString;
}

@end
