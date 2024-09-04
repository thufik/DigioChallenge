# Rick & Morty API - Stone Challenge

Oii, dev! Aqui nesse projeto, você encontra uma chamada da API do Rick & Morty, puxando e apresentando os dados dos personagens. Bora entender como isso foi construído?

--------------
### Framework e Arquitetura
Para essa tarefa, foi usado o framework UIKit.
A arquitetura escolhida foi a MVVM (Model–view–viewmodel). Isso se deu pelos seus benefícios de manutenção (por conseguir entrar em partes menores e focadas e fazer alterações), facilidade de fazer testes unitários e o pouco acoplamento da camada lógica e de apresentação. 

--------------
### Chamadas de API
As chamadas foram feitas no arquivo "APIService", do tipo APIServiceProtocol, e as funções criadas usam o método do *completion handler*.
Nelas, eu coloco a URL que devo usar para fazer tal chamada específica, crio um requerimento do tipo "GET" e começo a chamada em si usando o *dataTask*. No caso de sucesso, salvo os dados na minha viewModel.

--------------
### Navegação com Coordinator
Toda a navegação do app foi feita usando Coordinators, tirando das controllers a função de chamar outras controllers. Isso traz o benefício de poder testar o fluxo do app e também a capacidade de reutilizar a controller em outras partes do código. 

---------------
### Telas
Para o desenvolvimento das telas, foi escolhido o **ViewCode**, uma vez que facilita o processo de manutenção e uniformidade do código. Abaixo, você encontra todas as telas desenvolvidas.
Aah... tem para light e dark mode!

1. Mostrando todos os personagens

<img src= "https://user-images.githubusercontent.com/49920539/208337436-7123b679-3507-4f1f-be50-c5a4590c038e.png" width="150" height="350">

2. Detalhes de cada personagem

<img src= "https://user-images.githubusercontent.com/49920539/208913306-6450f91e-a475-420c-b933-0049d96e02c5.png" width="150" height="350"> 

3. Tela de Filtro

<img src= "https://user-images.githubusercontent.com/49920539/208338093-a14b1c7b-bce7-4f84-9938-52665fc2a0f4.png" width="150" height="350"> 

---------------
### Suporte de rotação de tela
Todas as telas estão disponíveis tanto para a orientação de Portrait como Landscape. Isso foi possível com a criação das constraints de forma específica para cada orientação. 

<img src= "https://user-images.githubusercontent.com/49920539/208915800-8c9c45c9-d253-4f1e-bf03-e9bf9f3c33da.png" width="500" height="250"> 

----------------
### Testes Unitários
Para garantir ainda mais o funcionamento e qualidade do código, foram implementados alguns testes unitários usando a biblioteca XCTest. Entre eles, há testes dos fluxos do coordinator, da função de lidar com o status do personagem para o filtro, e dos sucessos e falhas das chamadas de API.

-----------------
### Dúvidas 
Em caso de dúvidas, podem entrar em contato comigo :)
