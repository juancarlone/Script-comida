#                                                                                                   #
#   Este script se presenta como una manera de explorar Powershell para resolver un problema real   #
#                                                                                                   #

# Empezamos con algunas variables de datos
$almuerzo = @(get-content  "C:\Users\Jc\Documents\Script\Script comida\almuerzo.txt")
$cena = @(get-content  "C:\Users\Jc\Documents\Script\Script comida\cena.txt")

# Funciones
function calccomida {
[int]$max =$almuerzo.count
if ([int]$cena.count -gt [int]$almuerzo.count) { max = $cena.count;}
    $comida = for ($i = 0; $i -lt $max; $i++)
    {
        Write-Verbose "($almuerzo[$i]),($cena[$i])"
        [pscustomobject]@{
                Almuerzo = $almuerzo[$i]
                Cena = $cena[$i]
            }
    }
    $comida | out-file -Append "C:\Users\Jc\Documents\Script\Script comida\comida.txt"
}
# Menú de opciones
write-host "Bienvenido al menú semanal de comida"
function menú {
    Clear-Host
    Write-Host " "
    Write-Host "Por favor, selecciones una opción"
    Start-Sleep -s 0.5
    Write-Host "1. Añadir almuerzo"
    Start-Sleep -s 0.5
    Write-Host "2. Añadir cena"
    Start-Sleep -s 0.5
    Write-Host "3. Crear menú bisemanal"
    Start-Sleep -s 0.5
    Write-Host "4. Ver registro de comidas"
    Start-Sleep -s 0.5
    Write-Host "5. Salir"
    Write-Host " "
    Start-Sleep -s 0.5
}

# EMPIEZA EL SCRIPT
menú
while (($opt = Read-Host "Selecciona una opcion") -ne 5){
    switch($opt){
        1 {
            Clear-Host
            Write-Host "------------------------------";
            $almu = @()
            $almu += Read-Host "Introduce el almuerzo a añadir: "
            while ($true) {
                if (($almuerzo -like $almu)) {
                    $almu = @(Read-Host "Valor ya integrado, Introduce nuevo almuerzo") 
                } 
                else {
                    $almuerzo += $almu
                    $almuerzo | out-file -append "C:\Users\Jc\Documents\Script\Script comida\almuerzo.txt"
                    calccomida   
                    break
                }   
            }            

            Write-Host "El registro actualizado es: $almuerzo"
            Start-Sleep -s 3
            Write-Host "------------------------------";
            break
        }
        2 {
            Clear-Host
            Write-Host "------------------------------";
            $cen = @()
            $cen += Read-Host "Introduce la cena a añadir: "
            while ($true) {
                if (($cena -like $cen)) {
                    $cen = @(Read-Host "Valor ya integrado, Introduce nueva cena") 
                } 
                else {
                    $cena += $cen
                    $cena | out-file -append "C:\Users\Jc\Documents\Script\Script comida\cena.txt"
                    calccomida   
                    break
                } 
            Write-Host "El registro actualizado es: $cena"
            Start-Sleep -s 3
            Write-Host "------------------------------";
            break
            }
        }
        3 {
            if ( $almuerzo.count -lt 7) {
                Write-Host "Todavia faltan $(7 - $almuerzo.count) almuerzos";
            }
            elseif ($cena.count -lt 7) {
                Write-Host "Todavia faltan $(7 -$cena.count) cenas";
            }
# Vamos a añadir un parametro para no repetir comidas
            else
            {
                # configuracion previa
                Write-Host "------------------------------";
                #LUNES
                $almuerzoP = $($almuerzo | get-random)
                Write-Host "Lunes =  $almuerzoP ; $($cena | get-random )" | out-file -Append "C:\Users\Jc\Documents\Script\Script comida\menu.txt"
                #Introducimos el valor del lunes en un parametro, y se lo pasamos al array de almuerzo para que lo elimine del sus valores guardados
                $almuerzo = $almuerzo | Where-Object { $_ -ne $almuerzoP }
                #MARTES
                $almuerzoP = $($almuerzo | get-random)
                Write-Host "Marte = $almuerzoP ; $($cena | get-random)" | out-file -Append "C:\Users\Jc\Documents\Script\Script comida\menu.txt"
                $almuerzo = $almuerzo | Where-Object { $_ -ne $almuerzoP }
                #MIERCOLES
                $almuerzoP = $($almuerzo | get-random)
                Write-Host "Miercoles = $almuerzoP ; $($cena | get-random)" | out-file -Append "C:\Users\Jc\Documents\Script\Script comida\menu.txt"
                $almuerzo = $almuerzo | Where-Object { $_ -ne $almuerzoP }
                #JUEVES
                $almuerzoP = $($almuerzo | get-random)
                Write-Host "Jueves = $almuerzoP ; $($cena | get-random)" | out-file -Append "C:\Users\Jc\Documents\Script\Script comida\menu.txt"
                $almuerzo = $almuerzo | Where-Object { $_ -ne $almuerzoP }
                #VIERNES
                $almuerzoP = $($almuerzo | get-random)
                Write-Host "Viernes = $almuerzoP ; $($cena | get-random)" | out-file -Append "C:\Users\Jc\Documents\Script\Script comida\menu.txt"
                $almuerzo = $almuerzo | Where-Object { $_ -ne $almuerzoP }
                #SABADO
                $almuerzoP = $($almuerzo | get-random)
                Write-Host "Sabado = $almuerzoP ; $($cena | get-random)" | out-file -Append "C:\Users\Jc\Documents\Script\Script comida\menu.txt"
                $almuerzo = $almuerzo | Where-Object { $_ -ne $almuerzoP }
                #DOMINGO
                $almuerzoP = $($almuerzo | get-random)
                Write-Host "Domingo = $almuerzoP ; $($cena | get-random)" | out-file -Append "C:\Users\Jc\Documents\Script\Script comida\menu.txt"
                $almuerzo = $almuerzo | Where-Object { $_ -ne $almuerzoP }
                Write-Host "------------------------------";
                Start-Sleep -s 4
            }
            break
            }
        4 {
            Clear-Host
            Write-Host "------------------------------";
            Write-Host "Almuerzos: ";
            $almuerzo
            Write-Host ""
            Write-Host "Cenas: ";
            $cena
            Write-Host "------------------------------";
            Start-Sleep -s 3
            break
            }
        5 {"Exit"; break}
        default {Write-Host -ForegroundColor red -BackgroundColor white "Invalid option. Please select another option";pause}
        
    }
    menú
}