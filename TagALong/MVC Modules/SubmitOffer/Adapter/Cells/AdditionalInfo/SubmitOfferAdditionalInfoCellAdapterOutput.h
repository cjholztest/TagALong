//
//  SubmitOfferAdditionalInfoCellAdapterOutput.h
//  TagALong
//
//  Created by Nikita Vintonovich on 5/14/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SubmitOfferAdditionalInfoCellAdapterOutput <NSObject>

- (void)additionalInfoTextDidChange:(NSString*)additionalInfo;
- (void)additionalInfoCellDidTap;
- (NSString*)additionalInfo;

@end
