#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#
# MÓDULOS DE ENFEITES
#
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


# Módulo para imprimir mensagens aleatórias na tela!
_MSG_DADDY()
{
     local total_dialog_daddy number msg_daddy

    # Lista de mensagens para exibir em cada nova instalação
    # de pacotes. Estas mensagens são exibidas aleatoriamente.
    dialog_daddy=(
        "Wait while Daddy works!"
        "I smoke, if I went to eat I would eat."
        "And here we go. Wait..."
        "Only Shell Script Save your life."
        "In my mind, in my head, Packages."
        "Dad is going to work, he's coming!"
        "Daddy is tired but keeps working."
        "Packages Dream."
        "Wait baby... I install your package, and then we dance."
        "Did you want a daddy like me?"
        "rpm vs banana, banana wins"
        "Hello Mr. My name is Arnold, and I come from the future to install this package oO"
        "Daddy is written in Shell Script, OK? now i working..."
        "Sounds tell me that I'm more stable and simple than many other low-level managers. #Fight"
        "If one day I become a manager of high level I retire, Wait i Install package."
        "Diego likes plants."
        "OHHHH YEAAH, its ice :O"
        "UFC Tonight, banana vs dpkg."
        "Today I just want to install this package! Stop calling me"
        "U need more packages on your system. Daddy takes care of this."
        "I'm installing your package, please wait"
        "[Jeff Daniels]= Original drink for programmers."
        "The man the sold world, and i sold packages p.p"
        "Mari and Ruana is cool. ;P"
        "The daddy look you"
        "Package, u accept marry me? No!? Ok, remove now! MUAHAHAHAH"
        "Come with me if you want to install package."
        "Rostros y bocas para usted.. :o =D :) :P ;e =~ :I _^.^_"
        "The only road is UNIX."
        "A única frases em PT-BR é essa, Sinta-se orgulhoso papai."
        "This package is delicious. Dad will devour a pack."
        "Arrest the goblins. I need to work... Wait, i install your package."
        "Jeff love the packages."
        "Au au au? It's Dog? No! Banana Dog"
        "Hi! My name is Bá! Bá?... BÁnana."
        "Pkg is so fat, that if it were a Transformers it would be a goal ball."
        "La única salvación es la compilación y el empaquetado."
        "I am a packet intelligence =~)"
        "Hey UNIX, marry me."
        "Zombies are attacking the city. I'll hurry to install the package. Wait."
        "If it were not easy, it would not have the least grace."
        "Package i choice you!"
        "The Point G of package is a info/desc"
        "X-Men? No please, i am banana."
        "The Book On the Banana"
        "Ohhhhhhhhhh Floretina!"
        "Drinking three liters of water a day is soft, I want to see is to fill up your hd from .mz packages."
        "Go eat popcorn. While I go here I strive to install the package for you."
        "Drunk?? No, thks. I need install a package."
        "Go, Go, Go, Go? go, guo, gole google"
        "Viva la sociedad de la compilación :O"
        "Highway to Hell"
        "I feel the package being installed"
        "#bananapkg in silicon valley already."
        "La Revolution del Brazil"
        "Rich Package"
		    "1+1=Banana"
        "I see bananas! how often? All the time"
        "I never lost control baby *.*"
        "You and I are bananas."
        "Captain! The boat can not sink, pull the anchor and go packing"
        "Cheeseburger.mz Love it"
        "Luck day: You'll pack .mz, it every day"
        "Proerd is the program"
        "Welcome to the Jungle... Baby!"
        "It was for me to call myself orange, glad that banana is better"
        "Feel the package at the root. Please wait, I am installing the package."
        "Daddy likes UNIX-LIKE. Please wait I am installing the package."
        "Sweet banana dreams."
        "Pacient! ~:)"
        "Motorhead? Now is Motorbanana |,,|"
        "Version: Take me if you can :O"
        "Free Beer? OMG."
        "A meteor is falling! Please wait while I install your package."
		    "My temple is banana."
		    "Está é a segunda frase em português, se você é gringo não entenderá. MUAHAHAHA"
        "Mage Pack"
        "Keep it Simple, banana =)"
    )
    # Pegando o número de frases da lista.
    total_dialog_daddy=${#dialog_daddy[@]}
    # Gerando frase randomica.
    number=$(( $RANDOM % $total_dialog_daddy ))
    # Qual será a frase?
    msg_daddy="${dialog_daddy[$number]}"
    echo -e "${blue}${msg_daddy}${end}\n"
}


# Função de Spinner, para animação.
_SPINNER()
{
	local inc=0 # Var incremento
	local color="$cyan" # Cor inicial

	# O que vai ser mostrado?
    spin=(
    	'Banana wait.'
    	'bAnana wait.'
    	'baNana wait.'
    	'banAna wait.'
    	'banaNa wait.'
    	'bananA wait.'
    	'banana Wait.'
    	'banana wAit.'
    	'banana waIt.'
    	'banana waiT.'
    	'banana wait..'
    	'banana wait...'
    	'banana wait....'
    	'banana wait.....'
      'banana wait.....G'
      'banana wait.....gO'
      'banana wait.....go'
      'banana wait.....go '
      'banana wait.....go C'
      'banana wait.....go cO'
      'banana wait.....go coF'
      'banana wait.....go cofF'
      'banana wait.....go coffE'
    )
    
    while :; do
		# Cores aleatorias
		[[ "$inc" -gt '22' ]] && color="${red}"
		[[ "$inc" -gt '44' ]] && color="${blue}"
		[[ "$inc" -gt '66' ]] && color="${pink}"
		[[ "$inc" -gt '88' ]] && color="${yellow}"
		[[ "$inc" -gt '110' ]] && color="${white}"
		# Imprimindo
        for i in "${spin[@]}"; do
            echo -ne "${color}\r$i${end}"
			sleep 0.1s
			inc=$(($inc + 1))
        done
    done
}

#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#
# MÓDULOS EMULADOS PARA SE TORNAR BUILTINS
#
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

# Módulo para emular o comando cat
_CAT()
{
    # Tag para sinalizar que precisa parar.
    local end_of_file='EOF'
    
    INPUT=( "${@:-"%"}" )
    for i in "${INPUT[@]}"; do
        if [[ "$i" != "%" ]]; then
            exec 3< "$i" || exit 1
        else
            exec 3<&0
        fi
        while read -ru 3; do
            # END OF FILE. Para identificar que precisa parar.
            [[ "$REPLY" = "$end_of_file" ]] && break
            echo -E "$REPLY"
        done
    done
}

# Módulo para emular o grep
_GREP()
{
    # Se encontrar a linha ele retorna a expressão encontrada! com status 0
    # se não é status 1.
    # Para utilizar este módulo precisa ser passado o argumento seguido do arquivo.
    # ou variável.
    local expression="$1"
    local receive="$2"
    
    # Testando e buscando expressão.
    if [[ -z "$expression" ]]; then
        { echo 'MODULE _GREP ERROR. Not found variable $expression'; exit 1 ;}
    elif [[ -z "$receive" ]]; then
        { echo 'MODULE _GREP ERROR. Not found variable $receive'; exit 1 ;}
    fi
    while IFS= read line; do
        [[ "$line" =~ $expression ]] && { echo "$line"; return 0;}
    done < "$receive"
    return 1
}

# Módulo para emular o comando wc
# Está funcionando por enquanto somente para
# linhas.
_WC()
{
    local check="$@" # Recebendo args
    local inc='0'    # Var incremento
    
    for x in $check; do
        let inc++
    done
    echo "$inc"
    return 0
}


#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#
# MÓDULOS DE VERIFICAÇÕES
#
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


# Módulo para verificação de subshells =)
# importante para saber o exit code dos mesmos
_SUBSHELL_STATUS()
{
    [[ "$?" -ne '0' ]] && exit 1 || return 0
}


# Módulo de verifcação usado especialmente pelo banana em suas
# verificações de entrada
_INPUT_NULL_PARAMETER()
{
    [[ -z "$1" ]] && { "$HELP"; exit 1 ;}
}


# Módulo de conferencia da extensão da entrada
_NAME_FORMAT_PKG()
{
    local packname="$1"

    re="\b${format_pkg}\b"
    if ! [[ "$packname" =~ .*\.${re}$ ]]; then
        echo -e "${red}[ERROR]${end} Package need finish .${format_pkg}"
        return 1
    else
        return 0
    fi
}

# Módulo para gerenciar alguns arquivos do pacote
# como *desc*, e script de pós instalação *pos.sh*
_MANAGE_SCRIPTS_AND_ARCHIVES()
{
    local packname="${1/%.mz/}"
    local dir_desc="${dirlist/list/desc}"  
    
    if ! [[ -e "/info/desc" ]]; then
        echo -e "${red}[ERROR!]${end} /info/desc does not exist. ABORT!"
        exit 1
    fi

    pushd "/info/" &>/dev/null
    if mv 'desc' "/var/lib/banana/desc/${packname}.desc"; then
        echo -e "${blue}[MOVED DESC]${end}\t To /${dir_desc}/${packname}.desc"
    else
        echo -e "${red}[ERROR!]${end} could not move desc to /${dir_desc}/${packname}.desc"
        echo "ABORTING..."
        exit 1
    fi

    if [[ -e "pos.sh" ]]; then # pos.sh existe?
        echo -e "${blue}[Post-installation]${end}\tThe script pos.sh was found. Execute now!"
        bash "/info/pos.sh"
    fi

    if [[ -e "rm.sh" ]]; then # rm.sh existe?
        if mv 'rm.sh' "/var/lib/banana/remove/${packname}.rm"; then
            echo -e "${blue}[MOVED REMOVE]${end}\tto /var/lib/banana/remove/${packname}.rm"
        else
            echo -e "${red}[ERROR!]${end} could not move rm.sh to /var/lib/banana/remove/${packname}.rm"
            echo "ABORTING..."
            exit 1
        fi
    fi

    # Retornando ao diretório de origem.
    popd &>/dev/null

    # Finalizando instalação.
    [[ -d "/info/" ]] && rm -r "/info/" # Apagando diretório /info/ na raiz.
    echo -e "${blue}[INSTALLED]${end}\t Package $packname successfully installed."
    [[ -d '/tmp/info/' ]] && rm -r "/tmp/info/" # Removejdo sujeira
    return 0
}


#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#
# MÓDULOS DE CRIAÇÕES
#
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


# Módulo para criação de lista o pacote
_CREATE_LIST()
{
    # Variáveis locais
    local packname="$1"
    
    if ! tar tf "$packname" > "${dirlist}/${name_version_build}.list"; then
        echo -e "${red}[ERROR!]${end}\tNot Create ${dirlist}/${name_version_build}.list"
        return 1
    fi
    echo -e "${blue}[CREATE LIST]${end}\t On ${dirlist}/${name_version_build}.list"
    return 0    
}



# Módulo para Gerar o arquivo desc de base, também se o diretório
# info não existir ele cria!
_GENERATE_DESC()
{
    local DESC_PACKNAME="$1"
    local DESC_VERSION="$2"
    local DESC_BUILD="$3"
    
    [[ ! -d "info" ]] && mkdir info # diretorio info não existe? crie.
    _CAT > "info/desc" << EOF
######################################################################
# This file is the heart of the package, it is necessary to do
# conferences, so it is important you add the information correctly.
# All variables are required! The array of dependencies *dep* does
# not, but it's interesting you add for future reference.
######################################################################

# PACKAGE MAINTAINER NAME
maintainer="$MAINTAINER"

# PACKAGE NAME
pkgname='$DESC_PACKNAME'

# SOFTWARE VERSION
version='$DESC_VERSION'

# BUILD NUMBER
build='$DESC_BUILD'

# LICENSE OF SOFTWARE
license='$LICENSE'

# SMALL Description of Software, NO Trespassing |
#=============RULER=====================================================|
desc=""
#=======================================================================|

# URL SOFTWARE
url=''

# What packages do your package need to run?
dep=('')


#####################################################
# !!! Banana Infos, DONT EDIT!!!
#####################################################

BANANAVERSION="$VERSION"

EOF
    echo -e "${pink}[DESC]${end} Created successfully inside of directory ${blue}info${end}"
    exit 0
}


#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#####################################################################
#
# MÓDULOS PARA CRIAR PACOTE
#
#####################################################################
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


# Módulo para gerar assinatura gpg.
_GPG_SIGN()
{
    local package="$1"
    local sig='sig'
    
    # Pacote existe?
    if [[ ! -e "${package}.${format_pkg}" ]]; then
        echo "${red}[ERRO]${end} Unable to sign package. ${package}.${format_pkg}"
        echo "Reason: Package not found."
        echo "For security reasons, do not pass the package on to third parties."
        return 1
    fi
    
    # Gerando Assinatura no pacote
    gpg --detach-sign --pinentry-mode loopback "${package}.${format_pkg}" &>/dev/null || \
    gpg --detach-sign "${package}.${format_pkg}" || return 1
    echo -e "${blue}[Create]${end} Your ${sig} on:   ../${package}.${format_pkg}.${sig}"
    return 0
}


# Função para verificação do diretório (info)
# e seus arquivos.
_VERIFY_ON()
{
    local package="$1"

  ( # Subshell marota
    local dir_info='info'  # Diretorio info que contem informações como (desc)
    local info_desc='desc' # Descrição do pacote
    
    if [[ ! -d "$dir_info" ]]; then # Diretório info existe?
        echo -e "${red}[ERROR!]${end} ${pink}${dir_info}${end} directory\n"
        echo -e "It's necessary your package have the DIRECTORY ${pink}info${end}."
        echo -e "${pink}${dir_info}${end} its a directory store important archives."
        echo "For more information use -h, --help."
        exit 77
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
        fi
    fi # if principal

   # Verificando se rm -rf está presente em um dos scripts.
   for check_script in 'pre.sh' 'pos.sh' 'rm.sh'; do
       if [[ -e "${dir_info}/${check_script}" ]]; then
           if _GREP 'rm[[:space:]]+\-(rf|fr)' "${dir_info}/${check_script}"; then
               echo -e "${red}[CRAZY!]${end} $check_script contain command rm -rf. ABORTED NOW."
               exit 1
           fi
       fi
   done

 )
 
_SUBSHELL_STATUS
}

_LIST_ARCHIVES_DIRECTORIES()
{
    local packname="${1}.list"
    local LIST_CLEAN_DIRECTORIES
    
    echo -e "${cyan}[Clean]${end} List: ${dirlist}/${packname}"
    
    # Apagando coisas desnecessárias na lista e substituindo.
    sed -i "
        s/^\.\///g
        s/^\///g
        s|\/$||g
        /^\./d
        /^ *$/d
        /^bin$/d
        /^info$/d
        /^boot$/d
        /^dev$/d
        /^etc$/d
        /^home$/d
        /^lib$/d
        /^lib64$/d
        /^media$/d
        /^mnt$/d
        /^opt$/d
        /^proc$/d
        /^root$/d
        /^run$/d
        /^sbin$/d
        /^srv$/d
        /^sys$/d
        /^tmp$/d
        /^usr$/d
        /^var$/d
        /^info\/pos\.sh$/d
        /^info\/pre\.sh$/d
        /^info\/desc/d
        /info\/rm.sh/d
        /^var\/lib\/banana\/list\/.*\.list/d
        /^var\/lib$/d
        /^var\/lib\/banana/d
        /^var\/lib\/banana\/list/d
        /^var\/lib\/banana\/remove/d
    " "${dirlist}/${packname}"
    
    # Lista de diretórios para usar no loopzinho
    LIST_CLEAN_DIRECTORIES=(
        'var'
        'lib'
        'media'
        'usr'
        'usr/share'
		'srv'
    )
    # FIXME Essa parte não está tão boa e um algoritmo muito manual.
    # Basicamente ela remove toda hierarquia "vital" da lista
    # para evitar futuros furos e remoções na hora de remover o pacote.
    while read view; do
        if [[ "$view" =~ ^${LIST_CLEAN_DIRECTORIES[0]}/(cache|lib|local|lock|log|mail|opt|run|spool|tmp)$ ]]; then
            local view="${view//\//\\/}"
            sed -i "/^$view$/d" "${dirlist}/${packname}"
        elif [[ "$view" =~ ^${LIST_CLEAN_DIRECTORIES[1]}/(lib64)$ ]]; then
            local view="${view//\//\\/}"
            sed -i "/^$view$/d" "${dirlist}/${packname}"
        elif [[ "$view" =~ ^${LIST_CLEAN_DIRECTORIES[2]}/(cdrom|floppy)$ ]]; then
            local view="${view//\//\\/}"
            sed -i "/^$view$/d" "${dirlist}/${packname}"
        elif [[ "$view" =~ ^${LIST_CLEAN_DIRECTORIES[3]}/(bin|etc|lib|lib\/(pkgconfig)|local|share|doc|include|libexec|sbin|src)$ ]]; then
            local view="${view//\//\\/}"
            sed -i "/^$view$/d" "${dirlist}/${packname}"
        elif [[ "$view" =~ ^${LIST_CLEAN_DIRECTORIES[4]}/(keymaps|fonts|pixmaps|applications|doc|man|man\/man[[:digit:]]+|man\/.{2})$ ]]; then      
            local view="${view//\//\\/}"
            sed -i "/^$view$/d" "${dirlist}/${packname}"
		elif [[ "$view" =~ ^${LIST_CLEAN_DIRECTORIES[5]}/(www|httpd)$ ]]; then
			local view="${view//\//\\/}"
			sed -i "/^${view}$/d" "${dirlist}/${packname}"
        fi
    done < "${dirlist}/${packname}"
}


# Módulo para gerar o pacote
_CREATE_PKG()
{
    # Pegando somente nome do pacote
    # sem extensão
    local package="${1/%.mz/}"
    local ext_desc='desc'

    echo -e "${blue}[Create]${end} Now, create package for You! Wait..."

    # Criação do pacote, sem compressão.
    if tar cf ../${package}.${format_pkg} .; then
        echo -e "${blue}[Create]${end} Your Package on: ../${package}.${format_pkg}"
        cp "$descme" ../${package}.${format_pkg}.${ext_desc} &>/dev/null
        echo -e "${blue}[Create]${end} Your .${ext_desc} on:   ../${package}.${format_pkg}.${ext_desc}"
        # Voltando 1 diretório acima para fazer manipulação do pacote
        pushd .. &>/dev/null
        if sha256sum ${package}.${format_pkg} > ${package}.${format_pkg}.sha256; then
            echo -e "${blue}[Create]${end} Your sha256 on: ../${package}.${format_pkg}.sha256"
        else
            echo -e "${red}[Warning!]${end} No create ../${package}.${format_pkg}.sha256"
        fi
        # Assinatura GPG está ativada?
        if [[ "$GPG_SIGN" = '1' ]]; then
            _GPG_SIGN "${package}" || return 1 # Assinatura gpg
            popd &>/dev/null
        else
            return 0
        fi
    else
        echo -e "${red}[Error!]${end} No created package ../${package}.${format_pkg}"
        echo "This error is fatal, so the program will not proceed."
        exit 1
    fi
}


#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#####################################################################
#
# INSTALAR E ATUALIZAR
#
#####################################################################
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


_INSTALL_PKG()
{
  ( # Subshell Suicide
    local packname="$1"
    local name_version_build tmp_pack
    local tmp_pack
    local PRE_SH='pre.sh'

    # Chamando Animação e pegando PID do processo.
    _SPINNER &
    pid=$!
    
    # Descompactando desc primeiro para exibir informações do pacote.
    # e carregando o arquivo desc do programa ;)
    if ! tar xf "${packname}" -C "/tmp/" "./${descme}"; then
        echo -e "${red}[ERROR!]${end} I could not unzip the file desc."
        { kill $pid; wait $pid 2>/dev/null; echo ;}
        return 1
    fi
    source "/tmp/${descme}" || { echo -e "${red}[ERROR!]${end} Not load ${descme}, ABORT."; return 1 ;}
    if [[ ! -e "/tmp/${descme}" ]]; then
        echo -e "${red}[ERROR!]${end} Could not load /tmp/${descme}."
        echo "Archive not exist. ABORT!"
        { kill $pid; wait $pid 2>/dev/null; echo ;}
        return 1
    fi
    
    { kill $pid; wait $pid 2>/dev/null; echo ;}
    
    
    # Variavel puxando de source...
    # Está variavel é importante se caso
    # o usuario passe um caminho completo do pacote exemplo:
    # plantpkg -i /tmp/packages/pacote-versao.mz ou
    # plantpkg -i /tmp/*.mz
    name_version_build="${pkgname}-${version}-${build}"

    # Que beleza, deu tudo certo e vamos imprimir a descrição =)
    echo -e "\n#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=# ${blue}INSTALL${end} #=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#"
    echo -e "${pink}Maintainer:${end}\t$maintainer"
    echo -e "${pink}Package:${end}\t$pkgname"
    echo -e "${pink}Version:${end}\t$version"
    echo -e "${pink}Build-Package:${end}\t$build"
    echo -e "${pink}License:${end}\t${license:-Null}"
    echo -e "${pink}Small Desc:${end}\t$desc"
    echo -e "#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#=#\n"
    
   _MSG_DADDY # Mensagem aleátoria do pai! para exibir para o usuário

   # Vamos verificar se existe o script de pre instalação *pre.sh*
   # Se ele existir o programa deve executalo.
   if tar tf "${packname}" "./info/$PRE_SH" &>/dev/null; then
        if tar -xf "$packname" -C /tmp "./info/$PRE_SH" &>/dev/null; then
            echo -e "${blue}[Pre-Installation]${end} The script pre.sh was found. Execute now!"
        else
            echo -e "${red}[Pre-Installation]${end} Cannot extract ${PRE_SH}, ABORT"
            return 1
        fi  
        bash "/tmp/info/$PRE_SH"
        tar xf "${packname}" -C / || return 1
        echo -e "${blue}[EXTRACT]${end}\t On Your root, OK."
        _CREATE_LIST "$1" || return 1 # Criando lista
        _MANAGE_SCRIPTS_AND_ARCHIVES "${name_version_build}" || return 1
    else
        # Caiu aqui pode continuar normal.
        tar xf "${packname}" -C /
        echo -e "${blue}[EXTRACT]${end}\t On Your root, OK."
        _CREATE_LIST "$1" || return 1 # Criando lista
        _MANAGE_SCRIPTS_AND_ARCHIVES "${name_version_build}" || return 1
    fi
    
    # Ajustando lista.
    _LIST_ARCHIVES_DIRECTORIES "${name_version_build}"
 ) # Fim da subshell suicide
 
_SUBSHELL_STATUS
}



# Módulo que faz atualização do pacote.
_UPGRADE()
{
  ( # Subshell Meu precioso
    local packname="$1"
    local unpack_temporary='/tmp'
    local dir_desc='/var/lib/banana/desc'
    local jj p compare build_package_exist version_package_exist remove_old_version_pkg

    # Descompactando temporariamente diretorio *info/* para
    # pegar o arquivo *desc* do pacote.
    if tar xpmf "${packname}" -C "$unpack_temporary" "./${descme}"; then
        if [[ -e "${unpack_temporary}/${descme}" ]]; then
            if ! source ${unpack_temporary}/${descme}; then
                echo -e "${red}[Error!]${end} Could not find file ${blue}${unpack_temporary}/${desc_me}${end}"
                echo -e "This Archive is important for program verification. Aborting."
                exit 1
            fi
        fi
    fi

    # Verificando se o pacote ja existe... Se bater exatamente
    # com a descrição é sinal que ele não precisa atualizar ;)
    if [[ -e "${dir_desc}/${pkgname}-${version}-${build}.desc" ]]; then
        echo -e "${blue}[LAST VERSION!]${end} ${packname} already Upgraded in the system."
        echo "No need update;)"
        return 0 # Voltamos para tocar a diante.
    fi

    pushd "$dir_desc" &>/dev/null  # entrando no diretório /var/lib/banana/desc
    jj='0' # Var Incremento
    local re="\b${pkgname}\b" # Aquela expressãozinha com borda ;)
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
                remove_old_version_pkg="${pkgname}-${version_package_exist}-${build_package_exist}"
                echo -e "Package Installed version:\t${blue}${pkgname}-${version_package_exist}-${build_package_exist}${end}"
                echo -e "Package you are installing:\t${blue}${pkgname}-${version}-${build}${end}"
                echo -e "\n${blue}[UPDATE]${end} Let's start updating! Wait.\n"
                popd 1>/dev/null # Retornando ao diretório aonde estava.
                _PRE_REMOVE "${remove_old_version_pkg}" || exit 1
                _INSTALL_PKG "$1" && return 0 || exit 1
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
        else
            jj="$(( $jj + 1 ))" # Se não existir ela incrementa ;)
        fi
    done
    local packname="${packname/%.mz/}" # Cortando extensão para imprimir certinho.
    [[ "$jj" -gt '0' ]] && { echo -e "${red}[NOT FOUND]${end} ${packname} in system for upgrade."; return 1 ;}
  ) # FIm da subshell meu precioso
  _SUBSHELL_STATUS
}


#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#
# REMOVER PACOTE
#
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


# Módulo para fazer as conferencias antes da chamada do burn
_PRE_REMOVE()
{
  ( # Fazendo tudo em subshell para não sujar outros ambientes com o source.
    local packname="$1"
    local re="\b${packname}\b"
    local inc=0 # Incremento para existencia de pacote
    local count_occurrences=0 # Incremento de quantos pacotes existem com o mesmo nome
    local search_pack

    pushd "$dirdesc" 1>/dev/null
    for search_pack in *; do
        if [[ "$search_pack" =~ ^${re}.* ]]; then # Pacote existe?
            for q in *; do # Checando quantas ocorrencias existem.
                if [[ "$q" =~ ^${re}.* ]]; then
                    # Se existir varios pacotes com o mesmo nome incremente!
                    count_occurrences="$(( $count_occurrences + 1 ))"
                fi
            done
             # se caso o pacote tem mais de uma versão no sistema.
             source ${search_pack}
             # Variavel para vericação nome + versão + build
             local name_version_build="${pkgname}-${version}-${build}"
             if [[ "${name_version_build}.desc" =~ ^${re}.desc ]] || \
                [[ "${name_version_build}.desc" =~ ^${re}.* && "$count_occurrences" -eq '1' ]] ; then

                 echo -e "\n##################################### ${red}REMOVE${end} #####################################"
                 echo -e "${blue}PACKAGE:${end}\t${pkgname}"
                 echo -e "${blue}VERSION:${end}\t${version}"
                 echo -e "${blue}BUILD-PACK:${end}\t${build}"
                 echo -e "${blue}DESCRIPTION:${end}\t${desc}"
                 echo -e "##################################################################################\n"
                 [[ "$AUTO_YES" = '1' ]] && auto_confirm='y'
                 if [[ -z "$auto_confirm" ]] || [[ "$auto_confirm" != 'y' ]]; then # se ter -y é auto confirmar ;)
                     # Confirmando se usuário quer apagar
                     echo -e "${red}[REMOVE]${end} ${pkgname}-${version}-${build} ${red}package, do you want to continue?${end}"
                     read -p "Remove [Y/n]: " confirm
                     confirm=${confirm,,}  # Tudo em minusculo
                     confirm=${confirm:=y} # Apertou enter retorna yes.
                     [[ "$confirm" != 'y' ]] && return 0
                     pushd "${dirlist}" 1>/dev/null # Entrando no diretório das listas /var/lib/banana/list
                     search_pack="${search_pack/%.desc/.list}" # se terminar com .desc substitua por .list
                     # tudo certo retornamos ;)
                     [[ -e "${search_pack}" ]] && { _REMOVE_NOW "$name_version_build"; return 0 ;}  || return 1
                 else
                     pushd "${dirlist}" 1>/dev/null # Entrando no diretório das listas /var/lib/banana/list
                     search_pack="${search_pack/%.desc/.list}" # se terminar com .desc substitua por .list
                     # Chamada função para remoção.
                     [[ -e "${search_pack}" ]] && { _REMOVE_NOW "$name_version_build"; return 0 ;} || return 1
                 fi
             else
                 # Caiu aqui? Então existe mais de um pacote com o mesmo nome
                 # porém com versões diferente...
                 # O programa não pode fazer nada, apenas alertar.
                 search_pack="${search_pack/%.desc/}" # Cortando para impressão.
                 echo -e "${red}[FOUND]${end} $search_pack"
                 continue
             
             fi
        else
            inc="$(( $inc + 1 ))"
        fi
    done

    # Não existe o pacote no sistema
    [[ "$inc" -gt '0' ]] && { echo -e "${red}[NOT FOUND]${end} ${packname}"; return 1 ;}
 ) # Fechando subshell
 _SUBSHELL_STATUS
}


# Módulo para remoção
_REMOVE_NOW()
{
    local packname="${1/%.mz/}"
    local a='0' # Variavel incremento arquivos
    local d='0' # Variavel incremento diretorios vazios
    local l='0' # Variavel incremento link simbólico
    local archive

    [[ -z "$name_version_build" ]] && { echo -e "${red}[ERROR]${end} Variable 'name_version_build' NULL. ABORT"; exit 1 ;}
    pushd "/" &>/dev/null

    # Se existir o script rm.sh que é um script que precisa ser executado antes
    # de tudo, ele será executado.
    if [[ -e "${dirremove}/${packname}.rm" ]]; then
        echo -e "\n${blue}[EXECUTE]${end}\tThe script rm.sh was found. Execute now!"
        # Removendo rm -rf se existir para não ter problemas =)
        sed -E "/rm[[:space:]]+\-(rf|fr)/d" "${dirremove}/${packname}.rm" &>/dev/null
        bash "${dirremove}/${packname}.rm" && echo -e "${cyan}[SCRIPT]${end}\tThe script was well executed =)\n"
        # Removendo script pacote.rm em /var/lib/banana/remove/
        if [[ -e "${dirremove}/${packname}.rm" ]]; then
            rm "${dirremove}/${packname}.rm" && echo -e "${blue}[REMOVED]${end}\t${packname}.rm\n"
        fi
    fi    

    ###########################
    # Removendo:
    # Arquivos normais
    # Links simbólicos
    # Diretórios vazios
    ###########################
    
    while IFS= read thefile; do
        if [[ -f "$thefile" ]]; then
            rm "$thefile" &>/dev/null && echo -e "Delete\t${thefile}"
        fi
    done < "${dirlist}/${packname}.list"

    # Tirando todo conteudo da var para ser reaproveitada
    unset archive

   # Removendo links simbólicos
    while IFS= read thelink; do
       if [[ -L "$thelink" ]]; then
             unlink "$thelink" &>/dev/null && echo -e "Delete\t${thelink}"
       fi
    done < "${dirlist}/${packname}.list"

    # Tirando todo conteudo da var para ser reaproveitada
    unset archive

    # Removendo diretórios vazios, e forçando para
    # toda hierarquia do pacote seja removido.
        while IFS= read thedir; do
            if [[ -d "$thedir" ]] && [[ -z "$(ls -A ${thedir})" ]]; then 
                  rmdir -p "${thedir}" &>/dev/null && echo -e "Delete\t${thedir}"
            fi
    done < "${dirlist}/${packname}.list"
    
    echo -e "\nClean archives .desc and .list\n"

    # Removendo lista e Descrição
    for removeitem in "desc" "list"; do
        case $removeitem in
            desc)   DIREC="$dirdesc";;
            list)   DIREC="$dirlist";;
        esac
        if [[ -e "${DIREC}/${packname}.${removeitem}" ]]; then
            if rm "${DIREC}/${packname}.${removeitem}"; then 
                echo -e "${blue}[REMOVE]${end} ${DIREC}/${packname}.${removeitem} SUCCESSFULLY"
            else
                echo -e "\n${red}[ERROR]${end} It was not possible remove ${DIREC}/${packname}.list"
                exit 1
            fi
        else
            continue
        fi
    done

    popd &>/dev/null
    return 0
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
  ( #Subshell do destino
    local packname="$1"
    local re="\b${packname}\b"
    local inc='0' # Var de incremento

    pushd "$dirdesc" &> /dev/null # Entrando no diretório aonde estão as desc ;)
    for searchpkg in *; do
        if [[ "$searchpkg" =~ ${re} ]] && [[ -z "$ONE_LINE"  ]]; then
            inc=$(( $inc + 1 )) # Incrementando
            source $searchpkg # Carregando informações do pacote para impressão.
            # Se variavel for maior que 1 não exibe a entrada de novo
                echo -e "#------------------------[ FOUND ]----------------------------------------------#"
                echo -e "${cyan}[ PACKAGE ]${end}\t${pkgname}"
                echo -e "${cyan}[ VERSION ]${end}\t${version}"
                echo -e "${cyan}[ BUILD   ]${end}\t${build}"
                echo -e "${cyan}[ URL     ]${end}\t${url}"
                echo -e "${cyan}[ DEPS    ]${end}\t${dep[@]}"
                echo -e "${cyan}[ DESC    ]${end}\t${desc}\n"
        elif [[ "$searchpkg" =~ ${re} ]] && [[ "$ONE_LINE" = '1' ]]; then
            inc=$(( $inc + 1 )) # Incrementando
            source $searchpkg # Carregando informações do pacote para impressão.
            echo -e "${cyan}[FOUND]${end} ${pkgname}-${version}-${build}"       
        fi
    done
    if [[ "$inc" -eq '0' ]]; then
        echo -e "No packages found with the name of: $packname"
        exit 1
    else
        exit 0
    fi
 ) # Fim subshell do destino
 _SUBSHELL_STATUS
}


