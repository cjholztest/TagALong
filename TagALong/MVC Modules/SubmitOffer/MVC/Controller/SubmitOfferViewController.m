//
//  SubmitOfferViewController.m
//  TagALong
//
//  Created by User on 5/14/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "SubmitOfferViewController.h"
#import "SubmitOfferModel.h"
#import "SubmitOfferView.h"
#import "SubmitOfferAdapterHeaders.h"

@interface SubmitOfferViewController ()
<   SubmitOfferViewOutput,
    SubmitOfferModelOutput,
    SubmitOfferWhoCellAdapterOutput,
    SubmitOfferWhenCellAdapterOutput,
    SubmitOfferWhatCellAdapterOutput,
    SubmitOfferDurationCellAdapterOutput,
    SubmitOfferAmountCellAdapterOutput,
    SubmitOfferAdditionalInfoCellAdapterOutput  >

@property (nonatomic, weak) IBOutlet SubmitOfferView *contentView;
@property (nonatomic, strong) id <SubmitOfferModelInput> model;

@property (nonatomic, strong) id <SubmitOfferTableViewAdapterInput> tableViewAdapter;

@end

@implementation SubmitOfferViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

- (void)setup {
    
    self.model = [[SubmitOfferModel alloc] initWithOutput:self];
    self.contentView.output = self;
    
    SubmitOfferMainSectionAdapter *mainSectionAdapter = [SubmitOfferMainSectionAdapter new];
    
    mainSectionAdapter.cellAdapters = [NSArray <SubmitOfferCellAdapter> arrayWithObjects:
                                       [[SubmitOfferWhoCellAdapter alloc] initWithOutput:self],
                                       [[SubmitOfferWhenCellAdapter alloc] initWithOutput:self],
                                       [[SubmitOfferWhatCellAdapter alloc] initWithOutput:self],
                                       [[SubmitOfferDurationCellAdapter alloc] initWithOutput:self],
                                       [[SubmitOfferAmountCellAdapter alloc] initWithOutput:self],
                                       [[SubmitOfferAdditionalInfoCellAdapter alloc] initWithOutput:self], nil];
    
    SubmitOfferTableViewAdapter *tableAdapter = [[SubmitOfferTableViewAdapter alloc] init];
    tableAdapter.sectionAdapters = [NSMutableArray<SubmitOfferSectionAdapter> arrayWithObjects:mainSectionAdapter, nil];

    self.tableViewAdapter = tableAdapter;
    [self.tableViewAdapter setupWithTableView:self.contentView.tableView];
}

#pragma mark - SubmitOfferViewOutput

#pragma mark - SubmitOfferModelOutput

#pragma mark - SubmitOfferWhoCellAdapterOutput

#pragma mark - SubmitOfferWhenCellAdapterOutput

#pragma mark - SubmitOfferWhatCellAdapterOutput

#pragma mark - SubmitOfferDurationCellAdapterOutput

#pragma mark - SubmitOfferAmountCellAdapterOutput

#pragma mark - SubmitOfferAdditionalInfoCellAdapterOutput

#pragma mark - SubmitOfferModuleInput

@end
