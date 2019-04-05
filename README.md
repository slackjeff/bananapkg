# bananapkg :banana: :package:
🇧🇷 Gerenciador de baixo nível escrito em Shell. <br/>
:us: Low level package manager written in Shell.<br/>

----

:heavy_check_mark: **Versão/Version:** 2.2.2 (05/04/2019)<br/>

----

🇧🇷 **Para uma melhor Documentação consulte** <br/>
:us: **For better Documentation see** <br/><br/>
https://bananapkg.github.io/

----

## DESENVOLVEDORES leia o Code-Style :ledger:
https://bananapkg.github.io/code-style.html

----

## Requisitos/Requirements :star:
**Bash** >= 4.4.18 <br/>
**GNU Sed** >= 4.2.2<br/>
**GNU Tar** >= 1.30<br/>
**AWK** >= 4.2.1<br/>
**xz** >= 5.2.2<br/>
**GPG** >= 2.2.9<br/>

----

## Instalação Direta / Direct Install :computer:
**Clone Repo**<br/>
git clone https://github.com/slackjeff/bananapkg<br/>
<br/>
**ON ROOT, Create a directories**<br/>
mkdir -vp /var/lib/banana/{list,desc,remove}<br/>
mkdir -v /etc/banana<br/>
mkdir -v /usr/libexec/banana<br/>
<br/>

**Copy archives**<br/>
cp -v banana /sbin/<br/>
cp -v banana.conf /etc/banana<br/>
cp -v {core,help}.sh /usr/libexec/banana<br/>
cp -v banana.8 /usr/share/man/pt_BR/man8/<br/>
*Enjoy ;)*

## Instalação Automática / Automatic Install :computer:
**Permission and Execute Script**<br>
chmod +x install.sh<br>
bash install.sh
