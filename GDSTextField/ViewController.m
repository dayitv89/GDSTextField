//
//  ViewController.m
//  GDSTextField
//
//  Created by gauravds on 4/30/15.
//  Copyright (c) 2015 punchh. All rights reserved.
//

#import "ViewController.h"
#import "GDSTextField.h"

@interface ViewController ()<GDSTextFieldDelegate>{
    __weak IBOutlet GDSTextField *txtField1, *txtField2;
}
- (IBAction)btnValue:(id)sender;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [txtField1 setFields:5
     backgroundColor:[UIColor whiteColor]
              tintColor:[UIColor orangeColor]
               textColor:[UIColor blackColor]
       textSelectedColor:[UIColor redColor]
      fieldRightPadding:15.f
           keyboardType:UIKeyboardTypeNumberPad
                   font:[UIFont systemFontOfSize:30.f]
            andDelegate:self];
    
    [txtField2 setFields:6
         backgroundImage:[UIImage imageNamed:@"circle.png"]
               tintImage:[UIImage imageNamed:@"circle1.jpeg"]
               textColor:[UIColor blackColor]
       textSelectedColor:[UIColor redColor]
       fieldRightPadding:5.f
            keyboardType:UIKeyboardTypeDefault
                    font:[UIFont systemFontOfSize:30.f]
             andDelegate:self];
}

- (void)textField:(GDSTextField*)textField endEditingWithText:(NSString*)text {
    NSLog(@"GDGTextField string %@",text);
}

- (IBAction)btnValue:(id)sender {
    NSLog(@"value of textfield1 %@, textField2 %@",txtField1.text, txtField2.text);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
