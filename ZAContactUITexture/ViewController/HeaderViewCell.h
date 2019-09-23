//
//  HeaderViewCell.h
//  ZAContactUITexture
//
//  Created by CPU11899 on 9/23/19.
//  Copyright © 2019 Huynh Lam Phu Si. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AsyncDisplayKit/AsyncDisplayKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HeaderViewCell : ASCellNode
@property ASTextNode* headerLabel;
- (instancetype) initWithString:(NSString*) header;
@end

NS_ASSUME_NONNULL_END
