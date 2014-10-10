//
//  ZhenyaConnection.m
//  RobotoPult
//
//  Created by Alexander on 11/10/14.
//  Copyright (c) 2014 com.robodem.hack. All rights reserved.
//

#import "ZhenyaConnection.h"
#import "SBJson.h"

#define ZHENYA_URL @"http://192.168.1.12:81/"

@implementation ZhenyaConnection

+ (void) sendDictToZhenya:(NSDictionary *)dict
               completion:(void (^)(bool success, NSDictionary * result))completionBlock
{
    NSLog(@"Request to server: %@", dict);
    
    NSString * jsonString = [dict JSONRepresentation];
    NSMutableData * jsonData = [NSMutableData dataWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURL * url = [NSURL URLWithString:ZHENYA_URL];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:jsonData];
    [request addValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * response, NSData * data, NSError * connectionError) {
        if (connectionError) {
            completionBlock(NO, nil);
        } else {
            NSError * parseError;
            NSDictionary * jsonResultDict = (NSDictionary *) [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&parseError];
            if (parseError) {
                completionBlock(NO, nil);
            } else {
                completionBlock(YES, jsonResultDict);
            }
        }
    }];
}

@end
