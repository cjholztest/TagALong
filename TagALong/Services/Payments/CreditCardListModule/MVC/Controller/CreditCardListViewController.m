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
#import "UIViewController+Alert.h"

static NSString *const kReusableIdentifier = @"CreditCardTableViewCellIdentifier";

@interface CreditCardListViewController () <UITableViewDataSource, UITableViewDelegate, CreditCardListModelOutput, CreditCardListUserInterfaceInput, AddCreditCardModuleDelegate>

@property (nonatomic, strong) CreditCardListModel *model;
@property (nonatomic, weak) IBOutlet CreditCardListView *contentView;

@end

@implementation CreditCardListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupDependencies];
    [self loadCreditCardList];
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

- (void)loadCreditCardList {
    [SharedAppDelegate showLoading];
    [self.model loadCardList];
}

#pragma mark - CreditCardListModelOutput

- (void)cardListDidLoad {
    [SharedAppDelegate closeLoading];
    [self.contentView.tebleView reloadData];
}

- (void)cardListDidLoadWithError:(NSString *)errorMessage {
    [SharedAppDelegate closeLoading];
    [self showAlert:errorMessage];
}

#pragma mark - CreditCardListUserInterfaceInput

- (void)addCreditCardDidTap {
    NSLog(@"addCreditCardDidTap");
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Payment" bundle:nil];
    AddCreditCardViewController *addCreditVC = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass(AddCreditCardViewController.class)];
    addCreditVC.moduleDelegate = self;
    addCreditVC.modeType = AddCreditCardtModeTypeProfile;
    [self.navigationController pushViewController:addCreditVC animated:YES];
}

#pragma mark - AddCreditCardModuleDelegate

- (void)creditCardDidAdd {
    [self.navigationController popToViewController:self animated:YES];
    [self loadCreditCardList];
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
    /* next code probably will need to debug selection credit cards:
    NSIndexPath *previousIndexPath = [self.model selectedIndexPath];
    if (previousIndexPath) {
        CreditCardTableViewCell *previousCell = [tableView cellForRowAtIndexPath:previousIndexPath];
        [self.model cardSetSelected:NO atIndexPath:previousIndexPath];
        [previousCell updateWithModel:[self.model cardViewModelAtIndex:previousIndexPath.row]];
    }
    [self.model cardSetSelected:YES atIndexPath:indexPath];
    CreditCardTableViewCell *currentCell = [tableView cellForRowAtIndexPath:indexPath];
    [currentCell updateWithModel:[self.model cardViewModelAtIndex:indexPath.row]];
    */
}

@end
