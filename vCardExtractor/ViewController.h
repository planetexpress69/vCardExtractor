//
//  ViewController.h
//  VCardExtractor
//
//  Created by Martin Kautz on 08.05.12.
//  Copyright (c) 2012 JAKOTA Cruise Systems GmbH. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "VCardParser.h"

@interface ViewController : NSViewController <NSTableViewDelegate, NSTableViewDataSource, VCardParserDelegate>

@property (nonatomic, strong)               NSArray     *theRecords;
@property (nonatomic, strong)   IBOutlet    NSTableView *theTableView;
@property (nonatomic, strong)   IBOutlet    NSTextField *theTextField;

- (IBAction)openFiles:(id)sender;
- (IBAction)exportCsv:(id)sender;

@end
