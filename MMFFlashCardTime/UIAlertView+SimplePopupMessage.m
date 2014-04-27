//
//  UIAlertView+SimplePopupMessage.m
//  MMFNoFilter
//
//  Created by Michael Folcher on 2/16/14.
//  Copyright (c) 2014 Michael Folcher. All rights reserved.
//

#import "UIAlertView+SimplePopupMessage.h"

@implementation UIAlertView (SimplePopupMessage)

+(instancetype)alertPopupWithTitle:(NSString *)title withMessage:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:title
                          message:message
                          delegate:nil
                          cancelButtonTitle:NSLocalizedString(@"OK", @"OK Button Title")
                          otherButtonTitles:nil];
    return alert;
}

@end
