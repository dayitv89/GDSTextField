//
//  GDSTextField.m
//  GDSTextField
//
//  Created by gauravds on 4/30/15.
//  Copyright (c) 2015 punchh. All rights reserved.
//

#import "GDSTextField.h"

@protocol MyGDSCustomFieldDelegate <UITextFieldDelegate>
@optional
- (void)textFieldDidDelete:(UITextField*)textField;
@end

@interface GDSCustomField : UITextField
@end

@implementation GDSCustomField
- (CGRect)caretRectForPosition:(UITextPosition *)position {
    return CGRectZero;
}
- (void)deleteBackward {
    if (self.delegate &&
        [self.delegate conformsToProtocol:@protocol(MyGDSCustomFieldDelegate)] &&
        [self.delegate respondsToSelector:@selector(textFieldDidDelete:)]){
        [(NSObject<MyGDSCustomFieldDelegate>*)self.delegate textFieldDidDelete:self];
    }
    [super deleteBackward];
}

- (BOOL)keyboardInputShouldDelete:(UITextField *)textField {
    BOOL shouldDelete = YES;
    if ([UITextField instancesRespondToSelector:_cmd]) {
        BOOL (*keyboardInputShouldDelete)(id, SEL, UITextField *) = (BOOL (*)(id, SEL, UITextField *))[UITextField instanceMethodForSelector:_cmd];
        if (keyboardInputShouldDelete) {
            shouldDelete = keyboardInputShouldDelete(self, _cmd, textField);
        }
    }

    BOOL isIos8 = ([[[UIDevice currentDevice] systemVersion] intValue] == 8);
    BOOL isLessThanIos8_3 = ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.3f);

    if (![textField.text length] && isIos8 && isLessThanIos8_3) {
        [self deleteBackward];
    }

    return shouldDelete;
}

@end

@interface GDSTextField()<MyGDSCustomFieldDelegate>{
    NSInteger noOfFields;
    CGFloat fWidth;
    CGFloat rPadding;
    UIKeyboardType keyboardType;
    UIFont *font;
    NSObject<GDSTextFieldDelegate> *delegate;
    
    UIColor *bgColor, *tintColor;
    UIImage *bgImage, *tintImage;
    
    UIColor *textColor, *textSelectedColor;
    
    CGRect oldFrame;
}
@end

@implementation GDSTextField

#pragma mark - custom methods
- (void)setFields:(NSInteger)noOfFields1
  backgroundColor:(UIColor*)bgColor1
        tintColor:(UIColor*)tintColor1
        textColor:(UIColor*)textColor1
textSelectedColor:(UIColor*)textSelectedColor1
fieldRightPadding:(CGFloat)rPadding1
     keyboardType:(UIKeyboardType)keyboardType1
             font:(UIFont*)font1
      andDelegate:(NSObject<GDSTextFieldDelegate>*)delegate1 {
    oldFrame = self.frame;
    
    noOfFields = noOfFields1;
    bgColor = bgColor1;
    tintColor = tintColor1;
    textColor = textColor1;
    textSelectedColor = textSelectedColor1;
    rPadding = rPadding1;
    keyboardType = keyboardType1;
    font = font1;
    delegate = delegate1;
    
    [self designNewView];
}

- (void)setFields:(NSInteger)noOfFields1
  backgroundImage:(UIImage*)bgImage1
        tintImage:(UIImage*)tintImage1
        textColor:(UIColor*)textColor1
textSelectedColor:(UIColor*)textSelectedColor1
fieldRightPadding:(CGFloat)rPadding1
     keyboardType:(UIKeyboardType)keyboardType1
             font:(UIFont*)font1
      andDelegate:(NSObject<GDSTextFieldDelegate>*)delegate1 {
    oldFrame = self.frame;
    
    noOfFields = noOfFields1;
    bgImage = bgImage1;
    tintImage = tintImage1;
    textColor = textColor1;
    textSelectedColor = textSelectedColor1;
    rPadding = rPadding1;
    keyboardType = keyboardType1;
    font = font1;
    delegate = delegate1;
    
    [self designNewView];
}

