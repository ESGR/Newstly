//
//  ACViewController.m
//  CellExpander
//
//  Created by Adex on 25/05/2013.
//  Copyright (c) 2013 amaCoder. All rights reserved.
//

#import "ACViewController.h"

#import "CustomTableView.h"
#import "CustomTableView0.h"
#import "CustomSubCatTableView.h"
#import "ACIndicatorView.h"



#import "ACWebController.h"

#import "ACChannelxml.h"
#import "ACPostxml.h"
#import "NSDateFormatter+ACAdditionFormatter.h"
#import "ACCustomCell.h"

#import "ACFetchNewsPost.h"


#import "ACFeedManager.h"

@interface ACViewController (){
    
    ACChannelxml * _channel;
    NSArray * _subCategory;
    UIView * _currentTitleView;
}
    
@property  NSInteger  numberSelected;
@property (strong, nonatomic) NSMutableArray * arryContainer ;
@property (strong) NSIndexPath * selectedIndexPath;
@property (strong, nonatomic) UILabel * errorLabel;
@property (strong, nonatomic) UIImage * barButtonImage;
//@property (strong, nonatomic) NSURLRequest * refreshRequest;


    

@end




@implementation ACViewController
@synthesize myCategoryTableView;
@synthesize myFeedTableView;
@synthesize arryContainer;
@synthesize selectedIndexPath;
@synthesize mySubCategoryTableView;
@synthesize request = _request;
@synthesize errorLabel = _errorLabel;
@synthesize barButtonImage = _barButtonImage;
//@synthesize refreshRequest = _refreshRequest;

@synthesize managedObjectContext;

-(void)dealloc{
    
    self.myCategoryTableView = nil;
    self.myFeedTableView = nil;
    self.arryContainer = nil;
    self.selectedIndexPath = nil;
    self.mySubCategoryTableView = nil;
    self.request = nil;
    _currentTitleView = nil;
    
}
-(void)fetchFeeds:(NSURLRequest *) request{
    
   // self.refreshRequest = request;
    
    _currentTitleView = [[self navigationItem] titleView];
    UIActivityIndicatorView *aiView = [[UIActivityIndicatorView alloc]
                                       initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [[self navigationItem] setTitleView:aiView];
    [aiView startAnimating];
    
    
    [[ACFetchNewsPost sharedACFetchNewsPost] fetchChannelFeeds:request withCompletionZero:^(ACChannelxml * object, NSError * error, NSURLResponse * response){
        
        [[self navigationItem] setTitleView:_currentTitleView];
        _errorLabel.text = @"";
        if (!error) {
            
            _channel = object;
            
       /*     ACChannel *sortChannel = [[ACChannel alloc] init];
            _channel = [sortChannel sortItemsUsingChannelWithOtherOtherChannel:object]; */
            
            [myFeedTableView reloadData];
        }else{
            
            NSLog(@"ERRROOORR");
            
            self.myFeedTableView.frame = CGRectZero;
            self.errorLabel = [[UILabel alloc] init];
            _errorLabel.frame = CGRectMake((self.view.frame.size.width/4) + 60, 0, ((self.view.frame.size.width * 3)/4) - 60, self.view.frame.size.height);
            _errorLabel.backgroundColor = [UIColor colorWithWhite:0.076 alpha:1.0];
            _errorLabel.textAlignment = NSTextAlignmentCenter;
            _errorLabel.font = [UIFont systemFontOfSize:14];
            _errorLabel.textColor = [UIColor grayColor];
            [[self view] addSubview:_errorLabel];
            
            _errorLabel.text = @"Connection Failed";
        
        
        }
        
    }];
    
}





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
	// Do any additional setup after loading the view.
    
  /*  ACFeedManager * manager = [[ACFeedManager alloc] init];
    [manager setManagedObjectContext:self.managedObjectContext];
    [manager initialFetchingWith:@"http://api.feedzilla.com/v1/categories/27/articles.json"
               withManagedObject:@"NewsItem"];
    
    if ([manager isCompleted]) {
        
        [manager finalFetchManagedObject:@"NewsItem"];
        
        NSLog(@"WORKING");
    }
  */
    
    
    [self setBarButtonImage:[UIImage imageNamed:@"logo.png"]];
    UIImage *image = [self barButtonImage];
    
    UIButton * icon = [UIButton buttonWithType:UIButtonTypeCustom];
    icon.bounds = CGRectMake(0, 0, image.size.width, image.size.height);
    
    [icon setImage:image forState:UIControlStateNormal];
    UIBarButtonItem * button = [[UIBarButtonItem alloc] initWithCustomView:icon];
    self.navigationItem.leftBarButtonItem = button;
    [self navigationItem].title = @"Home";
    
    
    if (myCategoryTableView == nil) {
        
        myCategoryTableView = [[CustomTableView alloc] init];
        myCategoryTableView.frame = CGRectMake(0, 0, (self.view.frame.size.width/4) + 60, self.view.frame.size.height);
        myCategoryTableView.separatorColor = [UIColor colorWithWhite:0.076 alpha:1.0];
        myCategoryTableView.rowHeight = 50;
        
        
        myCategoryTableView.delegate = self;
        myCategoryTableView.dataSource = self;
        
        [[self view] addSubview:myCategoryTableView];
        
        
    }
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSArray *)array1{
    
    NSArray * array = [[NSArray alloc] initWithObjects:@"News",@"Sport",@"Entertainment",@"Technology",@"Business",@"Science", nil];
    
    return array;
}


