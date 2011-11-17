//
//  ObjectLoader.h
//  iOSFramework
//
//  Created by macadmin on 16/10/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestParam.h"
#import "FKObject.h"

@class ObjectRelationship;

@protocol LoadObjectDelegate<NSObject>

@optional
- (void) didLoadDictionaryFinished:(NSDictionary *) result;
- (void) didLoadObjectFinished:(FKObject *) result;
//- (void) didLoadObjectFinished:(id) result;
//- (void) didLoadObjectFinishedWithFKObject:(FKObject *) result;

@required
- (void) didLoadObjectFailed:(NSError *) error;

@end

@interface ObjectLoader : NSObject{
    id<LoadObjectDelegate> delegate;
    Class objectClass;
    ObjectRelationship *objectRelationship;
    RequestParam *requestParam;
    NSString *relativeKeyPath;
    //id resultObject;
    SEL didLoadDictionaryFinishedSelector;
    SEL didLoadObjectFinishedSelector;
    SEL didLoadObjectFailedSelector;
}

//@property (nonatomic, retain) id resultObject;
@property (nonatomic, assign) id<LoadObjectDelegate> delegate;
@property (nonatomic, assign) Class objectClass;
@property (nonatomic, retain) ObjectRelationship *objectRelationship;
@property (nonatomic, retain) RequestParam *requestParam;
@property (nonatomic, copy) NSString *relativeKeyPath;

@property (nonatomic, assign) SEL didLoadDictionaryFinishedSelector;
@property (nonatomic, assign) SEL didLoadObjectFinishedSelector;
@property (nonatomic, assign) SEL didLoadObjectFailedSelector;

+ (ObjectLoader *) sharedObjectLoader;

- (void) loadLocalDataAsDictionary:(NSString *) jsonString;

- (void) loadLocalData:(NSString *) jsonString forKeyPath: (NSString *) keyPath;

- (void) loadRemoteData: (NSString *) keyPath;

- (void) loadRemoteData: (Class) class forKeyPath :(NSString *) keyPath;

- (void) loadRemoteDataAsDictionary;

- (void) requestData: (SEL) requestFinishSelector requestFailedSelector : (SEL) requestFailedSelector withRequestMethod : (NSString *) requestMethod;

- (id) performMapping: (NSDictionary *) jsonObject;

- (BOOL)isNullCollection:(id)object;

- (id) getMappedObject: (id) object toClass: (Class) className;

+ (void) releaseSharedInstance;
@end
