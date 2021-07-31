//
//  ViewController.m
//  XibView
//
//  Created by Hibiscus on 2021/4/28.
//

#import "ViewController.h"
#import "XibViewController.h"
#import "LeadVC.h"
#import "ChartsViewController.h"
#import "ContextVC.h"
#import "ViewTransformImageVC.h"
#import "iCloudVC.h"
#import "PickViewTestVC.h"
#import "GenerateViewVC.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation ViewController{
    NSArray *array;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"小 demo";
    array = @[@"xib的自定义view使用",@"app引导图",@"图表",@"绘制图片",@"view转化为image",@"打开pdf",@"pickView的使用",@"View生成Image的VC"];
    UITableView *infoTab = [[UITableView alloc]init];
    infoTab.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    infoTab.delegate = self;
    infoTab.dataSource = self;
    [self.view addSubview:infoTab];
    [infoTab registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

//MARK:----UITableViewDelegate, UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = array[indexPath.row];
    return  cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  array.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        
        [self.navigationController pushViewController:[[XibViewController alloc]init] animated:YES];
    }else if (indexPath.row == 1){
        //scrollView布局方式
        //横向布局:利用shift按钮，对scrollView的contentView进行横向布局，横向滚动
        [self.navigationController pushViewController:[[LeadVC alloc]init] animated:YES];
    }else if (indexPath.row == 2){
        [self.navigationController pushViewController:[[ChartsViewController alloc]init] animated:YES];
    }else if (indexPath.row == 3){
        [self.navigationController pushViewController:[[ContextVC alloc]init] animated:YES];
    }else if (indexPath.row == 4){
        [self.navigationController pushViewController:[[ViewTransformImageVC alloc]init] animated:YES];
    }else if (indexPath.row == 5){
        [self.navigationController pushViewController:[[iCloudVC alloc]init] animated:YES];
    }else if (indexPath.row == 6){
        [self.navigationController pushViewController:[[PickViewTestVC alloc]init] animated:YES];
    }else if (indexPath.row == 7){
        [self.navigationController pushViewController:[[GenerateViewVC alloc]init] animated:YES];
    }
}

- (void)item1{
   
}

- (void)item2{
  
}

- (void)item3{
    
}

@end
