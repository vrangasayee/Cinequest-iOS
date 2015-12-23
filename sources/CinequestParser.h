//
//  CinequestParser.h
//  Cinequest
//
//  Created by Hai Nguyen on 11/28/13.
//  Copyright (c) 2013 San Jose State University. All rights reserved.
//  Renamed Chris Pollett 2015

#import <Foundation/Foundation.h>

@class Festival;
@class CinequestAppDelegate;

@interface CinequestParser : NSObject
{
    CinequestAppDelegate *delegate;
}

@property (strong, nonatomic) NSMutableArray *shows;

- (NSMutableArray *)getShows;
- (void) parseShows;
- (void) fakeParseShows;
- (Festival*)parseFestival;

@end
