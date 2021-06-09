//
//  XibViewController.m
//  XibView
//
//  Created by Hibiscus on 2021/6/1.
//

#import "XibViewController.h"
#import "TestView.h"
#import "AAView.h"
@interface XibViewController ()

@end

@implementation XibViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //对添加的view进行布局，如果超出屏幕还是会显示,但是没有办法对其进行操作点击

    AAView *aView = [[NSBundle mainBundle]loadNibNamed:@"AAView" owner:nil options:nil].firstObject;
    aView.frame = CGRectMake(100, 200, 300, 80);
    [self.view addSubview:aView];
    
    AAView *aview1 = [[AAView alloc]init];
    aview1.frame = CGRectMake(100, 400, 300, 180);
    [self.view addSubview:aview1];
    
    //错误构建----实例
    TestView *view1 = [[TestView alloc]initWithFrame:CGRectMake(10, 80, 0, 0)];
    view1.bgView.backgroundColor = [UIColor redColor];
    [self.view addSubview:view1];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
