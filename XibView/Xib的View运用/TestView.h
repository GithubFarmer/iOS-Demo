//
//  TestView.h
//  XibView
//
//  Created by Hibiscus on 2021/4/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TestView : UIView

@property (weak, nonatomic) IBOutlet UIView *bgView;
- (IBAction)send:(id)sender;

@end

NS_ASSUME_NONNULL_END
