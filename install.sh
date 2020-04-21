#!/usr/bin/env bash

######################################################################
# Autor     :   Jefferson 'slackjeff' Rocha <root@slackjeff.com.br>  #
# Licença   :   MIT                                                  #
# Descrição :   Instalador para o banana                             #
#                                                                    #
# Changelog :   (21/04/2020) - Hugo Torres                           #
#                   - Organizado o cabeçalho e HEADER                #
#                   - Adicionado variaveis para cores                #
#                   - Modificado mensagem do final da instalação     #
#               (20/02/2019) - Jefferson Rocha                       #
#                   - Adicionado suporte ao manual                   #
#                   - Inserido Cabeçalho no script                   #
#                   - Se falhar qualquer coisa agora sai =)          #
######################################################################

# ====================================================================
#                           VARIAVEIS
# ====================================================================

prg='banana'
DESTDIR=''

# Variaveis de cores
RED='\033[31;1m'
YELLOW_BLINK='\033[33;5;1m'
END='\033[m'

# ====================================================================
#                            TESTES
# ====================================================================

[[ "$UID" -ne "0" ]] && { echo -e "\nOnly ${RED}root${END}.\n"; exit 1 ;}

# Cabeçalho simples
echo -e "
###################################################
#   Banana Install, bugs? root@slackjeff.com.br   #
###################################################\n"

# ====================================================================
#                            INICIO
# ====================================================================

# Analisa parametros
for param in "$@"; do
    shift
    # Ex: DESTDIR=/caminho/para/dir ou DESTDIR /caminho/para/dir
    if [[ "$param" = 'DESTDIR'* ]]; then
        [[ "$param" = *'='* ]] && DESTDIR="${param#*=}" || DESTDIR="$1"
        # remove ultima barra
        DESTDIR="${DESTDIR%*/}"
    fi
done

# Dando permissões e copiando arquivos para seus lugares.
echo -e "\nPermission and Copy archives\n"
install -vDm755 -t "${DESTDIR}/sbin/" "$prg" || exit 1
install -vDm644 -t "${DESTDIR}/usr/share/man/pt_BR/man8/" 'banana.8' || exit 1
install -vDm644 -t "${DESTDIR}/usr/libexec/banana/" {core,help}'.sh' || exit 1

# Verifica se arquivo de configuração existe para cria-lo ou .new
if [[ -e "${DESTDIR}/etc/banana/${prg}.conf" ]]; then
    cmp -s "${prg}.conf" "${DESTDIR}/etc/banana/${prg}.conf" ||
        install -vDm644 "${prg}.conf" "${DESTDIR}/etc/banana/${prg}.conf.new" || exit 1
else
    install -vDm644 -t "${DESTDIR}/etc/banana/" "${prg}.conf" || exit 1
fi

# Criando diretórios se não existirem
mkdir -vp "${DESTDIR}/var/lib/banana/"{list,desc,remove}

# Mensagem apresentada apos finalizar a instalação.
echo -e "
                           +-----------------------+
                           |     !!! FINNALY !!!   |
                           | Work now, call ${YELLOW_BLINK}banana${END} |
                           +-----------------------+
"