#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#####################################################################
#
# IMPRIMIR LISTA DO PACOTE INSTALADO
#
#####################################################################
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


# Módulo de impressão de lista do pacote instalado
_PRINT_LIST(){
    local package_="$1"
    local re="\b$package_\b"
    local searchlist

    pushd "/${dirlist}" &>/dev/null
    for searchlist in *; do
        if [[ "$searchlist" =~ ^${re} ]]; then
            echo -e "==========================$searchlist=========================="
            _CAT "$searchlist"
            return 0
        fi
    done
    echo -e "${package_} ${red}[NOT FOUND]${end}"
    return 1
}


#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#####################################################################
#
# ATUALIZAR VERSÃO BANANAPKG
#
#####################################################################
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


_UPDATE_BANANA()
{
    local link='https://github.com/slackjeff/bananapkg'
    local check_url='www.stallman.org'
    local tmp_dir_banana="/tmp/${PRG}pkg"
    local DOWNLOAD m
    
    # Curl está no sistema?
    type -P curl &>/dev/null && CHECK_CONNECTION='ping -c 1' || CHECK_CONNECTION='wget -q --spider'
    $CHECK_CONNECTION "$check_url" &>/dev/null || { echo "Don't Have Internet. ABORTED."; return 1 ;}
    echo -e "Internet\t${cyan}[OK]${end}"
    
    # Ok, Puxe o repositorio agora!
    pushd /tmp &>/dev/null
    git clone "$link"
    pushd "${tmp_dir_banana}" &>/dev/null
    
    # Dando permissões e copiando arquivos para seus lugares.
    echo -e "\nPermission and Copy archives\n"
    for m in "${PRG}.conf" "${PRG}.8" 'core.sh' 'help.sh' 'builtin.sh' "$PRG"; do
        [[ -e "$m" ]] && [[ "$m" != "core.sh" ]] && chmod +x $m
        case $m in
            (banana) cp -v "$m" "/sbin/" || return 1 ;;
            (banana.8)
                [[ ! -d '/usr/share/man/pt_BR/man8/' ]] && mkdir -v /usr/share/man/pt_BR/man8/
                cp -v "$m" '/usr/share/man/pt_BR/man8/' || return 1
             ;;
            (banana.conf)
                read -p "Do you want to overwrite your configuration file? [y/N]" answer
                answer="${answer,,}" # Tudo em minusculo
                answer="${answer:=n}"
                if [[ "$answer" = 'y' ]]; then
                    cp -v "$m" "/etc/banana/" || return 1
                else
                    continue
                fi
             ;;
             (core.sh|help.sh) cp -v "$m" "/usr/libexec/banana/" || return 1 ;;
        esac
    done
    
    [[ -d "${tmp_dir_banana}" ]] && rm -r "${tmp_dir_banana}"
}
