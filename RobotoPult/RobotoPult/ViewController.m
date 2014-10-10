//
//  ViewController.m
//  RobotoPult
//
//  Created by Sasha on 10/10/14.
//  Copyright (c) 2014 com.robodem.hack. All rights reserved.
//

#import "ViewController.h"
#import "ZhenyaConnection.h"

#define BUTTONS_COUNT 18

@interface ViewController ()

@property (nonatomic, strong) UIButton * activeButton;

@end

@implementation ViewController


- (void) viewDidLoad {
    [super viewDidLoad];
    
    [self initButtons];
    [_lockSwitch setOn:NO];
    _lockSplash.alpha = 0;
}

- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) initButtons {
    float x = 5;
    float y = 5;
    for (int i = 0; i < BUTTONS_COUNT; i++) {
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
    
    [self sentFormButtonWithTag:(int) sender.tag];
}

- (void) sentFormButtonWithTag:(int)tag {
    NSString * angle = [NSString stringWithFormat:@"%f", ((float) tag / (float) (BUTTONS_COUNT - 1))];
    
    [ZhenyaConnection sendDictToZhenya:@{@"angle":angle, @"fignya":@"43215324645756723536546678798754523545797246287325672346578325783489573489567834657234657236786234765347"} completion:^(bool success, NSDictionary * result) {
        NSLog(@"Server returned: %@", result);
    }];
}

- (IBAction) lockSwitchPressed:(id)sender {
    if ([_lockSwitch isOn]) {
        _lockSplash.alpha = 1;
        _scroll.userInteractionEnabled = NO;
        [ZhenyaConnection sendDictToZhenya:@{@"action":@"lock"} completion:^(bool success, NSDictionary * result) { }];
    } else {
        _lockSplash.alpha = 0;
        _scroll.userInteractionEnabled = YES;
        [ZhenyaConnection sendDictToZhenya:@{@"action":@"unlock"} completion:^(bool success, NSDictionary * result) { }];
    }
}

@end
