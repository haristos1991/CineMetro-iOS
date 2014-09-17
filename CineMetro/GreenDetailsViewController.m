//
//  GreenDetailsViewController.m
//  CineMetro
//
//  Created by George Haristos on 19/8/14.
//  Copyright (c) 2014 George Haristos. All rights reserved.
//

#import "GreenDetailsViewController.h"
#import "ShowActorsViewController.h"
#import "MainViewController.h"
#import "ShowTextViewController.h"
#import <Social/Social.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "ViewController.h"

@interface GreenDetailsViewController ()
@property NSInteger position1;

@end

@implementation GreenDetailsViewController
@synthesize position1;
@synthesize position;
@synthesize movieTitle;
NSMutableArray *images;
NSArray *currentList;
NSArray *titles;
NSMutableArray *points;




- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    images = [[NSMutableArray alloc]init];
    
    position1 = position;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"GreenLineStations" ofType:@"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    NSArray *anns = [dict objectForKey:@"Stations"];
    currentList = anns;
    movieTitle.text = [[currentList objectAtIndex:position1]objectForKey:@"Subtitle"];
    images = [[anns objectAtIndex:position1]objectForKey:@"Images"];
    titles = [[NSArray alloc]initWithObjects:@"Συντελεστές",@"Πληροφορίες", nil];
    [self performSegueWithIdentifier:@"showPhotos" sender:self];


    // Do any additional setup after loading the view.
}

- (IBAction)rateButtonPressed:(id)sender {
    if(user != nil){
        points = [NSMutableArray arrayWithArray:[user objectForKey:@"greenLineStations"]];
        if([[points objectAtIndex:position1]intValue] != 0){
            UIAlertView *alert =[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"ratedTrue",@"word") message:nil delegate:nil cancelButtonTitle:NSLocalizedString(@"ok",@"word") otherButtonTitles:nil, nil];
            [alert show];
        }
        else{
            self.popViewController = [[RatingViewController alloc] initWithNibName:@"RatingViewController" bundle:nil];
            
            [self.popViewController showInView:self.navigationController.view  withController:self withArray:points atIndexPath:position1 withName:@"greenLineStations" animated:YES];
        }
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Please Log In to Rate" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    if(images.count == 0 && [identifier isEqualToString:@"showPhotos"]){
        return NO;
    }
    return YES;
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return titles.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"tCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    UILabel *label = (UILabel *)[cell viewWithTag:108];
    label.text = [titles objectAtIndex:indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row == 0){
        [self performSegueWithIdentifier:@"ShowActors" sender:nil];
    }
    else if(indexPath.row == 1){
        [self performSegueWithIdentifier:@"showText" sender:nil];
    }
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"showPhotos"]){
        ViewController *dest = segue.destinationViewController;
        if(images.count != 0){
            dest.pageImages = [[NSArray alloc]initWithArray:images];
        }
    }
    else if([segue.identifier isEqualToString:@"ShowActors"]){
        ShowActorsViewController *dest = segue.destinationViewController;
        dest.list = [[currentList objectAtIndex:position1]objectForKey:@"Actors"];
        dest.directlist = [[currentList objectAtIndex:position1]objectForKey:@"Director"];
    }
    else if([segue.identifier isEqualToString:@"showText"]){
        ShowTextViewController *dest = segue.destinationViewController;
        dest.text = [[currentList objectAtIndex:position1]objectForKey:@"text"];
        dest.movieTitle = [[currentList objectAtIndex:position1]objectForKey:@"Subtitle"];
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.

   
}

-(void)viewDidDisappear:(BOOL)animated{
    images = nil;
   // [[[self childViewControllers]objectAtIndex:0] removeFromParentViewController];
    
}



- (IBAction)twitterButton:(id)sender {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheetOBJ = [SLComposeViewController
                                                  composeViewControllerForServiceType:SLServiceTypeTwitter];
        NSString *twittertext = [NSString stringWithFormat:@"#CineMetro #line2station%i\n",position1+1];
        [tweetSheetOBJ setInitialText:twittertext];
        [self presentViewController:tweetSheetOBJ animated:YES completion:nil];
    }
    else{ // no twitter account
        UIAlertView *noaccount = [[UIAlertView alloc]initWithTitle:@"No Twitter Account" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        noaccount.tag = 200;
        [noaccount show];
    }
}

- (IBAction)facebookButton:(id)sender {
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        SLComposeViewController *fbSheetOBJ = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        NSString *fbtext = [NSString stringWithFormat:@"#CineMetro #line2station%i\n",position1+1];
        [fbSheetOBJ setInitialText:fbtext];
        [self presentViewController:fbSheetOBJ animated:YES completion:Nil];
    }
    else{ // no facebook account
        UIAlertView *noaccount = [[UIAlertView alloc]initWithTitle:@"No Facebook Account" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        noaccount.tag = 200;
        [noaccount show];
    }

}
@end
