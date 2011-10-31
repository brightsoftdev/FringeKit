//
//  NSArray+iOSAddtions.m
//  iOSFramework
//
//  Created by macadmin on 22/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//
//https://github.com/sgonzalez/NSArray-Categories
//

#import "NSArray+iOSAddtions.h"

@implementation NSArray (iOSAddtions)

- (NSArray *) groupArrayByField: (NSString *) groupString {
    
    NSMutableArray *tempCollectionArray = [[NSMutableArray alloc] initWithArray:self];
    NSMutableArray *collection = [[NSMutableArray alloc] init];
    [collection removeAllObjects];
    NSArray *arrIndexes = [NSArray arrayWithArray:
                           [@"A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z"
                            componentsSeparatedByString:@","]];
    for (NSString *indexString in arrIndexes) {
        NSPredicate *groupPredicate = [NSPredicate predicateWithFormat:@"self.%@ BEGINSWITH %@", groupString, indexString];
        
        NSArray *group = [tempCollectionArray filteredArrayUsingPredicate: groupPredicate];
        if ([group count] > 0) {
            NSDictionary *groupDict = [NSDictionary dictionaryWithObject:group forKey:indexString];
            [collection addObject:groupDict];
            [tempCollectionArray removeObjectsInArray:group];
        }
    }
    [tempCollectionArray release];
    return collection;
}

- (id)randomObject {
	return [self objectAtIndex:[self randomIndex]];
}

- (int)randomIndex {
	return arc4random()%[self count];
}

- (void)shuffle {
	NSMutableArray *tmp = [NSMutableArray arrayWithArray:self];
	for (int i=[tmp count]-1; i>0; i--) {
		[tmp exchangeObjectAtIndex: arc4random() % (i+1) withObjectAtIndex: i];
	}
	self = [NSArray arrayWithArray:tmp];
}

- (NSArray *)shuffledArray {
	NSArray *shuffledArray = [NSArray arrayWithArray:self];
	[shuffledArray shuffle];
	return shuffledArray;
}

@end

@implementation NSMutableArray (iOSAddtions)

- (NSArray *) sortByField: (NSString *) sortFieldString{
    
    NSSortDescriptor *sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:sortFieldString ascending:YES] autorelease];
    NSArray *sortDescriptorsArray = [NSArray arrayWithObject:sortDescriptor];
    NSArray *sortedArray = [self sortedArrayUsingDescriptors:sortDescriptorsArray];
    return sortedArray;
}

@end