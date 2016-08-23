//
//  MessageBuilder.h
//  SwiftProject
//
//  Created by Jon Hoffman on 2/12/15.
//  Copyright (c) 2015 Jon Hoffman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageBuilder : NSObject

-(NSString *)getPersonalizedMessageForName:(NSString*)name;
@end
