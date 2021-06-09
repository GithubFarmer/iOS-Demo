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
