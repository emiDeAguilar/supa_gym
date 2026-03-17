# supa_routines

## Descripcion:  
Aplicación con Firebase y Flutter para dar seguimiento y control de rutinas de gimnasio, permite registar progreso diario y marcar repeticiones de series.


**Requisitios:**

* Conectarse correctamente a una instancia de Firebase, investigando y configurando los servicios necesarios (como autenticación, almacenamiento o base de datos, según corresponda).


* Recuperar rutinas y progreso desde Firebase y mostrarlas en listas o similares.

***

Módulos:
* Autenticación
* Almacenamiento (firestone)

Investigación:
* Conexión exitosa a Firebase
* Seguridad en almacenamiento de noSQL

Acciones:
* Crear y recuperar rutinas desde firebase

Screens:   
* Login   
  * Home (mostrar rutina de hoy)  
    * Notas de entrenamiento por rutina (submenu)  
  * Mis rutinas
  * Profile
  * Analytics (Premium feature)

#

###  Home - Widgets
* todays date 
* Start button big.   
* Edit routine button small in right  
* to do list style todays routine.
    * for each element. from left to right:  
            * Checkbox toggle  
            * Exercise name  
            * Exercise repetitions
            * 
* Navbar(Home, routines, profile)  
* navbar [Profile]  
#### Start button on action.


### Profile
[profile, prof name, prof info (mock: premium or freemium account), logout]
