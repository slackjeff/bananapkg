# bananapkg :banana: :package:
🇧🇷 Gerenciador de baixo nível escrito em Shell. <br/>
:us: Low level package manager written in Shell.<br/>

:heavy_check_mark: **Versão/Version:** 2.1.4 (2018/02/13)<br/>

----

🇧🇷 **Para uma melhor Documentação consulte** <br/>
:us: **For better Documentation see** <br/><br/>
https://bananapkg.github.io/

----

## Requisitos/Requirements
**Bash** >= 4.4.18 <br/>
**GNU Sed** >= 4.2.2<br/>
**GNU Tar** >= 1.30<br/>
**xz** >= 5.2.2<br/>

----

## Instalação Direta / Direct Install
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
cp -v {core,help}.sh /usr/libexec/banana
<br/>
*Enjoy ;)*

## Instalação Automática / Automatic Install
**Permission and Execute Script**<br>
chmod +x install.sh<br>
bash install.sh
