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

MAIN ARGUMENTS

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

#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#
# REMOVER PACOTE
#
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


# Função para listagem de lista
_PKG_CONF()
{
    count_occurrences=0
    pushd "$dirdesc" 1>/dev/null
    re="\b${pack}\b"
    for search_pack in *; do
        if [[ "$search_pack" =~ ^${re}.* ]]; then # Pacote existe?
            for q in *; do # Checando quantas ocorrencias existem.
                if [[ "$q" =~ ^${re}.* ]]; then
                    # Se existir varios pacotes com o mesmo nome incremente!
                    count_occurrences="$(( $count_occurrences + 1 ))"
                fi
            done
            # Carregando descrição do pacote para testes!
            # se caso o pacote tem mais de uma versão no sistema.
             source ${search_pack}
             local name_version_build="${pkgname}-${version}-${build}" # Variavel para vericação nome + versão + build
             if [[ "${name_version_build}.desc" =~ ^${re}.desc ]] || \
                [[ "${name_version_build}.desc" =~ ^${re}.* && "$count_occurrences" -eq '1' ]] ; then

                 echo -e "\n!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! ${red}REMOVE${end} !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
                 echo -e "${blue}PACKAGE:${end}\t${pkgname}"
                 echo -e "${blue}VERSION:${end}\t${version}"
                 echo -e "${blue}BUILD-PACK:${end}\t${build}"
                 echo -e "${blue}DESCRIPTION:${end}\t${desc}"
                 echo -e "##################################################################################\n"
                 
                 if [[ -z "$auto_confirm" ]] || [[ "$auto_confirm" != 'y' ]]; then # se ter -y é auto confirmar ;)
                     # Confirmando se usuário quer apagar
                     echo -e "${red}Are you ready to remove the${end} ${pkgname}-${version}-${build} ${red}package, do you want to continue?${end}"
                     read -p "Remove [Y/n]: " confirm
                     confirm=${confirm,,}  # Tudo em minusculo
                     confirm=${confirm:=y} # Apertou enter retorna yes.
                     [[ "$confirm" != 'y' ]] && return 0
                     pushd "${dirlist}" 1>/dev/null # Entrando no diretório das listas /var/lib/banana/list
                     search_pack="${search_pack/%.desc/.list}" # se terminar com .desc substitua por .list
                     # Chamada função para remoção.
                     [[ -e "${search_pack}" ]] && _BURN && { popd 1>/dev/null; return 0 ;} || { popd 1>/dev/null; return 1 ;}
                 else
                     pushd "${dirlist}" 1>/dev/null # Entrando no diretório das listas /var/lib/banana/list
                     search_pack="${search_pack/%.desc/.list}" # se terminar com .desc substitua por .list
                     # Chamada função para remoção.
                     [[ -e "${search_pack}" ]] && _BURN && { popd 1>/dev/null; return 0 ;} || { popd 1>/dev/null; return 1 ;}
                 fi
             else
                 # Caiu aqui? Então existe mais de um pacote com o mesmo nome
                 # porém com versões diferente...
                 # O programa não pode fazer nada, apenas alertar.
                 search_pack="${search_pack/%.desc/}"
                 echo -e "${red}[FOUND]${end} $search_pack"
                 continue
             fi
        fi
    done
    # Não existe o pacote no sistema
    echo -e "\n${red}[NOT FOUND]${end} ${pack}"
    return 1
}

