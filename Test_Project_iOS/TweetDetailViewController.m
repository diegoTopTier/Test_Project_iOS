//
//  TweetDetailViewController.m
//  Test_Project_iOS
//
//  Created by TopTier labs on 10/3/15.
//  Copyright (c) 2015 TopTier labs. All rights reserved.
//

#import "TweetDetailViewController.h"
#import "BackendProxy.h"

@interface TweetDetailViewController ()

@end

@implementation TweetDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nameLabel.text=self.name;
    self.dscTweetLabel.text=self.dscTweet;
    self.profileImageView.image=self.profileImage;
    if([self.likeByMe isEqualToNumber:[NSNumber numberWithInt:0]]){
        self.unlikeButton.hidden=true;
        self.likeButton.hidden=false;
    }else{
        self.likeButton.hidden=true;
        self.unlikeButton.hidden=false;
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction) likePressed:(id) sender{
    self.likeButton.hidden=true;
    self.unlikeButton.hidden=false;
    [BackendProxy likeTweetWithId:self.idTweet completion:^(NSDictionary *json, BOOL success)  {
        if (!success){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Error" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
        }else{
            if (self.delegate!=nil){
                [self.delegate changedLike:[NSNumber numberWithInt:1] forTweet:self.idTweet];
            }
        }
    }];
    
};
- (IBAction) unlikePressed:(id) sender{
    self.unlikeButton.hidden=true;
    self.likeButton.hidden=false;
    [BackendProxy unlikeTweetWithId:self.idTweet completion:^(NSDictionary *json, BOOL success)  {
        if (!success){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Error" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
        }else{
            if (self.delegate!=nil){
                [self.delegate changedLike:[NSNumber numberWithInt:0] forTweet:self.idTweet];
            }
        }
    }];
};

@end
