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
        
        self.checkBox.frame = CGRectMake(0, 0, 30, 30);
        self.iconLabel.frame = CGRectMake(0, 0, 50, 50);
        self.nameLabel.frame = CGRectMake(0, 0, self.view.bounds.size.width - 150, 30);
        
        NSString* avatarString = [[ContactViewCell utility] getAvatarOf:contact];
        NSString* nameString = [[ContactViewCell utility] getContactFullNameOf:contact];
        
        self.iconLabel.attributedText = [[NSAttributedString alloc] initWithString:avatarString];
        self.nameLabel.attributedText = [[NSAttributedString alloc] initWithString:nameString];
        [self addSubnode:self.checkBox];
        [self addSubnode:self.iconLabel];
        [self addSubnode:self.nameLabel];
        dispatch_async(dispatch_get_main_queue(), ^{
            
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
- (ASLayoutSpec*) layoutSpecThatFits:(ASSizeRange)constrainedSize {
    ASRelativeLayoutSpec* checkBoxRelativeSpec = [ASRelativeLayoutSpec relativePositionLayoutSpecWithHorizontalPosition:ASRelativeLayoutSpecPositionStart verticalPosition:ASRelativeLayoutSpecPositionCenter sizingOption:ASRelativeLayoutSpecSizingOptionDefault child:self.checkBox];
    ASInsetLayoutSpec* checkBoxInsetSpec = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(0, 40, 0, 30) child:checkBoxRelativeSpec];
    return checkBoxInsetSpec;
}
@end
