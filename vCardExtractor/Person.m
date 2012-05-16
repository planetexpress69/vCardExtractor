//
//  Person.m
//  VCardExtractor
//
//  Created by Martin Kautz on 08.05.12.
//  Copyright (c) 2012 JAKOTA Cruise Systems GmbH. All rights reserved.
//

#import "Person.h"

@implementation Person
@synthesize lastName        = _lastName;
@synthesize firstName       = _firstName;
@synthesize emailAddress    = _emailAddress;

- (id)init {
    return [self initWithName:nil andFirstName:nil andEmailAddress:nil];
}

- (id)initWithName:(NSString *)aName andFirstName:(NSString *)aFirstName andEmailAddress:(NSString *)anEmailAddress {
    if ((self = [super init])) {
        self.lastName       = aName;
        self.firstName      = aFirstName;
        self.emailAddress   = anEmailAddress;
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"Person w/ name: '%@' and email address '%@'", self.lastName, self.emailAddress];
}

@end
