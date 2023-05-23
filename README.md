# google_search

A new Flutter project.

## Getting Started

Este projeto foi realizado de forma a consumir dados em uma pesquisa do google e mostra-los em um app.

Foi criado uma API em dart utilizando Shelf para auxiliar no processo, que esta no seguinte repositorio: 

- [google_search_api](https://github.com/carloshenrique-dev/google_search_api)

Para executar o projeto corretamente vc deve clonar o repositorio acima e executa-lo em seu pc.
Apos isso, vc deve clonar este repositorio, rodar o comando flutter pub get para o seu editor de codigo conseguir pegar todos as informacoes do projeto
e os packages utilizados para executar corretamente.
Feito isso, vc deve ir para o arquivo: 
  - api_repository_impl e alterar a seguinte linha: 
    - final url = Uri.parse('http://seu_ip:8080/search/$query');
    - Onde seu_ip deve ser substituido pelo seu ip :) (se estiver no windows basta usar o comando ipconfig no terminal e pegar o endereco de ipv4 e caso esteja no mac, ifconfig ou pegue nos ajustes na conexao de rede em que esta usando)
    - feito isso vc pode executar o projeto e realizar qualquer busca :) 
    
    - api_repository_test e alterar a seguinte linha: 
      - 'http://seu_ip:8080/search/query') 
      - e adicione seu ip tambem para que os testes funcionem corretamente, lembre-se a api deve estar rodando :)

OBS: Nao existe paginacao feita neste projeto devido a ser uma implementacao simples, entao vera em torno de 10 resultados para sua pesquisa na tela.

O projeto tem uso bem simples bastando clicar na caixa de texto e escrever o que deseja, e clicando na lupa ou em done no teclado do dispositivo vc consegue fazer a pesquisa.

Para a execucao dos testes basta ir no terminal com a pasta do projeto aberto e executar o comando: 
 - flutter test
