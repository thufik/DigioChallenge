# DigioChallenge

Bem-vindo ao projeto DigioChallenge. Aqui, você encontrará uma aplicação que faz chamadas a uma API pública da Digio. Vamos entender como isso foi construído?

--------------
### Framework e Arquitetura
Para essa tarefa, foi usado o framework UIKit.
A arquitetura escolhida foi a Clean Swift com Coordinator. Isso se deu pelos seus benefícios de manutenção (por conseguir entrar em partes menores e focadas e fazer alterações), facilidade de fazer testes unitários e o pouco acoplamento da camada lógica e de apresentação.

--------------
### XcodeGen
Este projeto utiliza **XcodeGen** para gerar o arquivo do projeto Xcode. Para configurar o projeto, você precisa rodar o seguinte comando na pasta do projeto:

```bash
xcodegen
```

--------------
### Chamadas de API
As chamadas foram feitas no arquivo "APIService", do tipo APIServiceProtocol, e as funções criadas usam o método do *completion handler*. Nelas, eu coloco a URL que devo usar para fazer tal chamada específica, crio um requerimento do tipo "GET" e começo a chamada em si usando o *dataTask*.

--------------
### Navegação com Coordinator
Toda a navegação do app foi feita usando Coordinators, tirando das controllers a função de chamar outras controllers. Isso traz o benefício de poder testar o fluxo do app e também a capacidade de reutilizar a controller em outras partes do código.

---------------
### Telas
Para o desenvolvimento das telas, foi escolhido o **ViewCode**, uma vez que facilita o processo de manutenção e uniformidade do código. Abaixo, você encontra todas as telas desenvolvidas.

1. Tela Home

<img src="https://github.com/thufik/DigioChallenge/blob/master/home-screen.png" width="150" height="350">

2. Tela de Detalhes

<img src="https://github.com/thufik/DigioChallenge/blob/master/details-screen.png" width="150" height="350">

----------------
### Testes Unitários e de Snapshot
Para garantir ainda mais o funcionamento e qualidade do código, foram implementados testes unitários usando a biblioteca XCTest e testes de snapshot. Entre eles, há testes de snapshot, testes de interactor e testes de presenter.

-----------------
### Script de Instalação de Templates
O projeto conta com um script `install_templates.sh` para configurar os templates necessários. Caso o script não funcione, você pode criar manualmente a pasta `Templates` no caminho `Library/Developer/Xcode/` usando o comando:

```bash
mkdir -p ~/Library/Developer/Xcode/Templates
```

-----------------
### Dúvidas 
Em caso de dúvidas, podem entrar em contato comigo :)
```

### Considerações Finais

- **XcodeGen**: Certifique-se de ter o XcodeGen instalado antes de rodar o comando `xcodegen`.
- **Scripts**: Verifique se o script `install_templates.sh` tem permissões de execução (`chmod +x install_templates.sh`).

Se precisar de mais alguma coisa ou tiver dúvidas adicionais, estou à disposição para ajudar!
