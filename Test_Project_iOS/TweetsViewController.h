//
//  TweetsViewController.h
//  Test_Project_iOS
//
//  Created by TopTier labs on 6/3/15.
//  Copyright (c) 2015 TopTier labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TweetDetailViewController.h"


@interface TweetsViewController : UITableViewController <TweetDetailViewControllerDelegate>

@property (nonatomic, strong) NSMutableArray *tweets;



@end
