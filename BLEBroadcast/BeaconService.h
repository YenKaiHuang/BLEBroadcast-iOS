//
//  BeaconService.h
//  BLEBroadcast
//
//  Created by yenkai huang on 2014/6/19.
//  Copyright (c) 2014年 yenkai huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@class BeaconService;
@protocol BeaconServiceDelegate <NSObject>
@optional
- (void)service:(BeaconService *)service Peripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData;
@end


@interface BeaconService : NSObject <CBPeripheralManagerDelegate, CBCentralManagerDelegate>

@property (nonatomic, strong) id<BeaconServiceDelegate>delegate;

- (id)initWithIdentifier:(NSString *)theIdentifier;

- (void)startDetecting;
- (void)stopDetecting;

- (void)startBroadcasting;
- (void)stopBroadcasting;

- (void) connectPeripheral;

@end
