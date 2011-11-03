//
//  ObjectRelationship.m
//  iOSFramework
//
//  Created by macadmin on 20/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ObjectRelationship.h"

@implementation ObjectRelationship

@synthesize relationshipMappings = _relationshipMappings;

- (id)init
{
    self = [super init];
    if (self) {
        if (!_relationshipMappings) {
            _relationshipMappings = [NSMutableArray new];
        }
    }
    return self;
}

- (void) relationshipBuilder: (Class) parentClass makeRelationshipWithClass : (Class) subClass linkWithKeyPath: (NSString *) mappingKeyPath {
    RelationEntity *relationEntity = [[RelationEntity alloc] init];
    relationEntity.parentClass = parentClass;
    relationEntity.subClass = subClass;
    relationEntity.keyPath = mappingKeyPath;
    
    [_relationshipMappings addObject:relationEntity];
    [relationEntity release];
}

- (void) relationshipBuilder: (Class) parentClass makeRelationshipWithClass : (Class) subClass linkWithKey: (NSString *) mappingKey {
    RelationEntity *relationEntity = [[RelationEntity alloc] init];
    relationEntity.parentClass = parentClass;
    relationEntity.subClass = subClass;
    relationEntity.keyPath = mappingKey;
    
    [_relationshipMappings addObject:relationEntity];
    [relationEntity release];
}

- (void) dealloc{
    //[_relationshipMappings release];
    [super dealloc];
}

@end

@implementation RelationEntity

@synthesize parentClass = _parentClass;
@synthesize subClass = _subClass;
@synthesize keyPath = _keyPath;

- (void) dealloc{
    [super dealloc];
}

@end
