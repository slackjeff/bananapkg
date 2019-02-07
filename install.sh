#!/usr/bin/env bash
#=====================HEADER=========================================|
#AUTOR
# Jefferson 'slackjeff' Rocha <root@slackjeff.com.br>
#
#LICENÇA
# MIT
#
# Instalador para o banana
#====================================================================|

[[ "$UID" -ne "0" ]] && { echo "Only root."; exit 1 ;}

prg='banana'

echo -e "Create Especial Directories...\n"
# Criando diretórios se não existirem.
for createdir in '/var/lib/banana/list' '/var/lib/banana/desc' '/var/lib/banana/remove' '/usr/libexec/banana'; do
    [[ ! -d "$createdir" ]] && mkdir -vp "$createdir" || echo "$createdir exist, skip."
done

set -e # Deu erro para ;)
# Dando permissões e copiando arquivos para seus lugares.
echo -e "\nPermission and Copy archives\n"
for m in "$prg" "${prg}.conf" 'core.sh'; do
   [[ -e "$m" ]] && [[ "$m" != "core.sh" ]] && chmod +x $m
    case $m in
        banana) cp -v "$m" "/sbin/"    ;;
        banana.conf) cp -v "$m" "/etc/" ;;
        core.sh) cp -v "$m" "/usr/libexec/banana/" ;;
    esac
done

echo -e "\nFINNALY! WORK NOW, call banana"
