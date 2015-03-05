//
//  BackendProxy.h
//  Test_Project_iOS
//
//  Created by TopTier labs on 5/3/15.
//  Copyright (c) 2015 TopTier labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface BackendProxy : NSObject

static NSString * const BaseURLString = @"http://www.raywenderlich.com/demos/weather_sample/";//poner url donde este la api
- (NSDictionary *)jsonTapped:(NSString *)algo;

@end