- (void)designNewView {
    [self setBackgroundColor:[UIColor clearColor]];
    [self setClipsToBounds:YES];
    
    if (noOfFields == 0 || rPadding == 0.0f || !font) {
        NSLog(@"GDSTextField error");
        return;
    }
    
    // remove all previouse view
    for (UIView *view in self.subviews) {
        if (view.tag > 0 && view.tag <= noOfFields ) {
            [view removeFromSuperview];
        }
    }
    
    fWidth = (self.frame.size.width - (noOfFields - 1)*rPadding) / noOfFields;
    for (NSInteger i = 0; i < noOfFields; i++) {
        CGRect txtFieldFrame = CGRectMake((fWidth+rPadding)*i, 0, fWidth, self.frame.size.height);
        GDSCustomField *txtField = [[GDSCustomField alloc] initWithFrame:txtFieldFrame];
        if (bgImage) {
            [txtField setBackground:bgImage];
            [txtField setBackgroundColor:[UIColor clearColor]];
        } else {
            [txtField setBackgroundColor:[UIColor whiteColor]];
            [txtField.layer setCornerRadius:4.f];
            [txtField setClipsToBounds:YES];
            [txtField.layer setBorderColor:[UIColor lightGrayColor].CGColor];
            [txtField.layer setBorderWidth:.5f];
        }
        [txtField setTextColor:textColor];
        [txtField setTag:i+1];
        [txtField setKeyboardType:keyboardType];
        [txtField setTextAlignment:NSTextAlignmentCenter];
        [txtField setFont:font];
        [txtField setDelegate:self];
        [self addSubview:txtField];
    }
}

- (NSString*)text {
    NSMutableString *mutableText = [NSMutableString new];
    for (NSInteger i = 0; i < noOfFields; i++) {
        GDSCustomField *txtField = (GDSCustomField*)[self viewWithTag:i+1];
        if ([txtField.text isEqualToString:@""]) {
            [mutableText appendString:@" "];
        } else {
            [mutableText appendString:txtField.text];
        }
    }
    return mutableText;
}

- (void)setViewForKeyboard {
    NSInteger areaCoverByKeyBoard = 216;
    CGFloat viewCenterY = oldFrame.origin.y + oldFrame.size.height / 2;
    CGRect applicationFrame = [[UIScreen mainScreen] applicationFrame];
    CGFloat availableHeight = applicationFrame.size.height - areaCoverByKeyBoard;
    CGFloat y;
    if (availableHeight < viewCenterY) {
        y =  viewCenterY - availableHeight / 2.0;
    } else {
        y = oldFrame.origin.y;
    }
    [UIView animateWithDuration:.2f
                     animations:^{
                         [self setFrame:CGRectMake(oldFrame.origin.x, y, oldFrame.size.width, oldFrame.size.height)];
                     }];
}

- (void)fireDelegate {
    if (delegate &&
        [delegate conformsToProtocol:@protocol(GDSTextFieldDelegate)] &&
        [delegate respondsToSelector:@selector(textField:endEditingWithText:)] ) {
        [delegate textField:self endEditingWithText:[self text]];
    }
}


#pragma mark - UITextFieldDelegates
- (void)textFieldDidDelete:(UITextField *)textField {
    if ([textField.text isEqualToString:@""] && textField.tag != 1) {
        UITextField *preTextField = (UITextField*)[self viewWithTag:textField.tag-1];
        if (preTextField) {
            [preTextField becomeFirstResponder];
        }
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (tintImage) {
        [textField setBackground:tintImage];
    } else {
        [textField setBackgroundColor:tintColor];
    }
    [textField setTextColor:textSelectedColor];
    [self setViewForKeyboard];
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    if (bgImage) {
        [textField setBackground:bgImage];
    } else {
        [textField setBackgroundColor:bgColor];
    }
    [textField setTextColor:textColor];
    return YES;
}

- (BOOL)textField:(UITextField *)textField
shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string {
    if ([string isEqualToString:@""]) {
        return YES;
    }
    
    [textField setText:string];
    if (textField.tag == noOfFields) {
        [UIView animateWithDuration:.2f animations:^{
            [self setFrame:oldFrame];
        }];
        [self fireDelegate];
        
        //--finally hide keyboard
        [textField resignFirstResponder];
        return NO;
    }
    
    UITextField *nextTextField = (UITextField*)[self viewWithTag:textField.tag+1];
    if (nextTextField) {
        [nextTextField becomeFirstResponder];
    }
    return NO;
}
@end
