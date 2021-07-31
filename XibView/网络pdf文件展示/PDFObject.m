//
//  PDFObject.m
//  XibView
//
//  Created by Hibiscus on 2021/7/5.
//

#import "PDFObject.h"

@implementation PDFObject

+ (void)showPdfFilePath:(NSString *)file toView:(WKWebView *)web{
    [self downloadUrl:file toWeb:web];
}

+ (void)downloadUrl:(NSString *)downloadUrl toWeb:(WKWebView *)web{
    if(![downloadUrl hasSuffix:@"pdf"]){
        [[CMManager sharedCMManager]showTipsWithMsg:@"该文件不是pdf格式"];
        return;
    }
    NSArray *path = [downloadUrl componentsSeparatedByString:@"/"];
    NSString *fileName = [path lastObject];
    if([self isExistFile:fileName]){
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *path = [paths objectAtIndex:0];
        NSString *pathString = [path stringByAppendingPathComponent:fileName];
        NSLog(@"pathString:%@",pathString);
        [self loadDocument:pathString toWeb:web];
    }else{
        [self downloadFile:downloadUrl toWeb:web] ;
    }
    
}

+(BOOL)isExistFile:(NSString *)fileName{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path= [paths objectAtIndex:0];
    NSString *filePath= [path stringByAppendingPathComponent:fileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL result = [fileManager fileExistsAtPath:filePath];
    return result;
}

//下载文件
+ (void)downloadFile:(NSString *)fileUrl toWeb:(WKWebView *)web{
    NSLog(@"fileUrl:%@",fileUrl);
//    __weak typedef(self) weakself = self;
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:fileUrl]];
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
         
          //6.处理数据  block所在线程为子线程
          NSLog(@"%@---%@",location,[NSThread currentThread]);
          
          //6.1 拼接文件全路径 ： 保存在tmp目录下得文件随时都回被删除，因此需要移动文件
          NSString *fullPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:response.suggestedFilename];
          
          //6.2 剪切文件
          [[NSFileManager defaultManager]moveItemAtURL:location toURL:[NSURL fileURLWithPath:fullPath] error:nil];
          NSLog(@"%@",fullPath);
          [self loadDocument:fullPath toWeb:web];
      }];
    [downloadTask resume];
}


//显示文件
+ (void)loadDocument:(NSString *)string toWeb:(WKWebView *)web{
    NSURL *url = [NSURL fileURLWithPath:string];
    [web loadFileURL:url allowingReadAccessToURL:[url URLByDeletingLastPathComponent]];
}


@end
