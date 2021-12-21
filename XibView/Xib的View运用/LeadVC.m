//
//  LeadVC.m
//  XibView
//
//  Created by Hibiscus on 2021/6/2.
//

#import "LeadVC.h"

@interface LeadVC ()

@end

@implementation LeadVC
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIButton *back = [[UIButton alloc]init];
    back.frame = CGRectMake(0, 0, 40, 70);
    [self.view addSubview:back];
    back.backgroundColor = [UIColor redColor];
    [back addTarget:self action:@selector(backBtn) forControlEvents:UIControlEventTouchUpInside];
    [self semaphore];
}
 

- (void)semaphore {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    // 设定信号量 需要有几条线程
    dispatch_semaphore_t sem = dispatch_semaphore_create(0);
    dispatch_async(queue, ^{
        sleep(1);
        NSLog(@"22212222");
        // 信号量 +1 向下执行
        dispatch_semaphore_signal(sem);
    });
    NSLog(@"===========");
    // 信号量 -1 线程休眠 如果信号量 >0 线程继续向下执行
    dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
    NSLog(@"cccccccccccccc");
    
    
}

- (void)backBtn{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setHidden:NO];
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
