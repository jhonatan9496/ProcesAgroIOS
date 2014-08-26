//
//  JHOViewController.m
//  ProcesAgro
//
//  Created by JHONATAN ACELAS AREVALO on 9/07/14.
//  Copyright (c) 2014 jhonatan. All rights reserved.
//

#import "JHOViewController.h"
#import <sqlite3.h>
//importamos appdelegate para acceder a las variables globales
#import "JHOAppDelegate.h"
// frameworks para saber si hay conexion a internet
#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import "JHOurlServicesViewController.h"
@interface JHOViewController (){
    NSMutableArray *convocatoriasPrincipal;
    
}

@end

@implementation JHOViewController

- (void)viewDidLoad
{
    
    
    [super viewDidLoad];
    
    //------------------------------------------------------------------
    // -------------- pedir comvocatorias  ----------------------
    //------------------------------------------------------------------
    /*
    NSURL * url = [NSURL URLWithString:@"http://localhost/WebService/convocatorias.php"];
    NSData * jsonData = [NSData dataWithContentsOfURL:url
                                              options:NSUTF8StringEncoding
                                                error:nil];
    NSError * error;
    NSArray * arreglo= [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
    if (!arreglo) {
        NSLog(@"No sirvio el webService");
        UIAlertView *alerta_convocatorias= [[UIAlertView alloc]init];
        [alerta_convocatorias setTitle:@"Error"];
        [alerta_convocatorias setMessage:@"Fallo en el web service de convocatorias"];
        [alerta_convocatorias addButtonWithTitle:@"Informar"];
        [alerta_convocatorias addButtonWithTitle:@"Cancelar"];
        [alerta_convocatorias show];
        
    }else {
        int i=0;
        while ([arreglo count]>i) {
            NSLog(@"contenido arreglo %@",[arreglo[i] objectForKey:@"descripcion"]);
            i++;
        }
    }
    */
    //------------------------------------------------------------------
    // -------------- FINAL  pedir comvocatorias  ----------------------
    //------------------------------------------------------------------
    
	// Do any additional setup after loading the view, typically from a nib.
    
    
    
    //------------------------------------------------------------------
    // ----------al iniciar carga de la base de datos un vector ---------
    // --------------aleatorio con convocatorias y las muestra  ---------
    //------------------------------------------------------------------
    
     convocatoriasPrincipal = [[NSMutableArray alloc]init];
    
    
    // creamos un objeto del delegado para acceder a las variables
    JHOAppDelegate *appDelegate = (JHOAppDelegate *) [[UIApplication sharedApplication]delegate];
    //bariable db
    sqlite3 *dataBase;
    //variable de sentencia
    sqlite3_stmt *sentencia;
    //abrir la base de datos
    if (sqlite3_open([appDelegate.dataBasePath UTF8String], &dataBase)== SQLITE_OK) {
            // crea la sentencia sql de ingresar los datos a la db
            NSString *sql= [NSString stringWithFormat:@"select * from convocatorias"];
            //se crea la sentencia
            NSLog(@"%@",sql);
            if (sqlite3_prepare_v2(dataBase, [sql UTF8String], -1, &sentencia, NULL)== SQLITE_OK) {
                NSLog(@"inserto una oferta");
                while  (sqlite3_step(sentencia)==SQLITE_ROW) {
                    NSMutableDictionary *dicSelectConsultas= [[NSMutableDictionary alloc] init];
                    NSString *nombreConsulta = [NSString  stringWithUTF8String:( char *)sqlite3_column_text(sentencia, 1)];
                    NSString *descConvoc = [NSString  stringWithUTF8String:( char *)sqlite3_column_text(sentencia, 2)];
                    [dicSelectConsultas  setValue:nombreConsulta forKey:@"nombre"];
                    [dicSelectConsultas setValue:descConvoc forKey:@"descripcion"];
                    [convocatoriasPrincipal addObject:dicSelectConsultas];
                }
            }else {
                NSLog(@"Falla en la creacion del sql: listar convocatorias de la DB ");
            }
            // incrementa el contador del vector
        sqlite3_finalize(sentencia);
    }else {
        NSLog(@"No se puede abrir la DB para ofertas ");
    }
    sqlite3_close(dataBase);
    // codigo a ejecutar si NO hay conexion
    
    //------------------------------------------------------------------
    // ----------FINAL MOSTRAR CONVOCATORIAS  ---------
    //------------------------------------------------------------------
    
    //------------------------------------------------------------------
    // ----------Creamos nuevo hilo y lo lanzamos ---------
    //------------------------------------------------------------------

    
    NSOperationQueue *queue = [NSOperationQueue new];
    NSInvocationOperation *operacion =  [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(mostrarConvocatorias) object:nil];
    [queue addOperation:operacion];
    
  
}


