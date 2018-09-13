//
//  PopMenuView.h
//  康维医生
//
//  Created by 张志彬 on 2018/9/13.
//  Copyright © 2018年 zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectActionHandler)(int index, id object);

@interface PopMenuView : UIView

+ (PopMenuView *)showInView:(UIView *)superView location:(CGPoint)point titleList:(NSArray *)titleList selectActionHandler:(SelectActionHandler)selectActionHandler;

@end
