module fidelizacao

-- classe cliente que tem como atributo boletos, e pode ou nao estar fidelizada ou ter dividas
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
	associado: one Cliente
}

--os tipos de fidelizacao, que extendem a classe TipoFidelização
sig Ouro, Prata, Bronze extends TipoFidelizacao {}

fact {
	-- nao devem existir fidelizacoes sem clientes associados
	all t:TipoFidelizacao |  #t.associado > 0

	all t:TipoFidelizacao | (t.associado.fidelizacao = t)
	all d:Divida | d.cliente.divida = d

	--todo cliente tem boletos
	all c:Cliente | some c.boletos

	--se um cliente e ouro, ele nao tem divida
	all c:Cliente | (c.fidelizacao = Ouro) => no c.divida

	--se um cliente eh prata, ele pode ter divida simples ou nenhuma
	all c:Cliente | (c.fidelizacao = Prata) => no c.divida or c.divida = Simples

	--se um cliente eh bronze ele pode ter divida media ou nenhuma
	all c:Cliente | (c.fidelizacao = Bronze) => no c.divida or c.divida = Media

	--se um cliente nao tem fidelizacao, ele tem divida critica
	all c:Cliente | no c.fidelizacao <=> c.divida  = Critica
}

assert nemTodoClienteEhBomPagador {
	all c:Cliente | #c.fidelizacao = 0 or #c.fidelizacao = 1
}

assert clientesComDividasCriticasSaoDesfidelizados {
	all c:Cliente | c.divida = Critica => no c.fidelizacao
}

check nemTodoClienteEhBomPagador for 120
check clientesComDividasCriticasSaoDesfidelizados for 120

--pred show[]{}
--run show for 40
 