-(void)arrayNews{
    
    _subCategory = [[NSArray alloc] initWithObjects:@"CNN News",@"BBC News",@"Euro News",@"Sky News", nil];
    
    [mySubCategoryTableView reloadData];
}

-(void)arraySport{
    
    _subCategory = [[NSArray alloc] initWithObjects:@"CNN Sport",@"Sky Sport", nil];
    
    [mySubCategoryTableView reloadData];
}

-(void)arrayEntertainment{
    
    _subCategory = [[NSArray alloc] initWithObjects:@"BBC Ent",@"Entertainmentwise Ent",@"Sky Ent",@"Heatworld Ent", nil];
    
    [mySubCategoryTableView reloadData];
}

-(void)arrayTechnology{
    
    _subCategory = [[NSArray alloc] initWithObjects:@"BBC Tech",@"CNN Tech",@"CNet Tech",@"Techcrunch Tech",@"ZDNet Tech", nil];
    
    [mySubCategoryTableView reloadData];
}

-(void)arrayBusiness{
    
    _subCategory = [[NSArray alloc] initWithObjects:@"Forbes Business",@"CNN Business",@"BBC Business",@"Sky Business", nil];
    
    [mySubCategoryTableView reloadData];
}

-(void)arrayScience{
    
    _subCategory = [[NSArray alloc] initWithObjects:@"Sciencedaily Sci",@"Newscientist Sci",@"BBC Sci",@"NY Times Sci", nil];
    
    [mySubCategoryTableView reloadData];
}





