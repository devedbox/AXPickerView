//
//  AXTableViewController.m
//  AXPickerView
//
//  Created by ai on 15/11/23.
//  Copyright © 2015年 AiXing. All rights reserved.
//

#import "AXTableViewController.h"
#import "AXPickerView.h"

@interface AXTableViewController ()
{
    NSArray *_dataSource;
}
@end

@implementation AXTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    _dataSource = @[@{@"title":@"Tips",@"detail":@"Show normal picker view with tips."},
                    @{@"title":@"Custion view",@"detail":@"Show normal picker view with custom view."},
                    @{@"title":@"Date picker",@"detail":@"Show date picker view."},
                    @{@"title":@"Image picker",@"detail":@"Show normal picker view with image picker view."}
                    ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"kAXPickerViewTableViewCell" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = _dataSource[indexPath.row][@"title"];
    cell.detailTextLabel.text = _dataSource[indexPath.row][@"detail"];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
            [AXPickerView showInView:self.view.window animated:YES style:AXPickerViewStyleNormal items:@[@"Yesterday",@"Today",@"Tomorrow"] title:@"Normal title" tips:@"Hello this is today.\n\nGet the new view controller using [segue destinationViewController].\n\nPass the selected object to the new view controller." configuration:^(AXPickerView *pickerView) {
                pickerView.tipsLabel.textAlignment = NSTextAlignmentLeft;
                AXPickerViewItemConfiguration *config = [AXPickerViewItemConfiguration configurationWithTintColor:[UIColor redColor] font:[UIFont boldSystemFontOfSize:16] atIndex:0];
                pickerView.itemConfigs = @[config];
            } completion:nil revoking:nil executing:^(NSString *selectedTitle, NSInteger index, AXPickerView *inPickerView) {
                NSLog(@"selected: %@", selectedTitle);
            }];
            break;
        case 1:
        {
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"TestImage.jpg"]];
            [imageView sizeToFit];
            [AXPickerView showInView:self.view.window animated:YES style:AXPickerViewStyleNormal items:@[@"Yesterday",@"Today",@"Tomorrow"] title:@"Normal title" customView:imageView configuration:nil completion:nil revoking:nil executing:^(NSString *selectedTitle, NSInteger index, AXPickerView *inPickerView) {
                NSLog(@"selected: %@", selectedTitle);
            }];
        }
            break;
        case 2:
            [AXPickerView showInView:self.view.window animated:YES style:AXPickerViewStyleDatePicker items:nil title:nil customView:nil configuration:^(AXPickerView *pickerView) {
                pickerView.separatorInsets = UIEdgeInsetsZero;
                pickerView.title = @"Date pick";
            } completion:^(AXPickerView *pickerView) {
                NSLog(@"selected date: %@", pickerView.selectedDate);
            } revoking:^(AXPickerView *pickerView) {
                NSLog(@"Canceled");
            } executing:nil];
            break;
        case 3:
            [AXPickerView showImagePickerInView:self.view.window animated:YES allowsMultipleSelection:YES containsCamera:YES configuration:nil completion:nil revoking:nil imagePickercompletion:^(AXPickerView *pickerView, NSArray *images) {
                
            }];
            break;
        default:
            break;
    }
}
@end