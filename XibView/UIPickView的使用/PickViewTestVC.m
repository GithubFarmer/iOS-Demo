//
//  PickViewTestVC.m
//  XibView
//
//  Created by Hibiscus on 2021/6/18.
//

#import "PickViewTestVC.h"

@interface PickViewTestVC ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UIPickerView *pickView;

@end

@implementation PickViewTestVC{
    NSArray *titles;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.pickView.backgroundColor = [UIColor whiteColor];
    self.pickView.delegate = self;
    self.pickView.dataSource = self;
    titles = @[@"今天",@"明天",@"后天",@"前天",@"将来",@"现在",@"刘娜",@"激励娜娜",@"网解释",@"周几搭建"];
    
    [self clearSeparatorWithView:self.pickView];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return titles.count;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return titles[row];
}

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString *normalRowString = [self pickerView:pickerView titleForRow:row forComponent:component];
    NSString *selectRowString = [self pickerView:pickerView titleForRow:[pickerView selectedRowInComponent:component] forComponent:component];
    if (row == [pickerView selectedRowInComponent:component]) {
        return [[NSAttributedString alloc] initWithString:selectRowString attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:21]}];
    } else {
        return [[NSAttributedString alloc] initWithString:normalRowString attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
    }
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSLog(@"===component:%ld,row:%ld",component,row);
    [pickerView reloadAllComponents];
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
   UILabel *pickerLabel = (UILabel *)view;
   if (!pickerLabel){
       pickerLabel = [[UILabel alloc] init];
       pickerLabel.font =[UIFont systemFontOfSize:20];
       pickerLabel.textColor = [UIColor blackColor];
       pickerLabel.textAlignment = 1;
       [pickerLabel setBackgroundColor:[UIColor clearColor]];
   }
//   pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    pickerLabel.attributedText = [self pickerView:pickerView attributedTitleForRow:row forComponent:component];
   //在该代理方法里添加以下两行代码删掉上下的黑线
//   [[pickerView.subviews objectAtIndex:1] setHidden:YES];
//   [[pickerView.subviews objectAtIndex:2] setHidden:YES];
    UIView *tmpView = [pickerView.subviews lastObject];
    tmpView.backgroundColor = [UIColor clearColor];
   UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tmpView.bounds.size.width, 1)];
   lineView1.backgroundColor = [UIColor blackColor];
   [tmpView addSubview:lineView1];

   UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, tmpView.bounds.size.height-1, tmpView.bounds.size.width, 1)];
   lineView2.backgroundColor =[UIColor blackColor];
   [tmpView addSubview:lineView2];
 
    
   return pickerLabel;
}

- (void)clearSeparatorWithView:(UIView * )view
{
    if(view.subviews != 0  )
    {
        if(view.bounds.size.height < 5)
        {
            view.backgroundColor = [UIColor clearColor];
        }
        
        [view.subviews enumerateObjectsUsingBlock:^( UIView *  obj, NSUInteger idx, BOOL *  stop) {
            [self clearSeparatorWithView:obj];
        }];
    }
    
}

@end
