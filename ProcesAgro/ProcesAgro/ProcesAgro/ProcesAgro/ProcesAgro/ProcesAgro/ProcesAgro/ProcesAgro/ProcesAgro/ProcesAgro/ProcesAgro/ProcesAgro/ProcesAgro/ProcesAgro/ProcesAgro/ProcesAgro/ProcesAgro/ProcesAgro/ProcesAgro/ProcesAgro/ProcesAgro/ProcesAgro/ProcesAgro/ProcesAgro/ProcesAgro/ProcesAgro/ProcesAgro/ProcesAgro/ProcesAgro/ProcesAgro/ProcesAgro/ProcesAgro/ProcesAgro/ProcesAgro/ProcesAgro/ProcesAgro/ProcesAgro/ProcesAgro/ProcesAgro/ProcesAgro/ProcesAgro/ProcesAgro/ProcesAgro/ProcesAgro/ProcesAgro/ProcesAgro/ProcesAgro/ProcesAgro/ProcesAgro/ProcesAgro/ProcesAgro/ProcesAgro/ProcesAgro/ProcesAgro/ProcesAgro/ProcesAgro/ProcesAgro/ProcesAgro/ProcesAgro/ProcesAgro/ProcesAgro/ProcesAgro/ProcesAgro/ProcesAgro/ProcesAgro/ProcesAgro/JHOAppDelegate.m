//
//  JHOAppDelegate.m
//  ProcesAgro
//
//  Created by JHONATAN ACELAS AREVALO on 9/07/14.
//  Copyright (c) 2014 jhonatan. All rights reserved.
//

#import "JHOAppDelegate.h"

@implementation JHOAppDelegate{
    NSString *dataBaseName;
    NSString *dataBasePath;
    NSMutableArray *tramiteVector ;
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    // lo que se ejecuta despues de haber cargado la aplicaicon
    
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString * documentsDirectiory = [paths objectAtIndex:0];
    
    self.dataBasePath =[documentsDirectiory stringByAppendingPathComponent:@"ProcesAgroDB.sqlite"];
    
    //NSLog(@"aaa %@",self.dataBasePath);
    //llamada al metodo cargar base de datos  
    [self cargarDB];
    tramiteVector = [NSMutableArray arrayWithObjects:@"cero",nil];
    //NSMutableArray *tramite = [NSMutableArray arrayWithObjects:@"cero",nil];
    
    
    return YES;
}

- (void) cargarDB{
    
    BOOL exito;
    // adquirimos el path del telefono para buscar la base de datos
    NSFileManager *filemanager= [ NSFileManager defaultManager];
    NSError *error;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectiory = [paths objectAtIndex:0];
    //directorio donde ecribir nuestra db
    NSString *writableDBpath =[documentsDirectiory stringByAppendingPathComponent:@"ProcesAgroDB.sqlite"];
    
    exito = [filemanager fileExistsAtPath:writableDBpath] ;
    
    // si si existe la base de datos en el directorio del telefono se sale del metdo
    if (exito) return;
    NSLog(@"no existe la db");
    // si sigue el metodo obtenemos el path de la db de la aplicaicon y la copiamos al path del telefono
    NSString  * defaultDBpath= [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"ProcesAgroDB.sqlite"];
    
    exito = [filemanager copyItemAtPath:defaultDBpath toPath:writableDBpath error:&error];
    if (!exito) {
        NSLog(@"error en el path de la db %@", [error localizedDescription]);
    }else {
    
        NSLog(@"creo por primera vez la db");
        //imprimir la ruta del xcode del la db simulador
        //NSLog(@"%@",writableDBpath);
    }
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