#pragma mark - Table view data source
-(void)tableView:(UITableView *)tableView
 willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (myCategoryTableView == tableView) {
        
        tableView.backgroundColor = [UIColor colorWithWhite:0.076 alpha:1.0];
        cell.backgroundColor = [UIColor colorWithWhite:0.076 alpha:1.0];
    }
    
   else if (myFeedTableView == tableView) {
        
        cell.backgroundColor = [UIColor colorWithWhite:0.076 alpha:1.0];
    }
    
   else if (mySubCategoryTableView == tableView) {
        
        cell.backgroundColor = [UIColor colorWithWhite:0.076 alpha:1.0];
    }
    
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //#warning Potentially incomplete method implementation.
    // Return the number of sections.
    
    
    return 1;
}  

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger  count = 0;
    
    if (myCategoryTableView == tableView) {
        
        NSLog(@"%d", [[self array1] count]);
        
        count =  [[self array1] count];
    }
      else if (myFeedTableView == tableView){
        
        NSLog(@"%d", [[_channel items] count]);
        count = [[_channel items] count];
      } else if (mySubCategoryTableView == tableView){
          
          NSLog(@"Sub View Delegate");
          count = [_subCategory count];
      }
    
    
    return count;
    
}


 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
 {
     UIImage *image ;
     UIImageView * _viewImage;
     static NSString *CellIdentifier = @"Cell";
     UITableViewCell *cl ;
     
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier ];
     
    
     if (!cell) {
         
         cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
         cell.textLabel.font = [UIFont systemFontOfSize:16];
         cell.textLabel.textColor = [UIColor whiteColor];
     }
 
     if (myCategoryTableView == tableView) {
         
         
         cl = cell;
         cl.textLabel.font = [UIFont boldSystemFontOfSize:18];
         
         NSString * string = [[self array1] objectAtIndex:[indexPath row]];
         _viewImage = [[UIImageView alloc] init];
         
         if ([string isEqual:@"News"]) {
             
             image = [UIImage imageNamed:@"180-stickynote.png"];
             cl.imageView.image = image;
             cl.textLabel.textColor = [UIColor blueColor];
             cl.textLabel.text = string;
         }else if ([string isEqual:@"Sport"]){
             
             image = [UIImage imageNamed:@"169-8ball.png"];
             cl.imageView.image = image;
             
             cl.textLabel.textColor = [UIColor redColor];
             cl.textLabel.text = string;
             
             
         }else if ([string isEqual:@"Entertainment"]){
            
             image = [UIImage imageNamed:@"153-guitar.png"];
             cl.imageView.image = image;
             
             cl.textLabel.textColor = [UIColor yellowColor];
             cl.textLabel.text = string;
         }else if ([string isEqual:@"Technology"]){
             
             image = [UIImage imageNamed:@"176-ipad.png"];
             cl.imageView.image = image;
             
             cl.textLabel.textColor = [UIColor purpleColor];
             cl.textLabel.text = string;
         }else if ([string isEqual:@"Business"]){
             
             image = [UIImage imageNamed:@"190-bank.png"];
             cl.imageView.image = image;
             
             cl.textLabel.textColor = [UIColor greenColor];
             cl.textLabel.text = string;
         }else if ([string isEqual:@"Science"]){
             
             image = [UIImage imageNamed:@"196-radiation.png"];
             cl.imageView.image = image;
             
             cl.textLabel.textColor = [UIColor orangeColor];
             cl.textLabel.text = string;
         }
         
         
         
     } else if (mySubCategoryTableView == tableView){
         
         cl = [self visibleSubCatTableView:tableView cellForRowAtIndexPath:indexPath];
     }
     
     else if (myFeedTableView ==  tableView) {
         
        cl = [self visibleTableView:tableView AtindexPath:indexPath];

     }
 
 return cl;
 }

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSURL * url;
    NSURLRequest * urlRequest ;
    
    if (myCategoryTableView == tableView) {
        
        
        if ([[[self array1] objectAtIndex:[indexPath row]] isEqual:@"News"]) {
            
            [self selectedCellAtMyFirstTableView:indexPath];
            
        }else if ([[[self array1] objectAtIndex:[indexPath row]] isEqual:@"Sport"]){
            
            [self selectedCellAtMyFirstTableView:indexPath];
        }else if ([[[self array1] objectAtIndex:[indexPath row]] isEqual:@"Entertainment"]){
            
            [self selectedCellAtMyFirstTableView:indexPath];
        }else if ([[[self array1] objectAtIndex:[indexPath row]] isEqual:@"Technology"]){
            
            [self selectedCellAtMyFirstTableView:indexPath];
        }else if ([[[self array1] objectAtIndex:[indexPath row]] isEqual:@"Business"]){
            
            [self selectedCellAtMyFirstTableView:indexPath];
        }else if ([[[self array1] objectAtIndex:[indexPath row]] isEqual:@"Science"]){
            
            [self selectedCellAtMyFirstTableView:indexPath];
        }
    }
    else if (mySubCategoryTableView == tableView){
        
        if ([[[self performSelector:@selector(array1)] objectAtIndex:0] isEqual:@"News"]) {
            
            if ([[_subCategory objectAtIndex:[indexPath row]] isEqual:@"CNN News"]) {
                
                url = [NSURL URLWithString:@"http://rss.cnn.com/rss/edition_world.rss"];
                urlRequest = [NSURLRequest requestWithURL:url];
                [self fetchFeeds:urlRequest];
                [self selectedCellAtMySubCatTableView:indexPath withCategoryName:@"News"];
                
            }if ([[_subCategory objectAtIndex:[indexPath row]] isEqual:@"BBC News"]){
                
                url = [NSURL URLWithString:@"http://feeds.bbci.co.uk/news/world/rss.xml"];
                urlRequest = [NSURLRequest requestWithURL:url];
                [self fetchFeeds:urlRequest];
                [self selectedCellAtMySubCatTableView:indexPath withCategoryName:@"News"];
            }else if ([[_subCategory objectAtIndex:[indexPath row]] isEqual:@"Euro News"]){
                
                url = [NSURL URLWithString:@"http://feeds.feedburner.com/euronews/en/news/"];
                urlRequest = [NSURLRequest requestWithURL:url];
                [self fetchFeeds:urlRequest];
                [self selectedCellAtMySubCatTableView:indexPath withCategoryName:@"News"];
            }else if ([[_subCategory objectAtIndex:[indexPath row]] isEqual:@"Sky News"]){
                
                url = [NSURL URLWithString:@"http://news.sky.com/feeds/rss/world.xml"];
                urlRequest = [NSURLRequest requestWithURL:url];
                [self fetchFeeds:urlRequest];
                [self selectedCellAtMySubCatTableView:indexPath withCategoryName:@"News"];
            }
            
            
        }  
        
        if ([[[self performSelector:@selector(array1)] objectAtIndex:1] isEqual:@"Sport"]){
            
            if ([[_subCategory objectAtIndex:[indexPath row]] isEqual:@"CNN Sport"]) {
                
                url = [NSURL URLWithString:@"http://rss.cnn.com/rss/edition_worldsportblog.rss"];
                urlRequest = [NSURLRequest requestWithURL:url];
                [self fetchFeeds:urlRequest];
                [self selectedCellAtMySubCatTableView:indexPath withCategoryName:@"Sport"];
            }else if ([[_subCategory objectAtIndex:[indexPath row]] isEqual:@"Sky Sport"]){
                
                url = [NSURL URLWithString:@"http://www.skysports.com/rss/0,20514,12040,00.xml"];
                urlRequest = [NSURLRequest requestWithURL:url];
                [self fetchFeeds:urlRequest];
                [self selectedCellAtMySubCatTableView:indexPath withCategoryName:@"Sport"];
            }
            
       }  
        
        if ([[[self performSelector:@selector(array1)] objectAtIndex:2] isEqual:@"Entertainment"]){
            
             if ([[_subCategory objectAtIndex:[indexPath row]] isEqual:@"BBC Ent"]) {
                
                 url = [NSURL URLWithString:@"http://feeds.bbci.co.uk/news/entertainment_and_arts/rss.xml"];
                 urlRequest = [NSURLRequest requestWithURL:url];
                 [self fetchFeeds:urlRequest];
                [self selectedCellAtMySubCatTableView:indexPath withCategoryName:@"Entertainment"];
            }else if ([[_subCategory objectAtIndex:[indexPath row]] isEqual:@"Entertainmentwise Ent"]){
                
                url = [NSURL URLWithString:@"http://www.entertainmentwise.com/rss/news.rss"];
                urlRequest = [NSURLRequest requestWithURL:url];
                [self fetchFeeds:urlRequest];
                [self selectedCellAtMySubCatTableView:indexPath withCategoryName:@"Entertainment"];
            }else if ([[_subCategory objectAtIndex:[indexPath row]] isEqual:@"Sky Ent"]){
                
                url = [NSURL URLWithString:@"http://news.sky.com/feeds/rss/entertainment.xml"];
                urlRequest = [NSURLRequest requestWithURL:url];
                [self fetchFeeds:urlRequest];
                [self selectedCellAtMySubCatTableView:indexPath withCategoryName:@"Entertainment"];
            }else if ([[_subCategory objectAtIndex:[indexPath row]] isEqual:@"Heatworld Ent"]){
                
                url = [NSURL URLWithString:@"http://heatworld.feedsportal.com/c/34180/f/619444/index.rss"];
                urlRequest = [NSURLRequest requestWithURL:url];
                [self fetchFeeds:urlRequest];
                [self selectedCellAtMySubCatTableView:indexPath withCategoryName:@"Entertainment"];
            }
            
           
            
        }
        
        if ([[[self performSelector:@selector(array1)] objectAtIndex:3] isEqual:@"Technology"]) {
            
            
            if ([[_subCategory objectAtIndex:[indexPath row]] isEqual:@"BBC Tech"]) {
                
                url = [NSURL URLWithString:@"http://feeds.bbci.co.uk/news/technology/rss.xml"];
                urlRequest = [NSURLRequest requestWithURL:url];
                [self fetchFeeds:urlRequest];
                [self selectedCellAtMySubCatTableView:indexPath withCategoryName:@"Technology"];
            }else if ([[_subCategory objectAtIndex:[indexPath row]] isEqual:@"CNN Tech"]){
                
                url = [NSURL URLWithString:@"http://rss.cnn.com/rss/edition_technology.rss"];
                urlRequest = [NSURLRequest requestWithURL:url];
                [self fetchFeeds:urlRequest];
                [self selectedCellAtMySubCatTableView:indexPath withCategoryName:@"Technology"];
            }else if ([[_subCategory objectAtIndex:[indexPath row]] isEqual:@"CNet Tech"]){
                
                url = [NSURL URLWithString:@"http://feeds.feedburner.com/cnet/tcoc?format=xml"];
                urlRequest = [NSURLRequest requestWithURL:url];
                [self fetchFeeds:urlRequest];
                [self selectedCellAtMySubCatTableView:indexPath withCategoryName:@"Technology"];
            }else if ([[_subCategory objectAtIndex:[indexPath row]] isEqual:@"Techcrunch Tech"]){
                
                url = [NSURL URLWithString:@"http://feeds.feedburner.com/TechCrunch/"];
                urlRequest = [NSURLRequest requestWithURL:url];
                [self fetchFeeds:urlRequest];
                [self selectedCellAtMySubCatTableView:indexPath withCategoryName:@"Technology"];
            }else if ([[_subCategory objectAtIndex:[indexPath row]] isEqual:@"ZDNet Tech"]){
                
                url = [NSURL URLWithString:@"http://www.zdnet.com/blog/cell-phones/rss.xml"];
                urlRequest = [NSURLRequest requestWithURL:url];
                [self fetchFeeds:urlRequest];
                [self selectedCellAtMySubCatTableView:indexPath withCategoryName:@"Technology"];
            }            
            
        }
        
        
        if ([[[self performSelector:@selector(array1)] objectAtIndex:4] isEqual:@"Business"]) {
            
            if ([[_subCategory objectAtIndex:[indexPath row]] isEqual:@"Forbes Business"]) {
                
                url = [NSURL URLWithString:@"http://www.forbes.com/finance/feed/"];
                urlRequest = [NSURLRequest requestWithURL:url];
                [self fetchFeeds:urlRequest];
                [self selectedCellAtMySubCatTableView:indexPath withCategoryName:@"Business"];
            }else if ([[_subCategory objectAtIndex:[indexPath row]] isEqual:@"CNN Business"]){
                
                url = [NSURL URLWithString:@"http://rss.cnn.com/rss/edition_business.rss"];
                urlRequest = [NSURLRequest requestWithURL:url];
                [self fetchFeeds:urlRequest];
                [self selectedCellAtMySubCatTableView:indexPath withCategoryName:@"Business"];
            }else if ([[_subCategory objectAtIndex:[indexPath row]] isEqual:@"BBC Business"]){
                
                url = [NSURL URLWithString:@"http://feeds.bbci.co.uk/news/business/rss.xml"];
                urlRequest = [NSURLRequest requestWithURL:url];
                [self fetchFeeds:urlRequest];
                [self selectedCellAtMySubCatTableView:indexPath withCategoryName:@"Business"];
            }else if ([[_subCategory objectAtIndex:[indexPath row]] isEqual:@"Sky Business"]){
                
                url = [NSURL URLWithString:@"http://news.sky.com/feeds/rss/business.xml"];
                urlRequest = [NSURLRequest requestWithURL:url];
                [self fetchFeeds:urlRequest];
                [self selectedCellAtMySubCatTableView:indexPath withCategoryName:@"Business"];
            }
            
            
        }
        
        if ([[[self performSelector:@selector(array1)] objectAtIndex:5] isEqual:@"Science"]) {
            
            if ([[_subCategory objectAtIndex:[indexPath row]] isEqual:@"Sciencedaily Sci"]) {
                
                url = [NSURL URLWithString:@"http://www.sciencedaily.com/rss/strange_science.xml"];
                urlRequest = [NSURLRequest requestWithURL:url];
                [self fetchFeeds:urlRequest];
                [self selectedCellAtMySubCatTableView:indexPath withCategoryName:@"Science"];
            }else if ([[_subCategory objectAtIndex:[indexPath row]] isEqual:@"Newscientist Sci"]){
                
                url = [NSURL URLWithString:@"http://feeds.newscientist.com/science-news"];
                urlRequest = [NSURLRequest requestWithURL:url];
                [self fetchFeeds:urlRequest];
                [self selectedCellAtMySubCatTableView:indexPath withCategoryName:@"Science"];
            }else if ([[_subCategory objectAtIndex:[indexPath row]] isEqual:@"BBC Sci"]){
                
                url = [NSURL URLWithString:@"http://feeds.bbci.co.uk/news/science_and_environment/rss.xml"];
                urlRequest = [NSURLRequest requestWithURL:url];
                [self fetchFeeds:urlRequest];
                [self selectedCellAtMySubCatTableView:indexPath withCategoryName:@"Science"];
            }else if ([[_subCategory objectAtIndex:[indexPath row]] isEqual:@"NY Times Sci"]){
                
                url = [NSURL URLWithString:@"http://rss.nytimes.com/services/xml/rss/nyt/Science.xml"];
                urlRequest = [NSURLRequest requestWithURL:url];
                [self fetchFeeds:urlRequest];
                [self selectedCellAtMySubCatTableView:indexPath withCategoryName:@"Science"];
            }
        }
        
       
        
    }
    else if (myFeedTableView == tableView) {
        ACPostxml *post = [[_channel items] objectAtIndex:[indexPath row]];
        NSURL *url = [NSURL URLWithString:[post link]];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        ACWebController *webViewController = [[ACWebController alloc] init];
        [[webViewController webView] loadRequest:request];
        
        [[webViewController navigationItem] setTitle:[post title]];
        
        [[self navigationController] pushViewController:webViewController animated:YES];
     

    } 
 
    
}


