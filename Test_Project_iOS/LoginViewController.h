//
//  LoginViewController.h
//  Test_Project_iOS
//
//  Created by TopTier labs on 5/3/15.
//  Copyright (c) 2015 TopTier labs. All rights reserved.
//

#import "ViewController.h"

@interface LoginViewController : ViewController

@property (nonatomic, weak) IBOutlet UILabel *errorLabel;
@property (nonatomic, weak) IBOutlet UITextField *nameField;
@property (nonatomic, weak) IBOutlet UITextField *passField;
- (IBAction) loginPressed:(id) sender;

@end
