//
//  SelectedViewCell.m
//  ZAContactUITexture
//
//  Created by Huynh Lam Phu Si on 10/3/19.
//  Copyright © 2019 Huynh Lam Phu Si. All rights reserved.
//

#import "SelectedViewCell.h"

@implementation SelectedViewCell
- (instancetype) initWithContact:(contactWithStatus *)contact {
    self = [super init];
    if (self) {
        self.avatar = [[ASImageNode alloc] init];
        self.avatar.image = [[SelectedViewCell utility] getIconOf:contact];
        self.model = contact;
        [self addSubnode:self.avatar];
        [self layoutIfNeeded];
    }
    return self;
}

+ (contactUtility*) utility {
    __block contactUtility* utility = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        utility = [[contactUtility alloc] init];
    });
    return utility;
}

- (void) nodeDidLayout {
    NSLog(@"Layout");
}

- (ASLayoutSpec*) layoutSpecThatFits:(ASSizeRange)constrainedSize {
    ASInsetLayoutSpec* insetLayout = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(5, 5, 5, 5) child:self.avatar];
    return insetLayout;
}
@end
