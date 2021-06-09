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
    //[self openiClound];
    [self openAppstore];
}

- (void)openAppstore{
    UIApplication *app = [UIApplication sharedApplication];
    NSURL *url = [NSURL URLWithString:@"itms-apps://apps.apple.com/cn/app/"];
    [app openURL:url options:@{} completionHandler:nil];
}


- (void)openiClound{
    NSArray *documentTypes = @[@"public.content", @"public.text", @"public.source-code", @"public.audiovisual-content", @"com.adobe.pdf", @"com.apple.keynote.key", @"com.microsoft.word.doc", @"com.microsoft.excel.xls"];
    UIDocumentPickerViewController *dp = [[UIDocumentPickerViewController alloc]initWithDocumentTypes:documentTypes inMode:UIDocumentPickerModeOpen];
    dp.delegate = self;
    [self presentViewController:dp animated:NO completion:nil];
}

//MARK: UIDocumentPickerDelegate
-(void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentsAtURLs:(NSArray<NSURL *> *)urls{
    NSLog(@"===%@",urls);
}

@end
