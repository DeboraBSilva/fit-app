## Desafio Semana 12 - App de Exercícios

O desafio dessa semana será a criação de uma aplicação de exercícios físicos com cadastro e log-in utilizando a gem de autenticação `Devise`.

A aplicação deverá possibilitar a criação de exercícios físicos, que poderão ser agrupados em uma rotina.
- Usuários que estão logados podem criar exercícios e rotinas; rotinas são um conjunto de exercícios. **apenas usuários logados podem criar exercícios e rotinas**
- **Não** precisa estar logado para poder visualizar as rotinas


## Etapa Inicial: 
Criar um novo projeto utilizando o comando `rails new nome_do_projeto`

## Tarefa 1: Setup Inicial de autenticação utilizando a gem `devise`
- Instalar a gem [devise](https://github.com/heartcombo/devise)
	- Criar a modelagem de dados:
		- Usuário (Ver como criar na seção Usuário)
		- Exercício
			- Descrição: obrigatório
			- Intensidade: obrigatório (integer de 0 a 10)
			- Pertence a uma ou mais rotinas	
		- Rotina
			- Nome
			- Possui um ou mais exercícios
	- **não esquecer de adicionar testes automatizados**

- Criar os formulários de criação de exercícios e de rotinas
	- O usuário precisa estar autorizado para acessar essas páginas
- Criar a tela de visualização de rotinas
	- Todos podem visualizar essa página

### Usuário
- Criar o model utilizando o gerador do `devise`
- O gerador da gem irá criar todos os campos necessários para autenticação, como e-mail, senha, timestamps, etc.
	- Também adicionar na tabela de usuários o atributo `jwt_key` como uma string. Ele será utilizado na tarefa 3

## Tarefa 2: Implementar features adicionais do `devise`
- Implementar autenticação com os seguintes módulos opcionais: [Validatable](https://www.rubydoc.info/github/heartcombo/devise/master/Devise/Models/Validatable),  [Confirmable](https://www.rubydoc.info/github/heartcombo/devise/master/Devise/Models/Confirmable), [Recoverable](https://www.rubydoc.info/github/heartcombo/devise/master/Devise/Models/Recoverable), [Lockable](https://www.rubydoc.info/github/heartcombo/devise/master/Devise/Models/Lockable) 
	- Adicionar validação de email e senha utilizando Validatable;
	- Adicionar confirmação de email de cadastro utilizando Confirmable
	- Adicionar opções de recuperação de conta através de Recoverable;
	- Adicionar a funcionalidade de bloquear o acesso da conta após um número de tentativas erradas de login utilizando Lockable;

## Tarefa 3: Implementar camada de autorização JWT
- Adicionar a gem [jwt](https://github.com/jwt/ruby-jwt)
- Salvar uma `secret_key` para o seu projeto que será utilizado durante a geração do token 
	- Salvar no envfile
- Quando o usuário realizar o login, gerar um token utilizando o método da gem `JWT.encode` e salvar no campo `jwt_token` adicionado no model `User` com o seguinte payload:
```
{ id: id_do_usuario, timestamp: Time.now }
```
- Realizar a seguinte verificação sempre que o usuário acessa uma nova página:
	- Decodificar o payload do usuário logado (utilizando o método `JWT.decode` da gem)
		- Caso seu token tem menos de 5 minutos de duração, gerar um novo token e atualizar no campo `jwt_token`
		- Caso o token tenha mais de 5 minutos, deletar o `jwt_token` do usuário e desloga-lo
