//
//  selectLabelView.h
//  selectLabel
//
//  Created by vteam on 2017/7/28.
//  Copyright © 2017年 vteam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface selectLabelView : UIView

-(instancetype)initWithFrame:(CGRect)frame titleFont:(UIFont *)titleFont allArray:(NSArray *)allArray;

@property (copy , nonatomic)void (^clickSureBtn)(NSArray *array);

@end
