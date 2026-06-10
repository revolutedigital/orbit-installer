# Orbit Linux — i18n PT-BR do readymade.
#
# Princípios de tom (decisão Igor):
# 1. 2ª pessoa direta — "você" em vez de "Por favor, defina"
# 2. Linguagem do leigo — "Apagar o Windows" em vez de "Disco Inteiro"
# 3. Honestidade nos pontos críticos — avisar quando é irreversível, sem disfarçar
# 4. Marca "Gravidade/órbita" com moderação — só na boas-vindas e na conclusão
# 5. Sem "Por favor" / "favor" / tom de software empresarial
#
# Override sobre o po/pt-BR/readymade.ftl upstream da Fyra Labs.

# Navegação
prev = Voltar
next = Continuar

# OS detection
unknown-os = Sistema desconhecido

# Tipos de partição (mantidos próximos do upstream — termos técnicos)
parttype-root = Sistema de arquivos raiz ({ $path })
parttype-extendedboot = Partição extendida do carregador de inicialização ({ $path })
parttype-esp = Partição do Sistema EFI ({ $path })
parttype-home = Arquivos do usuário ({ $path })
parttype-var = Arquivos variáveis ({ $path })
parttype-other = Ponto de montagem personalizado

# Tela de boas-vindas — usa a marca "órbita" (1ª referência)
page-welcome = Bem-vindo ao { $distro }
page-welcome-desc = Você pode experimentar o { $distro } primeiro ou começar a instalação agora. Sem pressa.
page-welcome-try = Experimentar primeiro
page-welcome-install = Instalar agora
# v0.2.7: aviso alpha — versão atual só apaga disco inteiro.
page-welcome-alpha-warning = Esta versão alpha do { $distro } só instala APAGANDO o disco inteiro. Não tem opção pra manter o Windows ou outro sistema. Faça backup antes. Dual-boot chega na v0.3.

# Falha
page-failure = Algo deu errado
page-failure-close = Fechar
page-failure-bug = Reportar o problema

# Idioma
page-language = Idioma
page-language-search-lang = Procurar idioma…
page-language-next = Continuar

# Conclusão — usa a marca "órbita" (2ª referência, fechamento)
page-completed = Pronto
page-completed-desc =
    O { $distro } foi instalado.

    Antes de reiniciar, RETIRE o pendrive do USB. Se você reiniciar com ele plugado, vai abrir o instalador de novo em vez do seu { $distro } instalado.

    Quando reiniciar, você vai criar seu usuário e começar a usar.
# v0.2.7: gate "retirei o pendrive" — Reiniciar só fica clicável quando marcado.
page-completed-pendrive-check = Já retirei o pendrive do USB
page-completed-close = Fechar
page-completed-reboot = Reiniciar agora

# Destino do install
page-destination = Onde instalar
page-destination-scanning = Procurando discos
page-destination-wait = Aguardando o detector de sistemas…
page-destination-no-disk = Nenhum disco encontrado
page-destination-no-disk-desc = Não encontrei nenhum disco onde possa instalar o { $distro }.

# Dual boot
page-installdual = Lado a lado com outro sistema
page-installdual-otheros = Outro sistema

# Confirmação
page-confirmation = Confirmar
# v0.2.7: bloco vermelho + gate "digitar APAGAR" — última defesa contra perda de dados.
page-confirmation-erase-title = Vou apagar TUDO de { $disk }
page-confirmation-erase-desc =
    Toda foto, documento, programa, conta de Windows que tem aí dentro. Não dá pra desfazer depois que clicar.

    <b>Pra confirmar, digite a palavra APAGAR (em maiúsculas) abaixo.</b>
page-confirmation-erase-placeholder = digite: APAGAR
# Palavra-chave EXATA que o usuário precisa digitar. Manter em português pra
# obrigar leitura local. Em outras locales, traduzir.
page-confirmation-erase-keyword = APAGAR
page-confirmation-problem-device-mounted = { $dev } está em uso (montado em { $mountpoint }). Feche os programas que estão usando ele antes de continuar.
page-confirmation-problem-devblkopen =
    O disco <tt>{ $dev }</tt> está sendo usado por estes processos:
    <tt>{ $pids }</tt>
    Feche eles antes de continuar.

# Telas do instalador rodando
page-installation = Instalando
page-installation-welcome-desc = Conheça seu novo sistema.
page-installation-help = Precisa de ajuda?
page-installation-help-desc = Pergunta na nossa comunidade.
page-installation-contrib = Contribuir com o { $distro }
page-installation-contrib-desc = Veja como colaborar com seu tempo, suporte ou hardware.
page-installation-progress = Instalando o { $distro }…

