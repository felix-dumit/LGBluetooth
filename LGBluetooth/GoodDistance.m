//
//  GoodAverage.m
//  Umwho
//
//  Created by Ramon Carvalho Maciel on 4/3/15.
//  Copyright (c) 2015 Umwho. All rights reserved.
//

#import "GoodDistance.h"

@interface GoodDistance ()
@property (nonatomic, strong) NSMutableArray *array;
@end

@implementation GoodDistance

- (instancetype)init {
    self = [super init];

    if (self) {
        self.array = [NSMutableArray array];
    }

    return self;
}

- (void)addAccuracy:(double)number {
    [self.array addObject:@(number)];
}

- (void)reset {
    [self.array removeAllObjects];
}

- (double)average {
    NSUInteger count = [self.array count];

    if (count) {
        NSArray *rangeArray = self.array;

        if (count >= 10) {
            NSUInteger first = count / 10;
            NSUInteger size = (count * 8) / 10;

            rangeArray = [rangeArray sortedArrayUsingSelector:@selector(compare:)];
            rangeArray = [rangeArray subarrayWithRange:NSMakeRange(first, size)];
        }

        double sum = 0;
        NSUInteger num = 0;

        for (NSUInteger i = 0; i < [rangeArray count]; i++) {
            sum = sum + [[rangeArray objectAtIndex:i] floatValue];
            num++;
        }

        return sum / num;
    }

    return 1e6f;
}

- (void)addRSSI:(double)rssi {
    double accuracy = [GoodDistance calculateAccuracyForRSSI:rssi];

    if ((accuracy >= 0.0) && (accuracy <= 80.0)) {
        [self addAccuracy:[GoodDistance calculateAccuracyForRSSI:rssi]];
    } else {
//        NSLog(@"GoodDistance >> Invalid RSSI value ignored");
    }
}

+ (double)calculateAccuracyForRSSI:(double)rssi {
    const static NSInteger tx_power = -59;

    if (rssi == 0) {
        return -1; // if we cannot determine accuracy, return -1.
    }

    double ratio = rssi * 1.0 / tx_power;

    if (ratio < 1.0) {
        return pow(ratio, 10);
    } else {
        double accuracy = (0.89976) * pow(ratio, 7.7095) + 0.111;
        return accuracy;
    }
}

@end
