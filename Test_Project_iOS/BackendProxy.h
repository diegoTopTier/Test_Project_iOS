//
//  BackendProxy.h
//  Test_Project_iOS
//
//  Created by TopTier labs on 5/3/15.
//  Copyright (c) 2015 TopTier labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

static NSString * const apiBase = @"http://192.168.1.163:3000/api/v1";

@interface BackendProxy : NSObject


+ (void)loginWithUserID:(NSString *)userID AndPassword:(NSString *)password completion:(void (^)(NSDictionary *json, BOOL success))completion;
+ (void)getTweetsWithCompletion:(void (^)(NSDictionary *json, BOOL success))completion;


@end
