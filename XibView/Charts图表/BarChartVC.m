//
//  BarChartVC.m
//  XibView
//
//  Created by Hibiscus on 2021/6/3.
//

#import "BarChartVC.h"
#import "XibView-Bridging-Header.h"
#import "xFormat.h"

@interface BarChartVC ()
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (nonatomic, strong) BarChartView *chartView;

@end

@implementation BarChartVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initChart];
    
}

- (void)initChart{
    _chartView = [[BarChartView alloc]initWithFrame:self.backView.bounds];
    _chartView.backgroundColor = [UIColor clearColor];
//    _chartView.gridBackgroundColor = [UIColor clearColor];
    [self.backView addSubview:_chartView];
    [_chartView setMaxVisibleCount:13];
    _chartView.noDataText = @"没有数据";
    _chartView.drawValueAboveBarEnabled = YES;
    _chartView.drawBarShadowEnabled = YES;
    _chartView.scaleXEnabled = NO;
    _chartView.scaleYEnabled = NO;
    _chartView.doubleTapToZoomEnabled = NO;
    _chartView.dragEnabled = YES;
    _chartView.dragDecelerationEnabled = NO;
    _chartView.dragDecelerationFrictionCoef = NO;
    //x轴设置
    ChartXAxis *xAixs = _chartView.xAxis;
    xAixs.axisLineWidth = 1;
    xAixs.labelPosition = XAxisLabelPositionBottom;
    xAixs.drawGridLinesEnabled = NO;
    xAixs.axisMinimum = -0.5;
    xAixs.granularity = 1;
    xAixs.axisLineColor = [UIColor redColor];
//    xAixs.gridColor = [UIColor blackColor];
//    xAixs.gridLineWidth = 1;
    
    
    //y轴设置
    ChartYAxis *yAixs = _chartView.leftAxis; //获取左边Y轴
    yAixs.axisLineWidth = 1;
    yAixs.labelPosition = YAxisLabelPositionOutsideChart;
  
    yAixs.axisMinimum = 0;
    yAixs.gridLineDashLengths = @[@3.f,@3.f];
    yAixs.gridColor = [UIColor redColor];
    yAixs.gridLineWidth = 1;
    
    yAixs.axisLineColor = [UIColor blackColor];
//    yAixs.zeroLineColor = [UIColor redColor];
    yAixs.gridAntialiasEnabled = YES;
   
    
    _chartView.rightAxis.enabled = NO;
    _chartView.legend.enabled = YES;
    _chartView.chartDescription.text = @"年度考核";
    _chartView.chartDescription.yOffset = -30;
    [_chartView animateWithYAxisDuration:1.f];
    
    CAGradientLayer *gradientLayer = CAGradientLayer.layer;
    gradientLayer.colors = @[[UIColor redColor], [UIColor yellowColor]];
    //@[[UIColor redColor].CGColor, [UIColor yellowColor].CGColor];
    gradientLayer.locations = @[[NSNumber numberWithFloat:0.25],[NSNumber numberWithFloat:1.0]];
//    @[0.25 , 1.0];
    gradientLayer.startPoint = CGPointMake(1, 0);
//    CGPoint(x: 1, y:0)
    gradientLayer.endPoint = CGPointMake(1, 1);
    //CGPoint(x:1, y: 1)
//    gradientLayer.frame = CGRectMake(, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
    //CGRect(x: rect[0], y: rect[1], width: rect[2], height: rect[3])
//    gradientLayer.cornerRadius = (rect[2] * 0.5)

    [self setupData];
}


- (void)setupData{
    //x轴数据显示
    NSArray *xData = @[@"1月", @"2月",@"3月",@"4月",@"5月",@"6月",@"7月",@"8月",@"9月",@"10月",@"11月",@"12月"];
    _chartView.xAxis.valueFormatter = [[xFormat alloc]initWithData:xData];
    [_chartView.xAxis setLabelCount:xData.count force:NO];
    
    //Y轴
    NSArray *y_data = @[@"13",@"16",@"9",@"8",@"18",@"10",@"30",@"11",@"14",@"7",@"16",@"12"];
    BarChartDataSet *ySet = nil;
    NSMutableArray *ydata = [NSMutableArray new];
    for(int i = 0; i < xData.count; i++){
        BarChartDataEntry *entry = [[BarChartDataEntry alloc]initWithX:i y:[y_data[i] floatValue]];
        
        [ydata addObject:entry];
    }
    
    //图表是否绘制过
    if(_chartView.data.dataSetCount){
        ySet = (BarChartDataSet *)_chartView.data.dataSets[0];
        [ySet replaceEntries:ydata];
//        _chartView.data = [[BarChartData alloc]initWithDataSet:ySet];
        [_chartView.data notifyDataChanged];
        [_chartView notifyDataSetChanged];
    }else{
        
        ySet = [[BarChartDataSet alloc]initWithEntries:ydata label:nil];
     
        ySet.highlightEnabled = NO;
        [ySet setLabel:@"精华"];
        [ySet setColor:[UIColor cyanColor]];
        ySet.barShadowColor = [UIColor clearColor];
        ySet.barBorderColor = [UIColor blackColor];
//        ySet.barBorderWidth = 3;
        
      
        ySet.drawValuesEnabled = YES;
        NSMutableArray *dataSets = [NSMutableArray new];
        [dataSets addObject:ySet];
        BarChartData *data = [[BarChartData alloc]initWithDataSets:dataSets];
        data.barWidth = 0.5;
        _chartView.data = data;
        [data setDrawValues:YES];
        NSLog(@"%d",ySet.isDrawValuesEnabled);
        
    }
}


@end
