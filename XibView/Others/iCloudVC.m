//
//  iCloudVC.m
//  XibView
//
//  Created by Hibiscus on 2021/6/9.
//

#import "iCloudVC.h"

@interface iCloudVC ()<UIDocumentPickerDelegate>

@end

@implementation iCloudVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)openiColud:(id)sender {
    [self openiClound];
//    [self openAppstore];
    [self getCachesPath];
}

- (void)openAppstore{
    UIApplication *app = [UIApplication sharedApplication];
    NSURL *url = [NSURL URLWithString:@"itms-apps://apps.apple.com/cn/app/"];
    [app openURL:url options:@{} completionHandler:nil];
}


-(NSString *)getCachesPath{
    // 获取Caches目录路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesDir = [paths objectAtIndex:0];
    NSLog(@"==%@",cachesDir);
    NSString *filePath = [cachesDir stringByAppendingPathComponent:@"表情.txt"];
    [self fileSizeAtPath:filePath];
    return filePath;
}



- (void)openiClound{
    NSArray *documentTypes = @[@"public.content", @"public.text", @"public.source-code", @"public.audiovisual-content", @"com.adobe.pdf", @"com.apple.keynote.key", @"com.microsoft.word.doc", @"com.microsoft.excel.xls"];
    UIDocumentPickerViewController *dp = [[UIDocumentPickerViewController alloc]initWithDocumentTypes:documentTypes inMode:UIDocumentPickerModeOpen];
    dp.delegate = self;
    [self presentViewController:dp animated:NO completion:nil];
}

//MARK: UIDocumentPickerDelegate
-(void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentsAtURLs:(NSArray<NSURL *> *)urls{
    
    //选择文件之后进行存储到本地沙盒进行使用
    NSLog(@"===%@",urls);
    for (NSURL *url in urls) {
        [self fileSizeAtPath:[NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil]];
        NSNumber *size;
        [url getResourceValue:&size forKey:NSURLFileSizeKey error:nil];
        CGFloat sizeCount = [size floatValue] /(1024.0*1024.0);
        NSLog(@"size is %fM === %fk",sizeCount,[size floatValue]);
    }
}

- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentAtURL:(NSURL *)url{
    NSLog(@"url==%@",url);
}

//计算原始文件的大小
- (long long) fileSizeAtPath:(NSString*) filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        double size = [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
        NSLog(@"file:%f ====%@",size,[self fileSizeWithInterge:size]);
        return size;
    }
    return 0;
}


//计算文件大小
- (NSString *)fileSizeWithInterge:(NSInteger)size{
//     1k = 1024, 1m = 1024k
    if (size < 1024 * 1024){// 小于1m
        CGFloat aFloat = size/1024.0;
        return [NSString stringWithFormat:@"%.2fK",aFloat];
    }else if (size < 1024 * 1024 * 1024){// 小于1G
        CGFloat aFloat = size/(1024 * 1024);
        return [NSString stringWithFormat:@"%.2fM",aFloat];
    }else{
        CGFloat aFloat = size/(1024*1024*1024);
        return [NSString stringWithFormat:@"%.2fG",aFloat];
    }
}

@end
