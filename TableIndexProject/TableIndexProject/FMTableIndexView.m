//
//  FMTableIndexView.m
//  TableIndexProject
//
//  Created by 朱发明 on 2017/11/24.
//  Copyright © 2017年 朱发明. All rights reserved.
//

#import "FMTableIndexView.h"
@interface FMTableIndexView(){
    CGRect newFrame;
}

@property (weak, nonatomic) IBOutlet UIView *titileView;
//显示当前View
@property (weak, nonatomic) IBOutlet UIView *showView;
//show View 顶部约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *showVTop;

@property (nonatomic,strong) NSMutableArray *labArray;
//选择的lab
@property (weak, nonatomic) IBOutlet UILabel *selectLab;



@end

@implementation FMTableIndexView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    self.frame = newFrame;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
        self =  [[[NSBundle mainBundle] loadNibNamed:@"FMTableIndexView" owner:nil options:nil] lastObject];
        //添加点击事件
        [_titileView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTitleViewAction:)] ];
        UIPanGestureRecognizer *swipe = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panViewAction:)];
//        swipe.direction = UISwipeGestureRecognizerDirectionUp;
//        swipe.direction = UISwipeGestureRecognizerDirectionDown;
        [_titileView addGestureRecognizer:swipe];
        newFrame = frame;
        //拿到坐标
         _labArray = [NSMutableArray array];
        
        _showView.layer.cornerRadius = 20;
        _showView.layer.masksToBounds = YES;
        _showView.hidden = YES;
        
    }
    return self;
}

/**
点击View 局域
 @param sender UITapGestureRecognizer
 */
-(void)tapTitleViewAction:(UITapGestureRecognizer *)sender
{
    CGPoint point = [sender locationInView:self.titileView];
   // NSLog(@"handleSingleTap!pointx:%f,y:%f",point.x,point.y);
    
    _showView.hidden = NO;
    //判断状态
    if (sender.state == UIGestureRecognizerStateEnded || sender.state == UIGestureRecognizerStateCancelled) {
        NSLog(@"手势取消");
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            _showView.hidden = YES;
        });
        
    }
     [self handleShow:point.y];
    
}

/**
 移动View 手势
 @param sender UIPanGestureRecognizer
 */
-(void)panViewAction:(UIPanGestureRecognizer *)sender
{
    CGPoint point = [sender locationInView:self.titileView];
    //NSLog(@"panSingle!pointx:%f,y:%f",point.x,point.y);
    _showView.hidden = NO;
    //判断状态
    if (sender.state == UIGestureRecognizerStateEnded || sender.state == UIGestureRecognizerStateCancelled) {
        NSLog(@"手势取消");
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
             _showView.hidden = YES;
        });
       
    }
    [self handleShow:point.y];
}


/**
 偏移处理
 @param pointY 偏移距离
 */
-(void) handleShow:(CGFloat )pointY
{
    int index  = pointY / 20;
    
    if (_indexArray.count ==0) {
        return;
    }
    if (index < 0 || index > _indexArray.count-1) {
        return ;
    }
    _showVTop.constant = (index*20+10)-20;
    //赋值
    if (_indexArray.count == 0) {
        return;
    }
    if (index>=_indexArray.count-1) {
        index = (int) _indexArray.count-1;
    }
    _selectLab.text = _indexArray[index];
    //block 返回
    if ([self block]) {
        self.block(index);
    }
}

-(void)setIndexArray:(NSArray *)indexArray
{
    _indexArray = indexArray;
    //增加 Lab
    _selectLab.text = _indexArray[0];
    
    for (NSString *title in _indexArray) {
        UILabel *lab = [[UILabel alloc] init];
        lab.textColor = [UIColor whiteColor];
        lab.text = title;
        lab.textAlignment = NSTextAlignmentCenter;
        lab.font = [UIFont systemFontOfSize:18.0f];
         [self.labArray addObject:lab];
        [self.titileView addSubview:lab];
       
    }
}

/**
 修改 frame
 */
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat titleH = 20.0f;
    CGFloat titleW = 35.0f;
    CGFloat titleX = 0.0f;
    int i = 0;
    for (UILabel *lab in _labArray) {
        lab.frame = CGRectMake(titleX, i*titleH, titleW, titleH);
        i++;
    }
    //根据字符数组决定高
    CGRect frame = self.frame;
    frame.size.height = titleH*_labArray.count;
    self.frame = frame;
}


@end
