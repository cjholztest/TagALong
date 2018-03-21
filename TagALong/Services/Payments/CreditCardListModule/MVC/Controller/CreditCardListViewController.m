//
//  CreditCardListViewController.m
//  TagALong
//
//  Created by Nikita Vintonovich on 3/20/18.
//  Copyright © 2018 PJH. All rights reserved.
//

#import "CreditCardListViewController.h"
#import "CreditCardTableViewCellViewModel.h"
#import "CreditCardTableViewCell.h"
#import "CreditCardListModel.h"
#import "CreditCardListView.h"
#import "AddCreditCardViewController.h"

static NSString *const kReusableIdentifier = @"CreditCardTableViewCellIdentifier";

@interface CreditCardListViewController () <UITableViewDataSource, UITableViewDelegate, CreditCardListModelOutput, CreditCardListUserInterfaceInput>

@property (nonatomic, strong) CreditCardListModel *model;
@property (nonatomic, weak) IBOutlet CreditCardListView *contentView;

@end

@implementation CreditCardListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupDependencies];
    [self.model loadCardList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Private

- (void)setupDependencies {
    self.model = [CreditCardListModel new];
    self.model.output = self;
    self.contentView.eventHandler = self;
}

#pragma mark - CreditCardListModelOutput

- (void)cardListDidLoad {
    NSLog(@"cardListDidLoad");
}

#pragma mark - CreditCardListUserInterfaceInput

- (void)addCreditCardDidTap {
    NSLog(@"addCreditCardDidTap");
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Payment" bundle:nil];
    AddCreditCardViewController *addCreditVC = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass(AddCreditCardViewController.class)];
    [self.navigationController pushViewController:addCreditVC animated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.model cardsCount];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CreditCardTableViewCell *cell = (CreditCardTableViewCell*)[tableView dequeueReusableCellWithIdentifier:kReusableIdentifier];
    id viewModel = [self.model cardViewModelAtIndex:indexPath.row];
    [cell updateWithModel:viewModel];
    return cell;
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    static NSString *footerIdentifier = @"CardListFooterIdentifier";
    UITableViewHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:footerIdentifier];
    if (!view) {
        view = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:footerIdentifier];
    }
    return view.contentView;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSIndexPath *previousIndexPath = [self.model selectedIndexPath];
    if (previousIndexPath) {
        CreditCardTableViewCell *previousCell = [tableView cellForRowAtIndexPath:previousIndexPath];
        [self.model cardSetSelected:NO atIndexPath:previousIndexPath];
        [previousCell updateWithModel:[self.model cardViewModelAtIndex:previousIndexPath.row]];
    }
    [self.model cardSetSelected:YES atIndexPath:indexPath];
    CreditCardTableViewCell *currentCell = [tableView cellForRowAtIndexPath:indexPath];
    [currentCell updateWithModel:[self.model cardViewModelAtIndex:indexPath.row]];
}

@end