-(void)selectedCellAtMyFirstTableView:(NSIndexPath *) indexPath{
    [self setSelectedIndexPath:indexPath];
    [[self navigationItem] setTitleView:_currentTitleView];
    self.errorLabel.frame =CGRectZero;
    self.errorLabel = nil;
    
    
    
    
    if (mySubCategoryTableView == nil) {
        
        [UIView animateWithDuration:0.5
                         animations:^(void){
                             myFeedTableView.frame = CGRectZero;
                             myFeedTableView.hidden = YES;
                             myCategoryTableView.frame = CGRectMake(0, 0, (self.view.frame.size.width/4) + 80, self.view.frame.size.height);
                             
                             
                             mySubCategoryTableView = [[CustomSubCatTableView alloc] init];
                             mySubCategoryTableView.frame = CGRectMake((self.view.frame.size.width/4) + 80, 0, (self.view.frame.size.width*3)/4 - 80, self.view.frame.size.height);
                             mySubCategoryTableView.backgroundColor = [UIColor colorWithWhite:0.076 alpha:1.0];
                             mySubCategoryTableView.separatorColor = [UIColor colorWithRed:0.103 green:0.155 blue:0.200 alpha:1.00];
                             mySubCategoryTableView.delegate = self;
                             mySubCategoryTableView.dataSource = self;
                             [[self view] addSubview:mySubCategoryTableView];
                             
                         }
                         completion:^(BOOL finished){
                             
                             self.myFeedTableView = nil;
                             [myFeedTableView removeFromSuperview];
                             [mySubCategoryTableView reloadData];
                         }];
    }else{
        
        NSLog(@"MY SUB CATEGORY IS NOT NIL");
        
        [mySubCategoryTableView reloadData];
    }
    
    if ([[self selectedIndexPath] row] == 0) {
        
        [self arrayNews];
    }else if ([[self selectedIndexPath] row] == 1){
        
        [self arraySport];
    }else if ([[self selectedIndexPath] row] == 2){
        
        [self arrayEntertainment];
    }else if ([[self selectedIndexPath] row] == 3){
        
        [self arrayTechnology];
    }else if ([[self selectedIndexPath] row] == 4){
        
        [self arrayBusiness];
    }else if ([[self selectedIndexPath] row] == 5){
        
        [self arrayScience];
    }




    
    
    
}

