//
//  QiButton_ButtonTypeViewController.m
//  QiButton_UIButtonType
//
//  Created by wangyongwang on 2018/8/6.
//  Copyright © 2018年 QiShare. All rights reserved.
//

#import "QiButton_ButtonTypeViewController.h"

@interface QiButton_ButtonTypeViewController ()

/** 承载button的可变数组 */
@property (nonatomic,strong) NSMutableArray<UIButton *> *buttonTypeButtons;

@end

@implementation QiButton_ButtonTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"UIButtonType";
    self.buttonTypeButtons = [NSMutableArray array];
    
    [self buttonType];
}



#pragma mark - Private functions

- (void)buttonType{
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    NSArray <NSString *>*buttonTypes = @[@"UIButtonTypeCustom",
                                           @"UIButtonTypeSystem NS_ENUM_AVAILABLE_IOS(7_0)",
                                           @"UIButtonTypeDetailDisclosure",
                                           @"UIButtonTypeInfoLight",
                                           @"UIButtonTypeInfoDark",
                                           @"UIButtonTypeContactAdd",
                                           @"UIButtonTypePlain API_AVAILABLE(tvos(11.0)) API_UNAVAILABLE(ios, watchos)",
                                           @"UIButtonTypeRoundedRect = UIButtonTypeSystem"];
    NSInteger buttonTypeI = 0;
    for (NSInteger row = 0; row < 3; row ++) {
        for (NSInteger col = 0; col < 3; col ++) {
            if (buttonTypeI > 7) {
                buttonTypeI = 7;
            }
            UIButton *btn = [UIButton buttonWithType:buttonTypeI];
#if 0
            //经测试 猜测默认创建的UIButton的是 UIButtonSystem 的样式的
            if (buttonTypeIndex == 1) {
                btn = [UIButton new];
                [btn setImage:[UIImage imageNamed:@"smallQiShareLogo"] forState:UIControlStateNormal];
                [btn setImage:[UIImage imageNamed:@"smallQiShareLogo"] forState:UIControlStateHighlighted];
            }
#endif
            [self.buttonTypeButtons addObject:btn];
            [self.view addSubview:btn];
            
            btn.tag = buttonTypeI;
            [btn addTarget:self action:@selector(buttonTypeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            
            //            btn.reversesTitleShadowWhenHighlighted = NO;
            [btn setTitle:buttonTypes[buttonTypeI] forState:UIControlStateNormal];
            if (row == 2 && col == 2) {
                btn.tag = 8;
                [btn setTitle:@"复位" forState:UIControlStateNormal];
                [btn setTitle:@"复位" forState:UIControlStateSelected|UIControlStateHighlighted];
            }
            btn.titleLabel.numberOfLines = 0;
            
            NSDictionary *foreAttriDict = @{NSForegroundColorAttributeName:[UIColor purpleColor]};
            NSDictionary *aheadAttriDict = @{NSForegroundColorAttributeName:[UIColor cyanColor]};
            NSMutableAttributedString *attriM = [[NSMutableAttributedString alloc]initWithString:buttonTypes[buttonTypeI]];
            [attriM addAttributes:foreAttriDict range:NSMakeRange(0, 12)];
            [attriM addAttributes:aheadAttriDict range:NSMakeRange(12, (buttonTypes[buttonTypeI].length)-12)];
            [btn setAttributedTitle:attriM forState:UIControlStateSelected];
            //            [btn setAttributedTitle:attriM forState:UIControlStateNormal];
            
            buttonTypeI++;
            [btn setBackgroundColor:[[UIColor redColor]colorWithAlphaComponent: 1.0/9.0 * buttonTypeI]];
            if(buttonTypeI == 1){
                [btn setImage:[UIImage imageNamed:@"smallQiShareLogo"] forState:UIControlStateNormal];
                [btn setImage:[UIImage imageNamed:@"smallQiShareLogo"] forState:UIControlStateHighlighted];
                //                btn.adjustsImageWhenHighlighted = NO;
            }else if (buttonTypeI == 2) {
                btn.layer.borderWidth = 6.0;
                btn.layer.borderColor = [UIColor yellowColor].CGColor;
            }else if (buttonTypeI == 3) {
                [btn setBackgroundColor:[[UIColor redColor]colorWithAlphaComponent: 1.0/9.0 * buttonTypeI]];
                btn.layer.shadowOffset = CGSizeMake(2.0, 2.0);
                btn.layer.cornerRadius = 5.0;
                btn.layer.shadowOpacity = 0.8;
                btn.layer.shadowColor = [UIColor blackColor].CGColor;
                btn.layer.shadowRadius = 8.0;
            }else if (buttonTypeI == 4 || buttonTypeI == 5) {
                //此处看字面意思UIButtonTypeInfoDark UIButtonTypeInfoLight  Dark 和 Light确实是一个暗一个亮 不过效果却不是如此 iOS7及之后上边的三种的类型是一样的 没什么区别
                [btn setBackgroundColor:[UIColor orangeColor]];
                btn.layer.cornerRadius = 20.0;
                btn.layer.masksToBounds = YES;
                btn.tintColor = [UIColor purpleColor]; //Normal状态下 用于设置文字及图片的颜色 及选中的时候的文字的背景色的颜色
            }else if(buttonTypeI == 6){
                //注意使用下列的方式做圆角的时候一定要注意 传入的值Rect相关的值的时候 是否有值 否则会无法出现预期的效果 尤其像  bezierPathWithRoundedRect:btn.bounds 或 maskLayer.frame = btn.bounds 这种;
                //UIButton 设置指定圆角
                //https://www.jianshu.com/p/7bd6d1424d96
                btn.backgroundColor = [UIColor cyanColor];
                UIRectCorner rectC = UIRectCornerTopLeft | UIRectCornerBottomLeft | UIRectCornerTopRight | UIRectCornerBottomRight;
                UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, SCREEN_WIDTH, (SCREEN_HEIGHT - WWStatusBarNavigationBarHeight)/9) byRoundingCorners:rectC cornerRadii:CGSizeMake(30.0, 30.0)];
                CAShapeLayer *maskLayer = [CAShapeLayer layer];
                maskLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH, (SCREEN_HEIGHT - WWStatusBarNavigationBarHeight)/9);
                maskLayer.path = bezierPath.CGPath;
                btn.layer.mask = maskLayer;
            }else if(buttonTypeI == 7){
                [btn setImage:[UIImage imageNamed:@"smallQiShareLogo"] forState:UIControlStateNormal];
                [btn setImage:[UIImage imageNamed:@"smallQiShareLogo"] forState:UIControlStateHighlighted];
            }
        }
        
        //把创建的按钮都放到UIStackView中 指定高度方面 UIStackView比较特殊 不像UIView直接创建的对象
        UIStackView *buttonContainerStackV = [[UIStackView alloc]initWithArrangedSubviews:[_buttonTypeButtons copy]];
        [self.view addSubview:buttonContainerStackV];
        buttonContainerStackV.frame = self.view.bounds;
        buttonContainerStackV.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        
        buttonContainerStackV.alignment = UIStackViewAlignmentFill;
        buttonContainerStackV.axis = UILayoutConstraintAxisVertical;
        buttonContainerStackV.distribution = UIStackViewDistributionFillEqually;
        
    }
}


