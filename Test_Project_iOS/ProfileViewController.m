//
//  ProfileViewController.m
//  Test_Project_iOS
//
//  Created by TopTier labs on 11/3/15.
//  Copyright (c) 2015 TopTier labs. All rights reserved.
//

#import "ProfileViewController.h"
#import "BackendProxy.h"
#import "TweetsTableCell.h"

#define PLACEHOLDERTEXT @"Que estas pensando?"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //efecto placeholder al textview
    self.tweetText.text = PLACEHOLDERTEXT;
    self.tweetText.textColor = [UIColor lightGrayColor];
    self.tweetText.delegate = self;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    //To make the border look very close to a UITextField
    [self.tweetText.layer setBorderColor:[[[UIColor grayColor] colorWithAlphaComponent:0.5] CGColor]];
    [self.tweetText.layer setBorderWidth:2.0];
    
    //The rounded corner part, where you specify your view's corner radius:
    self.tweetText.layer.cornerRadius = 5;
    self.tweetText.clipsToBounds = YES;
    
    self.profileImage.layer.cornerRadius = 5;
    self.profileImage.clipsToBounds = YES;
    
    [BackendProxy getProfileView:^(NSDictionary *json, BOOL success) {
        if (!success){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Error while loading tweets" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
        }else{

            NSDictionary *user = [json objectForKey:@"user"];
            
            NSMutableArray *tweets = [user objectForKey:@"tweets"];
            self.tweets=[[NSMutableArray alloc] initWithCapacity:[tweets count]];
            for(NSDictionary* object in tweets){
                NSNumber *idTweet=[object objectForKey:@"id"];
                NSString *text = [object objectForKey:@"text"];
                NSMutableDictionary *tweet=[[NSMutableDictionary alloc] init];
                [tweet setObject:text forKey:@"text"];
                [tweet setObject:idTweet forKey:@"idTweet"];
                [self.tweets addObject:tweet];
                
            }
            
            self.nameLabel.text=[NSString stringWithFormat:@"%@ %@",[user objectForKey:@"first_name"],[user objectForKey:@"last_name"]];
            NSString * urlImgString=[user objectForKey:@"avatar"];
            
            if (urlImgString == nil || [urlImgString isEqual:[NSNull null]]){
                self.profileImage.image=[UIImage imageNamed:@"homero"];
            }else{
                self.profileImage.image = [UIImage imageWithData:
                                               [NSData dataWithContentsOfURL:
                                                [NSURL URLWithString: [NSString stringWithFormat:@"http://192.168.1.163:3000/%@",urlImgString]]]];
            }
            
            }
           [self.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction) tweetButtonPressed:(id) sender{
    
    if(![self.tweetText.text isEqual:@""] && (![self.tweetText.text isEqual:PLACEHOLDERTEXT])){
    
        //Add Spinner
        [self.tweetButton setTitle:@"" forState:UIControlStateSelected];
        UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [spinner startAnimating];
        spinner.frame = self.tweetButton.bounds;
        [self.tweetButton addSubview:spinner];
        self.tweetButton.enabled = false;
        
        
        [BackendProxy postTweet:self.tweetText.text completion:^(NSDictionary *json, BOOL success) {
            //Remove spinner
            [spinner stopAnimating];
            [self.tweetButton setTitle:@"Tweet" forState:UIControlStateNormal];
            self.tweetButton.enabled=true;
            [spinner removeFromSuperview];
            
            if (!success){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Error while loading tweets" delegate:self cancelButtonTitle:@"Ok"otherButtonTitles:nil];
                [alert show];
            }else{
                NSLog(@"Tweet Posteado");
                NSDictionary *object = [json objectForKey:@"tweet"];
                NSNumber *idTweet=[object objectForKey:@"id"];
                NSString *text = [object objectForKey:@"text"];
                NSMutableDictionary *tweet=[[NSMutableDictionary alloc] init];
                [tweet setObject:text forKey:@"text"];
                [tweet setObject:idTweet forKey:@"idTweet"];
                [self.tweets insertObject:tweet atIndex:0];
                

                [self.tableView reloadData];

            }
        }];
        self.tweetText.text = PLACEHOLDERTEXT;
        self.tweetText.textColor = [UIColor lightGrayColor];
        self.tweetText.delegate = self;
        
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
        //To make the border look very close to a UITextField
        [self.tweetText.layer setBorderColor:[[[UIColor grayColor] colorWithAlphaComponent:0.5] CGColor]];
        [self.tweetText.layer setBorderWidth:2.0];
        
        //The rounded corner part, where you specify your view's corner radius:
        self.tweetText.layer.cornerRadius = 5;
        self.tweetText.clipsToBounds = YES;

    }
}


- (BOOL) textViewShouldBeginEditing:(UITextView *)textView{
    self.tweetText.text = @"";
    self.tweetText.textColor = [UIColor blackColor];
    return YES;
}

-(void) textViewDidChange:(UITextView *)textView{

    if(self.tweetText.text.length == 0){
        self.tweetText.textColor = [UIColor lightGrayColor];
        self.tweetText.text = @"Que estas pensando?";
        [self.tweetText resignFirstResponder];
    }
    if(self.tweetText.text.length > 150){
        [self.tweetText.layer setBorderColor:[[UIColor redColor] CGColor]];
        self.tweetButton.enabled = false;

    }
    if(self.tweetText.text.length < 151){
        [self.tweetText.layer setBorderColor:[[[UIColor grayColor] colorWithAlphaComponent:0.5] CGColor]];
        self.tweetButton.enabled = true;
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    return textView.text.length + (text.length - range.length) <= 300;
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
    
    cell.nameLabel.text =  self.nameLabel.text;
    cell.dscTweetLabel.text =  [(self.tweets)[indexPath.row] objectForKey:@"text"];
    cell.profileImageView.image = self.profileImage.image;
    
    return cell;
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.tweetText endEditing:YES];
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
