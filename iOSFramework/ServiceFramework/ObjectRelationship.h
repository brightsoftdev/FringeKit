//
//  ObjectRelationship.h
//  iOSFramework
//
//  Created by macadmin on 20/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ObjectRelationship : NSObject {
    NSMutableArray* relationshipMappings;
}

@property (nonatomic, retain) NSMutableArray* relationshipMappings;

- (void) relationshipBuilder: (Class) parentClass makeRelationshipWithClass : (Class) subClass linkWithKeyPath: (NSString *) mappingKeyPath ;

- (void) relationshipBuilder: (Class) parentClass makeRelationshipWithClass : (Class) subClass linkWithKey: (NSString *) mappingKey ;

@end


@interface RelationEntity : NSObject {
    Class parentClass;
    Class subClass;
    NSString *keyPath;
}

@property (nonatomic, assign) Class parentClass;
@property (nonatomic, assign) Class subClass;
@property (nonatomic, copy) NSString* keyPath;

@end