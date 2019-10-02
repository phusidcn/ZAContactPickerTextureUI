//
//  ContactUtility.m
//  ContactFriendMaking
//
//  Created by CPU11899 on 7/29/19.
//  Copyright © 2019 CPU11899. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContactUtility.h"
@implementation contactUtility : NSObject
- (NSString*) getContactFullNameOf:(contactWithStatus*) contact {
    NSString* fullName = [NSString stringWithFormat:@"%@ %@ %@ %@",[[contact instance] namePrefix], [[contact instance] familyName], [[contact instance] givenName], [[contact instance] nameSuffix]];
    return fullName;
}

- (NSString*) getAvatarOf:(contactWithStatus*) contact {
    NSString* avatar = [NSString stringWithFormat:@"%@%@", [[[contact instance] familyName] substringToIndex:1], [[[contact instance] givenName] substringToIndex:1]];
    return avatar;
}

- (NSString*) getPhoneNumberOf:(contactWithStatus*) contact {
    NSString* phoneNumber = contact.instance.phoneNumber;
    return phoneNumber;
}

- (UIColor*) getColorOf:(contactWithStatus *)contact {
    NSString* phoneNumber = contact.instance.phoneNumber;
    NSInteger hash = phoneNumber.hash;
    int red = (hash >> 16) & 0xFF;
    int green = (hash >> 8) & 0xFF;
    int blue = hash & 0xFF;
    UIColor *Color = [UIColor colorWithRed:red / 255.0 green:green / 255.0 blue:blue / 255.0 alpha:0.5];
    return Color;
}

- (UIImage*) getIconOf:(contactWithStatus*) contact {
    UIView* backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    UILabel* iconLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    [backView addSubview:iconLabel];
    
    backView.backgroundColor = [UIColor whiteColor];
    
    iconLabel.text = [self getAvatarOf:contact];
    iconLabel.backgroundColor = [self getColorOf:contact];
    iconLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightMedium];
    iconLabel.textAlignment = NSTextAlignmentCenter;
    iconLabel.textColor = [UIColor whiteColor];
    iconLabel.clipsToBounds = true;
    iconLabel.layer.cornerRadius = 25;
    
    UIGraphicsBeginImageContextWithOptions(backView.bounds.size, backView.opaque, 0.0);
    [[backView layer] renderInContext:UIGraphicsGetCurrentContext()];
    UIImage* result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return result;
}
@end
