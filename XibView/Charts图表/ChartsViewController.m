//
//  ChartsViewController.m
//  XibView
//
//  Created by Hibiscus on 2021/6/2.
//

#import "ChartsViewController.h"
#import "BarChartVC.h"

@interface ChartsViewController ()

@end

@implementation ChartsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)lineAction:(id)sender {
}
- (IBAction)barAction:(id)sender {
    [self.navigationController pushViewController:[[BarChartVC alloc]init] animated:YES];
}
- (IBAction)pieAction:(id)sender {
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