# Particionamento customizado (público técnico — termos mais próximos do original)
page-installcustom = Configuração personalizada
page-installcustom-title = Partições e pontos de montagem
page-installcustom-desc =
    { $num } { $num ->
        [uma] definição
       *[outras] definições
    }
page-installcustom-tool = Abrir ferramenta de particionamento
page-installcustom-add = Adicionar definição

# Tipo de instalação — AQUI é onde precisa máxima clareza pro leigo
page-installationtype = Como instalar
page-installationtype-entire = Usar o disco todo (apaga tudo que tem nele)
page-installationtype-tpm = Ativar TPM
page-installationtype-encrypt = Criptografar o disco com senha
page-installationtype-chromebook = Chromebook
page-installationtype-dual = Instalar do lado do sistema atual
page-installationtype-custom = Configuração avançada (manual)

# Diálogos da criptografia
dialog-installtype-encrypt = Senha do disco criptografado
dialog-installtype-encrypt-desc =
    Defina uma senha pra criptografar o disco.
    Se você esquecer essa senha, seus arquivos vão se perder pra sempre. Não há como recuperar.
dialog-installtype-password = Senha
dialog-installtype-repeat = Confirme a senha
dialog-installtype-cancel = Cancelar
dialog-installtype-confirm = Confirmar

# Edição de pontos de montagem (técnico)
installtype-edit-mp = Mudar onde monta
installtype-rm-mp = Remover ponto de montagem
dialog-mp-part = Partição
dialog-mp-at = Montar em
dialog-mp-opts = Opções de montagem
installtype-parttool = Escolha sua ferramenta de particionamento

# Etapas da instalação (mostradas durante o install)
stage-extracting = Extraindo arquivos do { $distro }
stage-copying = Copiando o { $distro } pro disco
stage-mkpart = Preparando o disco e copiando o { $distro }
stage-initramfs = Preparando o sistema pra bootar
stage-grub = Configurando o boot
stage-grub1 = Configurando o boot (etapa 1)…
stage-grub2 = Configurando o boot (etapa 2)…
stage-biosgrub = Instalando o boot legado
stage-kernel = Reinstalando o núcleo do sistema
stage-selinux = Configurando segurança (SELinux)

# Erros
err-no-bios = Não é possível detectar UEFI nesta máquina, e o { $distro } não suporta BIOS legado.

# Aviso da partição EFI — CRÍTICO. Honestidade total: vai destruir outros sistemas.
dialog-confirm-warn-efipartfound-title = Já tem outro sistema instalado nesse disco
dialog-confirm-warn-efipartfound-desc =
    Atenção: encontrei uma partição EFI nesse disco. Isso normalmente significa que tem outro sistema instalado aqui (Windows, outro Linux).

    Se você continuar, eu vou apagar essa partição EFI. O outro sistema vai deixar de bootar. Isso não tem volta — você precisaria reinstalar o outro sistema do zero pra ele voltar a funcionar.

    Se você quer manter os dois sistemas, cancele agora e volte pra escolher "Instalar do lado do sistema atual".

# Manifesto de privacidade (adição Orbit Linux)
# Esta tela não oferece opção, é declaração. Privacidade no Orbit é inegociável.
page-privacy = Privacidade
page-privacy-title = Seus dados ficam aqui
page-privacy-desc-1 = O { $distro } aprende como você trabalha. Tudo o que ele aprende fica neste computador — nada vai pra nuvem, ninguém além de você vê.
page-privacy-desc-2 = Você pode auditar e apagar tudo o que o { $distro } aprendeu sobre você, a qualquer momento. Ao instalar, você reconhece que é assim que ele funciona.
page-privacy-accept = Entendi

# Cards da tela de instalação (slideshow Orbit, em vez de "Welcome/Help/Contribute")
# 3 mensagens-manifesto sobre o que torna o Orbit diferente.
bento-learn-title = Ele aprende. Você continua privado.
bento-learn-desc = O { $distro } se adapta ao seu jeito de trabalhar — e tudo o que ele aprende sobre você fica neste computador. Sem nuvem, sem telemetria.
bento-rollback-title = Ele não quebra sozinho.
bento-rollback-desc = Toda atualização do sistema é reversível. Se algo der errado, o { $distro } volta sozinho pro estado anterior. Você não vai perder trabalho por causa de update ruim.
bento-organize-title = Ele organiza por você.
bento-organize-desc = Abra editor, terminal e navegador — o { $distro } arruma eles do jeito que você precisa. Modo foco entra sozinho quando você está concentrado.
