#!/bin/bash

echo "=== MATRICE D'ARCHITECTURE V2 ==="

if [ "$1" == "up" ]; then
    echo "[+] Démarrage du Cerveau (Traefik)..."
    cd ~/infra-traefik && docker compose up -d
    echo "[+] Démarrage de la Tour de Contrôle (Portainer)..."
    cd ~/infra-tools && docker compose up -d
    echo "[+] Démarrage de l'Usine (Sites Web)..."
    cd ~/infra-web && docker compose up -d
    echo ">>> SYSTÈME EN LIGNE <<<"
    
elif [ "$1" == "down" ]; then
    echo "[-] Extinction de l'Usine (Sites Web)..."
    cd ~/infra-web && docker compose down
    echo "[-] Extinction de la Tour de Contrôle (Portainer)..."
    cd ~/infra-tools && docker compose down
    echo "[-] Extinction du Cerveau (Traefik)..."
    cd ~/infra-traefik && docker compose down
    echo ">>> SYSTÈME HORS LIGNE <<<"
    
else
    echo "Erreur. Ordre non reconnu."
    echo "Commandes : ./manager.sh up | ./manager.sh down"
fi
