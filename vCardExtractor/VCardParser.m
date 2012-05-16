//
//  VCardParser.h
//  VCardExtractor
//
//  Created by Martin Kautz on 08.05.12.
//  Copyright (c) 2012 JAKOTA Cruise Systems GmbH. All rights reserved.
//

#import "VCardParser.h"
#import "Person.h"

@implementation VcardImporter
@synthesize filesToParse = _filesToParse;
@synthesize persons = _persons;
@synthesize currentPerson = _currentPerson;
@synthesize delegate = _delegate;


/* ---------------------------------------------------------------------------------------- */
#pragma mark - initialization
/* ---------------------------------------------------------------------------------------- */
- (id) init 
{
    return [self initWithFileList:nil];
}

- (id)initWithFileList:(NSArray *)aFileList 
{
    if (self = [super init]) {
        self.filesToParse = aFileList;
        self.persons = [[NSMutableArray alloc]initWithCapacity:10];
    }
    return self;
}


/* ---------------------------------------------------------------------------------------- */
#pragma mark - parsing, storing & handover to delegate
/* ---------------------------------------------------------------------------------------- */
- (void)parse 
{
    
    NSURL *path;
    
    for (path in self.filesToParse) {
        NSError *error;
        NSString *vcardString = [NSString stringWithContentsOfURL:path 
                                                         encoding:NSASCIIStringEncoding
                                                            error:&error];
        if (!error) {
        
            NSArray *lines = [vcardString componentsSeparatedByString:@"\n"];
        
            for(NSString* line in lines) {
                [self parseLine:line];
            }
        } else {
            NSLog(@"error opening file at path %@. cause: %@", path, [error localizedDescription]);
        }
    }

    if ([self.delegate respondsToSelector:@selector(gotResult:)]) {
        [self.delegate performSelector:@selector(gotResult:) withObject:self.persons];
    }

}

- (void) parseLine:(NSString *)line 
{
    
    /*  
        
        This is no smart piece of software at all! 
        We simply extract name, first name and the *first* email address from VCF.
        No further checks of mail addresses (work or private).
        Should work for both VCARD 2.1 and 3.0.
        Feel free to tinker with it...
     
     */
    
    
    
    if ([line hasPrefix:@"BEGIN"]) {
        self.currentPerson = [[Person alloc]init];
    } else if ([line hasPrefix:@"END"]) {
        [self.persons addObject:self.currentPerson];
    } else if ([line hasPrefix:@"N;"] || [line hasPrefix:@"N:"]) {
        [self parseName:line];
    } else if ([line hasPrefix:@"EMAIL;"]) {
        [self parseEmail:line];
    } 
}

- (void) parseName:(NSString *)line 
{
    NSArray *upperComponents = [line componentsSeparatedByString:@":"];
    NSArray *components = [[upperComponents objectAtIndex:1] componentsSeparatedByString:@";"];
    [self.currentPerson setLastName:[[components objectAtIndex:0]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    [self.currentPerson setFirstName:[[components objectAtIndex:1] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
}

- (void) parseEmail:(NSString *)line 
{
    if (self.currentPerson.emailAddress == nil) { // we always take the first address!
        NSArray *mainComponents = [line componentsSeparatedByString:@":"];
        NSString *emailAddress = [mainComponents objectAtIndex:1];
        [self.currentPerson setEmailAddress:[emailAddress stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    }
}

@end
