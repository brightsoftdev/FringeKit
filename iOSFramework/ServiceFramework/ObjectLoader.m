//
//  ObjectLoader.m
//  iOSFramework
//
//  Created by macadmin on 16/10/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ObjectLoader.h"
#import "Category.h"
#import "AppConfig.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "ObjectMapping.h"
#import "SBJson.h"

#define DEFAULT_RESULT_KEY_NAME (@"result")

@implementation ObjectLoader

static ObjectLoader *sharedObjectLoader;

@synthesize delegate = _delegate;
@synthesize objectClass = _objectClass;
@synthesize objectRelationship = _objectRelationship;
@synthesize requestParam = _requestParam;
@synthesize relativeKeyPath = _relativeKeyPath;
@synthesize resultObject = _resultObject;

- (id)init
{
    self = [super init];
    if (self) {
        _objectRelationship = [ObjectRelationship new];
        _requestParam = [RequestParam new];
    }
    return self;
}

+ (ObjectLoader *) sharedObjectLoader{
    @synchronized(self){
        if (sharedObjectLoader == nil)
			sharedObjectLoader = [[ObjectLoader alloc] init];
    }
    return sharedObjectLoader;
}

//load json string as a NSDictionary
- (void) loadLocalDataAsDictionary:(NSString *) jsonString{
    
    if ([_requestParam.requestUrl isNilOrEmpty]) {
        if (![_requestParam.requestUrlKeyNameInConfig isNilOrEmpty]) {
            _requestParam.requestUrl = [NSMutableString stringWithString:[[AppConfig sharedInstance] getValueForKey:_requestParam.requestUrlKeyNameInConfig withConfig:@"InterfaceConfig"]];
        }
    }
    
    if ([_requestParam.requestMethod isEqualToString:@"POST"]) {
        NSString * postData = [_requestParam.requestUrlParams JSONRepresentation]; 
        NSLog(@"Post Data: %@", postData);
    }
    
    NSDictionary *jsonObject = [jsonString JSONValue];
    if ([_delegate respondsToSelector:@selector(didLoadDictionaryFinished:)]) {
        [_delegate performSelector:@selector(didLoadDictionaryFinished:) withObject:jsonObject];
    }
}

//load json string as a custom class object
/*
 
 ObjectRelationship *objectRelationship = [[ObjectRelationship alloc] init];
 [objectRelationship makeRelationship:[ComplexDemoModel class] makeRelationshipWithClass:[City class] linkWithKeyPath:@"origin"];
 
 
 ObjectLoader *objectLoader = [[ObjectLoader alloc] init];
 objectLoader.delegate = self;
 objectLoader.objectRelationship = objectRelationship;
 objectLoader.objectClass = [ComplexDemoModel class];
 [objectLoader loadLocalData:jsonStr forKeyPath:@"searchResultRecord"];
 
*/
- (void) loadLocalData:(NSString *) jsonString forKeyPath: (NSString *) keyPath{
    
    if ([_requestParam.requestUrl isNilOrEmpty]) {
        if (![_requestParam.requestUrlKeyNameInConfig isNilOrEmpty]) {
            _requestParam.requestUrl = [NSMutableString stringWithString:[[AppConfig sharedInstance] getValueForKey:_requestParam.requestUrlKeyNameInConfig withConfig:@"InterfaceConfig"]];
        }
    }
    
    if ([_requestParam.requestMethod isEqualToString:@"POST"]) {
        NSString * postData = [_requestParam.requestUrlParams JSONRepresentation]; 
        NSLog(@"Post Data: %@", postData);
    }
    
    NSMutableDictionary *jsonObject = [jsonString JSONValue];
    _relativeKeyPath = keyPath;
    if (jsonObject) {
        [self performMapping: jsonObject];
        
        if ([_delegate respondsToSelector:@selector(didLoadObjectFinished:)]) {
            [_delegate performSelector:@selector(didLoadObjectFinished:) withObject:_resultObject];
        }
	} else {
        [_delegate performSelector:@selector(didLoadObjectFailed:) withObject:nil];
	}
}

//load json string from remote server as a custom class object
- (void) loadRemoteData: (NSString *) keyPath{
    _relativeKeyPath = keyPath;
    [self requestData:@selector(requestFinished:) requestFailedSelector :@selector(requestFailed:) withRequestMethod:_requestParam.requestMethod];
}

