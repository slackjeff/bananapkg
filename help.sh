#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#
# HELP
#
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

_HELP_US()
{
    cat <<EOF
banana - Low level package manager
banana [OPTION] [ARCHIVE]

MAIN ARGUMENTS
    -V, version
          Look version of Banana
    -h,help
          Show this message and exit
    -g, generate
          Generate directory info/ and into desc
    -c, create
          Create Package
    -i, install
          Install Package
    -u, upgrade
          Upgrade package
    -r, remove
          Remove Package
    -s, search
          Search Package        
    -ol, --one-line
          Use in -s, search for print one line search.
          program-version-build       
    -v, --verbose
          Look more
EOF
}


_HELP_PT()
{
    cat <<EOF
banana - Gerenciador de pacotes de baixo nível
banana [OPÇOES] [ARQUIVO(S)]

PRINCIPAIS ARGUMENTOS
    -V, version
          Verifica a versão do banana
    -h,help
          Exibe essa mensagem e sai
    -g, generate
          Gerar um diretório info/ e dentro um arquivo desc para editar
    -c, create
          Criar pacote
    -i, install
          Instalar pacote
    -u, upgrade
          Atualizar pacote
    -r, remove
          Remover pacote
    -s, search
          Procurar Pacote
    -ol, --one-line
          Use em -s, search para imprimir em uma linha o retorno de pesquisa.
          program-version-build
    -v, --verbose
          Visualizar melhor a saída

EOF
}
