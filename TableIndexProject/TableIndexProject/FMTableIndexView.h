//
//  FMTableIndexView.h
//  TableIndexProject
//
//  Created by 朱发明 on 2017/11/24.
//  Copyright © 2017年 朱发明. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^touchAndPanBlock)(int index);

@interface FMTableIndexView : UIView

@property (nonatomic,strong) NSArray *indexArray;

@property (nonatomic,copy) touchAndPanBlock block;

@end
