# bananapkg :banana: :package: 🇧🇷 [![Bash4.4.18-shield]](http://tldp.org/LDP/abs/html/bashver4.html#AEN21220) [![LICENSE](https://img.shields.io/badge/Licen%C3%A7a-MIT-brightgreen.svg)](https://github.com/slackjeff/bananapkg/blob/master/LICENSE) [![Doe-shield]](https://slackjeff.com.br/doacao/)

> Gerenciador de Pacotes de baixo nível, escrito em Shell Bash.
 
![Banner]

### Para uma melhor Documentação consulte
* [Site Oficial](https://bananapkg.github.io/)

### DESENVOLVEDORES: leiam o Code-Style :ledger:
* [Code Style](https://bananapkg.github.io/code-style.html)

### Requisitos/Requirements :star:
* **Bash** >= 4.4.18 <br/>
* **GNU Sed** >= 4.2.2<br/>
* **GNU Tar** >= 1.30<br/>
* **AWK** >= 4.2.1<br/>
* **xz** >= 5.2.2<br/>
* **GPG** >= 2.2.9<br/>

### Distribuições que usam o Banana com principal gerenciador :heart:
* [MazonOS](http://mazonos.com/pt)

----

### Instalação Direta :computer:
**Clone o Repositório**
```bash
git clone https://github.com/slackjeff/bananapkg
```

**Como ROOT, crie os diretórios**
```bash
mkdir -vp /var/lib/banana/{list,desc,remove}
mkdir -v /etc/banana
mkdir -v /usr/libexec/banana
```

**Copie os arquivos**
```bash
cp -v banana /sbin/
cp -v banana.conf /etc/banana
cp -v {core,help}.sh /usr/libexec/banana
cp -v banana.8 /usr/share/man/pt_BR/man8/
```
*Enjoy ;)*

## Instalação Automática :computer:
**Conceda permissões e execute o script**
```bash
chmod +x install.sh
bash install.sh
```

[Banner]: https://raw.githubusercontent.com/slackjeff/bananapkg/master/imgs/banners/bananabanner.png
[Bash4.4.18-shield]: https://img.shields.io/badge/Bash-4.4.18%2B-brightgreen.svg "Bash 4.4.18 Ou superior"
[Doe-shield]: https://img.shields.io/badge/Doe-Pagseguro-red.svg
