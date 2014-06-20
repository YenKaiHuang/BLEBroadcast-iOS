//
//  BeaconService.m
//  BLEBroadcast
//
//  Created by yenkai huang on 2014/6/19.
//  Copyright (c) 2014年 yenkai huang. All rights reserved.
//

#import "BeaconService.h"

@implementation BeaconService
{
    CBUUID *uuid;
    
    CBCentralManager *centralManager;
    CBPeripheralManager *peripheralManager;
    
    
//    BOOL bluetoothIsEnabledAndAuthorized;
//    NSTimer *authorizationTimer;
}

#pragma mark -


- (id)initWithIdentifier:(NSString *)identifier
{
    if ((self = [super init])) {
        uuid = [CBUUID UUIDWithString:identifier];
    }
    return self;
}


- (void)startDetecting
{
    if (!centralManager){
        NSLog(@"startDetecting");
        centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    }
    
    
}

- (void)startScanning
{
    
    NSDictionary *scanOptions = @{CBCentralManagerScanOptionAllowDuplicatesKey:@(YES)};
    
    
    [centralManager scanForPeripheralsWithServices:@[uuid] options:scanOptions];
}

- (void)stopDetecting
{
    [centralManager stopScan];
    centralManager = nil;
}

- (void)startBroadcasting
{
    // start broadcasting if it's stopped
    if (!peripheralManager) {
        peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil];
    }
}

- (void)stopBroadcasting
{
    
    // stop advertising.
    [peripheralManager stopAdvertising];
    peripheralManager = nil;
}

- (void)startAdvertising
{
    NSLog(@"startAdvertising");
    NSDictionary *advertisingData = @{CBAdvertisementDataLocalNameKey:[[UIDevice currentDevice] name], CBAdvertisementDataServiceUUIDsKey:@[uuid]};

//    NSDictionary *advertisingData = @{CBAdvertisementDataLocalNameKey:@"AAAA",
//                                      CBAdvertisementDataServiceUUIDsKey:@[uuid]};
    
    // Start advertising over BLE
    [peripheralManager startAdvertising:advertisingData];
    
}



#pragma mark - CBCentralManagerDelegate
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral
     advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    NSLog(@"peripheral: %@, data: %@, %1.2f", [peripheral.identifier UUIDString], advertisementData, [RSSI floatValue]);
        
    [self.delegate service:self Peripheral:peripheral advertisementData:advertisementData];
}

- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    NSLog(@"central state: %ld", centralManager.state);
    
    if (central.state == CBCentralManagerStatePoweredOn) {
        [self startScanning];
    }
    
}

#pragma mark - CBPeripheralManagerDelegate
- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral
{
    NSLog(@"peripheral state : %ld", peripheral.state);
        
    
    if (peripheral.state == CBPeripheralManagerStatePoweredOn) {
        [self startAdvertising];
    }
}

- (void)peripheralManagerDidStartAdvertising:(CBPeripheralManager *)peripheral error:(NSError *)error
{
    if (error){
        NSLog(@"error starting advertising: %@", [error localizedDescription]);
    }
    
}

@end
