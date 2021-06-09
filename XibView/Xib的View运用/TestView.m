//
//  TestView.m
//  XibView
//
//  Created by Hibiscus on 2021/4/28.
//

#import "TestView.h"

@interface TestView()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttontopConstant;


@end

@implementation TestView
-(void)awakeFromNib {
    [super awakeFromNib];
    [[NSBundle mainBundle]loadNibNamed:@"TestView"owner:self options:nil];
    [self addSubview:self.bgView];

}

 

-(instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle]loadNibNamed:@"TestView"owner:self options:nil];
        self.frame = CGRectMake(frame.origin.x, frame.origin.y, self.bgView.bounds.size.width, self.bgView.bounds.size.height);
        [self addSubview:self.bgView];
    }
    return self;
}

- (IBAction)send:(id)sender {
    NSLog(@"hldfklgjlasflafk");
}
@end
