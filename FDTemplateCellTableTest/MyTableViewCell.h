//
//  MyTableViewCell.h
//  FDTemplateCellTableTest
//
//  Created by Apple on 16/5/26.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyCellModel;

@interface MyTableViewCell : UITableViewCell
@property (nonatomic, strong) MyCellModel *model;
@end
