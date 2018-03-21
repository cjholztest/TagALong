//
//  CreditCardTableViewCellViewModel.h
//  TagALong
//
//  Created by Nikita Vintonovich on 3/20/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CreditCardTableViewCellViewModel : NSObject

@property (nonatomic, strong) NSString *cardID;

@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, assign) NSInteger cardType;
@property (nonatomic, strong) UIImage *cardImage;
@property (nonatomic, strong) NSString *lastNumbers;
@property (nonatomic, strong) NSString *brandTitle;

@end
