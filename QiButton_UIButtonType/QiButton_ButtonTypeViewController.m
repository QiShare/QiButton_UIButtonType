//
//  QiButton_ButtonTypeViewController.m
//  QiButton_UIButtonType
//
//  Created by QiShare on 2018/8/6.
//  Copyright © 2018年 QiShare. All rights reserved.
//

#import "QiButton_ButtonTypeViewController.h"


@interface QiButton_ButtonTypeViewController ()

@end

@implementation QiButton_ButtonTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"UIButtonType";
    
    [self buttonType];
}



#pragma mark - Private functions

- (void)buttonType {
    
    NSArray <NSString *>*buttonTypes = @[@"UIButtonTypeCustom",
                                         @"UIButtonTypeSystem NS_ENUM_AVAILABLE_IOS(7_0)",
                                         @"UIButtonTypeDetailDisclosure",
                                         @"UIButtonTypeInfoLight",
                                         @"UIButtonTypeInfoDark",
                                         @"UIButtonTypeContactAdd",
                                         @"UIButtonTypePlain API_AVAILABLE(tvos(11.0)) API_UNAVAILABLE(ios, watchos)",
                                         @"7 = UIButtonTypePlain | UIButtonTypeSystem",
                                         @"UIButtonTypeRoundedRect = UIButtonTypeSystem",
                                         @"new a Button"];
    CGFloat btnHeight = [UIScreen mainScreen].bounds.size.height / buttonTypes.count;
    
    for (NSInteger buttonTypeI = 0 ; buttonTypeI < buttonTypes.count; buttonTypeI ++) {
        UIButton *buttonTypeBtn = [UIButton buttonWithType:buttonTypeI];
        // 设置最后的一个按钮 new的方式创建
        if (buttonTypeI == buttonTypes.count - 1) {
            // 经测试 打印的btn.buttonType 为 UIButtonTypeCustom 观察button的显示样式也是如此
            buttonTypeBtn = [UIButton new];
            [buttonTypeBtn setImage:[UIImage imageNamed:@"smallQiShareLogo"] forState:UIControlStateNormal];
            [buttonTypeBtn setImage:[UIImage imageNamed:@"smallQiShareLogo"] forState:UIControlStateHighlighted];
        } else if(buttonTypeI == buttonTypes.count - 2) {
            /** 注意UIButtonTypeRoundedRect = UIButtonTypeSystem 真正的值为 1 而不是7
             如果以 [UIButton buttonWithType:7] 方式创建UIButton
             相当于 [UIButton buttonWithType:UIButtonTypePlain | UIButtonTypeSystem];
             */
            buttonTypeBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [buttonTypeBtn setImage:[UIImage imageNamed:@"smallQiShareLogo"] forState:UIControlStateNormal];
            [buttonTypeBtn setImage:[UIImage imageNamed:@"smallQiShareLogo"] forState:UIControlStateHighlighted];
        } else if(buttonTypeI == UIButtonTypeCustom || buttonTypeI == UIButtonTypeSystem || buttonTypeI == UIButtonTypeRoundedRect) {
            [buttonTypeBtn setImage:[UIImage imageNamed:@"smallQiShareLogo"] forState:UIControlStateNormal];
            [buttonTypeBtn setImage:[UIImage imageNamed:@"smallQiShareLogo"] forState:UIControlStateHighlighted];
        } else if(buttonTypeI == UIButtonTypeDetailDisclosure || buttonTypeI == UIButtonTypeInfoLight || buttonTypeI == UIButtonTypeInfoDark) {
            buttonTypeBtn.showsTouchWhenHighlighted = YES;
        }
        [self.view addSubview:buttonTypeBtn];
        buttonTypeBtn.frame = CGRectMake(.0, buttonTypeI * btnHeight, CGRectGetWidth(self.view.frame), btnHeight);
        buttonTypeBtn.backgroundColor = (buttonTypeI % 2 ? [UIColor lightGrayColor] : [UIColor colorWithWhite:0.8 alpha:0.8]);
        [buttonTypeBtn setTitle:buttonTypes[buttonTypeI] forState:UIControlStateNormal];
        buttonTypeBtn.titleLabel.numberOfLines = 0;
        
        [buttonTypeBtn addTarget:self action:@selector(buttonTypeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
}


#pragma mark - Action functions

- (void)buttonTypeButtonClicked:(UIButton *)sender {
    
    sender.selected = !sender.selected;
}


#pragma mark - 解释说明相关文字

- (void)readMe {
    
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
     * UIButtonType 如下:
     
     UIButtonTypeCustom
     No button style.  没有按钮样式 默认new的是这种样式
     
     UIButtonTypeSystem
     A system style button, such as those shown in navigation bars and toolbars.  系统样式
     
     UIButtonTypeDetailDisclosure
     A detail disclosure button. 图片为圆圈中有个字母i 详情
     
     UIButtonTypeInfoLight
     An information button that has a light background. 图片为圆圈中有个字母i 亮的背景的信息类型
     
     UIButtonTypeInfoDark
     An information button that has a dark background. 图片为圆圈中有个字母i 暗的背景的信息类型
     
     
     * 此处看字面意思UIButtonTypeInfoDark UIButtonTypeInfoLight
     * Dark 和 Light意思一个暗一个亮 不过效果却不是如此
     * iOS7及之后上边的三种的类型中UIButtonTypeInfoDark UIButtonTypeInfoLight效果是一样的
     * 选中状态下UIButtonTypeInfoDark UIButtonTypeInfoLight文字图片都是白色的
     * UIButtonTypeDetailDisclosure在选中状态下图片文字颜色较暗
     
     UIButtonTypeContactAdd
     A contact add button.  图片为圆圈中 加内部一个 ➕  添加联系人的时候有的有用到
     
     UIButtonTypePlain
     A standard system button without a blurred background view. 没有模糊背景视图的标准的系统按钮 不过看起来说是API不支持 iOS和 WatchOS的 只支持 tvOS
     
     UIButtonTypeRoundedRect
     A rounded-rectangle style button.  方形的圆角形式的按钮在iOS7及之后就没有这个样式了需要使用border的方式来做到效果
     */
}

@end