-(UITableViewCell *)visibleSubCatTableView:(UITableView *) subTableView cellForRowAtIndexPath:(NSIndexPath *) indexPath{
    static NSString * cellIndetifier = @"Cell";
    
    UITableViewCell * cell = (UITableViewCell *)[subTableView  dequeueReusableCellWithIdentifier:cellIndetifier];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndetifier];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:14];
    }
    
    if ([[self selectedIndexPath] row] == 0) {
        
        NSString *string = [_subCategory objectAtIndex:[indexPath row]];
        cell.textLabel.textColor = [UIColor blueColor];
        cell.textLabel.text = string;
    }else if ([[self selectedIndexPath] row] == 1){
        
        NSString * string = [_subCategory objectAtIndex:[indexPath row]];
        cell.textLabel.textColor = [UIColor redColor];
        cell.textLabel.text = string;
    }else if ([[self selectedIndexPath] row] == 2){
        
        NSString * string = [_subCategory objectAtIndex:[indexPath row]];
        cell.textLabel.textColor = [UIColor yellowColor];
        cell.textLabel.text = string;
    }else if ([[self selectedIndexPath] row] == 3){
        
        NSString * string = [_subCategory objectAtIndex:[indexPath row]];
        cell.textLabel.textColor = [UIColor purpleColor];
        cell.textLabel.text = string;
    }else if ([[self selectedIndexPath] row] == 4){
        
        NSString * string = [_subCategory objectAtIndex:[indexPath row]];
        cell.textLabel.textColor = [UIColor greenColor];
        cell.textLabel.text = string;
    }else if ([[self selectedIndexPath] row] == 5){
        
        NSString * string = [_subCategory objectAtIndex:[indexPath row]];
        cell.textLabel.textColor = [UIColor orangeColor];
        cell.textLabel.text = string;
    }
    
    return cell;
}

