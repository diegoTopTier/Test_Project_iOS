//
//  TweetDetailViewController.h
//  Test_Project_iOS
//
//  Created by TopTier labs on 10/3/15.
//  Copyright (c) 2015 TopTier labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TweetDetailViewController;

@protocol TweetDetailViewControllerDelegate <NSObject>
-(void) changedLike:(NSNumber *)like forTweet:(NSNumber *) idTweet;
@end

@interface TweetDetailViewController : UIViewController

@property (nonatomic, weak) id <TweetDetailViewControllerDelegate> delegate;

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UITextView *dscTweetLabel;
@property (nonatomic, weak) IBOutlet UIImageView *profileImageView;

@property (nonatomic, weak) IBOutlet UIButton *likeButton;
@property (nonatomic, weak) IBOutlet UIButton *unlikeButton;

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *dscTweet;
@property (nonatomic, strong) UIImage *profileImage;
@property (nonatomic, strong) NSNumber *likeByMe;
@property (nonatomic, strong) NSNumber *idTweet;

- (IBAction) likePressed:(id) sender;
- (IBAction) unlikePressed:(id) sender;

@end
