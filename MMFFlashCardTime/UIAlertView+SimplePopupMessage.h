//
//  UIAlertView+SimplePopupMessage.h
//  MMFNoFilter
//
//  Created by Michael Folcher on 2/16/14.
//  Copyright (c) 2014 Michael Folcher. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertView (SimplePopupMessage)

+(instancetype)alertPopupWithTitle:(NSString *)title withMessage:(NSString *)message;

@end
