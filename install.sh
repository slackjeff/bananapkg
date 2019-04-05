#!/usr/bin/env bash
#=====================HEADER=========================================|
#AUTOR
# Jefferson 'slackjeff' Rocha <root@slackjeff.com.br>
#
#INSTALAÇÃO DO BANANA
#
#LICENÇA
#  MIT
#
# Instalador para o banana
#
#CHANGELOG
# (20/02/2019) - Jefferson Rocha
#  - Adicionado suporte ao manual
#  - Inserido Cabeçalho no script
#  - Se falhar qualquer coisa agora sai =)
#====================================================================|

#================== VARIAVEIS
prg='banana'

#================== TESTES
[[ "$UID" -ne "0" ]] && { echo "Only root."; exit 1 ;}

# Cabeçalho simples
echo "###################################################"
echo "   Banana Install, bugs? root@slackjeff.com.br     "
echo -e "###################################################\n"

#================== INICIO
# Criando diretórios se não existirem.
echo -e "Create Especial Directories...\n"
for createdir in '/var/lib/banana/list' '/var/lib/banana/desc' '/var/lib/banana/remove' '/usr/libexec/banana' '/etc/banana'; do
    [[ ! -d "$createdir" ]] && mkdir -vp "$createdir" || echo "$createdir exist, skip."
done

# Dando permissões e copiando arquivos para seus lugares.
echo -e "\nPermission and Copy archives\n"
for m in "$prg" "${prg}.conf" 'banana.8' 'core.sh' 'help.sh' 'builtin.sh'; do
   [[ -e "$m" ]] && [[ "$m" != "core.sh" ]] && chmod +x $m
    case $m in
        (banana) cp -v "$m" "/sbin/" || exit 1    ;;
        (banana.8) cp -v "$m" '/usr/share/man/pt_BR/man8/' || exit 1 ;;
        (banana.conf) cp -v "$m" "/etc/banana/" || exit 1 ;;
        (core.sh|help.sh|builtin.sh) cp -v "$m" "/usr/libexec/banana/" || exit 1 ;;
    esac
done

echo -e "\nFINNALY! WORK NOW, call banana"
