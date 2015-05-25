//
//  ListViewControllerController.m
//  Feed
//
//  Created by Yongjia Liu on 14-5-21.
//  Copyright (c) 2014年 Yongjia Liu. All rights reserved.
//

#import "ListViewControllerController.h"
#import "WebViewController.h"
#import "RSSChannel.h"
#import "RSSItem.h"
@interface ListViewControllerController ()

@end

@implementation ListViewControllerController
@synthesize webViewController;
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    NSLog(@"%@ found a %@ element",self,elementName);
    if ([elementName isEqual:@"channel"]) {
        channel=nil;
        channel=[[RSSChannel alloc]init];
        [channel setParentParserDelegate:self];
        [parser setDelegate:channel];
    }
}
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        [self fetchEntries];// Custom initialization
    }
    return self;
}
-(void)fetchEntries
{
    xmlData=[[NSMutableData alloc]init];
    //NSURL *url=[NSURL URLWithString:@"http://www.apple.com/pr/feeds/pr.rss"];
    //NSURL *url=[NSURL URLWithString:@"http://images.apple.com/main/rss/hotnews/hotnews.rss"];
    NSURL *url=[NSURL URLWithString:@"http://www.pingwest.com/feed/"];
    NSURLRequest *req=[NSURLRequest requestWithURL:url];
    connection=[[NSURLConnection alloc]initWithRequest:req delegate:self startImmediately:YES];
    
}
-(void)connection:(NSURLConnection *)conn didReceiveData:(NSData *)data
{
    [xmlData appendData:data];
}
-(void)connection:(NSURLConnection *)conn didFailWithError:(NSError *)error
{
    connection=nil;
    xmlData=nil;
    NSString *errorString=[NSString stringWithFormat:@"Fetch failed:%@",[error localizedDescription]];
    UIAlertView *av=[[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [av show];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)conn
{
    NSXMLParser *parser=[[NSXMLParser alloc]initWithData:xmlData];
    [parser setDelegate:self];
    [parser parse];
    parser=nil;
    xmlData=nil;
    connection=nil;
    
    [[self tableView] reloadData];
    NSLog(@"%@\n%@\n%@\n",channel,[channel title],[channel shortDescription]);
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[self navigationController] pushViewController:webViewController animated:YES];
    RSSItem *entry=[[channel items]objectAtIndex:[indexPath row]];
    NSURL *url=[NSURL URLWithString:[entry link]];
    NSURLRequest *req=[NSURLRequest requestWithURL:url];
    [[webViewController webView] loadRequest:req];
    [[webViewController navigationItem] setTitle:[entry title]];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[channel items] count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"UITableViewCell"];
    }
    RSSItem *item=[[channel items] objectAtIndex:[indexPath row]];
    [[cell textLabel]setText:[item title]];
    [[cell detailTextLabel]setText:[item shortDescription]];
    [cell detailTextLabel].textColor=[UIColor colorWithRed:0.56 green:0.56 blue:0.56 alpha:1];
    [cell detailTextLabel].lineBreakMode=NSLineBreakByCharWrapping;
    [cell detailTextLabel].numberOfLines=0;
    return cell;
}
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
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
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
