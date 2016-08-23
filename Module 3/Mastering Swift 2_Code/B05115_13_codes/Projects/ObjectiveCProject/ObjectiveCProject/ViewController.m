//
//  ViewController.m
//  ObjectiveCProject
//
//  Created by Jon Hoffman on 2/11/15.
//  Copyright (c) 2015 Jon Hoffman. All rights reserved.
//

#import "ViewController.h"
#import "ObjectiveCProject-Swift.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)messagePressed:(id)sender {
    MessageBuilder *mb = [[MessageBuilder alloc] init];
    
    self.messageView.text = [mb getPersonalizedMessage:self.nameField.text];
}

@end
