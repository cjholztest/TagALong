//
//  SubmitOfferWhatCellAdapterOutput.h
//  TagALong
//
//  Created by Nikita Vintonovich on 5/14/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SubmitOfferWhatCellAdapterOutput <NSObject>

- (void)whatCellDidTap;
- (void)whatTextDidChange:(NSString*)text;
- (NSString*)what;

@end
