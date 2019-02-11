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

OTHERS ARGUMENTS

    After the -r, remove parameter, use -y argument for
    auto remove package without question. You can set this
    automatically in the configuration file in /etc/banana.conf

LICENSE
    
    MIT

AUTHOR
   
    Jefferson Rocha <root@slackjeff.com.br>

COMPLETE DOCUMENT

    https://bananapkg.github.io/
EOF
}


_HELP_PT()
{
    cat <<EOF
banana - Gerenciador de pacotes de baixo nível

banana [OPÇOES] [ARQUIVO(S)]

PRINCIPAIS ARGUMENTOS

    -g, generate
          Gerar um diretório info/ e dentro um arquivo desc
          para editar

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

OUTROS ARGUMENTOS

    Após o parâmetro -r, remove, use -y este argumento remove
    o(s) pacote(s) automaticamente sem questionar. Você pode definir isso
    automaticamente no arquivo de configuração em /etc/banana.conf

LICENÇA
    
    MIT

AUTOR
   
    Jefferson Rocha <root@slackjeff.com.br>

DOCUMENTAÇÃO COMPLETA

    https://bananapkg.github.io/
EOF
}
