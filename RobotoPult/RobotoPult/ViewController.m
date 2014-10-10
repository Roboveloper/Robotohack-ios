//
//  ViewController.m
//  RobotoPult
//
//  Created by Sasha on 10/10/14.
//  Copyright (c) 2014 com.robodem.hack. All rights reserved.
//

#import "ViewController.h"
#import "GCDAsyncUdpSocket.h"
#import "SBJson.h"

@interface ViewController ()

@property (nonatomic, strong) UIButton * activeButton;

@end

@implementation ViewController


- (void) viewDidLoad {
    [super viewDidLoad];
    
    [self initButtons];
}

- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) initButtons {
    float x = 5;
    float y = 5;
    for (int i = 0; i <= 25; i++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(x, y, 100, 100);
        [button setBackgroundImage:[UIImage imageNamed:@"button-disabled.png"] forState:UIControlStateNormal];
        [button setTitle:[NSString stringWithFormat:@"%i", i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:40];
        button.titleLabel.textColor = [UIColor blackColor];
        [button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchDown];
        button.tag = i;
        [_scroll addSubview:button];
        _scroll.contentSize = CGSizeMake(320, button.frame.origin.y + button.frame.size.height + 5);
        
        x += 105;
        if (x > 300) {
            x = 5;
            y += 105;
        }
    }
}

- (IBAction) buttonTapped:(UIButton *)sender {
    if (_activeButton) {
        [_activeButton setBackgroundImage:[UIImage imageNamed:@"button-disabled.png"] forState:UIControlStateNormal];
        _activeButton.titleLabel.textColor = [UIColor blackColor];
    }
    [sender setBackgroundImage:[UIImage imageNamed:@"button-enabled.png"] forState:UIControlStateNormal];
    _activeButton = sender;
}

- (IBAction) sendBtnPressed:(id)sender {
    NSLog(@"sdghiljdfbkjdf");
    
    GCDAsyncUdpSocket * udpSocket;
    udpSocket = [[GCDAsyncUdpSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    
    NSData * data = [[NSString stringWithFormat:@"Hello Wold"] dataUsingEncoding:NSUTF8StringEncoding];
                    
    [udpSocket sendData:data toHost:@"192.168.10.111" port:550 withTimeout:-1 tag:1];
}

- (void) sendPostRequest:(NSString *)function
                   token:(NSString *)token
                    dict:(NSDictionary *)dict
              completion:(void (^)(bool success, NSDictionary * result))completionBlock
{
    NSString * jsonString = [dict JSONRepresentation];
    NSMutableData * jsonData = [NSMutableData dataWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", @"dfb", function]];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:jsonData];
    [request addValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:token forHTTPHeaderField:@"key"];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * response, NSData * data, NSError * connectionError) {
        if (connectionError) {
            completionBlock(NO, nil);
        } else {
            NSError * parseError;
            NSDictionary * jsonResultDict = (NSDictionary *) [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&parseError];
            if (parseError) {
                completionBlock(NO, nil);
            } else {completionBlock(YES, jsonResultDict);
                
            }
        }
    }];
}

@end
