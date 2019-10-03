//
//  HeaderViewCell.m
//  ZAContactUITexture
//
//  Created by CPU11899 on 9/23/19.
//  Copyright © 2019 Huynh Lam Phu Si. All rights reserved.
//

#import "HeaderViewCell.h"

@implementation HeaderViewCell
- (instancetype) initWithString:(NSString *)header {
    self = [super init];
    if (self) {
        self.headerLabel = [[ASTextNode alloc] init];
        self.seperator = [[ASDisplayNode alloc] init];
        
        self.headerLabel.attributedText = [self attributedStringWith:header Color:[UIColor blackColor] AndFont:[UIFont systemFontOfSize:12 weight:UIFontWeightBold]];
        self.seperator.backgroundColor = [UIColor blackColor];
        self.seperator.style.preferredSize = CGSizeMake(self.view.bounds.size.width, 5);
        [self addSubnode:self.seperator];
        [self addSubnode:self.headerLabel];
    }
    return self;
}

- (NSAttributedString*) attributedStringWith:(NSString*)string Color:(UIColor*)color AndFont:(UIFont*)font {
    NSDictionary* attribute = @{NSForegroundColorAttributeName:color, NSFontAttributeName: font};
    NSAttributedString* result = [[NSAttributedString alloc] initWithString:string attributes:attribute];
    return result;
}

- (ASLayoutSpec*) layoutSpecThatFits:(ASSizeRange)constrainedSize {
    //ASRelativeLayoutSpec* seperatorLayout = [ASRelativeLayoutSpec relativePositionLayoutSpecWithHorizontalPosition:ASRelativeLayoutSpecPositionCenter verticalPosition:ASRelativeLayoutSpecPositionStart sizingOption:ASRelativeLayoutSpecSizingOptionDefault child:self.seperator];
    ASInsetLayoutSpec* seperatorLayout = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) child:self.seperator];
    ASInsetLayoutSpec* headerLayout = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(5, 10, 5, 10) child:self.headerLabel];
    ASRelativeLayoutSpec* relativeLayoutSpec = [ASRelativeLayoutSpec relativePositionLayoutSpecWithHorizontalPosition:ASRelativeLayoutSpecPositionStart verticalPosition:ASRelativeLayoutSpecPositionCenter sizingOption:ASRelativeLayoutSpecSizingOptionDefault child:headerLayout];
    ASStackLayoutSpec* overallLayout = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical spacing:0 justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsStart children:@[seperatorLayout, relativeLayoutSpec]];
    return overallLayout;
}
@end
