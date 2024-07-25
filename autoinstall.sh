#!/bin/bash

#Status bar
show_progress() {
    percentage=$1
    bar_length=20
    completed_length=$((percentage * bar_length / 100))
    remaining_length=$((bar_length - completed_length))

    printf "["
    for ((i = 0; i < completed_length; i++)); do
        printf "="
    done
    for ((i = 0; i < remaining_length; i++)); do
        printf " "
    done
    printf "] %d%%\r" $percentage
}

#Calc percentage
calculate_percentage() {
    completed_tasks=$1
    total_tasks=$2
    echo $((completed_tasks * 100 / total_tasks))
}

#def tasks
total_tasks=6

#count
completed_tasks=0

#update package linux
sudo apt update -y
((completed_tasks++))
show_progress $(calculate_percentage $completed_tasks $total_tasks)

#upgrade package linux
sudo apt upgrade -y
((completed_tasks++))
show_progress $(calculate_percentage $completed_tasks $total_tasks)

#removing
sudo apt autoremove -y
((completed_tasks++))
show_progress $(calculate_percentage $completed_tasks $total_tasks)

#install essentials apps
sudo apt install -y flatpak gnome-tweaks openjdk-21-jdk openjdk-21-jre htop vim git curl wget openssh-server grep findutils net-tools screen tmux nmap bash-completion zip unzip neofetch nano telnet ssh
((completed_tasks++))
show_progress $(calculate_percentage $completed_tasks $total_tasks)

#add repo flathub
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
((completed_tasks++))
show_progress $(calculate_percentage $completed_tasks $total_tasks)

#Array flatpak apps
flatpaks=(
    org.ryujinx.Ryujinx
    #Insert here........... <================
)

#Loop install
for flatpak_name in "${flatpaks[@]}"; do
    echo "Instalando $flatpak_name"
    flatpak install -y $flatpak_name
    ((completed_tasks++))
    show_progress $(calculate_percentage $completed_tasks $total_tasks)
done

echo -e "\nDone =)"
