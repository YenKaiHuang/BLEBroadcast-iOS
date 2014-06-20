//
//  ViewController.h
//  BLEBroadcast
//
//  Created by yenkai huang on 2014/6/19.
//  Copyright (c) 2014年 yenkai huang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define IDENTIFIER @"CB284D88-5317-4FB4-9621-C5A3A49E6155"

#define SHORT_IDENTIFIER @"6121"

@interface ViewController : UIViewController
- (IBAction)centralPress:(id)sender;
- (IBAction)broadcastingPress:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *centralTextView;
@property (weak, nonatomic) IBOutlet UILabel *broadcastingName;

@end