//------------------------------------------------------------------
// ----------Metodo del hilo que cambia cada 5s txt convocatorias---------
//-----------------------------------------------------------------
-(void)mostrarConvocatorias{
    int i=0;
    while ([convocatoriasPrincipal count]>i) {
        NSString *var = [convocatoriasPrincipal[i] objectForKey:@"nombre"];
        NSString *varDes = [convocatoriasPrincipal[i] objectForKey:@"descripcion"];
        // se comunica con el hilo principal y asigna el valor al componente
        [tituloConvocatoria performSelectorOnMainThread:@selector(setText:)  withObject:var  waitUntilDone:YES];
        [descipcionLabelConvocatoria performSelectorOnMainThread:@selector(setText:) withObject:varDes waitUntilDone:YES];
        // duereme el metodo 5s
        sleep(3);
        i++;
        if ([convocatoriasPrincipal count]==i) {
        // en caso de llegar al final del vector vuelve a iniciar
            i=0;
        }
    }
}

//------------------------------------------------------------------
// ---------- FIN Metodo del hilo que cambia cada 5s txt convocatorias---------
//-----------------------------------------------------------------

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//------------------------------------------------------------------
// -------------- Sincronizar Pasos Ofertas   ----------------------
//------------------------------------------------------------------
-(void) sincronizarPasosOfertas{
    // creamos un objeto del delegado para acceder a las variables
    JHOAppDelegate *appDelegate = (JHOAppDelegate *) [[UIApplication sharedApplication]delegate];
    //bariable db
    sqlite3 *dataBase;
    //variable de sentencia
    sqlite3_stmt *sentencia;
    //abrir la base de datos
    if (sqlite3_open([appDelegate.dataBasePath UTF8String], &dataBase)== SQLITE_OK) {
        NSURL * url = [NSURL URLWithString:@"http://localhost/WebService/pasosofertas.php"];
        NSData * jsonData = [NSData dataWithContentsOfURL:url
                                                  options:NSUTF8StringEncoding
                                                    error:nil];
        NSError * error;
        NSArray * arreglo= [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
        NSLog(@"%@",arreglo);
        if (!arreglo) {
            NSLog(@"No sirvio el webService");
            UIAlertView *alerta_convocatorias= [[UIAlertView alloc]init];
            [alerta_convocatorias setTitle:@"Error"];
            [alerta_convocatorias setMessage:@"Fallo en el web service de Ofertas institucionales"];
            [alerta_convocatorias addButtonWithTitle:@"Informar"];
            [alerta_convocatorias addButtonWithTitle:@"Cancelar"];
            [alerta_convocatorias show];
        }else {
            int i=0;
            while ([arreglo count]>i) {
                NSLog(@"contenido arreglo descripcion pasos ofertas :  %@",[arreglo[i] objectForKey:@"titulo_oferta"]);
                // crea la sentencia sql de ingresar los datos a la db
                NSString *sql= [NSString stringWithFormat:@"insert into pasos_ofertas (\"id_paso\", \"titulo_paso\" , \"descripcion_paso\" , \"id_oferta_institucional\") VALUES(\"%i\", \"%@\", \"%@\",\"%@\")",[[arreglo[i] objectForKey:@"id"] integerValue],[arreglo[i] objectForKey:@"tituloPasos"],[arreglo[i] objectForKey:@"descripcionPaso"],[arreglo[i] objectForKey:@"ofertaInstitucional_id"]];
                //se crea la sentencia
                //NSLog(@"%@",sql);
                if (sqlite3_prepare_v2(dataBase, [sql UTF8String], -1, &sentencia, NULL)== SQLITE_OK) {
                    NSLog(@"inserto una oferta");
                    while  (sqlite3_step(sentencia)==SQLITE_OK) {
                        NSLog(@"Insertado");
                    }
                }else {
                    NSLog(@"Falla en la creacion del sql: alimentar base de datos pasos  ofertas institucionaes ");
                }
                // incrementa el contador del vector
                i++;
            }
        }
        
        sqlite3_finalize(sentencia);
    }else {
        NSLog(@"No se puede abrir la DB para ofertas ");
    }
    sqlite3_close(dataBase);
    // codigo a ejecutar si NO hay conexion
    
}
//-----------------------------------------------------------------------
// ------------------- Final Sincronizar pasos Ofertas  -----------------
//-----------------------------------------------------------------------

//------------------------------------------------------------------
// -------------- Sincronizar Ofertas   ----------------------------
//------------------------------------------------------------------
-(void) sincronizarOfertasInstitucionales{
    // creamos un objeto del delegado para acceder a las variables
    JHOAppDelegate *appDelegate = (JHOAppDelegate *) [[UIApplication sharedApplication]delegate];
    //bariable db
    sqlite3 *dataBase;
    //variable de sentencia
    sqlite3_stmt *sentencia;
    //abrir la base de datos
    if (sqlite3_open([appDelegate.dataBasePath UTF8String], &dataBase)== SQLITE_OK) {
        NSURL * url = [NSURL URLWithString:@"http://localhost/WebService/ofertasinstitucionales.php"];
        NSData * jsonData = [NSData dataWithContentsOfURL:url
                                                  options:NSUTF8StringEncoding
                                                    error:nil];
        NSError * error;
        NSArray * arreglo= [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
        NSLog(@"%@",arreglo);
        if (!arreglo) {
            NSLog(@"No sirvio el webService");
            UIAlertView *alerta_convocatorias= [[UIAlertView alloc]init];
            [alerta_convocatorias setTitle:@"Error"];
            [alerta_convocatorias setMessage:@"Fallo en el web service de Ofertas institucionales"];
            [alerta_convocatorias addButtonWithTitle:@"Informar"];
            [alerta_convocatorias addButtonWithTitle:@"Cancelar"];
            [alerta_convocatorias show];
        }else {
            int i=0;
            while ([arreglo count]>i) {
                NSLog(@"contenido arreglo descripcion ofertas :  %@",[arreglo[i] objectForKey:@"titulo_oferta"]);
                // crea la sentencia sql de ingresar los datos a la db
                NSString *sql= [NSString stringWithFormat:@"insert into ofertas_institucionales (\"id_oferta_institucional\", \"titulo_oferta\" , \"descripcion_oferta\" , \"url_audio_oferta\", \"url_oferta\") VALUES(\"%i\", \"%@\", \"%@\",\"%@\",\"%@\")",[[arreglo[i] objectForKey:@"id"] integerValue],[arreglo[i] objectForKey:@"tituloOferta"],[arreglo[i] objectForKey:@"descripcionOferta"],[arreglo[i] objectForKey:@"urlAudioOferta"],[arreglo[i] objectForKey:@"urlOferta"]];
                //se crea la sentencia
                //NSLog(@"%@",sql);
                if (sqlite3_prepare_v2(dataBase, [sql UTF8String], -1, &sentencia, NULL)== SQLITE_OK) {
                    NSLog(@"inserto una oferta");
                    while  (sqlite3_step(sentencia)==SQLITE_OK) {
                        NSLog(@"Insertado");
                    }
                }else {
                    NSLog(@"Falla en la creacion del sql: alimentar base de datos ofertas institucionaes ");
                }
                // incrementa el contador del vector
                i++;
            }
        }
        
        sqlite3_finalize(sentencia);
    }else {
        NSLog(@"No se puede abrir la DB para ofertas ");
    }
    sqlite3_close(dataBase);
    // codigo a ejecutar si NO hay conexion
    
}
//-----------------------------------------------------------------------
// ------------------- Final Sincronizar Ofertas  ----------------------
//-----------------------------------------------------------------------

//------------------------------------------------------------------
// -------------- Sincronizar Oficinas  ------  --------------------
//------------------------------------------------------------------
-(void) sincronizarOficinas{
    // creamos un objeto del delegado para acceder a las variables
    JHOAppDelegate *appDelegate = (JHOAppDelegate *) [[UIApplication sharedApplication]delegate];
    //bariable db
    sqlite3 *dataBase;
    //variable de sentencia
    sqlite3_stmt *sentencia;
    //abrir la base de datos
    if (sqlite3_open([appDelegate.dataBasePath UTF8String], &dataBase)== SQLITE_OK) {
        NSURL * url = [NSURL URLWithString:@"http://localhost/WebService/oficinas.php"];
        NSData * jsonData = [NSData dataWithContentsOfURL:url
                                                  options:NSUTF8StringEncoding
                                                    error:nil];
        NSError * error;
        NSArray * arreglo= [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
        NSLog(@"%@",arreglo);
        if (!arreglo) {
            NSLog(@"No sirvio el webService");
            UIAlertView *alerta_convocatorias= [[UIAlertView alloc]init];
            [alerta_convocatorias setTitle:@"Error"];
            [alerta_convocatorias setMessage:@"Fallo en el web service de Servicios"];
            [alerta_convocatorias addButtonWithTitle:@"Informar"];
            [alerta_convocatorias addButtonWithTitle:@"Cancelar"];
            [alerta_convocatorias show];
        }else {
            int i=0;
            while ([arreglo count]>i) {
                NSLog(@"contenido arreglo descripcion oficinas :  %@",[arreglo[i] objectForKey:@"descripcion"]);
                // crea la sentencia sql de ingresar los datos a la db
                NSString *sql= [NSString stringWithFormat:@"insert into oficinas (\"id_oficina\", \"nombre_oficina\" , \"direccion_oficina\" , \"descripcion_oficina\", \"municipio_oficina\") VALUES(\"%i\", \"%@\", \"%@\",\"%@\",\"%@\")",[[arreglo[i] objectForKey:@"id"] integerValue],[arreglo[i] objectForKey:@"nombreOficina"],[arreglo[i] objectForKey:@"direccionOficina"],[arreglo[i] objectForKey:@"descripcionOficina"],[arreglo[i] objectForKey:@"lugar_id"]];
                //se crea la sentencia
                //NSLog(@"%@",sql);
                if (sqlite3_prepare_v2(dataBase, [sql UTF8String], -1, &sentencia, NULL)== SQLITE_OK) {
                    NSLog(@"inserto una Oficina ");
                    while  (sqlite3_step(sentencia)==SQLITE_OK) {
                        NSLog(@"Insertado");
                    }
                }else {
                    NSLog(@"Falla en la creacion del sql: alimentar base de datos Oficinas");
                }
                // incrementa el contador del vector
                i++;
            }
        }
        
        sqlite3_finalize(sentencia);
    }else {
        NSLog(@"No se puede abrir la DB Oficinas ");
    }
    sqlite3_close(dataBase);
    // codigo a ejecutar si NO hay conexion
    
}
//-----------------------------------------------------------------------
// ------------------- Final Sincronizar Oficinas  ----------------------
//-----------------------------------------------------------------------

//------------------------------------------------------------------
// ------------------- Sincronizar Servicios ------------------------
//------------------------------------------------------------------
-(void) sincronizarServicios{
    // creamos un objeto del delegado para acceder a las variables
    JHOAppDelegate *appDelegate = (JHOAppDelegate *) [[UIApplication sharedApplication]delegate];
    //bariable db
    sqlite3 *dataBase;
    //variable de sentencia
    sqlite3_stmt *sentencia;
    //abrir la base de datos
    if (sqlite3_open([appDelegate.dataBasePath UTF8String], &dataBase)== SQLITE_OK) {
        NSURL * url = [NSURL URLWithString:@"http://localhost/WebService/servicios.php"];
        NSData * jsonData = [NSData dataWithContentsOfURL:url
                                                  options:NSUTF8StringEncoding
                                                    error:nil];
        NSError * error;
        NSArray * arreglo= [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
        //NSLog(@"%@",arre)
        if (!arreglo) {
            NSLog(@"No sirvio el webService");
            UIAlertView *alerta_convocatorias= [[UIAlertView alloc]init];
            [alerta_convocatorias setTitle:@"Error"];
            [alerta_convocatorias setMessage:@"Fallo en el web service de Servicios"];
            [alerta_convocatorias addButtonWithTitle:@"Informar"];
            [alerta_convocatorias addButtonWithTitle:@"Cancelar"];
            [alerta_convocatorias show];
        }else {
            int i=0;
            while ([arreglo count]>i) {
                NSLog(@"contenido arreglo descripcion servicios :  %@",[arreglo[i] objectForKey:@"descripcion"]);
        // crea la sentencia sql de ingresar los datos a la db
        NSString *sql= [NSString stringWithFormat:@"insert into servicios (\"id_servicio\", \"titulo_servicio\" , \"descripcion_servicio\" , \"url_audio_servicio\", \"url_servicio\") VALUES(\"%i\", \"%@\", \"%@\",\"%@\",\"%@\")",[[arreglo[i] objectForKey:@"id"] integerValue],[arreglo[i] objectForKey:@"tituloServicio"],[arreglo[i] objectForKey:@"descripcionServicio"],[arreglo[i] objectForKey:@"urlAudioServicio"],[arreglo[i] objectForKey:@"urlServicio"]];
        //se crea la sentencia
        //NSLog(@"%@",sql);
        if (sqlite3_prepare_v2(dataBase, [sql UTF8String], -1, &sentencia, NULL)== SQLITE_OK) {
            NSLog(@"inserto un servicio");
            while  (sqlite3_step(sentencia)==SQLITE_OK) {
                NSLog(@"Insertado");
            }
        }else {
            NSLog(@"Falla en la creacion del sql: alimentar base de datos de servicios ");
        }
                // incrementa el contador del vector
                i++;
            }
        }
        
        sqlite3_finalize(sentencia);
    }else {
        NSLog(@"No se puede abrir la DB de servicios ");
    }
    sqlite3_close(dataBase);
    // codigo a ejecutar si NO hay conexion
    
}
//-----------------------------------------------------------------------
// ------------------- Final Sincronizar Servicios ----------------------
//-----------------------------------------------------------------------

//-----------------------------------------------------------------------
// ------------------- Sincronizar Convocatorias ------------------------
//-----------------------------------------------------------------------
-(void) sincronizarConvocatorias{
    // creamos un objeto del delegado para acceder a las variables
    JHOAppDelegate *appDelegate = (JHOAppDelegate *) [[UIApplication sharedApplication]delegate];
    //bariable db
    sqlite3 *dataBase;
    //variable de sentencia
    sqlite3_stmt *sentencia;
    //abrir la base de datos
    if (sqlite3_open([appDelegate.dataBasePath UTF8String], &dataBase)== SQLITE_OK) {
        NSURL * url = [NSURL URLWithString:@"http://localhost/WebService/convocatorias.php"];
        NSData * jsonData = [NSData dataWithContentsOfURL:url
                                                  options:NSUTF8StringEncoding
                                                    error:nil];
        NSError * error;
        NSArray * arreglo= [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
        //NSLog(@"%@",arre)
        if (!arreglo) {
            NSLog(@"No sirvio el webService");
            UIAlertView *alerta_convocatorias= [[UIAlertView alloc]init];
            [alerta_convocatorias setTitle:@"Error"];
            [alerta_convocatorias setMessage:@"Fallo en el web service de Convocatorias"];
            [alerta_convocatorias addButtonWithTitle:@"Informar"];
            [alerta_convocatorias addButtonWithTitle:@"Cancelar"];
            [alerta_convocatorias show];
        }else {
            int i=0;
            while ([arreglo count]>i) {
                NSLog(@"contenido arreglo %@",[arreglo[i] objectForKey:@"descripcion"]);
                // crea la sentencia sql de ingresar los datos a la db
                NSString *sql= [NSString stringWithFormat:@"insert into convocatorias (\"id_convocatoria\", \"titulo_convocatoria\" , \"descripcion_convocatoria\" , \"descripcion_larga_convocatoria\", \"url_convocatoria\") VALUES(\"%i\", \"%@\", \"%@\",\"%@\",\"%@\")",[[arreglo[i] objectForKey:@"id"] integerValue],[arreglo[i] objectForKey:@"titulo_convocatoria"],[arreglo[i] objectForKey:@"descripcion"],[arreglo[i] objectForKey:@"descripcionLarga"],[arreglo[i] objectForKey:@"urlConvocatoria"]];
                //se crea la sentencia
                NSLog(@"%@",sql);
                if (sqlite3_prepare_v2(dataBase, [sql UTF8String], -1, &sentencia, NULL)== SQLITE_OK) {
                    NSLog(@"inserto un convocatoria");
                    while  (sqlite3_step(sentencia)==SQLITE_OK) {
                        NSLog(@"Insertado");
                    }
                }else {
                    NSLog(@"Falla en la creacion del sql: alimentar base de datos de convocatoria");
                }
                // incrementa el contador del vector
                i++;
            }
        }
        
        sqlite3_finalize(sentencia);
    }else {
        NSLog(@"No se puede abrir la DB en convocatoria ");
    }
    sqlite3_close(dataBase);
}
//-----------------------------------------------------------------------
// ------------------- Final Sincronizar Convocatorias ------------------
//-----------------------------------------------------------------------

//-----------------------------------------------------------------------
// ------------------- Evento esconder teclado  buscar General-----------
//-----------------------------------------------------------------------
- (IBAction)buscarGeneralText:(id)sender {
     [sender resignFirstResponder];
    
}
//-----------------------------------------------------------------------
// ------------------- Evento boton Actualizar   ------------------------
//-----------------------------------------------------------------------
- (IBAction)actualizarDB:(id)sender {
    
    //------- Verificamos Conexion a Internet --------------
    
    #define SITIO_WEB "www.google.com"
    SCNetworkReachabilityRef referencia = SCNetworkReachabilityCreateWithName (kCFAllocatorDefault, SITIO_WEB);
    SCNetworkReachabilityFlags resultado;
    SCNetworkReachabilityGetFlags ( referencia, &resultado );
    CFRelease(referencia);
    // codigo a ejecutar si hay conexion
    if (resultado & kSCNetworkReachabilityFlagsReachable) {
        NSLog(@"SI HAY CONEXION");
        [self sincronizarServicios];
        [self sincronizarConvocatorias];
        [self sincronizarOficinas];
        [self sincronizarOfertasInstitucionales];
        [self sincronizarPasosOfertas];
   
  
    // codigo a ejecutar si NO hay conexion

}else {
        NSLog(@"NO HAY CONEXION");
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Alerta Conexion a Internet " message:@"No está conectado a internet. \n Verifique que tiene conexion a internet para actualizar la informacion" delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles:nil]; [message show];
    }
    
}
//-----------------------------------------------------------------------
// ------------------- Fin Evento boton Actualizar   --------------------
//-----------------------------------------------------------------------


- (IBAction)BuscarPrincipal:(id)sender {
    NSLog(@"putada multiple");
}

- (IBAction)servicio1:(id)sender {
    // Cargar ViewController desde Codigo
    UIStoryboard *story= [UIApplication sharedApplication].delegate.window.rootViewController.storyboard;
    JHOurlServicesViewController *serv =[story instantiateViewControllerWithIdentifier:@"servicios"];
    
    serv.modalTransitionStyle= UIModalTransitionStyleCrossDissolve;
    [self presentViewController:serv animated:YES completion:nil];
    // Asignar la url al
    NSURL *url = [NSURL URLWithString:@"http://www.ica.gov.co/Tramites/Formas-para-los-tramites.aspx"];
    NSURLRequest *loadUrl = [[NSURLRequest alloc]initWithURL:url];
    [serv.urlServicioWeb loadRequest:loadUrl];

}

- (IBAction)servicio2:(id)sender {
    // Cargar ViewController desde Codigo
    UIStoryboard *story= [UIApplication sharedApplication].delegate.window.rootViewController.storyboard;
    JHOurlServicesViewController *serv =[story instantiateViewControllerWithIdentifier:@"servicios"];
    
    serv.modalTransitionStyle= UIModalTransitionStyleCrossDissolve;
    [self presentViewController:serv animated:YES completion:nil];
    // Asignar la url al
    NSURL *url = [NSURL URLWithString:@"http://www.moviles.gobiernoenlinea.gov.co/"];
    NSURLRequest *loadUrl = [[NSURLRequest alloc]initWithURL:url];
    [serv.urlServicioWeb loadRequest:loadUrl];

}

- (IBAction)servicio3:(id)sender {
    // Cargar ViewController desde Codigo
    UIStoryboard *story= [UIApplication sharedApplication].delegate.window.rootViewController.storyboard;
    JHOurlServicesViewController *serv =[story instantiateViewControllerWithIdentifier:@"servicios"];
    
    serv.modalTransitionStyle= UIModalTransitionStyleCrossDissolve;
    [self presentViewController:serv animated:YES completion:nil];
    // Asignar la url al
    NSURL *url = [NSURL URLWithString:@"http://www.siembra.gov.co/"];
    NSURLRequest *loadUrl = [[NSURLRequest alloc]initWithURL:url];
    [serv.urlServicioWeb loadRequest:loadUrl];

}
//-----------------------------------------------------------------------
// ------------------- Evento cargar url enviando    --------------------
//-----------------------------------------------------------------------
- (IBAction)servicio4:(id)sender {
    // Cargar ViewController desde Codigo
    UIStoryboard *story= [UIApplication sharedApplication].delegate.window.rootViewController.storyboard;
    JHOurlServicesViewController *serv =[story instantiateViewControllerWithIdentifier:@"servicios"];
    
    serv.modalTransitionStyle= UIModalTransitionStyleCrossDissolve;
    [self presentViewController:serv animated:YES completion:nil];
    // Asignar la url al 
    NSURL *url = [NSURL URLWithString:@"http://www.corpoica.org.co/"];
    NSURLRequest *loadUrl = [[NSURLRequest alloc]initWithURL:url];
    [serv.urlServicioWeb loadRequest:loadUrl];
    
    
}
@end


