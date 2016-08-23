//
//  ViewController.m
//  TestObjectiveC
//
//  Created by Jon Hoffman on 1/4/15.
//  Copyright (c) 2015 Jon Hoffman. All rights reserved.
//

#import "ViewController.h"
#import "MyObject.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    
    MyObject *m;
 //   m = [[MyObject alloc]init];
    NSLog(@"Value: %d",[m myMethodWithValue:5]);
    
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

@end
