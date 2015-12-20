//
//  StripTableViewCell.h
//  Driving
//
//  Created by 黄欣 on 15/12/6.
//  Copyright © 2015年 黄欣. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    PracticeButtonType0, //
    PracticeButtonType1, //
    PracticeButtonType2, //
    PracticeButtonType3
} PracticeButtonType;

@protocol PracticeCellDelegate <NSObject>

- (void)PracticeDidClickButton:(PracticeButtonType)buttonType String:(NSString *)string;

@end

@interface StripTableViewCell : UITableViewCell
@property (nonatomic , assign) id<PracticeCellDelegate> delegate;
@end
