$(date)
echo "MENU PRINCIPAL"
echo "--- Por favor, escoga una opcion"

Opcion1="1. info del usuario"
Opcion2="2. Detecrtar equipos activos"
Opcion3="3. Detectar puertos abiertos"
Opcion4="4. Salir"::
 
 
select opcion in "$Opcion1" "$Opcion2" "$Opcion3" "$Opcion4" ;
do
    if [ "$opcion" = "$Opcion1" ]; then 
        echo "tu username es: " $(whoami)
        echo "tu Hostname es: " $(hostname)

    done

    elif ["$opcion" = "$Opcion2" ]; then
        which ifconfig && { echo "Comando ifconfig existe...";
                            direccion_ip= 'ifconfig |grep inet |grep -v "127.0.0.1" |awk '{print $2}'';
                            echo "esta es tu direccion ip: " $direccion_ip;
                            subred= 'ifconfig |grep inet |grep -v "127.0.0.1" |awk '{ print $2}' |awk -F  {print $1"."$2"."$3"."}';
                            echo "esta es tu subred:"$subred;
                              }

                           { echo "no existe el comando ifconfig...usando ip";
                            direccion_ip='ip addr show |grep inet | grep -v "127.0.0.1" |awk '{print $2}'' ;
                            echo "esta es tu direccion ip:"$direccion_ip;
                            subred= 'ip ddr show |grep inet | grep -v "127.0.0.1" |awk ' {print $1"."$2"."$3"."}
                            echo "esta es tu subred: "$subred
                              }
        for ip in {1..254}
        do
            ping -q -c 4 ${subred}${ip} > /dev/null
            if [$? -eq 0]
            then
                echo "host responde: " ${subred}${ip}
            fi
        done

    elif  ["$opcion" = "$opcion3"]; then
        if [$# -eq 0]
        then
            echo "Modo de uso: ./portscanv2.sh [IP]"
            echo "Ejemplo: ./portscanv2.sh 192.168.1.19"
        else
            echo "favor de esperar mientras se escanean los primeros 1024 puertos..."
            nc -nvz $1 1-1024 > ${1}.txt 2>&1
            echo "tu escaneo ha finalizado"
            echo "podras revisar tus resultados en el archivo: "${1}.txt

    elif ["$opcion" = "$Opcion4"]; then
        exit
        
    else
        echo "Opción no válida" 
    fi
    done
