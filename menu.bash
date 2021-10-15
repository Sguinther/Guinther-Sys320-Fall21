#!/bin/bash

# storyline: menu for admin, vpn, and security functions

function invalid_opt() {

 echo ""
 echo "Invalid option"
 echo ""
 sleep 2

}

function menu() {


    # clears screen
    clear

    echo "[1] Admin Menu"
    echo "[2] Security Menu"
    echo "[3] Exit"
    read -p "Please enter a choice above: " choice

    case "$choice" in

        1) admin_menu
        ;;
        2) security_menu
        ;;
        3) exit 0
        ;;
        *)
            invalid_opt
            # call the main menu
            menu

        ;;
    esac


}

function security_menu() {

    clear
    echo "[1] list open network sockets"
    echo "[2] check if any user besides root has a UID of 0"
    echo "[3] check last 10 logged in users"
    echo "[4] see current logged in users"
    echo "[5] Block List Menu"
    echo "[6] Exit"
    read -p "Please enter a choice above: " choice

    case "$choice" in

        1) sudo netstat -plntu |less
        ;;
        2) grep 'x:0:' /etc/passwd |less
        ;;
        3) last | head -n 10 |less
        ;;
        4) w |less
        ;;
	5) blocklistmenu
	;;
        6) exit 0
        ;;

        *)
           invalid_opt

        ;;
    esac

security_menu

}


function blocklistmenu() {

    clear

    echo "[C]isco blocklist gen"
    echo "[D]omain URL blocklist gen"
    echo "[W]indows Blocklist gen" 
    read -p "please enter a choice: " choice
    case "$choice" in
	C) 
	;;
	D)
	;;
	W)
	;;
	E) exit 0
	;;

	*)
	   invalid_opt

	;;
    esac
blocklistmenu

}




function admin_menu() {

    clear
    echo "[L]ist Running Processes"
    echo "[N]etwork Sockets"
    echo "[V]PN menu"
    echo "[4] Exit"
    read -p "Please enter a choice above: " choice

    case "$choice" in

        L|l) ps -ef |less
        ;;
        N|n) netstat -an --inet |less
        ;;
        V|v) vpn_menu
        ;;
        4) exit 0
        ;;

        *)
            invalid_opt

        ;;
    esac

admin_menu
}

function vpn_menu() {

    clear
    echo "[A]dd a peer"
    echo "[D]elete a peer"
    echo "[B]ack to admin menu"
    echo "[M]ain menu"
    echo "[E]xit"
    read -p "Please select an option: " choice

    case "$choice" in

        A|a)

         bash peer.bash
         tail -6 wg0.conf |less

        ;;
        D|d)
          # create a promt for the user
          # call thqe manage-user.bash and pass the proper switchs and arguments
          # to delete the user
         read -p "enter name to delete: " name
         bash manage-users.bash -d -u ${name}
        ;;
        B|b) admin_menu
        ;;
        M|m) menu
        ;;
        E|e) exit 0
        ;;
        *)
            invalid_opt

        ;;

    esac

vpn_menu
}

# Call the main function
menu