-(void)selectedCellAtMySubCatTableView:(NSIndexPath *) indexPath withCategoryName:(NSString *) category{
    
    [self setSelectedIndexPath:indexPath];
    NSLog(@"MY SECOND VIEW ");
    _errorLabel.text = @"";
    
    if (myFeedTableView == nil) {
        
        [UIView animateWithDuration:0.5
                         animations:^(void){
                             
                             mySubCategoryTableView.frame = CGRectZero;
                             mySubCategoryTableView.hidden = YES;
                             myCategoryTableView.frame = CGRectMake(0, 0, (self.view.frame.size.width/4) + 60, self.view.frame.size.height);
                             
                             myFeedTableView = [[CustomTableView0 alloc] init];
                             myFeedTableView.rowHeight = 80;
                             myFeedTableView.frame = CGRectMake((self.view.frame.size.width/4) + 60, 0, ((self.view.frame.size.width * 3)/4) - 60, self.view.frame.size.height);
                             myFeedTableView.backgroundColor = [UIColor colorWithWhite:0.076 alpha:1.0];
                             myFeedTableView.separatorColor = [UIColor colorWithRed:0.103 green:0.155 blue:0.200 alpha:1.00];
                            
                             myFeedTableView.delegate = self;
                             myFeedTableView.dataSource = self;
                             
                             [[self view] addSubview:myFeedTableView];
                             
   
                             
                         }
                         completion:^(BOOL finished){
                             
                             self.mySubCategoryTableView = nil;
                             [mySubCategoryTableView removeFromSuperview];
                             [myFeedTableView reloadData];
                             
                         }];
        
        
    }
    
    
    
    UINib *nib = [UINib nibWithNibName:@"ACCustCell" bundle:nil];
    [myFeedTableView registerNib:nib forCellReuseIdentifier:@"ACCustCell"];
    
}