# Função para remoção dos arquivos e diretórios do pacote
_BURN()
{
    # Se existir o script rm.sh que é um script que precisa ser executado antes
    # de tudo, ele será executado.
    if [[ -e "${dirremove}/${pkgname}-${version}-${build}.rm" ]]; then
        echo -e "${blue}[REMOVE]${end}\tThe script rm.sh was found. Execute now!"  
        bash "${dirremove}/${pkgname}-${version}-${build}.rm"
    fi
    pushd "/" &>/dev/null # Entrando na raiz
    #AC = Arquivo
    #ED = Diretorio Vazio
    # Removendo arquivos normais
    # Depois do loop estar completo ele vai para
    # Remoção de Links Simbólicos e por último
    # Remoção de diretórios vazios
    a='0' # Variavel incremento arquivos
    d='0' # Variavel incremento diretorios vazios
    l='0' # Variavel incremento link simbólico
    while IFS= read archive; do
        if [[ -f "$archive" ]]; then
            if rm "$archive" &>/dev/null; then
                a="$(($a + 1))"
                echo -e "${red}Burned AC${end}\t${archive}"   
                archive="$(echo "$archive" | sed 's|/|\\/|g')"
            fi
        fi
    done < "${dirlist}/${search_pack}" # Recebendo de _PKG_CONF

    # Tirando todo conteudo da var para ser reaproveitada
    unset archive

   # Removendo links simbólicos
    while IFS= read archive; do
       if [[ -L "$archive" ]]; then
             if unlink "$archive" &>/dev/null; then
                l="$(($l + 1))"
                echo -e "${pink}Burned SL${end}\t${archive}"   
                archive="$(echo "$archive" | sed 's|/|\\/|g')"
            fi
       fi
    done < "${dirlist}/${search_pack}" # Recebendo de _PKG_CONF

    # Tirando todo conteudo da var para ser reaproveitada
    unset archive

    # Removendo diretórios vazios, e forçando para
    # toda hierarquia do pacote seja removido.
        while IFS= read archive; do
            if [[ -d "$archive" ]]; then
                if [[ -z "$(ls -A ${archive})" ]]; then 
                    rmdir -p "${archive}" &>/dev/null
                    d="$(( $d + 1 ))"
                    echo -e "${blue}Burned ED${end}\t${archive}"   
                    archive="$(echo "$archive" | sed 's|/|\\/|g')"
                fi
            fi
        done < "${dirlist}/${search_pack}" # Recebendo de _PKG_CONF

    # Impressão na tela
    if [[ "$a" -gt '0' ]] || [[ "$d" -gt '0' ]]; then
        total="$(( $a + $d +$l ))"
        echo -e "\n=======> ${red}TOTAL BURNED${end} $total Archives."
        echo -e "=======> ${red}BURNED${end} $a Archives, $d Empty Directories and $l Symlink."
    fi
    # Removendo lista
    rm "${dirlist}/${search_pack}" &>/dev/null
    popd &>/dev/null
    return 0
}


#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#####################################################################
#
# INSTALAR E ATUALIZAR
#
#####################################################################
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


_PRE_CONF()
{
    # Variavel pack é importante para descompactar o pacote com o tar.
    # De resto todas informações são puxadas das variaveis presentes no arquivo
    # dentro do diretorio info (desc). Como por exemplo, nome e versão do pacote.
    pack="$1"

    re="\.\<${format_pkg}\>"
    if ! [[ "$pack" =~ .*${re} ]]; then
        echo -e "${red}[Error!]${end} Package need finish $format_pkg"
        return 1
    elif [[ ! -e "$pack" ]]; then # Pacote existe?
        return 1
    fi
    # Pegando somente nome do pacote
    # sem extensão.
    pack="${1/%.mz/}"
    return 0
}

