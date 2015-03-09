//
//  LoginViewController.m
//  Test_Project_iOS
//
//  Created by TopTier labs on 5/3/15.
//  Copyright (c) 2015 TopTier labs. All rights reserved.
//

#import "LoginViewController.h"
#import "BackendProxy.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.errorLabel.text=@"";
    self.errorLabel.hidden=true;
    self.passField.secureTextEntry = true;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) loginPressed:(id) sender{
    if(([self.nameField.text isEqualToString:@""])||([self.passField.text isEqualToString:@""])){
        self.errorLabel.text=@"Error: Fields must not be empty";
        self.errorLabel.hidden=false;
    }else{
        
        [BackendProxy loginWithUserID:self.nameField.text AndPassword:self.passField.text completion:^(NSDictionary *json, BOOL success) {
            if (!success){
                self.errorLabel.text=@"Connection error";
                self.errorLabel.hidden=false;
            }else{
                NSDictionary *user = [json objectForKey:@"user"];
                NSString *ident = [user objectForKey:@"id"];
                NSString *token = [user objectForKey:@"session_token"];
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                
                [defaults setObject:ident forKey:@"ident"];
                [defaults setObject:token forKey:@"token"];
                
               [self performSegueWithIdentifier:@"TabBar" sender:sender];
            }
        }];
    }

    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
