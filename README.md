# GDSTextField
GDSTextField for multiple text field with single characters input for each text field with equal width and height.

![alt tag] (https://raw.githubusercontent.com/dayitv89/GDSTextField/master/projectImage.png)
Just make a UIView in storyboard and connect to GDSTextField object, and add this line into code
```
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
```

when you want text of GDSTextField, get it simple
```
NSLog(@"value of textfield1 %@, textField2 %@",txtField1.text, txtField2.text);
```

And it will work, Voila!