# Função de pré instalação do pacote.
# vamos arrumar tudo antes de seguir o processo.
_PRE_INSTALL_PKG()
{    
    # Descompactando desc primeiro para exibir informações do pacote.
    if ! tar xmf "${pack}.${format_pkg}" -C "/tmp/" "./${descme}"; then
        echo -e "${red}[ERROR!]${end} I could not unzip the file desc."
        exit 1
    else
        # Carregando informações do pacote
        if ! source "/tmp/${descme}"; then
            echo -e "${red}[ERROR!]${end} Not load ${descme}, ABORT."
            return 1
        fi
    fi
    # Pegando tamanho da string
    #string_size=${#desc}
    # Se string ultrapassar 44 caracteres, corte!
    #[[ "$string_size" -gt '50' ]] && desc="${desc:1:50}"
    if [[ -e "/tmp/${descme}" ]]; then
        echo -e "\n#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=# ${blue}DESCRIPTION${end} #=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#"
        echo -e "${pink}Maintainer:${end}\t$maintainer"
        echo -e "${pink}Package:${end}\t$pkgname"
        echo -e "${pink}Version:${end}\t$version"
        echo -e "${pink}Build-Package:${end}\t$build"
        echo -e "${pink}Small Desc:${end}\t$desc"
        echo -e "#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#\n"
        # Variavel puxando de source...
        # Está variavel é importante se caso
        # o usuario passe um caminho completo do pacote exemplo:
        # plantpkg -i /tmp/packages/pacote-versao.mz ou
        # plantpkg -i /tmp/*.mz
        info_pack="${pkgname}-${version}-${build}"
        return 0 # Até aqui tudo bem! Podemos continuar com o processo de instalação.
    else
        echo -e "${red}[ERROR!]${end} Could not load /tmp/${descme}."
        echo "Archive not exist. ABORT!"
        return 1
    fi
}

# Verificando se pacote ja existe.
_PKG_EXIST()
{
    local unpack_temporary='/tmp'
    local dir_desc='/var/lib/banana/desc'

    # Descompactando temporariamente diretorio *info/* para
    # pegar o arquivo *desc* do pacote.
    if tar xmf "${pack}.${format_pkg}" -C "$unpack_temporary" "./${descme}"; then
        if [[ -e "${unpack_temporary}/${descme}" ]]; then
            if ! source ${unpack_temporary}/${descme}; then
                echo -e "${red}[Error!]${end} Could not find file ${blue}${unpack_temporary}/${desc_me}${end}"
                echo -e "This Archive is important for program verification. Aborting."
                exit 1
            else
                # Nome + versão do pacote que o usuario deu entrada.
                # Esta variavel vai servir para fazer comparação com a
                # Descrição temporária.
                info_pack="${pkgname}-${version}-${build}"
            fi
        fi
    fi
    # Verificando se o pacote ja existe... Se bater exatamente
    # com a descrição é sinal que ele não precisa atualizar ;)
    if [[ -e "${dir_desc}/${info_pack}.desc" ]]; then
        echo -e "${blue}[EXIST!]${end} ${info_pack} already Upgraded in the system."
        echo "No need update;)"
        return 0 # Voltamos para tocar a diante.
    fi

    pushd "$dir_desc" 1>/dev/null  # entrando no diretório /var/lib/banana/desc
    re="\b${pkgname}\b" # Aquela expressãozinha com borda ;)
    for p in *; do # puxando todos arquivos do diretório
        if [[ "$p" =~ ^${re}.* ]]; then # Pacote existe e é igual? vamos verificar a versão
            # corte o final .desc e deixe somente a versão
            version_package_exist="$(echo "$p" | cut -d '-' -f 2 | sed 's/\.desc//')"
            build_package_exist="$(echo "$p" | cut -d '-' -f 3 | sed 's/\.desc//')"
            # Vamos verificar se versão instalada é menor ou maior.
            compare=$(echo ${version_package_exist} ${version} | \
            awk '{ split($1, a, ".");
                   split($2, b, ".");
                   for (i = 1; i <= 4; i++)
                       if (a[i] < b[i]) {
                           x =-1;
                           break;
                       } else if (a[i] > b[i]) {
                           x = 1;
                           break;
                       }
                   print x;
                }'
            )
            # Verificando de versão OU build é igual ao o que o usuario quer atualizar.
            if [[ "$compare" = '-1' ]] || [[ "$build" -gt "$build_package_exist" ]]; then
                echo -e "Package Installed version:\t${blue}${pkgname}-${version_package_exist}-${build_package_exist}${end}"
                echo -e "Package you are installing:\t${blue}${pkgname}-${version}-${build}${end}"
                echo -e "\n${blue}[UPDATE]${end} Let's start updating! Wait.\n"
                popd 1>/dev/null # Retornando ao diretório aonde estava.
                _BURN "${pkgname}" # Removendo o pacote
                _PRE_CONF "$1"
                _PRE_INSTALL_PKG || exit 1
                _INSTALL_PKG || exit 1
            # Tudo igual?
            elif [[ "$compare" = '1' ]] || [[ "$build_package_exist" -eq "$build" ]]; then
                echo -e "${blue}[HIGHER!]\t${end} ${pink}${pkgname}-${version_package_exist}-${build_package_exist}${end} is in a higher version on your system"
                return 0
            else
                # Se o usuário que um downgrade do pacote, vish!
                echo -e "You trying to ${red}downgrade${end} with the parameter *upgrade* !"
                echo -e "Package Installed version:\t${blue}${pkgname}-${version_package_exist}-${build_package_exist}${end}"
                echo -e "Package you want to install:\t${blue}${pkgname}-${version}-${build}${end}"
                return 1
            fi
        fi
    done 
}

