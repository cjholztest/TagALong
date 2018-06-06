//
//  ReviewOfferAdditionalSectionAdapterOutput.h
//  TagALong
//
//  Created by Nikita Vintonovich on 5/17/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ReviewOfferAdditionalSectionAdapterOutput <NSObject>

- (NSInteger)additionalRowsCount;

- (id)additionalDisplayModelAtIndexPath:(NSIndexPath*)indexPath;

@end
