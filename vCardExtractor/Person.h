//
//  Person.h
//  VCardExtractor
//
//  Created by Martin Kautz on 08.05.12.
//  Copyright (c) 2012 JAKOTA Cruise Systems GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *emailAddress;

- (id)initWithName:(NSString *)aName andFirstName:(NSString *)aFirstName andEmailAddress:(NSString *)anEmailAddress;

@end
