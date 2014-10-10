//
//  ViewController.h
//  RobotoPult
//
//  Created by Sasha on 10/10/14.
//  Copyright (c) 2014 com.robodem.hack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView * batteryBgImg;
@property (strong, nonatomic) IBOutlet UIImageView * batteryEnergy1;
@property (strong, nonatomic) IBOutlet UIImageView * baterryEnergy2;
@property (strong, nonatomic) IBOutlet UIImageView * baterryEnergy3;
@property (strong, nonatomic) IBOutlet UIImageView * baterryEnergy4;
@property (strong, nonatomic) IBOutlet UIImageView * baterryEnergy5;
@property (strong, nonatomic) IBOutlet UILabel * baterryLabel;
@property (strong, nonatomic) IBOutlet UIScrollView * scroll;
@property (strong, nonatomic) IBOutlet UILabel * baterryLabel1;
@property (strong, nonatomic) IBOutlet UILabel * baterryLabel2;

@end
