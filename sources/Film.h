//
//  Film.h
//  Cinequest
//
//  Created by Hai Nguyen on 11/5/13.
//  Copyright (c) 2013 San Jose State University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CinequestItem.h"

@interface Film : CinequestItem {
    NSMutableArray *schedules;
    NSString *tagline;
    NSString *genre;
    NSString *director;
    NSString *producer;
    NSString *writer;
    NSString *cinematographer;
    NSString *editor;
    NSString *cast;
    NSString *country;
    NSString *language;
    NSString *filmInfo;
}

@property (strong, nonatomic) NSMutableArray *schedules;
@property (strong, nonatomic) NSString *tagline;
@property (strong, nonatomic) NSString *genre;
@property (strong, nonatomic) NSString *director;
@property (strong, nonatomic) NSString *producer;
@property (strong, nonatomic) NSString *writer;
@property (strong, nonatomic) NSString *cinematographer;
@property (strong, nonatomic) NSString *editor;
@property (strong, nonatomic) NSString *cast;
@property (strong, nonatomic) NSString *country;
@property (strong, nonatomic) NSString *language;
@property (strong, nonatomic) NSString *filmInfo;

@end