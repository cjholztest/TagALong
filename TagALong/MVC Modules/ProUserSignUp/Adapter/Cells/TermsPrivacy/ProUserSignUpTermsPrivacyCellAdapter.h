//
//  ProUserSignUpTermsPrivacyCellAdapter.h
//  TagALong
//
//  Created by User on 5/21/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProUserSignUpCellAdapter.h"
#import "ProUserSignUpTermsPrivacyCellAdapterOutput.h"

@interface ProUserSignUpTermsPrivacyCellAdapter : NSObject <ProUserSignUpCellAdapter>

- (instancetype)initWithOutput:(id <ProUserSignUpTermsPrivacyCellAdapterOutput>)output;

@end
