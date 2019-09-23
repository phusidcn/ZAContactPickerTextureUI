//
//  ContactViewCell.m
//  ZAContactUITexture
//
//  Created by CPU11899 on 9/23/19.
//  Copyright © 2019 Huynh Lam Phu Si. All rights reserved.
//

#import "ContactViewCell.h"

@implementation ContactViewCell
- (instancetype) initWithContactModel:(contactWithStatus *)contact {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor orangeColor];
        self.model = contact;
        self.checkBox = [[ASImageNode alloc] init];
        self.iconLabel = [[ASTextNode alloc] init];
        self.nameLabel = [[ASTextNode alloc] init];
        NSString* avatarString = [[ContactViewCell utility] getAvatarOf:contact];
        NSString* nameString = [[ContactViewCell utility] getContactFullNameOf:contact];
        
        self.iconLabel.attributedText = [[NSAttributedString alloc] initWithString:avatarString];
        self.nameLabel.attributedText = [[NSAttributedString alloc] initWithString:nameString];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.view addSubnode:self.checkBox];
            [self.view addSubnode:self.iconLabel];
            [self.view addSubnode:self.nameLabel];
        });
    }
    return self;
}

+ (contactUtility*) utility {
    static contactUtility* utilityInstace = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        utilityInstace = [[contactUtility alloc] init];
    });
    return utilityInstace;
}
- (void) nodeDidLayout {
    NSLog(@"Layout");
}
/*
- (ASLayoutSpec*) layoutSpecThatFits:(ASSizeRange)constrainedSize {
    ASRelativeLayoutSpec* checkBoxLayout = [ASRelativeLayoutSpec relativePositionLayoutSpecWithHorizontalPosition:ASRelativeLayoutSpecPositionStart verticalPosition:ASRelativeLayoutSpecPositionCenter sizingOption:ASRelativeLayoutSpecSizingOptionDefault child:self.checkBox];
    ASRelativeLayoutSpec
}*/
@end
