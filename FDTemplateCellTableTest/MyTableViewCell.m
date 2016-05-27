//
//  MyTableViewCell.m
//  FDTemplateCellTableTest
//
//  Created by Apple on 16/5/26.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "MyTableViewCell.h"
#import "MyCellModel.h"
#import "Masonry.h"
#import "YYWebImage.h"

@interface MyTableViewCell ()
@property (nonatomic, strong) UILabel       *titleLabel;
@property (nonatomic, strong) UILabel       *contentLabel;
@property (nonatomic, strong) UIImageView   *contentImageView;
@property (nonatomic, strong) UILabel       *usernameLabel;
@property (nonatomic, strong) UILabel       *timeLabel;
@property (nonatomic, strong) UIImageView   *headImage;
@end

@implementation MyTableViewCell

//重写cell的prepareForReuse 知道cell是否被复用，在这个方法中将数据源初始化为nil
- (void)prepareForReuse {
    _titleLabel.text = nil;
    _contentLabel.text = nil;
    _contentImageView.image = nil;
    _usernameLabel.text = nil;
    _timeLabel.text = nil;
    _headImage.image = nil;
}

#pragma mark - init View;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //init cell view and set autoLayout By Masonry Framework
        //Masonry内部处理了循环引用，这地方用ws只是为了替代self.contentView
        __weak typeof(self.contentView) ws = self.contentView;
        
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [UIColor blueColor];
        _titleLabel.font = [UIFont boldSystemFontOfSize:16];

        [ws addSubview:_titleLabel];
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@10);
            make.left.equalTo(@10);
            make.right.equalTo(@(-70));
        }];
        
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.textColor = [UIColor blackColor];
        _contentLabel.font = [UIFont systemFontOfSize:14];
        _contentLabel.numberOfLines = 0;
        
        [ws addSubview:_contentLabel];
        
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_titleLabel.mas_left);
            make.top.equalTo(_titleLabel.mas_bottom).with.offset(8);
            make.right.equalTo(@(-70));
        }];
        
        _contentImageView = [[UIImageView alloc]init];
        _contentImageView.backgroundColor = [UIColor redColor];
        
        [ws addSubview:_contentImageView];
        
        [_contentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_contentLabel.mas_bottom).with.offset(8);
            make.left.equalTo(_titleLabel.mas_left);
            make.right.lessThanOrEqualTo(@(-16));
        }];
        
        _usernameLabel = [[UILabel alloc]init];
        _usernameLabel.textColor = [UIColor lightGrayColor];
        _usernameLabel.font = [UIFont systemFontOfSize:13];

        [ws addSubview:_usernameLabel];
        
        [_usernameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_contentImageView.mas_bottom).with.offset(8);
            make.left.equalTo(_titleLabel.mas_left);
            make.bottom.equalTo(@(-8));
        }];

        _timeLabel = [[UILabel alloc]init];
        _timeLabel.textColor = [UIColor redColor];
        _timeLabel.font = [UIFont systemFontOfSize:13];
        
        [ws addSubview:_timeLabel];
        
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@(-10));
            make.bottom.equalTo(@(-8));
            //和usernameLabel; 在水平线齐平，也可以设置center_y 或者 mas_top
            make.centerY.equalTo(_usernameLabel.mas_centerY);
        }];
        
        _headImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
        _headImage.backgroundColor = [UIColor redColor];
        //通过UIBezierPath设置圆角 优化性能
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:_headImage.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(25, 0)];
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.frame = _headImage.bounds;
        maskLayer.path = path.CGPath;
        _headImage.layer.mask = maskLayer;
        _headImage.layer.masksToBounds = YES;

        [ws addSubview:_headImage];
        
        [_headImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@10);
            make.right.equalTo(@(-10));
            make.height.mas_equalTo(50);
            make.width.mas_equalTo(50);
            make.left.equalTo(_titleLabel.mas_right).with.offset(10);
        }];
    }
    return self;
}

#pragma mark - setter
- (void)setModel:(MyCellModel *)model {
    //配置model数据
    _model = model;
    
    self.titleLabel.text = model.title;
    self.contentLabel.text = model.content;
    self.contentImageView.image = model.imageName.length > 0 ? [UIImage imageNamed:model.imageName] : nil;
    self.usernameLabel.text = model.username;
    self.timeLabel.text = model.time;
    NSURL *url = [NSURL URLWithString:model.headImage];
    [self.headImage yy_setImageWithURL:url options:YYWebImageOptionProgressive];

}

@end
