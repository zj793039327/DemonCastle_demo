//
//  HelpViewController.m
//  DemonCastle
//
//  Created by macbook on 13-6-7.
//
//

#import "HelpViewController.h"
#import <QuartzCore/CoreAnimation.h>
#import "UIView+MDCShineEffect.h"




@interface HelpViewController ()

@end

@implementation HelpViewController

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
    self.view.backgroundColor=[UIColor blackColor];
    //-----------------------------------------------------------------------------------------
    //右键
    UILabel *rightLabel=[[UILabel alloc]initWithFrame:CGRectMake(300, 0, 180, 250)];
    rightLabel.text=@"右区域操作说明:\n单击:向右走一步\n双击:向右跳\n常按:持续向右走\n上划:上跳\n右划:向右攻击\n下划:回旋腿\n左划:后空翻/冲锋";
    rightLabel.numberOfLines=0;
    rightLabel.textAlignment=NSTextAlignmentCenter;
    rightLabel.backgroundColor=[UIColor grayColor];
    [self.view addSubview:rightLabel];
    //-------------------------------------------------------------------------------------------------------
    //左键
    UILabel *leftLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 180, 250)];
    leftLabel.text=@"左区域操作说明:\n单击:向左走一步\n双击:向左跳\n常按:持续向左走\n上划:上跳\n左划:向左攻击\n下划:回旋腿\n右划:后空翻/冲锋";
    leftLabel.numberOfLines=0;
    leftLabel.textAlignment=NSTextAlignmentCenter;
    leftLabel.backgroundColor=[UIColor grayColor];
    [self.view addSubview:leftLabel];
    //-------------------------------------------------------------------------------------------------------
    //中键
    UILabel *middleLabel=[[UILabel alloc]initWithFrame:CGRectMake(180, 0, 120, 250)];
    middleLabel.text=@"中区域操作:\n单击:在记录点可存档\n双击:向上跳";
    middleLabel.numberOfLines=0;
    middleLabel.textAlignment=NSTextAlignmentCenter;
    middleLabel.backgroundColor=[UIColor yellowColor];
    [self.view addSubview:middleLabel];
    //-------------------------------------------------------------------------------------------------------
    //右下键
    UILabel *rightBottomLabel=[[UILabel alloc]initWithFrame:CGRectMake(240, 250, 240, 70)];
    rightBottomLabel.text=@"右下区域操作说明:\n单击:向左蹲,双击:向下跳\n常按:持续蹲,右划:扫荡腿";
    rightBottomLabel.numberOfLines=0;
    rightBottomLabel.textAlignment=NSTextAlignmentCenter;
    rightBottomLabel.backgroundColor=[UIColor redColor];
    [self.view addSubview:rightBottomLabel];
    //-------------------------------------------------------------------------------------------------------
    //左下键
    UILabel *leftBottomLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 250, 240, 70)];
    leftBottomLabel.text=@"左下区域操作说明:\n单击:向右蹲,双击:向下跳\n常按:持续蹲,左划:扫荡腿";
    leftBottomLabel.numberOfLines=0;
    leftBottomLabel.textAlignment=NSTextAlignmentCenter;
    leftBottomLabel.backgroundColor=[UIColor blueColor];
    [self.view addSubview:leftBottomLabel];
    //-------------------------------------------------------------------------------------------------------
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0,0, 960, 320);
    backButton.backgroundColor=[UIColor lightGrayColor];
    backButton.alpha=0.4;
    [backButton addTarget:self action:@selector(removeHelpVC) forControlEvents:UIControlEventTouchUpInside];
    [backButton shineWithRepeatCount:HUGE_VALF duration:8 maskWidth:480.0f maskHeight:320.0f];
    [self.view addSubview:backButton];
}
-(void)removeHelpVC
{
    self.view=nil;
    [self.view removeFromSuperview];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
