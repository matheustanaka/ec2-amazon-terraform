# Desafio terraform

Comecei tomando pau em 2 coisas.

Primeira, eu tava tentando pingar o ip público da máquina. Ai eu descobri que tinha que criar uma policy no security groups
para liberar o acesso externo, o que não faz o menor sentido era que já existia um policy security com all traffic habilitado.
Isso não fez o menor sentido, pedi pro chatgpt me ajudar e ele criou uma nova policy lá que na minha visão era a mesma que a default de quando
você sobe o EC2.

Segunda parte, tomei pau pra caralho pra fazer um ssh pra máquina. Tentei importar a minha chave pública com a tag de user_data e não funcionou.
Tentei criar um script pra baixar o pacote de openssh e atualizar o service de ssh (quebrou a máquina).
Eu tentei mais algumas coisas que não funcionaram. Por último eu descobri que precisava importar a chave através da tag key_name do terraform.
Então eu criei um recurso chamado "aws_key_pair" e passei o conteúdo da minha chave pública.

Algumas coisas que eu preciso aprender:

- Como funciona uma conexão ssh
- Entender redes de vez (ta foda, não to entendendo nada)
