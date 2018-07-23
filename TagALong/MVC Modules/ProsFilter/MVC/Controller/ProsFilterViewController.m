//
//  ProsFilterViewController.m
//  TagALong
//
//  Created by User on 7/20/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "ProsFilterViewController.h"
#import "ProsFilterModuleHeaders.h"

@interface ProsFilterViewController ()
<
ProsFilterModelOutput,
ProsFilterViewOutput
>

@property (nonatomic, weak) IBOutlet ProsFilterView *contentView;
@property (nonatomic, strong) id <ProsFilterModelInput> model;

@end

@implementation ProsFilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

- (void)setup {
    ProsFilterModel *model = [[ProsFilterModel alloc] initWithOutput:self];
    self.model = model;
    self.contentView.output = self;
}

@end
