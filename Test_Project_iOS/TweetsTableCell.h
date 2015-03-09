//
//  TweetsTableCell.h
//  Test_Project_iOS
//
//  Created by TopTier labs on 9/3/15.
//  Copyright (c) 2015 TopTier labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TweetsTableCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *dscTweetLabel;
@property (nonatomic, weak) IBOutlet UIImageView *profileImageView;

@end