# Função para gerenciar alguns arquivos do pacote
# como *desc*, e script de pós instalação *pos.sh*
_MANAGE_ARCHIVES()
{
    echo -e "${blue}[UNZIPPED]${end}\tOK..."
    if [[ -e "/info/desc" ]]; then
          pushd "/info/" &>/dev/null
          if mv 'desc' "/var/lib/banana/desc/${info_pack}.desc"; then
              echo -e "${blue}[MOVED DESC]${end}\tto /var/lib/banana/${info_pack}.desc"
          else
              echo -e "${red}[ERROR!]${end} could not move desc to /var/lib/banana/${info_pack}.desc"
              echo "ABORTING..."
              return 1
          fi
    else
          echo -e "${red}[ERROR!]${end} /info/desc does not exist. ABORT!"
          return 1
    fi

    if [[ -e "pos.sh" ]]; then # pos.sh existe?
        echo -e "${blue}[Post-installation]${end}\tThe script pos.sh was found. Execute now!"
        bash "/info/pos.sh"
    fi

    if [[ -e "rm.sh" ]]; then # rm.sh existe?
        if mv 'rm.sh' "/var/lib/banana/remove/${info_pack}.rm"; then
            echo -e "${blue}[MOVED REMOVE]${end}\tto /var/lib/banana/remove/${info_pack}.rm"
        else
            echo -e "${red}[ERROR!]${end} could not move rm.sh to /var/lib/banana/remove/${info_pack}.rm"
            echo "ABORTING..."
            return 1
        fi
    fi

    # Retornando ao diretório de origem.
    popd &>/dev/null

    # Finalizando instalação.
    [[ -d "/info/" ]] && rm -r "/info/" # Apagando diretório /info/ na raiz.
    echo -e "${blue}[INSTALLED]${end}\tPackage ${info_pack}.${format_pkg} successfully installed."
    return 0
}

