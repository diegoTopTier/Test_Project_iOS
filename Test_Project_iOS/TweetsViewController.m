//
//  TweetsViewController.m
//  Test_Project_iOS
//
//  Created by TopTier labs on 6/3/15.
//  Copyright (c) 2015 TopTier labs. All rights reserved.
//

#import "TweetsViewController.h"
#import "TweetsTableCell.h"
#import "BackendProxy.h"


@interface TweetsViewController ()

@end

@implementation TweetsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.center = self.tableView.center; //set some center
    [self.tableView addSubview: spinner];
    [self.tableView bringSubviewToFront:spinner];
    spinner.hidesWhenStopped = YES;
    spinner.hidden = NO;
    [spinner startAnimating];
    
    
    [BackendProxy getTweetsWithCompletion:^(NSDictionary *json, BOOL success) {
        [spinner stopAnimating];
        if (!success){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Error while loading tweets" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
        }else{
            
            NSMutableArray *tweets = [json objectForKey:@"tweets"];
            self.tweets=[[NSMutableArray alloc] initWithCapacity:[tweets count]];
            for(NSDictionary* object in tweets){
                NSNumber *idTweet=[object objectForKey:@"id"];
                NSNumber *likeByMe= [object objectForKey:@"like_by_me"];
                NSString *text = [object objectForKey:@"text"];
                NSDictionary *user = [object objectForKey:@"user"];
                NSString *firstName=[user objectForKey:@"first_name"];
                NSString *lastName=[user objectForKey:@"last_name"];
                NSMutableDictionary *tweet=[[NSMutableDictionary alloc] init];
                [tweet setObject:[NSString stringWithFormat:@"%@ %@",firstName,lastName] forKey:@"full_name"];
                [tweet setObject:text forKey:@"text"];
                [tweet setObject:idTweet forKey:@"idTweet"];
                [tweet setObject:likeByMe forKey:@"likeByMe"];
                
                [self.tweets addObject:tweet];

            }
            [self.tableView reloadData];
        }
    }];
    
    // Initialize the refresh control.
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor whiteColor];
    self.refreshControl.tintColor = [UIColor blackColor];
    [self.refreshControl addTarget:self
                            action:@selector(renewTweets)
                  forControlEvents:UIControlEventValueChanged];
    
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return [self.tweets count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *tweetsTableIdentifier = @"TweetsTableCell";
    
    TweetsTableCell *cell = (TweetsTableCell *)[tableView dequeueReusableCellWithIdentifier:tweetsTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TweetsTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.nameLabel.text =  [(self.tweets)[indexPath.row] objectForKey:@"full_name"];
    cell.dscTweetLabel.text =  [(self.tweets)[indexPath.row] objectForKey:@"text"];
    cell.profileImageView.image = [UIImage imageNamed:@"homero"];
    
    return cell;
 
}

//porque cuando selecciono por primera vez no me logea?
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"TweetDetail" sender:indexPath];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"TweetDetail"]) {
        
        NSIndexPath *senderIndexPath=(NSIndexPath *)sender;
        TweetDetailViewController *tweetDetailViewController = segue.destinationViewController;
        tweetDetailViewController.name= [self.tweets[senderIndexPath.row] objectForKeyedSubscript:@"full_name"];
        tweetDetailViewController.dscTweet = [self.tweets[senderIndexPath.row] objectForKeyedSubscript:@"text"];
        tweetDetailViewController.profileImage= [UIImage imageNamed:@"homero"];
        tweetDetailViewController.likeByMe=[self.tweets[senderIndexPath.row] objectForKeyedSubscript:@"likeByMe"];
        tweetDetailViewController.idTweet=[self.tweets[senderIndexPath.row] objectForKeyedSubscript:@"idTweet"];
        tweetDetailViewController.delegate = self;
        
    }
    
};

#pragma mark - TweetsDetailsViewControllerDelegate

-(void) changedLike:(NSNumber *)like forTweet:(NSNumber *) idTweet{
//TODO
    NSEnumerator *enumerator = [self.tweets objectEnumerator];
    NSNumber *actualTweet;
    id object;
    while (object = [enumerator nextObject]) {
        actualTweet=object[@"idTweet"];
        if ([actualTweet isEqualToValue:idTweet]){
            [object setObject:like forKey:@"likeByMe"];
            break;
        };
    }
}

-(void) renewTweets{
    


    
    [BackendProxy getTweetsWithCompletion:^(NSDictionary *json, BOOL success) {

        if (!success){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Error while loading tweets" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
        }else{
            NSMutableArray *tweets = [json objectForKey:@"tweets"];
            self.tweets=[[NSMutableArray alloc] initWithCapacity:[tweets count]];
            for(NSDictionary* object in tweets){
                NSNumber *idTweet=[object objectForKey:@"id"];
                NSNumber *likeByMe= [object objectForKey:@"like_by_me"];
                NSString *text = [object objectForKey:@"text"];
                NSDictionary *user = [object objectForKey:@"user"];
                NSString *firstName=[user objectForKey:@"first_name"];
                NSString *lastName=[user objectForKey:@"last_name"];
                NSMutableDictionary *tweet=[[NSMutableDictionary alloc] init];
                [tweet setObject:[NSString stringWithFormat:@"%@ %@",firstName,lastName] forKey:@"full_name"];
                [tweet setObject:text forKey:@"text"];
                [tweet setObject:idTweet forKey:@"idTweet"];
                [tweet setObject:likeByMe forKey:@"likeByMe"];
                
                [self.tweets addObject:tweet];
            
            }
            [self.refreshControl endRefreshing];

            [self.tableView reloadData];
        }
    }];
    
}




/*- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 78.0;
}*/




/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


@end
