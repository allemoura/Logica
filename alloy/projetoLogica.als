module fidelizacao

-- classe cliente que tem como atributo boletos
sig Cliente {
	boletos: set Boleto,
	fidelizacao: lone TipoFidelizacao,
	divida: lone Divida
}

-- classe boleto que representa  as contas do cliente
sig Boleto {
	pagador: one Cliente
}

--classe abstrata que simboliza o grau de divida de um cliente 
abstract sig Divida {
	cliente: one Cliente
}

--graus de divida possíveis
sig Simples, Media, Critica extends Divida {}

-- classe abstrata dos tipos de fidelizacao
abstract sig TipoFidelizacao {
	cliente: one Cliente
}

--os tipos de fidelizacao, que extendem a classe TipoFidelização
sig Ouro, Prata, Bronze extends TipoFidelizacao {}

fact {
	-- nao devem existir fidelizacoes sem clientes
	all t:TipoFidelizacao | #t.cliente > 0

	all t:TipoFidelizacao | (t.cliente.fidelizacao = t)
	all d:Divida | d.cliente.divida = d

	--todo cliente tem boletos
	all c:Cliente | some c.boletos

	--se um cliente e ouro, ele nao tem divida

	--se um cliente eh prata, ele pode ter divida simples ou nenhuma

	--se um cliente eh bronze ele pode ter divida media ou nenhuma

	--se um cliente nao tem fidelizacao, ele tem divida critica
}

assert nemTodoClienteEhBomPagador {
	all c:Cliente | #c.fidelizacao = 0 or #c.fidelizacao = 1
}

check nemTodoClienteEhBomPagador for 30

pred show[]{}
run show for 20
 
