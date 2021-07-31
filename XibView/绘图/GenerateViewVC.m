//
//  GenerateViewVC.m
//  XibView
//
//  Created by Hibiscus on 2021/7/15.
//

#import "GenerateViewVC.h"

@interface GenerateViewVC ()
@property (weak, nonatomic) IBOutlet UIImageView *aa;

@end

@implementation GenerateViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.aa.backgroundColor = [UIColor yellowColor];
    self.aa.image = [self createImage:[self createView]];
    UIImageWriteToSavedPhotosAlbum(self.aa.image, self, nil, nil);
}

- (UIImage *)createImage:(UIView *)mainView{
    UIGraphicsBeginImageContextWithOptions(mainView.bounds.size, NO, 0);
    CGContextRef cxt = UIGraphicsGetCurrentContext();
    [mainView.layer renderInContext:cxt];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


- (UIView *)createView{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
    view.backgroundColor = [UIColor redColor];
    UIView *sonView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, 40, 40)];
    view.backgroundColor = [UIColor blueColor];
    UIImageView *imv = [[UIImageView alloc]initWithFrame:CGRectMake(10, 30, 40, 30)];
    [view addSubview:imv];
    imv.image = [UIImage imageNamed:@"photo"];
    [view addSubview:sonView];
    return  view;
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
