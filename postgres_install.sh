
#verificação  - colocar no final do código nas verificações

postgres)
    if verificar_docker_e_portainer; then

        ## INICIO TOKEN
        STACK_NAME="postgres"

        # Verificando se o token existe no arquivo
        if grep -q "Token: .\+" /root/dados_vps/dados_portainer; then
            ferramenta_postgresql_setup
        else
            # Se o token não existir, passa a variável para a função de setup
            APP_ORION="ferramenta_postgresql_setup"
            ferramenta_postgresql_setup
        fi
        ## FIM TOKEN

    fi   
    ;;

#função pra instação

ferramenta_postgresql_setup() {
    echo "Iniciando a configuração do PostgreSQL..."

     
    install_postgresql

    # Configurações específicas ou ações adicionais para o PostgreSQL
    echo "Configuração do PostgreSQL finalizada com sucesso!"
}

install_postgresql() {
    echo "Iniciando instalação do PostgreSQL..."

    # Baixando a imagem do PostgreSQL
    docker pull postgres:latest > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo "1/3 - [ OK ] - Baixando a imagem do PostgreSQL"
    else
        echo "1/3 - [ OFF ] - Erro ao baixar a imagem do PostgreSQL"
        echo "Verifique a conexão e tente novamente."
        return 1
    fi

    # Criando um container para o PostgreSQL
    echo "2/3 - [ OK ] - Criando o container PostgreSQL..."
    docker run --name postgres-container -e POSTGRES_PASSWORD=mysecretpassword -d -p 5432:5432 postgres > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo "2/3 - [ OK ] - Container do PostgreSQL criado com sucesso"
    else
        echo "2/3 - [ OFF ] - Erro ao criar o container do PostgreSQL"
        return 1
    fi

    docker ps | grep postgres > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo "3/3 - [ OK ] - PostgreSQL está rodando"
    else
        echo "3/3 - [ OFF ] - Erro ao verificar o container do PostgreSQL"
        echo "Verifique se o Docker está funcionando corretamente."
        return 1
    fi

    echo "PostgreSQL instalado e configurado com sucesso."
    sleep 2
}