/*
 
 NSMutableDictionary *conditions = [[NSMutableDictionary alloc] init];
 [conditions setObject:@"IPHONE_SSM20_PROF" forKey:@"partnerCode"];
 
 RequestParam *requestParam = [[RequestParam alloc] init];
 requestParam.requestUrlParams = conditions;
 requestParam.requestMethod = @"GET";
 requestParam.requestUrlKeyName = @"FindCarrier";
 
 ObjectLoader *objectLoader = [[ObjectLoader alloc] init];
 objectLoader.requestParam = requestParam;
 objectLoader.delegate = self;
 [objectLoader loadRemoteData:[DemoModel class] forKeyPath:@"carrier"];
 
*/
- (void) loadRemoteData: (Class) class forKeyPath :(NSString *) keyPath{
    _objectClass = class;
    _relativeKeyPath = keyPath;
    [self requestData:@selector(requestFinished:) requestFailedSelector :@selector(requestFailed:) withRequestMethod:_requestParam.requestMethod];
}

- (void) requestFinished: (ASIHTTPRequest *) request{
    NSString *jsonStr = [request responseString];
    NSLog(@"Response String: %@", jsonStr);
    NSMutableDictionary *jsonObject = [jsonStr JSONValue];// objectFromJSONString];
    NSString * errorDescription = [jsonObject objectForKey:@"errorDescription"];
    
    if (errorDescription){
        if (![errorDescription isNilOrEmpty]) {
            [_delegate performSelector:@selector(didLoadObjectFailed:) withObject:nil];
            return;
        }
    }
	
    if (jsonObject) {
        [self performMapping: jsonObject];
        if ([_delegate respondsToSelector:@selector(didLoadObjectFinished:)]){
            [_delegate performSelector:@selector(didLoadObjectFinished:) withObject:_resultObject];
        }
	} else {
        [_delegate performSelector:@selector(didLoadObjectFailed:) withObject:nil];
	}
}

- (void) requestFailed:(ASIHTTPRequest *)request {
	NSError *error = [request error];
    NSLog(@"Response Error: %@", error);
    [_delegate performSelector:@selector(didLoadObjectFailed:) withObject:error];
}

//load json string from remote server as a NSDictionary
- (void) loadRemoteDataAsDictionary{
    
    [self requestData:@selector(requestAsDictionaryFinished:) requestFailedSelector :@selector(requestAsDictionaryFailed:) withRequestMethod:_requestParam.requestMethod];
}

- (void) requestAsDictionaryFinished: (ASIHTTPRequest *) request{   
    NSString *jsonStr = [request responseString];
    NSLog(@"Response String: %@", jsonStr);
    NSDictionary *jsonObject = [jsonStr JSONValue ];//objectFromJSONString];
    NSString * errorDescription = [jsonObject objectForKey:@"errorDescription"];
    
    if (errorDescription) {
        if (![errorDescription isNilOrEmpty]) {
            [_delegate performSelector:@selector(didLoadObjectFailed:) withObject:nil];
            return;
        }
    }
	
    if (jsonObject) {
        if ([_delegate respondsToSelector:@selector(didLoadDictionaryFinished:)]) {
            [_delegate performSelector: @selector(didLoadDictionaryFinished:) withObject:jsonObject];
        }
	} else {
        NSError *error = [[NSError alloc] initWithDomain:@"" code:1002 userInfo:nil];
        [_delegate performSelector:@selector(didLoadObjectFailed:) withObject:error];
	}
}

- (void) requestAsDictionaryFailed:(ASIHTTPRequest *)request {
	NSError *error = [request error];
    NSLog(@"Response Error: %@", error);
    [_delegate performSelector:@selector(didLoadObjectFailed:) withObject:error];
}

- (void) requestData: (SEL) requestFinishSelector requestFailedSelector :(SEL) requestFailedSelector withRequestMethod : (NSString *) requestMethod{
    if ([_requestParam.requestUrl isNilOrEmpty]) {
        if (![_requestParam.requestUrlKeyNameInConfig isNilOrEmpty]) {
            _requestParam.requestUrl = [NSMutableString stringWithString:[[AppConfig sharedInstance] getValueForKey:_requestParam.requestUrlKeyNameInConfig withConfig:@"InterfaceConfig"]];
        }
    }
    
    if ([requestMethod isEqualToString:@"POST"]) {
        NSString * postData = [_requestParam.requestUrlParams JSONRepresentation]; 
        NSLog(@"Post Data: %@", postData);
        NSURL *url = [NSURL URLWithString:_requestParam.requestUrl];
        
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        [request setUsername:_requestParam.password];
        [request setPassword:_requestParam.userID];
        [request setRequestMethod:@"POST"];
        [request setRequestHeaders:_requestParam.requestHeader];
        [request setTimeOutSeconds:_requestParam.timeOutValue];
        [request setPostValue:postData forKey:_requestParam.postConditionKeyName];
        [request setDelegate:self];
        [request setDidFinishSelector: requestFinishSelector];
        [request setDidFailSelector: requestFailedSelector];
        [request startAsynchronous];
    }
    else{
        [_requestParam.requestUrl appendString:@"?"];
        
        for (NSString *key in _requestParam.requestUrlParams.allKeys) {
            [_requestParam.requestUrl appendFormat:@"%@=%@&", key, [_requestParam.requestUrlParams valueForKey:key]];
        }
        
        NSLog(@"Request URL: %@", _requestParam.requestUrl);
        NSURL *url = [NSURL URLWithString:_requestParam.requestUrl];
        
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        [request setUsername:_requestParam.password];
        [request setPassword:_requestParam.userID];
        [request setRequestHeaders:_requestParam.requestHeader];
        [request setRequestMethod:@"GET"];
        [request setTimeOutSeconds: _requestParam.timeOutValue];
        [request setDelegate:self];
        [request setDidFinishSelector:requestFinishSelector ];
        [request setDidFailSelector: requestFailedSelector];
        [request startAsynchronous];
    }
}

