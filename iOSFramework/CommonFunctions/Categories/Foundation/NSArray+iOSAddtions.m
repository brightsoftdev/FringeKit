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
    NSMutableArray *collectionWithEngChar = [[NSMutableArray alloc] init];
    [collection removeAllObjects];
    NSArray *arrIndexes = [NSArray arrayWithArray:
                           [@"A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,#"
                            componentsSeparatedByString:@","]];
    for (NSString *indexString in arrIndexes) {
        NSPredicate *groupPredicate = [NSPredicate predicateWithFormat:@"self.%@ BEGINSWITH[c] %@", groupString, indexString];
        
        NSArray *group = [tempCollectionArray filteredArrayUsingPredicate: groupPredicate];
        [collectionWithEngChar addObjectsFromArray:group];
        
        if ([group count] > 0) {
            NSDictionary *groupDict = [NSDictionary dictionaryWithObject:group forKey:indexString];
            [collection addObject:groupDict];
            [tempCollectionArray removeObjectsInArray:group];
        }
    }
    
    NSPredicate *thePredicate = [NSPredicate predicateWithFormat:@"NOT (SELF in %@)", collectionWithEngChar];
    
    //NSLog(@"filtered collection: %@", [tempCollectionArray filteredArrayUsingPredicate:thePredicate]);
    NSArray *collectionWithNotEng = [tempCollectionArray filteredArrayUsingPredicate:thePredicate];
    NSDictionary *dicWithNotEng = [[NSDictionary alloc] initWithObjectsAndKeys:collectionWithNotEng, @"#", nil];
    [collection addObject:dicWithNotEng];
    
    [dicWithNotEng release];
    [tempCollectionArray release];
    [collectionWithEngChar release];
    return collection;
}

- (NSDictionary *) groupArrayAsDictionaryByField: (NSString *) groupString{
    NSMutableArray *tempCollectionArray = [[NSMutableArray alloc] initWithArray:self];
    NSMutableDictionary *collection = [[NSMutableDictionary alloc] init];
    
    NSMutableArray *collectionWithEngChar = [[NSMutableArray alloc] init];
    
    [collection removeAllObjects];
    NSArray *arrIndexes = [NSArray arrayWithArray:
                           [@"A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,#"
                            componentsSeparatedByString:@","]];
    for (NSString *indexString in arrIndexes) {
        NSPredicate *groupPredicate = [NSPredicate predicateWithFormat:@"self.%@ BEGINSWITH[c] %@", groupString, indexString];
        
        NSArray *group = [tempCollectionArray filteredArrayUsingPredicate: groupPredicate];
        NSLog(@"in: %@", group);
        
        if ([group count] > 0) {
            [collection setObject:group forKey:indexString];
            [tempCollectionArray removeObjectsInArray:group];
        }
    }
    
    NSPredicate *thePredicate = [NSPredicate predicateWithFormat:@"NOT (SELF in %@)", collectionWithEngChar];
    
    NSArray *collectionWithNotEng = [tempCollectionArray filteredArrayUsingPredicate:thePredicate];
    [collection setObject:collectionWithNotEng forKey:@"#"];
    
    [collectionWithEngChar release];
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

- (NSArray *) sortByField: (NSString *) sortFieldString{
    NSSortDescriptor *sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:sortFieldString ascending:YES] autorelease];
    NSArray *sortDescriptorsArray = [NSArray arrayWithObject:sortDescriptor];
    NSArray *sortedArray = [self sortedArrayUsingDescriptors:sortDescriptorsArray];
    return sortedArray;
}

@end

@implementation NSMutableArray (iOSAddtions)

- (NSArray *) sortByField: (NSString *) sortFieldString{
    NSSortDescriptor *sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:sortFieldString ascending:YES] autorelease];
    NSArray *sortDescriptorsArray = [NSArray arrayWithObject:sortDescriptor];
    NSArray *sortedArray = [self sortedArrayUsingDescriptors:sortDescriptorsArray];
    //NSLog(@"%@", sortedArray);
    return sortedArray;
}

@end