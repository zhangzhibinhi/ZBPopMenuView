//
//  PopMenuView.m
//  康维医生
//
//  Created by 张志彬 on 2018/9/13.
//  Copyright © 2018年 zhang. All rights reserved.
//

#import "PopMenuView.h"
#import "PopMenuListCell.h"

#define kPopupTriangleHeigh 20  //  尖角高度
#define kPopupTriangleWidth 20  //  尖角宽度
#define kPopupTriangleMargin 20 //  尖角与边缘的距离
#define kPopupTriangleTopPointX self.frame.size.width - kPopupTriangleWidth - kPopupTriangleMargin
#define kRowHeight 44

@interface PopMenuView()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (copy, nonatomic) NSArray *listArr;

@property (copy) SelectActionHandler selectActionHandler;

@end

@implementation PopMenuView

+ (PopMenuView *)showInView:(UIView *)superView location:(CGPoint)point titleList:(NSArray *)titleList selectActionHandler:(SelectActionHandler)selectActionHandler {
    PopMenuView *menuView = [PopMenuView new];
    menuView.listArr = titleList;
    menuView.selectActionHandler = selectActionHandler;
    menuView.frame = CGRectMake(point.x - menuView.tableView.frame.size.width + kPopupTriangleWidth + kPopupTriangleMargin, point.y, menuView.tableView.frame.size.width, menuView.tableView.frame.size.height + kPopupTriangleHeigh);
    [superView addSubview:menuView];
    
    return menuView;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kPopupTriangleHeigh, 180, 0)];
        self.tableView.backgroundColor = [UIColor clearColor];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.bounces = NO;
        [self.tableView registerNib:[UINib nibWithNibName:@"PopMenuListCell" bundle:nil] forCellReuseIdentifier:@"PopMenuListCell"];
        [self addSubview:self.tableView];
    }
    
    return self;
}

- (void)setListArr:(NSArray *)listArr {
    _listArr = listArr;
    [self updateUI];
    [self.tableView reloadData];
}

- (void)updateUI {
    CGFloat height = kRowHeight * self.listArr.count;
    CGRect tableViewFrame = self.tableView.frame;
    tableViewFrame.size.height = height;
    self.tableView.frame = tableViewFrame;
    CGRect selfFrame = self.frame;
    selfFrame.size.height = height + kPopupTriangleHeigh;
    self.frame = selfFrame;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    [self drawPopup:rect];
}

- (void)drawPopup:(CGRect)rect {
    // 绘制气泡
    CGFloat viewW = rect.size.width;
    CGFloat viewH = rect.size.height;
    CGFloat strokeWidth = 1;    //边框宽度
    CGFloat borderRadius = 5;   //圆角
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, rect);  // 需要clear一下，设置成为透明背景
    // 画笔样式配置
    CGContextSetLineJoin(context, kCGLineJoinRound);
    CGContextSetLineWidth(context, strokeWidth);
    CGContextSetStrokeColorWithColor(context, [UIColor clearColor].CGColor); // 设置画笔颜色
    CGContextSetFillColorWithColor(context, [UIColor lightGrayColor].CGColor); // 设置填充颜色
    // 路径配置
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, borderRadius, kPopupTriangleHeigh);
    CGContextAddLineToPoint(context, kPopupTriangleTopPointX - kPopupTriangleWidth / 2.0, kPopupTriangleHeigh);
    CGContextAddLineToPoint(context, kPopupTriangleTopPointX, 0);
    CGContextAddLineToPoint(context, kPopupTriangleTopPointX + kPopupTriangleWidth / 2.0, kPopupTriangleHeigh);
    CGContextAddArcToPoint(context, viewW, kPopupTriangleHeigh, viewW, kPopupTriangleHeigh + borderRadius, borderRadius-strokeWidth);
    CGContextAddArcToPoint(context, viewW, viewH, viewW-borderRadius, viewH, borderRadius-strokeWidth);
    CGContextAddArcToPoint(context, 0, viewH, 0, viewH - borderRadius, borderRadius-strokeWidth);
    CGContextAddArcToPoint(context, 0, kPopupTriangleHeigh, viewW - borderRadius, kPopupTriangleHeigh, borderRadius-strokeWidth);
    CGContextClosePath(context);
    // 开始绘制
    CGContextDrawPath(context, kCGPathFillStroke);
}

#pragma mark - UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kRowHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PopMenuListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PopMenuListCell"];
    
    NSDictionary *titleDic = [self.listArr objectAtIndex:indexPath.row];
    
    cell.titleLabel.text = titleDic[@"title"];
    cell.iconImageView.image = [UIImage imageNamed:titleDic[@"imageName"]];
    
    cell.selectedBackgroundView = [UIView new];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self removeFromSuperview];
    _selectActionHandler((int)indexPath.row, self.listArr[indexPath.row]);
}

@end