- (void) performMapping: (NSDictionary *) jsonObject
{
    id json = [jsonObject objectForKey:[_relativeKeyPath isNilOrEmpty]? DEFAULT_RESULT_KEY_NAME: _relativeKeyPath];
    
    //if json is array
    if ([json isKindOfClass:[NSArray class]]) {
        if (!_resultObject) {
            _resultObject = [[NSMutableArray alloc] init];
        }
        
        for (NSDictionary *element in json) {
            id obj = [[_objectClass alloc] init];
            [obj setValuesForKeysWithDictionary:element];
            
            for (RelationEntity *relationEntity in _objectRelationship.relationshipMappings) {
                if ([relationEntity.keyPath rangeOfString:@"."].location != NSNotFound) {
                    id value = [self getMappedObject:[_resultObject valueForKeyPath:relationEntity.keyPath] toClass:relationEntity.subClass];
                    [obj setValue:value forKeyPath:relationEntity.keyPath];
                }
                else{
                    [obj setValue:[self getMappedObject:[element valueForKey:relationEntity.keyPath] toClass:relationEntity.subClass] forKey:relationEntity.keyPath];
                }
            }
            
            [_resultObject addObject:obj];
            [obj release];
        }
    }
    //if json is dictionary
    else if ([json isKindOfClass:[NSDictionary class]]) {
        if (!_resultObject) {
            if (_objectClass == [NSDictionary class]) {
                _resultObject = [[NSMutableDictionary alloc] initWithDictionary:json];
            }
            else{
                _resultObject = [[_objectClass alloc] init];
                [_resultObject setValuesForKeysWithDictionary:json];
            }
        }
        for (RelationEntity *relationEntity in _objectRelationship.relationshipMappings) {
            if ([relationEntity.keyPath rangeOfString:@"."].location != NSNotFound) {
                [_resultObject setValue:[self getMappedObject:[_resultObject valueForKeyPath:relationEntity.keyPath] toClass:relationEntity.subClass] forKeyPath:relationEntity.keyPath];
            }
            else{
                [_resultObject setValue:[self getMappedObject:[_resultObject valueForKey:relationEntity.keyPath] toClass:relationEntity.subClass] forKey:relationEntity.keyPath];
            }
        }
    }
    else{
        NSLog(@"json object is a nil value...");
    }
}

//handle leaf type 
- (id) getMappedObject: (id) object toClass: (Class) className {
    if ([object isKindOfClass:[NSArray class]]) {
        NSMutableArray *tempArray = [[[NSMutableArray alloc] init] autorelease];
        for (NSDictionary *element in object) {
            id loopobj = [[className alloc] init];
            [loopobj setValuesForKeysWithDictionary:element];
            [tempArray addObject:loopobj];
            [loopobj release];
        }
        return tempArray;
    }
    else if([object isKindOfClass:[NSDictionary class]])
    {
        id obj = [[[className alloc] init] autorelease];
        [obj setValuesForKeysWithDictionary:object];
        return obj;
    }
    return nil;
}

- (BOOL)isNullCollection:(id)object {
    if ([object respondsToSelector:@selector(objectForKey:)]) {
        return NO;
    }
    
    if ([object respondsToSelector:@selector(countForObject:)] && [object count] > 0) {        
        if ([object countForObject:[NSNull null]] == [object count]) {
            NSLog(@"Found a collection containing only NSNull values...");
            return YES;
        }
    }
    
    return NO;
}

- (void) dealloc
{
    [_resultObject release];
    [_objectRelationship release];
    [_requestParam release];
    [_relativeKeyPath release];
	[super dealloc];
}

- (oneway void)superRelease {
    [super release];
}

+ (void)releaseSharedInstance {
    @synchronized(self) {
        [sharedObjectLoader superRelease];
        sharedObjectLoader = nil;
    }
}

@end
