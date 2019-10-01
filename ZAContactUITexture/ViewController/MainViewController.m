//
//  ViewController.m
//  ZAContactUITexture
//
//  Created by Huynh Lam Phu Si on 9/21/19.
//  Copyright © 2019 Huynh Lam Phu Si. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()
@property ASCollectionNode* selectedNodeView;
@property UISearchBar* searchBar;
@property ASCollectionNode* contactsNodeView;

@property CGFloat selectedViewHeight;
@property UICollectionViewFlowLayout* selectedViewFlowLayout;
@property UICollectionViewFlowLayout* contactsViewFlowLayout;

@property NSArray<contactWithStatus*>* selectedContacts;
@property NSArray<contactWithStatus*>* searchedContacts;
@property NSDictionary<NSString*, NSArray<contactWithStatus*>*>* allContacts;
@property ContactBussiness* businessInteface;
@property BOOL isSearched;
@end

@interface MainViewController (DataSource) <ASCollectionDataSource>
@end

@interface MainViewController (Delegate) <ASCollectionDelegate>
@end

@interface MainViewController (SearchDelegate) <UISearchBarDelegate>

@end

@implementation MainViewController

#pragma mark : - Layout for view
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.selectedViewFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.contactsViewFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.allContacts = [[NSDictionary alloc] init];
    self.selectedContacts = [[NSArray alloc] init];
    self.searchedContacts = [[NSArray alloc] init];
    self.selectedViewHeight = 60;
    
    CGSize viewSize = self.view.bounds.size;
    CGFloat navigationHeight = self.navigationController.navigationBar.frame.size.height;
    
    self.businessInteface = [[ContactBussiness alloc] init];
    self.selectedNodeView = [[ASCollectionNode alloc] initWithFrame:CGRectMake(0, navigationHeight, viewSize.width, self.selectedViewHeight) collectionViewLayout:self.selectedViewFlowLayout];
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, navigationHeight + self.selectedViewHeight, self.view.bounds.size.width, 44)];
    self.contactsNodeView = [[ASCollectionNode alloc] initWithFrame:CGRectMake(0,navigationHeight +  self.selectedViewHeight + 44, viewSize.width, viewSize.height - self.selectedViewHeight - 44 - navigationHeight) collectionViewLayout:self.contactsViewFlowLayout];
    
    [self.businessInteface getAllContacInDeviceWithCompletionHandler:^(BOOL canGet) {
        if (canGet) {
            [self.businessInteface groupContactToSectionWithCompletion:^{
                self.allContacts = self.businessInteface.dictionary;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.contactsNodeView reloadData];
                });
            }];
        }
    }];
    
    self.selectedNodeView.delegate = self;
    self.selectedNodeView.dataSource = self;
    [self.view addSubnode:self.selectedNodeView];
    
    self.searchBar.delegate = self;
    [self.view addSubview:self.searchBar];
    
    self.contactsNodeView.delegate = self;
    self.contactsNodeView.dataSource = self;
    [self.view addSubnode:self.contactsNodeView];
}

- (void) viewDidLayoutSubviews {
    CGSize viewSize = self.view.bounds.size;
    CGFloat navigationHeight = self.navigationController.navigationBar.frame.size.height;
    
    self.selectedNodeView.frame = CGRectMake(0, navigationHeight, viewSize.width, self.selectedViewHeight);
    self.searchBar.frame = CGRectMake(0, navigationHeight + self.selectedViewHeight, viewSize.width, 44);
    self.contactsNodeView.frame = CGRectMake(0, navigationHeight + self.selectedViewHeight + 44, viewSize.width, viewSize.height - self.selectedViewHeight - navigationHeight - 44);
}

@end

#pragma mark : - ASCollection DataSource
@implementation MainViewController (DataSource)

- (NSInteger) numberOfSectionsInCollectionNode:(ASCollectionNode *)collectionNode {
    if (collectionNode == self.selectedNodeView) {
        return 1;
    }
    if (collectionNode == self.contactsNodeView) {
        if (self.isSearched) {
            return 1;
        } else {
            return self.allContacts.allKeys.count;
        }
    }
    return 0;
}

- (NSInteger) collectionNode:(ASCollectionNode *)collectionNode numberOfItemsInSection:(NSInteger)section {
    if (collectionNode == self.selectedNodeView) {
        return self.selectedContacts.count;
    }
    if (collectionNode == self.contactsNodeView) {
        if (self.isSearched) {
            return self.searchedContacts.count;
        } else {
            NSString* sectionHeader = [[self.businessInteface titleForSection] objectAtIndex:section];
            NSArray* array = [self.allContacts valueForKey:sectionHeader];
            return array.count;
        }
    }
    return 0;
}

- (ASCellNodeBlock) collectionNode:(ASCollectionNode *)collectionNode nodeBlockForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString* sectionHeader = [[self.businessInteface titleForSection] objectAtIndex:indexPath.section];
    NSArray* array = [self.allContacts valueForKey:sectionHeader];
    contactWithStatus* contact = [array objectAtIndex:indexPath.row];
    return ^{
        ContactViewCell* cell = [[ContactViewCell alloc] initWithContactModel:contact];
        return cell;
    };
}

- (ASCellNode*) collectionNode:(ASCollectionNode *)collectionNode nodeForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        NSString* stringHeader = [[self.businessInteface titleForSection] objectAtIndex:indexPath.section];
        HeaderViewCell* headerSuplementary = [[HeaderViewCell alloc] initWithString:stringHeader];
        return headerSuplementary;
    } else {
        return nil;
    }
}

- (ASSizeRange)collectionNode:(ASCollectionNode *)collectionNode constrainedSizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize maxSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height / 8);
    CGSize minSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height / 10);
    return ASSizeRangeMake(minSize, maxSize);
}
@end

#pragma mark : - ASCollection Delegate
@implementation MainViewController (Delegate)

- (void) collectionNode:(ASCollectionNode *)collectionNode didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}
@end

#pragma mark : - SearchBar Delegate
@implementation MainViewController (SearchDelegate)
- (void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchText.length == 0) {
        self.isSearched = false;
    } else {
        self.isSearched = false;
    }
}
@end
