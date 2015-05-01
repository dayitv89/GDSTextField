//
//  GDSTextField.h
//  GDSTextField
//
//  Created by gauravds on 4/30/15.
//  Copyright (c) 2015 punchh. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol GDSTextFieldDelegate
@optional
- (void)textField:(UIView*)textField endEditingWithText:(NSString*)text;
@end

@interface GDSTextField : UIView

- (void)setFields:(NSInteger)noOfFields1
  backgroundColor:(UIColor*)bgColor1
        tintColor:(UIColor*)tintColor1
fieldRightPadding:(CGFloat)rPadding1
     keyboardType:(UIKeyboardType)keyboardType1
             font:(UIFont*)font1
      andDelegate:(NSObject<GDSTextFieldDelegate>*)delegate1;

- (void)setFields:(NSInteger)noOfFields1
  backgroundImage:(UIImage*)bgImage1
        tintImage:(UIImage*)tintImage1
fieldRightPadding:(CGFloat)rPadding1
     keyboardType:(UIKeyboardType)keyboardType1
             font:(UIFont*)font1
      andDelegate:(NSObject<GDSTextFieldDelegate>*)delegate1;

- (NSString*)text;

@end
