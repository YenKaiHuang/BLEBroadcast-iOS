//
//  ViewController.m
//  BLEBroadcast
//
//  Created by yenkai huang on 2014/6/19.
//  Copyright (c) 2014年 yenkai huang. All rights reserved.
//

#import "ViewController.h"
//#import "INBeaconService.h"
#import "BeaconService.h"

@interface ViewController ()<BeaconServiceDelegate>{
    BeaconService *beaconService;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    beaconService = [[BeaconService alloc] initWithIdentifier:SHORT_IDENTIFIER];
    beaconService.delegate = self;
    
    [self.broadcastingName setText:[[UIDevice currentDevice] name]];
//    [self.broadcastingName setText:@"AAAA"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - BeaconServiceDelegate

- (void) service:(BeaconService *)service Peripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData{
    NSLog(@"did discover peripheral: %@, data: %@", [peripheral.identifier UUIDString], advertisementData);
    
    CBUUID *uuid = [advertisementData[CBAdvertisementDataServiceUUIDsKey] firstObject];
    NSLog(@"service uuid: %@", [uuid UUIDString]);
    
    [self.centralTextView setText:[NSString stringWithFormat:@"%@ \n%@ \nuuid:%@", [NSDate date], [advertisementData objectForKey:@"kCBAdvDataLocalName"], [uuid UUIDString]]];
}

#pragma mark -

- (IBAction)centralPress:(id)sender {
    self.title = @"Central";
    [beaconService stopBroadcasting];
    [beaconService startDetecting];
}

- (IBAction)broadcastingPress:(id)sender {
    self.title = @"Broadcasting";
    [beaconService stopDetecting];
    [beaconService startBroadcasting];
}

@end
