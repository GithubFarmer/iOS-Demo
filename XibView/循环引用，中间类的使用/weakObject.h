//
//  weakObject.h
//  XibView
//
//  Created by Hibiscus on 2021/6/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface weakObject : NSObject

@property (nonatomic, weak) id target;

- (id)initWithTarget:(id)target;

+ (void)eat;

- (void)finishlog:(NSString *)num;

@end

NS_ASSUME_NONNULL_END
