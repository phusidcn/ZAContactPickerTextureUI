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

@interface MainViewController (ContactsNodeViewDataSource)
- (NSInteger) numberOfContactsSection;
- (NSInteger) numberOfRowInContactsSection:(NSInteger) section;
- (ASCellNodeBlock) contactNodeAtIndexPath:(NSIndexPath*) indexPath;
@end

@interface MainViewController (SelectedNodeViewDataSource)
- (NSInteger) numberOfSelectedSection;
- (NSInteger) numberOfRowInSelectedSection;
- (ASCellNodeBlock) selectedNodeAtIndexPath:(NSIndexPath*) indexPath;
@end

@interface MainViewController (Delegate) <ASCollectionDelegate>
@end

@interface MainViewController (ContactsNodeViewDelegate)
@end

@interface MainViewController (SelectedNodeViewDelegate)
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
    self.contactsViewFlowLayout.headerReferenceSize = CGSizeMake(self.view.bounds.size.width, 30);
    
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
    [self.contactsNodeView registerSupplementaryNodeOfKind:UICollectionElementKindSectionHeader];
    
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
        return [self numberOfContactsSection];
    }
    return 0;
}

- (NSInteger) collectionNode:(ASCollectionNode *)collectionNode numberOfItemsInSection:(NSInteger)section {
    if (collectionNode == self.selectedNodeView) {
        return self.selectedContacts.count;
    }
    if (collectionNode == self.contactsNodeView) {
        return [self numberOfRowInContactsSection:section];
    }
    return 0;
}

- (ASCellNodeBlock) collectionNode:(ASCollectionNode *)collectionNode nodeBlockForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionNode == self.contactsNodeView) {
        return [self contactNodeAtIndexPath:indexPath];
    }
    if (collectionNode == self.selectedNodeView) {
        return [self selectedNodeAtIndexPath:indexPath];
    }
    return nil;
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
    if (collectionNode == self.contactsNodeView) {
        CGSize maxSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height / 8);
        CGSize minSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height / 10);
        return ASSizeRangeMake(minSize, maxSize);
    }
    if (collectionNode == self.selectedNodeView) {
        //CGSize maxSize = CGSizeMake(self., <#CGFloat height#>)
    }
    return ASSizeRangeMake(CGSizeMake(0, 0));
}
@end

#pragma mark : - ContactViewNode DataSource
@implementation MainViewController (ContactsNodeViewDataSource)
- (NSInteger) numberOfContactsSection {
    if (self.isSearched) {
        return self.searchedContacts.count;
    } else {
        return self.allContacts.allKeys.count;
    }
}

- (NSInteger) numberOfRowInContactsSection:(NSInteger)section {
    if (self.isSearched) {
        return self.searchedContacts.count;
    } else {
        NSString* sectionHeader = [[self.businessInteface titleForSection] objectAtIndex:section];
        NSArray* array = [self.allContacts valueForKey:sectionHeader];
        return array.count;
    }
}

- (ASCellNodeBlock) contactNodeAtIndexPath:(NSIndexPath*) indexPath {
    if (self.isSearched) {
        contactWithStatus* contact = [self.searchedContacts objectAtIndex:indexPath.row];
        return ^{
            ContactViewCell* cell = [[ContactViewCell alloc] initWithContactModel:contact];
            return cell;
        };
    }
    NSString* sectionHeader = [[self.businessInteface titleForSection] objectAtIndex:indexPath.section];
    NSArray* array = [self.allContacts valueForKey:sectionHeader];
    contactWithStatus* contact = [array objectAtIndex:indexPath.row];
    return ^{
        ContactViewCell* cell = [[ContactViewCell alloc] initWithContactModel:contact];
        return cell;
    };
}
@end

#pragma mark : - Selected Node View DataSource
@implementation MainViewController (SelectedNodeViewDataSource)
- (NSInteger) numberOfSelectedSection {
    return 1;
}

- (NSInteger) numberOfRowInSelectedSection {
    return [self.selectedContacts count];
}

- (ASCellNodeBlock) selectedNodeAtIndexPath:(NSIndexPath *)indexPath {
    contactWithStatus* contact = [self.selectedContacts objectAtIndex:indexPath.row];
    return ^{
        SelectedViewCell* cell = [[SelectedViewCell alloc] initWithContact:contact];
        return cell;
    };
}
@end

#pragma mark : - ASCollection Delegate
@implementation MainViewController (Delegate)

- (void) collectionNode:(ASCollectionNode *)collectionNode didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld %ld", (long)indexPath.section, (long)indexPath.row);
    if (self.isSearched) {
        [self.businessInteface ]
    }
    [self.businessInteface getContatAtIndexPath:indexPath WithCompletionHandler:^(contactWithStatus* contact) {
        if (contact.isSelected) {
            [self.businessInteface deselectContactAtIndexPath:indexPath completion:^(NSError* error) {
                [self updateUIWhenChangeContactAtIndexPath:indexPath];
            }];
        } else {
            [self.businessInteface selectOneContactAtIndexPath:indexPath completion:^(NSError* error) {
                [self updateUIWhenChangeContactAtIndexPath:indexPath];
            }];
        }
    }];
}

- (void) updateUIWhenChangeContactAtIndexPath:(NSIndexPath*) indexPath {
    self.allContacts = [self.businessInteface dictionary];
    [self.businessInteface getSelectedContactWithCompletionHandler:^(NSArray<contactWithStatus*>* result) {
        self.selectedContacts = result;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.contactsNodeView reloadItemsAtIndexPaths:@[indexPath]];
            [self.selectedNodeView reloadData];
        });
    }];
}

@end

#pragma mark : - SearchBar Delegate
@implementation MainViewController (SearchDelegate)
- (void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchText.length == 0) {
        self.isSearched = false;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.contactsNodeView reloadData];
        });
    } else {
        self.isSearched = true;
        [self.businessInteface searchContactWithKey:searchText completion:^(NSError* error) {
            [self.businessInteface getSearchedContactWithCompletionHandler:^(NSArray<contactWithStatus*>* result) {
                self.searchedContacts = result;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.contactsNodeView reloadData];
                });
            }];
        }];
    }
}
@end
