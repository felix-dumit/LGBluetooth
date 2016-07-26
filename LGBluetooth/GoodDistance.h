//
//  GoodAverage.h
//  Umwho
//
//  Created by Ramon Carvalho Maciel on 4/3/15.
//  Copyright (c) 2015 Umwho. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodDistance : NSObject

- (double)average;
- (void)addRSSI:(double)rssi;
- (void)addAccuracy:(double)number;
- (void)reset;
+ (double)calculateAccuracyForRSSI:(double)rssi;

@end