#pragma mark - Action functions

- (void)buttonTypeButtonClicked:(UIButton *)sender{
    
    if (sender.tag == 8) {
        //复位tag 为 8
        [self.buttonTypeButtons enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            ((UIButton *)obj).enabled = YES;
            ((UIButton *)obj).selected = NO;
        }];
        return;
    }
    sender.selected = !sender.selected;
    
    //下边是一些属性方法
    NSLog(@"currentTitle: %@",sender.currentTitle);
    NSLog(@"currentImage: %@",sender.currentImage);
    NSLog(@"currentBackgroundImage: %@",sender.currentBackgroundImage);
    //ww注意 ：这种 设置在Normal状态的属性字符串的时候 下边的属性字符标题才会有值
    // 否则的话 即使设置了 选中状态的属性字符串 下边也是没有值的
    NSLog(@"currentAttributedTitle: %@",sender.currentAttributedTitle);
    NSLog(@"currentTitleColor: %@",sender.currentTitleColor);
    NSLog(@"currentTitleShadowColor: %@",sender.currentTitleShadowColor);
    NSLog(@"imageForStateNormal: %@",[sender imageForState:UIControlStateNormal]);
    NSLog(@"imageForStateSelected: %@",[sender imageForState:UIControlStateSelected]);
    NSLog(@"contentInsets: %@",NSStringFromUIEdgeInsets([sender contentEdgeInsets]));
    NSLog(@"titleEdgeInsets: %@",NSStringFromUIEdgeInsets([sender titleEdgeInsets]));
    NSLog(@"imageEdgeInsets: %@",NSStringFromUIEdgeInsets([sender imageEdgeInsets]));
    NSLog(@"backgroundRectForBounds: %@",NSStringFromCGRect([sender backgroundRectForBounds:sender.bounds]));
    NSLog(@"ContentRectForBounds: %@",NSStringFromCGRect([sender contentRectForBounds:sender.bounds]));
    NSLog(@"titleRectForBounds: %@",NSStringFromCGRect([sender titleRectForContentRect:sender.bounds]));
    NSLog(@"imageRectForBounds: %@",NSStringFromCGRect([sender imageRectForContentRect:sender.bounds]));
    
}


#pragma mark - 解释说明相关文字

- (void)readMe{
    
#if 0
    typedef NS_ENUM(NSInteger, UIButtonType) {
        UIButtonTypeCustom = 0,                         // no button type
        UIButtonTypeSystem NS_ENUM_AVAILABLE_IOS(7_0),  // standard system button
        
        UIButtonTypeDetailDisclosure,
        UIButtonTypeInfoLight,
        UIButtonTypeInfoDark,
        UIButtonTypeContactAdd,
        
        UIButtonTypePlain API_AVAILABLE(tvos(11.0)) API_UNAVAILABLE(ios, watchos), // standard system button without the blurred background view
        
        UIButtonTypeRoundedRect = UIButtonTypeSystem   // Deprecated, use UIButtonTypeSystem instead
    };
    //    一些个人理解
#endif
    /**
     * UIButtonType 如下
     
     UIButtonTypeCustom     //没有按钮样式 默认new的是这种样式
     No button style.
     UIButtonTypeSystem     //系统样式
     A system style button, such as those shown in navigation bars and toolbars.
     
     UIButtonTypeDetailDisclosure
     A detail disclosure button.     //感叹号图片 详情
     UIButtonTypeInfoLight      //感叹号的图片 亮的信息 类型
     An information button that has a light background.
     UIButtonTypeInfoDark       //感叹号的图片 暗的信息类型
     An information button that has a dark background.
     //iOS7及之后上边的三种的类型是一样的 没什么区别
     
     UIButtonTypeContactAdd     //加号图片  添加联系人的时候有的有用到
     A contact add button.
     UIButtonTypePlain          没有模糊背景视图的标准的系统按钮 不过看起来说是API不支持 iOS和 WatchOS的 只支持 tvOS
     A standard system button without a blurred background view.
     UIButtonTypeRoundedRect    方形的圆角形式的按钮在iOS7及之后就没有这个样式了需要使用border的方式来做到效果
     A rounded-rectangle style button.
     */
}

@end
