//
//  SubmitOfferView.h
//  TagALong
//
//  Created by Nikita Vintonovich on 5/14/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "GradientView.h"
#import "SubmitOfferProtocols.h"

@interface SubmitOfferView : GradientView <SubmitOfferViewInput>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UIButton *submitOfferButton;

@property (nonatomic, weak) id <SubmitOfferViewOutput> output;



@end
