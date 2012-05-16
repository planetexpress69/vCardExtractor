//
//  AppDelegate.m
//  VCardExtractor
//
//  Created by Martin Kautz on 08.05.12.
//  Copyright (c) 2012 JAKOTA Cruise Systems GmbH. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@implementation AppDelegate

@synthesize window          = _window;
@synthesize vc              = _vc;
@synthesize exportMenuItem  = _exportMenuItem;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    self.vc = [[ViewController alloc]initWithNibName:@"ViewController" bundle:[NSBundle mainBundle]];
    
    [self.window.contentView setAutoresizesSubviews:YES];
    [self.window.contentView addSubview:_vc.view];
    [self.exportMenuItem setEnabled:NO];
    
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender 
{
    return YES;
}

- (IBAction)openProxy:(id)sender 
{
    [self.vc openFiles:nil];
}

- (IBAction)exportProxy:(id)sender 
{
    [self.vc exportCsv:nil];
}

- (BOOL)validateMenuItem:(NSMenuItem *)menuItem {
    
    NSLog(@"Checking...");
    
    if (menuItem == self.exportMenuItem) {
        return [self.vc.theRecords count] == 0 ? NO : YES;
    }
    
    return YES;
}

@end