_INSTALL_PKG()
{
    # Lista de mensagens para exibir em cada nova instalação
    # de pacotes. Estas mensagens são exibidas aleatoriamente.
    dialog_daddy=(
        "Wait while Daddy works!"
        "I smoke, if I went to eat I would eat."
        "And here we go. Wait..."
        "Dad is going to work, he's coming!"
        "Daddy is tired but keeps working."
        "Wait baby... I install your package, and then we dance."
        "Did you want a daddy like me?"
        "Hello Mr. My name is Arnold, and I come from the future to install this package oO"
        "Daddy is written in Shell Script, OK? now i working..."
        "If one day I become a manager of high level I retire, Wait i Install package."
        "Diego likes plants."
        "Today I just want to install this package! Stop calling me"
        "U need more packages on your system. Daddy takes care of this."
        "I'm installing your package, please wait"
        "[Jeff Daniels]= Original drink for programmers."
        "Mari and Ruana is cool. ;P"
        "Come with me if you want to install package."
        "Rostros y bocas para usted.. :o =D :) :P ;e =~ :I"
        "The only road is UNIX."
        "This package is delicious. Dad will devour a pack."
        "Arrest the goblins. I need to work... Wait, i install your package."
        "Jeff hate the package."
        "La única salvación es la compilación y el empaquetado."
        "I am a packet intelligence =~)"
        "Zombies are attacking the city. I'll hurry to install the package. Wait."
        "If it were not easy, it would not have the least grace."
        "Package i choice you!"
        "Go eat popcorn. While I go here I strive to install the package for you."
        "Drunk?? No, thks. I need install a package."
        "Viva la sociedad de la compilación :O"
        "I feel the package being installed"
        "You and I are bananas."
        "Feel the package at the root. Please wait, I am installing the package."
        "Daddy likes UNIX-LIKE. Please wait I am installing the package."
        "A meteor is falling! Please wait while I install your package."
    )
    # Pegando o número de frases da lista.
    total_dialog_daddy=${#dialog_daddy[@]}
    # Gerando frase randomica.
    number=$(( $RANDOM % $total_dialog_daddy ))
    # Qual será a frase?
    msg_daddy="${dialog_daddy[$number]}"
    echo -e "${blue}${msg_daddy}${end}\n"
    # Vamos verificar se existe o script de pre instalação *pre.sh*
    # Se ele existir o programa deve executalo.
    if tar tf "${pack}.${format_pkg}" ./info/pre.sh &>/dev/null; then
        tmp_pack="/tmp/${pack}" # Var para criação de diretório temporário
        echo -e "${blue}[Pre-Installation]${end} The script pre.sh was found. Execute now!"
        mkdir "$tmp_pack" # Criando arquivo temporário para descompactar pacote
        if ! tar xmf "${pack}.${format_pkg}" -C $tmp_pack 1>/dev/null 2>&1; then
            return 1
        fi
        pushd "$tmp_pack" >/dev/null
        bash "info/pre.sh" # Executando script de pré-instalação pre.sh
        cp -rf * / # Enviando todos arquivos para a /
        _MANAGE_ARCHIVES && { popd >/dev/null; rm -r "${tmp_pack}";return 0 ;} || { popd >/dev/null; rm -r "${tmp_pack}"; return 1 ;}
    else
        # Caiu aqui pode continuar normal.
        if ! tar xmf "${pack}.${format_pkg}" -C / 1>/dev/null; then
            return 1
        else
            _MANAGE_ARCHIVES && return 0 || return 1
        fi  
    fi
}


#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#####################################################################
#
# CRIAR PACOTE
#
#####################################################################
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


# Função para verificação do diretório (info)
# e seus arquivos.
_VERIFY_ON()
{
    # Variaveis locais
    local dir_info='info'  # Diretorio info que contem informações como (desc)
    local info_desc='desc' # Descrição do pacote
    
    if [[ ! -d "$dir_info" ]]; then # Diretório info existe?
        echo -e "${red}[ERROR!]${end} ${pink}${dir_info}${end} directory\n"
        echo -e "It's necessary your package have the DIRECTORY ${pink}info${end}."
        echo -e "${pink}${dir_info}${end} its a directory store important archives."
        echo "For more information use -h, --help."
        exit 1
    elif [[ ! -e "${dir_info}/${info_desc}" ]]; then
        echo -e "${red}[ERROR!]${end} ${pink}${info_desc}${end} archive\n"
        echo -e "It's necessary your package have the ARCHIVE ${pink}desc${end} inside of directory '${dir_info}'."
        echo -e "${pink}${info_desc}${end} have informations of your package."
        echo "For more information use -h, --help."
        exit 1
    else
    # Se caiu aqui está tudo certo, vamo então conferir as variaveis do 'desc'
    # Se alguma variavel estiver nula não podemos continuar.
        source ${dir_info}/${info_desc} # Carregando arquivo.
        if [[ -z "$maintainer" ]]; then
            echo -e "Check ${pink}${info_desc}${end}, VARIABLE ${blue}maintainer${end} null"
            echo "Enter the name of the package maintainer into variable maintainer."
            exit 1
        elif [[ -z "$pkgname" ]]; then
            echo -e "Check ${pink}${info_desc}${end}, VARIABLE ${blue}pkgname${end} null"
            echo "Enter the name of the package into variable pkgname."
            exit 1
        elif [[ -z "$version" ]]; then
            echo -e "Check ${pink}${info_desc}${end}, VARIABLE ${blue}version${end} null"
            echo "Enter a version of software into variable version."
            exit 1
        elif [[ -z "$build" ]]; then
            echo -e "Check ${pink}${info_desc}${end}, VARIABLE ${blue}build${end} null"
            echo "Enter the build number of package."
            exit 1
        elif [[ -z "$desc" ]]; then
            echo -e "Check ${pink}${info_desc}${end}, VARIABLE ${blue}desc${end} null"
            echo "Detail a small description into variable desc."
            exit 1
        elif [[ -z "$url" ]]; then
            echo -e "Check ${pink}${info_desc}${end}, VARIABLE ${blue}url${end} null"
            echo "Enter a url of project/software into variable url."
            exit 1
        fi
        # Conferindo se o nome do pacote e versão batem com o que
        # o usuario passou em linha, se não bater não devemos continuar.
        if [[ "$pkgname" != "$(echo "$package" | cut -d '-' -f '1')" ]]; then
            echo -e "Check ${pink}${info_desc}${end}, VARIABLE ${blue}pkgname${end} it different"
            echo "of the name you entered as an argument. Check and return ;)"
            exit 1
        elif [[ "$version" != $(echo "$package" | cut -d '-' -f '2' | sed 's/\.mz//') ]]; then
            echo -e "Check ${pink}${info_desc}${end}, VARIABLE ${blue}version${end} it different"
            echo "of the version you entered as an argument. Check and return ;)"
            exit 1
        elif [[ "$build" != $(echo "$package" | cut -d '-' -f '3' | sed 's/\.mz//') ]]; then
            echo -e "Check ${pink}${info_desc}${end}, VARIABLE ${blue}build${end} it different"
            echo "of the version you entered as an argument. Check and return ;)"
            exit 1
        else
            echo -e "${blue}[CHECK VARIABLES]${end} OK."
            return 0
        fi
    fi # if principal
}

_LIST_ARCHIVES_DIRECTORIES()
{
    echo -e "${blue}[Create]${end} ${package}.list in temporary local: $temp_list"
    # Pegando todos arquivos que possui no diretório
    # menos os listados abaixo, isso implica em futuros erros.
    find .                        \
       \( ! -name info \)         \
      -print > "$temp_list"
}

# Função para fazer a limpa na (pacote).list
# Para ter a certeza absoluta que não haverá problemas ;)
# Se caso o arquivo ou diretório estiver solto ele será
# removido.
_CLEAN_LIST()
{
    echo -e "${cyan}[Clean]${end} List: $temp_list"
    # Apagando linhas desnecessárias na lista
    # E substituindo
    sed -i "
        s/^\.\///g
        s/^\///g
        /^\./d
        /^ *$/d
        /^var\/lib\/banana\/list\/.*\.list/d
        /^var\/lib$/d
        /^var\/lib\/banana/d
        /^var\/lib\/banana\/list/d
        /^var\/lib\/banana\/remove/d
        s|info\/desc|var\/lib\/banana\/desc\/${package}.desc|
        s|info\/rm.sh|var\/lib\/banana\/remove\/${package}.rm|
    " "$temp_list"
}

_CREATE_PKG()
{
    echo -e "${blue}[Create]${end} Now, create package for You! Wait..."
    if tar cvJf ../${package}.${format_pkg} . ; then
        echo -e "${blue}[Create]${end} Your Package on: ../${package}.${format_pkg}"
          # Voltando 1 diretório acima para fazer manipulação do pacote
          pushd .. &>/dev/null
          if sha256sum ${package}.${format_pkg} > ${package}.${format_pkg}.sha256; then
              echo -e "${blue}[Create]${end} Your sha256 on: ../${package}.${format_pkg}.sha256"
          else
              echo -e "${red}[Warning!]${end} No create ../${package}.${format_pkg}.sha256"
          fi
          popd &>/dev/null
    else
        echo -e "${red}[Error!]${end} No created package ../${package}.${format_pkg}"
        echo "This error is fatal, so the program will not proceed."
        exit 1
    fi
}

# Gera o arquivo desc de base, também se o diretório
# info não existir ele cria!
_GENERATE_DESC()
{
    [[ ! -d "info" ]] && mkdir info # diretorio info não existe? crie.
    cat > "info/desc" << 'EOF'
######################################################################
# This file is the heart of the package, it is necessary to do
# conferences, so it is important you add the information correctly.
# All variables are required! The array of dependencies *dep* does
# not, but it's interesting you add for future reference.
#
# !!!! USE SIMPLE QUOTES '' ONLY. !!!!
######################################################################

# Package Maintainer Name
maintainer=''

# Package Name
pkgname=''

# Software Version
version=''

# Build number
build=''

# SMALL Description of Software, NO Trespassing |
#=============RULER=====================================================|
desc=""
#=======================================================================|

# URL SOFTWARE
url=''

# What packages do your package need to run?
# This array is optional.
dep=('')
EOF
    echo -e "${pink}[DESC]${end} Created successfully inside of directory ${blue}info${end}"
    exit 0
}


#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#####################################################################
#
# PROCURAR PACOTE
#
#####################################################################
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

# Função para procurar pacote no sistema
_SEARCH_PKG()
{
    pushd "$dirdesc" &> /dev/null # Entrando no diretório aonde estão as desc ;)
    re="\b${inputsearch}\b"
    inc='0' # Var de incremento
    for searchpkg in *; do
        if [[ "$searchpkg" =~ ^${re}.*.desc ]]; then
            inc=$(( $inc + 1 )) # Incrementando
            source $searchpkg # Carregando informações do pacote para impressão.
            # Se variavel for maior que 1 não exibe a entrada de novo
            if [[ "$inc" -eq '1' ]]; then
                echo -e "#------------------------[ CARD ]----------------------------------------------#"
                echo -e "${cyan}[ PACKAGE ]${end}\t${pkgname}"
                echo -e "${cyan}[ VERSION ]${end}\t${version}"
                echo -e "${cyan}[  BUILD  ]${end}\t${build}"
                echo -e "${cyan}[   URL   ]${end}\t${url}"
                echo -e "${cyan}[   DEPS  ]${end}\t${dep[@]}"
                echo -e "${cyan}[   DESC  ]${end}\t${desc}\n"
            else
                echo -e "${cyan}[ PACKAGE ]${end}\t${pkgname}"
                echo -e "${cyan}[ VERSION ]${end}\t${version}"
                echo -e "${cyan}[  BUILD  ]${end}\t${build}"
                echo -e "${cyan}[   URL   ]${end}\t${url}"
                echo -e "${cyan}[   DEPS  ]${end}\t${dep[@]}"
                echo -e "${cyan}[   DESC  ]${end}\t${desc}\n"
            fi
        fi
    done
    [[ "$inc" -eq '0' ]] && { echo -e "No packages found with the name of: $inputsearch"; exit 1 ;}
}
