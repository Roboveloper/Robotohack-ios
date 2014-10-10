//
//  ZhenyaConnection.h
//  RobotoPult
//
//  Created by Alexander on 11/10/14.
//  Copyright (c) 2014 com.robodem.hack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZhenyaConnection : NSObject

+ (void) sendDictToZhenya:(NSDictionary *)dict completion:(void (^)(bool success, NSDictionary * result))completionBlock;

@end
