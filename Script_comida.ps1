# Empezamos con algunas variables de datos

$almuerzo = @(get-content  "C:\Users\Jc\Documents\Script\Script comida\almuerzo.txt")
$cena = @(get-content  "C:\Users\Jc\Documents\Script\Script comida\cena.txt")
# Funciones
function calccomida {
[int]$max =$almuerzo.count
if ([int]$cena.count -gt [int]$almuerzo.count) { max = $cena.count;}
    $comida = for ($i = 0; $i -lt $max; $i++)
    {
        Write-Verbose "$(almuerzo[$i]),$(cena[$i])"
        [pscustomobject]@{
                Almuerzo = $almuerzo[$i]
                Cena = $cena[$i]
            }
    }
    $comida | out-file -Append "C:\Users\Jc\Documents\Script\Script comida\comida.txt"
}

write-host "Bienvenido al menú semanal de comida"
function menú {
    Clear-Host
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
            $almuerzo += Read-Host "Introduce el almuerzo a añadir"
            $almuerzo | out-file -append "C:\Users\Jc\Documents\Script\Script comida\almuerzo.txt"
            calccomida
            Write-Host "El registro actualizado es: "
            $almuerzo
            Start-Sleep -s 3

            Write-Host "------------------------------";
            break
        }
        2 {
            Clear-Host
            Write-Host "------------------------------";
            $cena += Read-Host "Introduce el cena a añadir"
            $cena | out-file -append "C:\Users\Jc\Documents\Script\Script comida\cena.txt"
            calccomida
            Write-Host "El registro actualizado es: "
            $cena
            Start-Sleep -s 3
            Write-Host "------------------------------";
            break
        }
        3 {
            if ( $almuerzo.count -lt 7) {
                Write-Host "Todavia faltan $(7 - $almuerzo.count) almuerzos";
            }
            elseif ($cena.count -lt 7) {
                Write-Host "Todavia faltan $(7 -$cena.count) cenas";
            }
            else
            {
                Write-Host "------------------------------";
                Write-Host "Lunes = $($almuerzo | get-random) ; $($cena | get-random )" | out-file -Append "C:\Users\Jc\Documents\Script\Script comida\menu.txt"
                Write-Host "Marte = $($almuerzo | get-random) ; $($cena | get-random)" | out-file -Append "C:\Users\Jc\Documents\Script\Script comida\menu.txt"
                Write-Host "Miercoles = $($almuerzo | get-random) ; $($cena | get-random)" | out-file -Append "C:\Users\Jc\Documents\Script\Script comida\menu.txt"
                Write-Host "Jueves = $($almuerzo | get-random) ; $($cena | get-random)" | out-file -Append "C:\Users\Jc\Documents\Script\Script comida\menu.txt"
                Write-Host "Viernes = $($almuerzo | get-random) ; $($cena | get-random)" | out-file -Append "C:\Users\Jc\Documents\Script\Script comida\menu.txt"
                Write-Host "Sabado = $($almuerzo | get-random) ; $($cena | get-random)" | out-file -Append "C:\Users\Jc\Documents\Script\Script comida\menu.txt"
                Write-Host "Domingo = $($almuerzo | get-random) ; $($cena | get-random)" | out-file -Append "C:\Users\Jc\Documents\Script\Script comida\menu.txt"
                Write-Host "------------------------------";
                Start-Sleep -s 4
            }
            break
            }
        4 {
            Clear-Host
            Write-Host "------------------------------";
            $comida 
            Write-Host "------------------------------";
            Start-Sleep -s 3
            break
            }
        5 {"Exit"; break}
        default {Write-Host -ForegroundColor red -BackgroundColor white "Invalid option. Please select another option";pause}
        
    }
    menú
}