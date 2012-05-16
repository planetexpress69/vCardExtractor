//
//  AppDelegate.h
//  VCardExtractor
//
//  Created by Martin Kautz on 08.05.12.
//  Copyright (c) 2012 JAKOTA Cruise Systems GmbH. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ViewController.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign)              IBOutlet    NSWindow        *window;
@property (nonatomic, strong)               ViewController  *vc;

@property (nonatomic, strong)   IBOutlet    NSMenuItem      *exportMenuItem;


- (IBAction)openProxy:(id)sender;
- (IBAction)exportProxy:(id)sender;

@end