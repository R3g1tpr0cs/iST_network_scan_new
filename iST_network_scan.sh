#!/bin/bash

cat << EOF

                                                                             
   "     mmmm mmmmmmm        mm   m          m                         #     
 mmm    #"   "   #           #"m  #  mmm   mm#mm m     m  mmm    m mm  #   m 
   #    "#mmm    #           # #m # #"  #    #   "m m m" #" "#   #"  " # m"  
   #        "#   #           #  # # #""""    #    #m#m#  #   #   #     #"#   
 mm#mm  "mmm#"   #           #   ## "#mm"    "mm   # #   "#m#"   #     #  "m 
                                                                             
                                                                             
                                                                             
         mmmm                                                                
        #"   "  mmm    mmm   m mm   m mm    mmm    m mm                      
        "#mmm  #"  "  "   #  #"  #  #"  #  #"  #   #"  "                     
            "# #      m"""#  #   #  #   #  #""""   #                         
        "mmm#" "#mm"  "mm"#  #   #  #   #  "#mm"   #                         
                                                                             
                                                           
EOF

echo "Добро пожаловать в сканер iST"
echo "============================="
echo "Вы хотите просканировать сеть или хост? Нажмите n"
echo "Вы хотите просканировать директории на хосте? Нажмите d"
echo "Вы хотите просканировать директории более глубо? Нажмите sd"
echo "Вы хотите просканировать поддомены на хосте? Нажмите s"
echo "Если Вы хотите выйти, то нажмите Ctrl + C"

while :
do
    read command

    if [ $command == "d" ]; then
        echo "Введите IP: "
        read ip_
        dirsearch -u $ip_
    elif [ $command == "s" ]; then
	    echo "Введите URL: "
        read url_
        gobuster dns -w /usr/share/wordlists/seclists/Discovery/DNS/bitquark-subdomains-top100000.txt -d $url_  -t 100
    elif [ $command == "n" ]; then
        echo "Введите IP: "
        read ip_
        echo "Введите до какого порта сканировать (масксимум 65535, стандартно 1000)"
        read ports_
        nmap -sC -sV -p -$ports_ --min-rate 5000 $ip_
    elif [ $command == "sd" ]; then
        echo "Введите IP/{direct}: "
        read ip_
        gobuster dir -w /usr/share/wordlists/dirbuster/directory-list-2.3-small.txt -u  $ip_ -t 100
    else
	    echo "Введено что-то не то. Попробуй ещё раз."
        continue
    fi
done