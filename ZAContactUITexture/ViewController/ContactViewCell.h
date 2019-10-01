//
//  ContactViewCell.h
//  ZAContactUITexture
//
//  Created by CPU11899 on 9/23/19.
//  Copyright © 2019 Huynh Lam Phu Si. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AsyncDisplayKit/AsyncDisplayKit.h>
#import "../Bussiness/ContactWithStatus.h"
#import "../Bussiness/ContactUtility.h"

NS_ASSUME_NONNULL_BEGIN

@interface ContactViewCell : ASCellNode
@property contactWithStatus* model;
@property ASDisplayNode* labelBackground;
@property ASImageNode* checkBox;
@property ASTextNode* iconLabel;
@property ASTextNode* nameLabel;
- (instancetype) initWithContactModel:(contactWithStatus*) contact;
+ (contactUtility*) utility;
@end

NS_ASSUME_NONNULL_END
