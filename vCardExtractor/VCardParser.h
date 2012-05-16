//
//  VCardParser.h
//  VCardExtractor
//
//  Created by Martin Kautz on 08.05.12.
//  Copyright (c) 2012 JAKOTA Cruise Systems GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

// delegate
@protocol VCardParserDelegate <NSObject>
@required
- (void)gotResult:(NSArray *)result;
@end

@interface VcardImporter : NSObject

@property (nonatomic, strong) NSArray                   *filesToParse;
@property (nonatomic, strong) NSMutableArray            *persons;
@property (nonatomic, strong) Person                    *currentPerson;
@property (nonatomic, strong) id<VCardParserDelegate>   delegate;

- (id)initWithFileList:(NSArray *)aFileList;
- (void)parse;
- (void)parseLine:(NSString *)line;
- (void)parseName:(NSString *)line;
- (void)parseEmail:(NSString *)line;

@end

