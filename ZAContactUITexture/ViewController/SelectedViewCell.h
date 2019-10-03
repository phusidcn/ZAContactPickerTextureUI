//
//  SelectedViewCell.h
//  ZAContactUITexture
//
//  Created by Huynh Lam Phu Si on 10/3/19.
//  Copyright © 2019 Huynh Lam Phu Si. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AsyncDisplayKit/AsyncDisplayKit.h>
#import "../Bussiness/ContactUtility.h"
#import "../Bussiness/ContactWithStatus.h"

NS_ASSUME_NONNULL_BEGIN

@interface SelectedViewCell : ASCellNode
@property ASImageNode* avatar;
- (instancetype) initWithContact:(contactWithStatus*) contact;
+ (contactUtility*) utility;
@end

NS_ASSUME_NONNULL_END
