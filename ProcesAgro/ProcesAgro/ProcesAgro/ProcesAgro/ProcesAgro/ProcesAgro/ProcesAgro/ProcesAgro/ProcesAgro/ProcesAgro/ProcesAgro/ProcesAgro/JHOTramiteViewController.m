//
//  JHOTramiteViewController.m
//  ProcesAgro
//
//  Created by JHONATAN ACELAS AREVALO on 23/07/14.
//  Copyright (c) 2014 jhonatan. All rights reserved.
//
#import "JHOTramiteViewController.h"
// importamos el appdelegate para acceder al vector donde vamos a guardar variables del tramite
#import "JHOAppDelegate.h"

@interface JHOTramiteViewController ()

@end

@implementation JHOTramiteViewController

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
    
    // Escucha cunado el teclado se abre
   // [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(muestraTeclado:) name:UIKeyboardWillShowNotification object:nil];
    // Escucha cunado el teclado de esconde
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(escondeTeclado:) name:UIKeyboardWillHideNotification object:nil];

    
    NSURL *url = [NSURL URLWithString:@"http://localhost/WebService/Tramite.php?tipo_lugar=Ciudad&nombre_lugar=Sogamoso&id_lugar=6"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSString *ret = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"ret=%@", ret);
    
    
    //NSString *url =[NSString stringWithFormat:@"http://localhost/WebService/Tramite.php?tipo_lugar=\"Ciudad\"&nombre_lugar=\"pereira\"&id_lugar=\"4\" "];
    //NSLog(@"%@",url);
    //NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    //[req setHTTPMethod:@"GET"];
    
    
    // This might be redundant, I'm pretty sure GET is the default value
    //NSURLConnection *connection = [[[NSURLConnection alloc] initWithRequest:req delegate:self]autorelease];
    // [connection start];
    // Do any additional setup after loading the view.
}

//----------------------------------------------------------
//           Pone el frame siempre en orientacion y 0
//----------------------------------------------------------
-(void) escondeTeclado:(NSNotification *)notification{
    
    NSDictionary *info = [notification userInfo];
    
    NSTimeInterval duracionAnimacion;
    UIViewAnimationCurve animationCurve;
    CGRect keyboardFrame;
    
    [[info objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
    [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&duracionAnimacion];
    [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] getValue:&keyboardFrame];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:duracionAnimacion];
    [UIView setAnimationCurve:animationCurve];
    [self.view setFrame:CGRectMake(self.view.frame.origin.x,0, self.view.frame.size.width, self.view.frame.size.height)];
    [UIView commitAnimations];
    
}
//----------------------------------------------------------
//           Pone el frame siempre en orientacion y 0- alto teclado
//----------------------------------------------------------
-(void) muestraTeclado:(NSNotification *)notification{
    
    NSDictionary *info = [notification userInfo];
    
    NSTimeInterval duracionAnimacion;
    UIViewAnimationCurve animationCurve;
    CGRect keyboardFrame;
    
    [[info objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
    [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&duracionAnimacion];
    [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] getValue:&keyboardFrame];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:duracionAnimacion];
    [UIView setAnimationCurve:animationCurve];
   
    [self.view setFrame:CGRectMake(self.view.frame.origin.x, 0-keyboardFrame.size.height, self.view.frame.size.width, self.view.frame.size.height)];
    [UIView commitAnimations];
    
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


//-----------------------------------------------------------
//                Eventos Campo Telefono Fijo
//-----------------------------------------------------------
- (IBAction)textDownMove:(id)sender {
    // acciona el evento de correr el frame solo cuando el teclado Tapa los componentes
       [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(muestraTeclado:) name:UIKeyboardWillShowNotification object:nil];
    
}
//guarda teclado corre frame
-(IBAction)guardarTecladoFijo:(id)sender{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(escondeTeclado:) name:UIKeyboardWillHideNotification object:nil];
    [sender resignFirstResponder];
}

//-----------------------------------------------------------
//                Eventos Campo Celular
//-----------------------------------------------------------

- (IBAction)subeTecladoCelular:(id)sender {
    // acciona el evento de correr el frame solo cuando el teclado Tapa los componentes
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(muestraTeclado:) name:UIKeyboardWillShowNotification object:nil];
}
-(IBAction)ReturnKeyButton:(id)sender{    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(escondeTeclado:) name:UIKeyboardWillHideNotification object:nil];
    [sender resignFirstResponder];
}
//-----------------------------------------------------------
//                Eventos campo Cedula
//-----------------------------------------------------------
- (IBAction)returnKeyCedula:(id)sender {
    [sender resignFirstResponder];
}
//-----------------------------------------------------------
//                Eventos campo NombrePro
//-----------------------------------------------------------
- (IBAction)returnkKeyPropietario:(id)sender {
    [sender resignFirstResponder];
}
//-----------------------------------------------------------
//                Eventos campo FincaName
//-----------------------------------------------------------
- (IBAction)fincaReturnKey:(id)sender {
     [sender resignFirstResponder];
}
//-----------------------------------------------------------
//                Eventos campo Ica
//-----------------------------------------------------------
- (IBAction)icaKey:(id)sender {
     [sender resignFirstResponder];
}
- (IBAction)icaSubeTeclado:(id)sender {
    [self.view setFrame:CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height)];
}
//-----------------------------------------------------------
//                Eventos Guardar datos en vector 
//-----------------------------------------------------------
- (IBAction)avanzarTramite1:(id)sender {
    // creamos un objeto del delegado para acceder a las variables
    JHOAppDelegate *appDelegate = (JHOAppDelegate *) [[UIApplication sharedApplication]delegate];
    appDelegate.tramiteVector = [NSMutableArray arrayWithObjects:@"cero",nil];
    
    // Agregamos la informacion de la vista3 al vector
    [appDelegate.tramiteVector addObject:ica_numero.text];
    [appDelegate.tramiteVector addObject:nombre_finca.text];
    [appDelegate.tramiteVector addObject:nombre_propietario.text];
    [appDelegate.tramiteVector addObject:cedula_propietario.text];
    [appDelegate.tramiteVector addObject:telefono_fijo_propietario.text];
    [appDelegate.tramiteVector addObject:celular_propietario.text];
}
@end
