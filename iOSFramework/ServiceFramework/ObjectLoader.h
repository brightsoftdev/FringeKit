//
//  ObjectLoader.h
//  iOSFramework
//
//  Created by macadmin on 16/10/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestParam.h"

@class ObjectRelationship;

@protocol LoadObjectDelegate<NSObject>

@optional
- (void) didLoadDictionaryFinished:(NSDictionary *) result;
- (void) didLoadObjectFinished:(id) result;

@required
- (void) didLoadObjectFailed:(NSError *) error;

@end

@interface ObjectLoader : NSObject{
    id<LoadObjectDelegate> delegate;
    Class objectClass;
    ObjectRelationship *objectRelationship;
    RequestParam *requestParam;
    NSString *relativeKeyPath;
    id resultObject;
}

@property (nonatomic, retain) id resultObject;
@property (nonatomic, assign) id<LoadObjectDelegate> delegate;
@property (nonatomic, assign) Class objectClass;
@property (nonatomic, retain) ObjectRelationship *objectRelationship;
@property (nonatomic, retain) RequestParam *requestParam;
@property (nonatomic, copy) NSString *relativeKeyPath;

+ (ObjectLoader *) sharedObjectLoader;

- (void) loadLocalDataAsDictionary:(NSString *) jsonString;

- (void) loadLocalData:(NSString *) jsonString forKeyPath: (NSString *) keyPath;

- (void) loadRemoteData: (NSString *) keyPath;

- (void) loadRemoteData: (Class) class forKeyPath :(NSString *) keyPath;

- (void) loadRemoteDataAsDictionary;

- (void) requestData: (SEL) requestFinishSelector requestFailedSelector : (SEL) requestFailedSelector withRequestMethod : (NSString *) requestMethod;

- (void) performMapping: (NSDictionary *) jsonObject;

- (BOOL)isNullCollection:(id)object;

- (id) getMappedObject: (id) object toClass: (Class) className;

+ (void) releaseSharedInstance;
@end
