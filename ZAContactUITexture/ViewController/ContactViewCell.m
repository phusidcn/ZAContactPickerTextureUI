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
        self.backgroundColor = [UIColor whiteColor];
        self.model = contact;
        self.checkBox = [[ASImageNode alloc] init];
        self.iconLabel = [[ASTextNode alloc] init];
        self.nameLabel = [[ASTextNode alloc] init];
        self.labelBackground = [[ASDisplayNode alloc] init];
        self.avatarImage = [[ASImageNode alloc] init];
        self.phoneNumber = [[ASTextNode alloc] init];

        NSString* avatarString = [[ContactViewCell utility] getAvatarOf:contact];
        NSString* nameString = [[ContactViewCell utility] getContactFullNameOf:contact];
        NSString* phoneNumber = [[ContactViewCell utility] getPhoneNumberOf:contact];
        
        //self.iconLabel.attributedText = [self attributedStringWith:avatarString Color:[UIColor blackColor] AndFont:[UIFont systemFontOfSize:25]];
        //self.labelBackground.backgroundColor = [[ContactViewCell utility] getColorOf:contact];
        [self checkImageOfContac:contact];
        self.checkBox.style.preferredSize = CGSizeMake(30, 30);
        
        self.avatarImage.image = [[ContactViewCell utility] getIconOf:contact];
        self.avatarImage.backgroundColor = [UIColor clearColor];
        
        self.nameLabel.attributedText = [self attributedStringWith:nameString Color:[UIColor blackColor] AndFont:[UIFont systemFontOfSize:15]];
        
        self.phoneNumber.attributedText = [self attributedStringWith:phoneNumber Color:[UIColor lightGrayColor] AndFont:[UIFont systemFontOfSize:12 weight:UIFontWeightLight]];

        //[self addSubnode:self.labelBackground];
        [self addSubnode:self.checkBox];
        [self addSubnode:self.avatarImage];
        //[self addSubnode:self.iconLabel];
        [self addSubnode:self.nameLabel];
        [self addSubnode:self.phoneNumber];
    }
    return self;
}

- (NSAttributedString*) attributedStringWith:(NSString*)string Color:(UIColor*)color AndFont:(UIFont*)font {
    NSDictionary* attribute = @{NSForegroundColorAttributeName:color, NSFontAttributeName: font};
    NSAttributedString* result = [[NSAttributedString alloc] initWithString:string attributes:attribute];
    return result;
}

- (void) checkImageOfContac:(contactWithStatus*) contact {
    if (contact.isSelected) {
        self.checkBox.image = [UIImage imageNamed:@"checked-checkbox"];
    } else {
        self.checkBox.image = [UIImage imageNamed:@"unchecked-checkbox"];
    }
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
    
    ASStackLayoutSpec* nameAndPhoneStack = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical spacing:5 justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsStart children:@[self.nameLabel, self.phoneNumber]];
    
    
    ASRelativeLayoutSpec* checkBoxLayout = [ASRelativeLayoutSpec relativePositionLayoutSpecWithHorizontalPosition:ASRelativeLayoutSpecPositionEnd verticalPosition:ASRelativeLayoutSpecPositionStart sizingOption:ASRelativeLayoutSpecSizingOptionMinimumSize child:self.checkBox];
    
    ASStackLayoutSpec* horizontalStack = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal spacing:10 justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsCenter children:@[checkBoxLayout, self.avatarImage, nameAndPhoneStack]];
    
    ASInsetLayoutSpec* stackInset = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(0, 20, 0, 10) child:horizontalStack];
    
    return stackInset;
}
@end
