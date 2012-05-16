//
//  ViewController.m
//  VCardExtractor
//
//  Created by Martin Kautz on 08.05.12.
//  Copyright (c) 2012 JAKOTA Cruise Systems GmbH. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "VCardParser.h"

@interface ViewController ()
@end

@implementation ViewController
@synthesize theTableView    = _theTableView;
@synthesize theRecords      = _theRecords;
@synthesize theTextField    = _theTextField;

/* ---------------------------------------------------------------------------------------- */
#pragma mark - init & view handling
/* ---------------------------------------------------------------------------------------- */
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        
    }
    return self;
}

- (void)loadView 
{
    [super loadView];
    self.theTableView.delegate = self;
    self.theTableView.dataSource = self;
    self.theTextField.stringValue = @"";
}


/* ---------------------------------------------------------------------------------------- */
#pragma mark - NSTableViewDataSource methods
/* ---------------------------------------------------------------------------------------- */
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView 
{
    return [self.theRecords count]; 
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn 
            row:(NSInteger)row 
{
    
    Person *p = [self.theRecords objectAtIndex:row];
    
    if (!p) {
        return nil;
    }
    
    NSString *sColumnIdentifier = tableColumn.identifier;
    
    if  ([sColumnIdentifier isEqualToString:@"number"])
        return [NSString stringWithFormat:@"%d", row +1];
    else if  ([sColumnIdentifier isEqualToString:@"name"])
        return p.lastName;
    else if ([sColumnIdentifier isEqualToString:@"firstname"]) 
        return p.firstName;
    else if ([sColumnIdentifier isEqualToString:@"email"]) 
        return p.emailAddress;
    else 
        return @"...";  
    
}


/* ---------------------------------------------------------------------------------------- */
#pragma mark - User triggered stuff - open & parse
/* ---------------------------------------------------------------------------------------- */
- (IBAction)openFiles:(id)sender
{
    NSOpenPanel *panel=[NSOpenPanel openPanel];
    [panel setTitle:@"Choose the vcf files you want to parse..."];
    [panel setAllowedFileTypes:[NSArray arrayWithObject:@"vcf"]];
    [panel setAllowsMultipleSelection:YES];
    
    [panel beginWithCompletionHandler:^(NSInteger result){
        if (result == NSFileHandlingPanelOKButton) {
            
            NSMutableArray *array = [[NSMutableArray alloc]initWithCapacity:10];
            
            for (NSURL *fileURL in [panel URLs]) {
                [array addObject:fileURL];
            }
            
            self.theTextField.stringValue = [NSString stringWithFormat:@"%d files parsed.", array.count];
            
            // init parser and assign payload to parse
            VcardImporter *importer = [[VcardImporter alloc]initWithFileList:array];
            importer.delegate = self;
            [importer parse];
        }
    }];
}

- (IBAction)exportCsv:(id)sender
{
    NSSavePanel *savePanel = [NSSavePanel savePanel];
    [savePanel setTitle:@"Save as CSV..."];
    [savePanel setAllowedFileTypes:[NSArray arrayWithObject:@"csv"]];
    [savePanel setExtensionHidden:NO];
    [savePanel beginWithCompletionHandler:^(NSInteger result) {
        if (result == NSFileHandlingPanelOKButton) {
            NSLog(@"Saving stuff into %@", [savePanel URL]);
            
            Person *p;
            NSString *sLine = @"";
            NSError *error;
            for (p in self.theRecords) {
                
                sLine = [sLine stringByAppendingString:[NSString stringWithFormat:@"%@;%@;%@\n", p.lastName, p.firstName, p.emailAddress]];
                
            }
                        
            [sLine writeToFile:[[savePanel URL]path] 
                    atomically:YES 
                      encoding:NSUTF8StringEncoding 
                         error:&error];
            
            if (error) {
                NSLog(@"Error writing file '%@'. Cause: %@", [savePanel URL], [error localizedDescription]);
            }
            
        }
    }];
    
}


/* ---------------------------------------------------------------------------------------- */
#pragma mark - VcardImporterDelegate methods
/* ---------------------------------------------------------------------------------------- */
- (void)gotResult:(NSArray *)result 
{
    self.theRecords = result;
    [self.theTableView reloadData];
}

@end
