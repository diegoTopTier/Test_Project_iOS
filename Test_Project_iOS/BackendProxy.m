//
//  BackendProxy.m
//  Test_Project_iOS
//
//  Created by TopTier labs on 5/3/15.
//  Copyright (c) 2015 TopTier labs. All rights reserved.
//

#import "BackendProxy.h"

@implementation BackendProxy

+ (void)loginWithUserID:(NSString *)userID AndPassword:(NSString *)password completion:(void (^)(NSDictionary *json, BOOL success))completion{
    
    NSString *apiRequestString = [NSString stringWithFormat:@"%@/login", apiBase];
    NSDictionary *parameters = @{
                                 @"email" : userID,
                                 @"password" : password,
                                 };
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:apiRequestString parameters:parameters success:^(AFHTTPRequestOperation *operation, id jsonObject)
     {
         NSLog(@"Success: %@", jsonObject);
         
         NSDictionary *jsonDictionary = (NSDictionary *)jsonObject;
         
         if (completion)
             completion(jsonDictionary, YES);
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"%@ AFError: %@", self.class, [error localizedDescription]);
         
         completion(nil, NO);
     }];
    
}

+ (void)getTweetsWithCompletion:(void (^)(NSDictionary *json, BOOL success))completion{
    
    NSString *apiRequestString = [NSString stringWithFormat:@"%@/tweets", apiBase];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *token = [defaults objectForKey:@"token"];
    NSDictionary *parameters = @{
                                 @"token" : token,
                                 };
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:apiRequestString parameters:parameters success:^(AFHTTPRequestOperation *operation, id jsonObject)
     {
         NSLog(@"Success: %@", jsonObject);
         
         NSDictionary *jsonDictionary = (NSDictionary *)jsonObject;
         
         if (completion)
             completion(jsonDictionary, YES);
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"%@ AFError: %@", self.class, [error localizedDescription]);
         
         completion(nil, NO);
     }];
    
}


@end
