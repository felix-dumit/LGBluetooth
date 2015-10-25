//
//  GoodAverage.h
//  Umwho
//
//  Created by Ramon Carvalho Maciel on 4/3/15.
//  Copyright (c) 2015 Umwho. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodDistance : NSObject

- (CGFloat)average;
- (void)addRSSI:(CGFloat)rssi;
- (void)addAccuracy:(CGFloat)number;
- (void)reset;
+ (CGFloat)calculateAccuracyForRSSI:(CGFloat)rssi;

@end
