#!/bin/bash
# Laboratorio 2 · Datos de usuario para Amazon Linux 2023.
# Se pega en EC2 → Lanzar instancia → Detalles avanzados → Datos de usuario.
# Instala Apache y publica una página que muestra el nombre del servidor.
dnf update -y
dnf install -y httpd
systemctl enable --now httpd
echo "<h1>Hola desde $(hostname -f)</h1>" > /var/www/html/index.html
