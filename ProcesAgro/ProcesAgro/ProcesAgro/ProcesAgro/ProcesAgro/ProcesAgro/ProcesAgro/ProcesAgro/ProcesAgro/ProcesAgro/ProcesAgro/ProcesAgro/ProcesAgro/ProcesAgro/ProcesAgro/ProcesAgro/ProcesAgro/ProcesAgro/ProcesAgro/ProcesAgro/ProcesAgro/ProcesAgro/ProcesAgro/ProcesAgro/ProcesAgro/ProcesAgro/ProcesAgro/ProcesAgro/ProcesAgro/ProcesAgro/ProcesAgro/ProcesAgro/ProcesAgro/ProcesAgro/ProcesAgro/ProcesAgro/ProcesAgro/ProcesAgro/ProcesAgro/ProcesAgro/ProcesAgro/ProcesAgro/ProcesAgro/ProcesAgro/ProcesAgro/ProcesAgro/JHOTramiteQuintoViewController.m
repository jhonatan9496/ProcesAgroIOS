//
//  JHOTramiteQuintoViewController.m
//  ProcesAgro
//
//  Created by JHONATAN ACELAS AREVALO on 4/08/14.
//  Copyright (c) 2014 jhonatan. All rights reserved.
//

#import "JHOTramiteQuintoViewController.h"
#import "JHOAppDelegate.h"
#import <AVFoundation/AVFoundation.h>
//#import <AVFoundation/AVAudioPlayer.h>
#import <AVFoundation/AVPlayer.h>
//#import <AVFoundation/AVPlayerItem.h>

@interface JHOTramiteQuintoViewController ()

@end

@implementation JHOTramiteQuintoViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)enviarTramite:(id)sender {
       JHOAppDelegate *appDelegate = (JHOAppDelegate *) [[UIApplication sharedApplication]delegate];
    
    NSString *ica = appDelegate.tramiteVector[1];
    NSString *nombre_finca = appDelegate.tramiteVector[2];
    NSString *nombre_propietario = appDelegate.tramiteVector[3];
    NSString *cedula_propietario = appDelegate.tramiteVector[4];
    NSString *telefono_fijo_propuetario = appDelegate.tramiteVector[5];
    NSString *celular_propietario = appDelegate.tramiteVector[6];
 
    
   
    
    NSString *urlArmada = [NSString  stringWithFormat:@"http://localhost/WebService/Tramite.php?ica3101=%@ &nombre_finca=%@&nombre_propietario=%@&cedula_propietario=%@&telefonofijo%@&celular_propietario=%@",ica,nombre_finca,nombre_propietario,cedula_propietario,telefono_fijo_propuetario,celular_propietario];
    
    NSLog(@"%@" ,urlArmada);
    
    
    NSURL *url = [NSURL URLWithString:urlArmada];
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSString *ret = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"ret=%@", ret);
    
   
    // player.numberOfLoops = -1; //Infinite
    //[player play];
    
    
}

- (IBAction)reproducir:(id)sender {
    
    /*
    
    NSURL *soundFileURL = [NSURL fileURLWithPath:@"http://181.41.201.152/conexionapi/audioinicio.mp3"];
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL
                                                                   error:nil];
    
    [player prepareToPlay];
    [player setVolume:3];
    [player setDelegate:nil];
    player.numberOfLoops = 1;
    [player play];
    
    */
   // AVPlayer *playerr = [[AVPlayer playerWithURL:[NSURL  URLWithString:@"http://www.mp3.com/mp3file.mp3"]] retain];
   // [playerr play];
   // NSLog(@"hizo todo");
    
   // NSURL *url = [NSURL URLWithString:@"http://181.41.201.152/conexionapi/audioinicio.mp3"];
    
   // NSData *data = [NSData dataWithContentsOfURL:url];
    
  //  AVAudioPlayer *audioPlayer = [[AVAudioPlayer alloc] initWithData:data error:nil];
    
   // [audioPlayer play];
    
    /*
    NSString * resourcePath = @"http://localhost/WebService/audioinicio.mp3"; //your url
    NSData *_objectData = [NSData dataWithContentsOfURL:[NSURL URLWithString:resourcePath]];
    NSError *error;
    AVAudioPlayer *audioPlayer;
    
    
    audioPlayer = [[AVAudioPlayer alloc] initWithData:_objectData error:&error];
    audioPlayer.numberOfLoops = 1;
    audioPlayer.volume = 1.0f;
    [audioPlayer prepareToPlay];
    
    if (audioPlayer == nil){
        NSLog(@"%@", [error description]);
    }else {
        [audioPlayer play];
        NSLog(@"entro al play");
    }
    NSLog(@"termino");
    */
   
    NSString * resourcePath = @"http://localhost/WebService/audioinicio.mp3"; //your url
    NSData *_objectData = [NSData dataWithContentsOfURL:[NSURL URLWithString:resourcePath]];
    NSError *error;
    AVPlayer *audioPlayer;
    
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    
    NSURL *url2 = [NSURL URLWithString:@"http://localhost/WebService/audioinicio.mp3"];
    
    audioPlayer= [AVPlayer playerWithURL:url2];
    
    
//    audioPlayer.numberOfLoops = 1;
   // audioPlayer.volume = 1.0f;
    //[audioPlayer prepareToPlay];
    
    if (audioPlayer == nil){
        NSLog(@"%@", [error description]);
    }else {
        [audioPlayer play];
        NSLog(@"entro al play");
    }
    NSLog(@"termino");
    
    /*
    AVPlayer *player = [[AVPlayer playerWithURL:[NSURL  URLWithString:@"http://www.mp3.com/mp3file.mp3"]] retain];
    [player play];
    */
    
    /*
    AVPlayerItem *playerItem;
    AVPlayer *player;
    
    
    NSURL *url = [NSURL URLWithString:@"http://localhost/WebService/audioinicio.mp3"];
                  
                  // You may find a test stream at <http://devimages.apple.com/iphone/samples/bipbop/bipbopall.m3u8>.
                  
                  playerItem = [AVPlayerItem playerItemWithURL:url];
                  
                  //(optional) [playerItem addObserver:self forKeyPath:@"status" options:0 context:&ItemStatusContext];
                  
                player = [AVPlayer playerWithPlayerItem:playerItem];
                  
                player = [AVPlayer playerWithURL:url];
                  
                  //(optional)[player addObserver:self forKeyPath:@"status" options:0 context:&PlayerStatusContext];
                  
                  [player play];
     
     */
}
@end
