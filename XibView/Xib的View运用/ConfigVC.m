//
//  ConfigVC.m
//  XibView
//
//  Created by Hibiscus on 2021/6/3.
//

#import "ConfigVC.h"

@interface ConfigVC ()

@end

@implementation ConfigVC

#pragma mark- Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark- InitSubviews && ConfigData
//初始化界面
- (void)yt_initSubviews {
}
//界面数据配置
- (void)yt_configData {
}

#pragma mark- Request && Response


#pragma mark- Event Response

- (void)buttonAction:(UIButton *)button {
    [self hideView];
}

- (void)hideView{
    
}

#pragma mark- Delegate && DataSource

#pragma mark- Private Methods(一般不要在控制器添加这个方法,因为这个方法属于数据加工，并不是业务逻辑)

//MARK: 点赞

//MARK:评论

#pragma mark- Setter && Getter


@end
