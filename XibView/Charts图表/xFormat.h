//
//  xFormat.h
//  XibView
//
//  Created by Hibiscus on 2021/6/3.
//

#import <Foundation/Foundation.h>
@import Charts;

NS_ASSUME_NONNULL_BEGIN

@interface xFormat : NSObject<IChartAxisValueFormatter>

- (id)initWithData:(NSArray *)xData;

@end

NS_ASSUME_NONNULL_END
