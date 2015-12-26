//
//  RedioButtonView.h
//  RadioButton
//
//  Created by 黄欣 on 15/10/30.
//  Copyright © 2015年 黄欣. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYRadioButton.h"
#import "subjectOneModel.h"
#import "SubjectOneFrame.h"
@interface RedioButtonView : UIView<RadioButtonDelegate>
@property (nonatomic, strong) SubjectOneFrame * datasFrame;
@property (nonatomic , assign) int indexs;//是第几个cell
@end
