//
//  xFormat.m
//  XibView
//
//  Created by Hibiscus on 2021/6/3.
//

#import "xFormat.h"

@implementation xFormat{
    NSArray *_data;
}

-(id)initWithData:(NSArray *)xData{
    self = [super init];
    if(self){
        _data = xData;
    }
    return  self;
}

- (NSString *)stringForValue:(double)value axis:(ChartAxisBase *)axis{
    return  _data[(int)value];
}

@end
