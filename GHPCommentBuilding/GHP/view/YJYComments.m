//
//  YJYComments.m
//  MedicalEducation
//
//  Created by 高鸿鹏 on 2017/6/9.
//  Copyright © 2017年 YiJiaoYuan. All rights reserved.
//

#import "YJYComments.h"
#import "YJYCommentsTool.h"
@implementation YJYComments
@synthesize showAll;
@synthesize content_H;
@synthesize commentup;
@synthesize delegate;
@synthesize index;

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.borderColor = LINE_COLOR.CGColor;
        self.layer.borderWidth = 0.5;
        self.backgroundColor = RGB(255, 253, 236);
        
        showAll = NO;
        
        _floor = [[UILabel alloc]init];
        _floor.backgroundColor = RGB(244, 244, 218);
        _floor.textColor = [UIColor lightGrayColor];
        _floor.font = [UIFont systemFontOfSize:12];
        _floor.textAlignment = NSTextAlignmentCenter;
        _floor.text = @"12";
        [self addSubview:_floor];
        
        _name = [[UILabel alloc]init];
        _name.font = [UIFont systemFontOfSize:15];
        _name.textColor = RGB(22, 103, 223);
        _name.text = @"ghp";
        [self addSubview:_name];
        
        _nameBtn = [[UIButton alloc]init];
        [self addSubview:_nameBtn];
        
        _from = [[UILabel alloc]init];
        _from.font = [UIFont systemFontOfSize:13];
        _from.textColor = [UIColor lightGrayColor];
        _from.text = @"北京市海淀区";
        [self addSubview:_from];
        
        _content = [[UILabel alloc]init];
        _content.font = [UIFont systemFontOfSize:15];
        _content.text = @"评论内容";
        _content.numberOfLines = 0;
        
        _contentBtn = [[UIButton alloc]init];
        [self addSubview:_contentBtn];
        [self addSubview:_content];

        [_contentBtn addTarget:self action:@selector(buttonBackGroundHighlighted:) forControlEvents:UIControlEventTouchUpInside];

        _zanBtn = [[UIButton alloc]init];
        [_zanBtn setImage:[UIImage imageNamed:@"dianzan"] forState:UIControlStateNormal];
        [_zanBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 25, 0, 0)];
        [self addSubview:_zanBtn];
        
        _zanNumber = [[UILabel alloc]init];
        _zanNumber.textAlignment = NSTextAlignmentRight;
        _zanNumber.font = [UIFont systemFontOfSize:13];
        _zanNumber.text = @"";
        _zanNumber.textColor = [UIColor lightGrayColor];
        [self addSubview:_zanNumber];
        
        _flodBtn = [[UIButton alloc]init];
        [_flodBtn setTitle:@"查看全部" forState:UIControlStateNormal];
        _flodBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [_flodBtn addTarget:self action:@selector(packUp) forControlEvents:UIControlEventTouchUpInside];
        _flodBtn.layer.masksToBounds = YES;
        [_flodBtn setTitleColor:RRR(100) forState:UIControlStateNormal];
        _flodBtn.layer.borderColor = LINE_COLOR.CGColor;
        _flodBtn.layer.borderWidth = 0.5;
        _flodBtn.layer.cornerRadius = 10;
        [_flodBtn setImage:[UIImage imageNamed:@"xjt"] forState:UIControlStateNormal];
        [_flodBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 20)];
        [_flodBtn setImageEdgeInsets:UIEdgeInsetsMake(9, 64, 7, 8)];
        [self addSubview:_flodBtn];
        _flodBtn.hidden = YES;

    }
    return self;
}

- (void)packUp{
    if(self.showAll){
        self.showAll = NO;
    }else{
        self.showAll = YES;
        _content.numberOfLines = 0;
        [_content sizeToFit];
        _flodBtn.hidden = YES;
        self.commentup();
    }
}

- (void)buttonBackGroundHighlighted:(UIButton *)sender
{
    [self.delegate clickcomments:self.index];
    _content.backgroundColor = RRR(230);
    
    [self performSelector:@selector(buttonNormal:) withObject:sender afterDelay:0.2];
}

- (void)buttonNormal:(UIButton *)sender{
    _content.backgroundColor = [UIColor clearColor];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    _floor.frame = CGRectMake(0, _toTop, 30, 20);
    
    _name.frame = CGRectMake(CGRectGetMaxX(_floor.frame)+10, CGRectGetMinY(_floor.frame), 200, 20);

    _nameBtn.frame = _name.frame;

    _from.frame = CGRectMake(CGRectGetMinX(_name.frame), CGRectGetMaxY(_name.frame)+5, self.frame.size.width-15-CGRectGetMaxX(_floor.frame)-10, 20);

    _content.frame = CGRectMake(CGRectGetMinX(_name.frame), CGRectGetMaxY(_from.frame)+15, self.frame.size.width-15-CGRectGetMaxX(_floor.frame)-10, 20);
    
    [_content sizeToFit];
    
//    _content.lineBreakMode = NSLineBreakByTruncatingTail;

    self.content_H = [YJYCommentsTool setFlodContentheight:_content.bounds.size.height] ;
    if (self.showAll == NO && [YJYCommentsTool MorethanSevenline:_content.bounds.size.height]) {
        _content.numberOfLines = 5;
        CGRect frame = _content.frame;
        frame.size.height = self.content_H;
        _content.frame = frame;
        _flodBtn.hidden = NO;
    }else{
        _content.numberOfLines = 0;
        [_content sizeToFit];
    }

    _contentBtn.frame = _content.frame;
    
    _flodBtn.frame = CGRectMake(self.bounds.size.width-80-15, CGRectGetMaxY(_content.frame)+15, 80, 20);
    
    _zanBtn.frame = CGRectMake(self.bounds.size.width-40-15, CGRectGetMinY(_floor.frame)-12, 40, 40);
    
    _zanNumber.frame = CGRectMake(CGRectGetMinX(_zanBtn.frame)-85, CGRectGetMinY(_floor.frame), 100, 20);
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
