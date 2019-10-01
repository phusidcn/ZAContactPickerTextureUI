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
        self.headerLabel.attributedText = [[NSAttributedString alloc] initWithString:header];
    }
    return self;
}

- (ASLayoutSpec*) layoutSpecThatFits:(ASSizeRange)constrainedSize {
    ASRelativeLayoutSpec* relativeLayoutSpec = [ASRelativeLayoutSpec relativePositionLayoutSpecWithHorizontalPosition:ASRelativeLayoutSpecPositionStart verticalPosition:ASRelativeLayoutSpecPositionStart sizingOption:ASRelativeLayoutSpecSizingOptionDefault child:self.headerLabel];
    return relativeLayoutSpec;
}
@end
