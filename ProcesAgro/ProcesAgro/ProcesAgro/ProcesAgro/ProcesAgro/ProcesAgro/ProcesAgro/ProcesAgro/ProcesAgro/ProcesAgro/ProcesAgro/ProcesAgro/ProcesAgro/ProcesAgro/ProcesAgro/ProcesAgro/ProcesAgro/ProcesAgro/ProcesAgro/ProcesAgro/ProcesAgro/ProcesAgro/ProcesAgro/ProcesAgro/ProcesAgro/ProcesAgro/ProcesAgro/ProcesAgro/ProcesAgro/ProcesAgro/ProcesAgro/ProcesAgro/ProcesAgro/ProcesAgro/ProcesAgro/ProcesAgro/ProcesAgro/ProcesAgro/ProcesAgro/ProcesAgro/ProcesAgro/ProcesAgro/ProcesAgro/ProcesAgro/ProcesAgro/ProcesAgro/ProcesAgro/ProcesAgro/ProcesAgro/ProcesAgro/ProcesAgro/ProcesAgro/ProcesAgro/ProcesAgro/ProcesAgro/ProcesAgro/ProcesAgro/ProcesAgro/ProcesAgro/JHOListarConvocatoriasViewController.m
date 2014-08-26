//
//  JHOListarConvocatoriasViewController.m
//  ProcesAgro
//
//  Created by JHONATAN ACELAS AREVALO on 7/08/14.
//  Copyright (c) 2014 jhonatan. All rights reserved.
//
#import "JHOListarConvocatoriasViewController.h"
#import "JHOAppDelegate.h"
#import <sqlite3.h>
#import "JHOCadaConvocatoriaViewController.h"

@interface JHOListarConvocatoriasViewController (){
    NSMutableArray *vectorConvocatorias;
}

@end

@implementation JHOListarConvocatoriasViewController

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
    vectorConvocatorias = [[NSMutableArray alloc]init];
    [self cargarConvocatorias];
    [self.tableView reloadData];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//------------------------------------------------------------------
//-----------------Cargar Convocatorias de la DB -----------------
//------------------------------------------------------------------
- (void) cargarConvocatorias{
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
                [vectorConvocatorias addObject:dicSelectConsultas];
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
}
//------------------------------------------------------------------
//-----------------Numero de secciones en la table -----------------
//------------------------------------------------------------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}
//------------------------------------------------------------------
//-----------------Numero de celdas    en la table -----------------
//------------------------------------------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [vectorConvocatorias count];
}
//------------------------------------------------------------------
//-----------------Crea cada celda y le asigna un contenido --------
//------------------------------------------------------------------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Celidentifield=@"Cell";
    // extraemos la posicion del arreglo segun la posicion del numero de la celda
    NSDictionary *dic = [vectorConvocatorias objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Celidentifield];
    
    if (cell==nil) {
      //  cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Celidentifield];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:Celidentifield];

    }
    
    cell.textLabel.text = [dic objectForKey:@"nombre"];
    cell.detailTextLabel.text = [dic objectForKey:@"descripcion"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    // Configure the cell...
    
    return cell;
}
//------------------------------------------------------------------
//-----------------Numero de pixeles de las celdas -----------------
//------------------------------------------------------------------
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
//------------------------------------------------------------------
//-----------------Evento al hacer click en cada celda--------------
//------------------------------------------------------------------
-(void) tableView: (UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *datosConvocatoria =[vectorConvocatorias objectAtIndex:indexPath.row];
    JHOCadaConvocatoriaViewController  *cadaConvocatoria = [self.storyboard instantiateViewControllerWithIdentifier:@"JHOCadaConvocatoriaViewController"];
    [self.navigationController pushViewController:cadaConvocatoria animated:YES];
    cadaConvocatoria.textTituloConvocatoria =[datosConvocatoria objectForKey:@"nombre"];
    cadaConvocatoria.textDeescripcionConvocatoria = [datosConvocatoria objectForKey:@"descripcion"];
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

@end
