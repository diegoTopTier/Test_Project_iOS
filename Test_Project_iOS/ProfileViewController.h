//
//  ProfileViewController.h
//  Test_Project_iOS
//
//  Created by TopTier labs on 11/3/15.
//  Copyright (c) 2015 TopTier labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITextView *tweetText;
@property (weak, nonatomic) IBOutlet UIButton *tweetButton;

@property (nonatomic, strong) NSMutableArray *tweets;

- (IBAction) tweetButtonPressed:(id) sender;

@end
