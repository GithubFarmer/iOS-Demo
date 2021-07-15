//
//  PDFObject.h
//  XibView
//
//  Created by Hibiscus on 2021/7/5.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>
#import "CMManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface PDFObject : NSObject

+ (void)showPdfFilePath:(NSString *)file toView:(WKWebView *)web;

@end

NS_ASSUME_NONNULL_END
