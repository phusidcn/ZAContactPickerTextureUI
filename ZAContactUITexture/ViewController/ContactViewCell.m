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

        NSString* avatarString = [[ContactViewCell utility] getAvatarOf:contact];
        NSString* nameString = [[ContactViewCell utility] getContactFullNameOf:contact];
        //[attributedString addAttributes:attributes range:NSMakeRange(0, nameString.length)];
        
        self.iconLabel.attributedText = [self attributedStringWith:avatarString Color:[UIColor blackColor] AndFont:[UIFont systemFontOfSize:25]];
        self.labelBackground.backgroundColor = [[ContactViewCell utility] getColorOf:contact];
        
        self.nameLabel.attributedText = [self attributedStringWith:nameString Color:[UIColor blackColor] AndFont:[UIFont systemFontOfSize:15]];
        [self checkImageOfContac:contact];
        self.checkBox.forcedSize = CGSizeMake(10, 10);
        [self addSubnode:self.labelBackground];
        [self addSubnode:self.checkBox];
        [self addSubnode:self.iconLabel];
        [self addSubnode:self.nameLabel];
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
    ASInsetLayoutSpec* iconCenterInset = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(10, 10, 10, 10) child:self.iconLabel];
    ASOverlayLayoutSpec* iconLayoutSpec = [ASOverlayLayoutSpec overlayLayoutSpecWithChild:iconCenterInset overlay:self.labelBackground];
    
    ASStackLayoutSpec* horizontalStack = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal spacing:10 justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsCenter children:@[self.checkBox, iconLayoutSpec, self.nameLabel]];
    
    return horizontalStack;
}
@end
