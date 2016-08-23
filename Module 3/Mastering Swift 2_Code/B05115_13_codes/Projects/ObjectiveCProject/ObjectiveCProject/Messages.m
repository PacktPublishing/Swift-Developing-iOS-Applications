//
//  Messages.m
//  ObjectiveCProject
//
//  Created by Jon Hoffman on 2/12/15.
//  Copyright (c) 2015 Jon Hoffman. All rights reserved.
//

#import "Messages.h"

@implementation Messages

NSMutableArray *theMessages;

-(id)init {
    if ( self = [super init] ) {
        theMessages = [[NSMutableArray alloc] init];
        [theMessages addObject:@"You should learn from your mistakes"];
        [theMessages addObject:@"It is in the now that we must live"];
        [theMessages addObject:@"The greatest risk is not taking one"];
        [theMessages addObject:@"You will be a Swift programmer"];
    }
    
    return self;
}

-(NSString *)getMessage {
    int num = arc4random() % theMessages.count;

    return theMessages[num];
}
@end