-(UITableViewCell *)visibleTableView:(UITableView *) tableView AtindexPath:(NSIndexPath *) indexPath{
   
    ACCustomCell *cell = (ACCustomCell *)[tableView dequeueReusableCellWithIdentifier:@"ACCustCell"];
    
    
    if (!cell) {
        
       NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"ACCustCell" owner:nil options:nil];
        
        for (id obj in nibArray){
            
            if ([obj isMemberOfClass:[ACCustomCell class]]) {
                
                cell = (ACCustomCell * ) obj;
                break;
                
            }
            
            
        } 
    
        
    }

    
    // Configure the cell...
    [cell.shortStory.scrollView setScrollEnabled:NO];
    cell.shortStory.scrollView.showsHorizontalScrollIndicator = NO;
    cell.shortStory.scrollView.showsVerticalScrollIndicator = NO;
    
    
    ACPostxml *post = [[_channel items] objectAtIndex:[indexPath row]];
    
 /*   NSMutableString *postHeaderContent = [[NSMutableString alloc] init];
    [postHeaderContent appendFormat:@"<html><body>"];
    [postHeaderContent appendFormat:@"<head><style>body{background-color:#141212;  color:#fff; margin:0px; padding:5px 10px 5px 10px; } div.title{font-weight:bold; font-size:12px} .meta{font-size:15px;} .meta .subtitle{font-size:bold; } </style><head>"];
    [postHeaderContent appendFormat:@"<div class='title'>%@</div>", [post shortStory]];
    [postHeaderContent appendFormat:@"</body></html>"];   */
    
    
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateStyle:NSDateFormatterMediumStyle];
    [dateformatter setTimeStyle:NSDateFormatterNoStyle];
    
   
    
    if ([[self performSelector:@selector(array1)] objectAtIndex:[[self selectedIndexPath] row]]) {
  
        
       // [cell.shortStory loadHTMLString:postHeaderContent baseURL:nil];
        cell.headLine.text = [post title];
      //  cell.dateLabel.text = [dateformatter stringFromDate:[post publicationDate]];
        
     }    
    return cell;
}


-(void)setBarButtonImage:(UIImage *)barButtonImage{
    
    CGSize originalIMageSize = [barButtonImage size];
    
    CGRect newRect = CGRectMake(0, 0, 80, 41);
    
    float ratio = MAX(newRect.size.width/ originalIMageSize.width,
                      newRect.size.height/originalIMageSize.height);
    
    UIGraphicsBeginImageContextWithOptions(newRect.size, NO, 0);
    
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:newRect
                                                     cornerRadius:5.0];
    [path addClip];
    
    
    CGRect projectRect;
    
    projectRect.size.width = ratio * originalIMageSize.width;
    projectRect.size.height = ratio * originalIMageSize.height;
    projectRect.origin.x = (newRect.size.width - projectRect.size.width) / 2.0;
    projectRect.origin.y = (newRect.size.height - projectRect.size.height) / 2.0;
    
    [barButtonImage drawInRect:projectRect];
    
    _barButtonImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
}















@end
