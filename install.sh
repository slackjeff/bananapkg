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
DESTDIR=''

#================== TESTES
[[ "$UID" -ne "0" ]] && { echo "Only root."; exit 1 ;}

# Cabeçalho simples
echo "###################################################"
echo "   Banana Install, bugs? root@slackjeff.com.br     "
echo -e "###################################################\n"

#================== INICIO
# Analisa parametros
for param in "$@"; do
    shift
    # Ex: DESTDIR=/caminho/para/dir ou DESTDIR /caminho/para/dir
    if [[ "$param" = DESTDIR* ]]; then
        [[ "$param" = *=* ]] && DESTDIR="${param#*=}" || DESTDIR=$1
    fi
done

# Criando diretórios se não existirem.
echo -e "Create Especial Directories...\n"
for createdir in '/var/lib/banana/list' '/var/lib/banana/desc' '/var/lib/banana/remove' '/usr/libexec/banana' '/etc/banana'; do
    [[ ! -d "${DESTDIR}${createdir}" ]] && mkdir -vp "${DESTDIR}${createdir}" || echo "${DESTDIR}${createdir} exist, skip."
done

# Dando permissões e copiando arquivos para seus lugares.
echo -e "\nPermission and Copy archives\n"
for m in "$prg" "${prg}.conf" 'banana.8' 'core.sh' 'help.sh'; do
    [[ -e "$m" ]] && [[ "$m" != "core.sh" ]] && chmod +x $m
    case $m in
        (banana) cp -v "$m" "${DESTDIR}/sbin/" || exit 1    ;;
        (banana.8)
		if [[ -d "${DESTDIR}/usr/share/man/pt_BR/man8/" ]]; then
		    cp -v "$m" "${DESTDIR}/usr/share/man/pt_BR/man8/" || exit 1
                else
                    mkdir -vp "${DESTDIR}/usr/share/man/pt_BR/man8/"
		    cp -v "$m" "${DESTDIR}/usr/share/man/pt_BR/man8/" || exit 1
                fi
        ;;
        (banana.conf) cp -v "$m" "${DESTDIR}/etc/banana/" || exit 1 ;;
        (core.sh|help.sh|builtin.sh) cp -v "$m" "${DESTDIR}/usr/libexec/banana/" || exit 1 ;;
    esac
done

echo -e "\nFINNALY! WORK NOW, call banana"
